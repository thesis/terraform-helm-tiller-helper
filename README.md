
<!-- Module Name and description are required -->
# Helm Tiller Helper Module

Provides a helper used by the Helm provider, that sets up a namespace, service
account, and permissions for Tiller to run on.

<!-- Compatibility section is optional -->
## Compatibility

This module is compatible with Terraform `<= 0.12.0`
This module is compatible with Helm provider version `0.7.0` - it may or may
not work with higher versions.

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
  tiller_namespace_name = "your-namespace-for-tiller"
}

provider "helm" {
  version = "= x.y.z"

  kubernetes {
    host                   = "url-of-kubernetes-host"
    token                  = "reference-to-your-client-config-access-token"
    cluster_ca_certificate = "reference-to-your-cluster-ca-certificate"
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

Note: The values for Kubernetes `token` and `cluster_ca_certificate` should not
be stored in plain text in your Terraform config, or commited to source control.

We recommend sourcing the token from your client config data:
`token                  = "${data.google_client_config.default.access_token}"`
and decoding the certificate from the associated Kubernetes module's cluster:
`cluster_ca_certificate` = `${base64decode(module.gke_cluster.cluster_ca_certificate)}`

<!-- License is required -->
## License

See [LICENSE](./LICENSE).
