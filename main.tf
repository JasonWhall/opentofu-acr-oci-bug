module "example" {
  source = "oci://${var.acr_name}.azurecr.io/example-module?tag=latest"
}

output "example_output" {
  value = module.example.test
}