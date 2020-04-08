
<!-- Module Name and description are required -->
# Helm Tiller Helper Module

<!-- TODO: Add description -->

<!-- Compatibility section is optional -->
## Compatibility

This module is compatible with Terraform `<= 0.12.0`

<!-- Usage section is required -->
## Usage

<!-- NOTE: Examples should go into an `/examples` directory, with a link here
along the following lines:

There are multiple examples included in the [examples](./examples/) folder but
simple usage is as follows:
 -->

```hcl
module "your_custom_name_for_your_instance_of_this_module" {
  source                = "git@github.com:thesis/terraform-helm-tiller-helper.git"
  tiller_namespace_name = "${var.tiller_namespace}"
}

provider "helm" {
  version = "= 0.7.0"

  kubernetes {
    host                   = "https://${var.gke_cluster["master_private_endpoint"]}"
    token                  = "${data.google_client_config.default.access_token}"
    cluster_ca_certificate = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
  }

  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.11.0"
  service_account = "${module.helm_provider_helper.tiller_service_account}"
  override        = ["spec.template.spec.automountserviceaccounttoken=true"]
  namespace       = "${module.helm_provider_helper.tiller_namespace}"
  install_tiller  = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| tiller\_namespace\_name | The name of the namespace you want tiller to live in. | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| tiller\_namespace | The tiller namespace name. |
| tiller\_service\_account | The tiller service account name. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Notes section is optional -->
## Notes

<!-- Anything quirky about the module folks may want to know about. Relevant
links or additional useful information.  Format is up to you.
 -->

<!-- License is required -->
## License

See [LICENSE](./LICENSE).
