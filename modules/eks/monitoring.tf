resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.12.0"  
 
}

resource "helm_release" "prometheus_stack" {
  name       = "prometheus-grafana"
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = "monitoring"
  version    = "62.2.0"

  values = [
    <<EOF
grafana:
  adminPassword: "admin"

EOF
  ]

  # Ensure the monitoring namespace is created
  depends_on = [kubernetes_namespace.monitoring,helm_release.metrics_server]
}

resource "helm_release" "loki" {
  name       = "loki"
  chart      = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"

  values = [
    <<EOF
loki:
  enabled: true

promtail:
  enabled: true
EOF
  ]

  # Ensure the monitoring namespace is created
  depends_on = [kubernetes_namespace.monitoring]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
