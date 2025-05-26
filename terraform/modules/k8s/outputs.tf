output "k8s_cluster_id" {
  description = "ID созданного Kubernetes кластера"
  value       = yandex_kubernetes_cluster.k8s-cluster.id
}

output "k8s_cluster_name" {
  description = "Имя Kubernetes кластера"
  value       = yandex_kubernetes_cluster.k8s-cluster.name
}

output "k8s_cluster_network_id" {
  description = "ID сети, к которой подключён кластер"
  value       = yandex_kubernetes_cluster.k8s-cluster.network_id
}

output "obs_node_group_id" {
  description = "ID группы нод observability"
  value       = yandex_kubernetes_node_group.k8s-obs-node-group.id
}

output "obs_node_group_name" {
  description = "Имя группы нод observability"
  value       = yandex_kubernetes_node_group.k8s-obs-node-group.name
}

output "pg_node_group_id" {
  description = "ID группы нод PostgreSQL"
  value       = yandex_kubernetes_node_group.k8s-pg-node-group.id
}

output "pg_node_group_name" {
  description = "Имя группы нод PostgreSQL"
  value       = yandex_kubernetes_node_group.k8s-pg-node-group.name
}
