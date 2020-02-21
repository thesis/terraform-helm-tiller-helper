resource "kubernetes_namespace" "tiller" {
  metadata {
    annotations {
      description = "Namespace dedicated to tiller install."
    }

    name = "${var.tiller_namespace_name}"
  }

  count = "${var.tiller_namespace_name == "kube-system" ? 0 : 1}"
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "${var.tiller_namespace_name}"
  }
}

resource "kubernetes_cluster_role_binding" "tiller-cluster-role-binding" {
  metadata {
    name = "tiller-cluster-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.tiller.metadata.0.name}"
    namespace = "${var.tiller_namespace_name}"
    api_group = ""
  }
}
