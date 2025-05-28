#!/usr/bin/env python3
"""
Dynamic inventory for Ansible — JSON with _meta.hostvars
Includes management host from ../../terraform/stages/20-management
and Kubernetes cluster name + S3 credentials from ../../terraform/stages/30-k8s
"""
import json
import os
import subprocess
import sys
from pathlib import Path
from typing import Any, Dict


def _tf_output(workdir: Path) -> Dict[str, Any]:
    cmd = ["terraform", f"-chdir={workdir}", "output", "-json"]
    try:
        raw = subprocess.check_output(cmd, text=True)
    except FileNotFoundError:
        sys.stderr.write(f"[tf-inventory] terraform binary not found ({cmd[0]})\n")
        sys.exit(1)
    except subprocess.CalledProcessError as exc:
        sys.stderr.write(f"[tf-inventory] terraform failed in {workdir}: {exc}\n")
        sys.exit(exc.returncode)
    try:
        return json.loads(raw)
    except json.JSONDecodeError as exc:
        sys.stderr.write(f"[tf-inventory] invalid JSON from terraform: {exc}\n")
        sys.exit(1)


def build_inventory(tf_mgmt: Dict[str, Any], tf_k8s: Dict[str, Any]) -> Dict[str, Any]:
    # Management outputs we must have
    req_mgmt = {"ansible_sa_name", "mgmt_id", "mgmt_public_ip"}
    missing = req_mgmt - tf_mgmt.keys()
    if missing:
        sys.stderr.write(f"[tf-inventory] missing management outputs: {', '.join(sorted(missing))}\n")
        sys.exit(1)

    # K8s outputs we must have
    req_k8s = {"cluster_name", "pg_access_key", "pg_secret_key"}
    missing_k8s = req_k8s - tf_k8s.keys()
    if missing_k8s:
        sys.stderr.write(f"[tf-inventory] missing k8s outputs: {', '.join(sorted(missing_k8s))}\n")
        sys.exit(1)

    user        = tf_mgmt["ansible_sa_name"]["value"]
    mgmt_id     = tf_mgmt["mgmt_id"]["value"]
    mgmt_ip     = tf_mgmt["mgmt_public_ip"]["value"][0]

    cluster_name    = tf_k8s["cluster_name"]["value"]
    pg_access_key   = tf_k8s["pg_access_key"]["value"]
    pg_secret_key   = tf_k8s["pg_secret_key"]["value"]

    hostvars = {
        "management": {
            "ansible_host": mgmt_ip,
            "instance_id": mgmt_id,
        }
    }

    inventory: Dict[str, Any] = {
        "_meta": {"hostvars": hostvars},
        "all": {
            "vars": {
                "ansible_user": "yc-sa-" + user,
                "cluster_name": cluster_name,
                "pg_access_key": pg_access_key,
                "pg_secret_key": pg_secret_key,
            },
            "hosts": ["management"],
        },
        "management": {"hosts": ["management"]},
    }
    return inventory


if __name__ == "__main__":
    here = Path(__file__).resolve().parent
    mgmt_dir = Path(os.getenv("TF_INFRA_DIR", here / "../../terraform/stages/20-management")).resolve()
    k8s_dir = Path(os.getenv("TF_K8S_DIR", here / "../../terraform/stages/30-k8s")).resolve()

    if not mgmt_dir.exists():
        sys.stderr.write(f"[tf-inventory] management dir not found: {mgmt_dir}\n")
        sys.exit(1)
    if not k8s_dir.exists():
        sys.stderr.write(f"[tf-inventory] k8s dir not found: {k8s_dir}\n")
        sys.exit(1)

    tf_mgmt = _tf_output(mgmt_dir)
    tf_k8s = _tf_output(k8s_dir)
    inv = build_inventory(tf_mgmt, tf_k8s)
    print(json.dumps(inv, indent=2))
