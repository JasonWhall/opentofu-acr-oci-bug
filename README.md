# OpenTofu OCI Module Source Azure Container Registry

This module demonstrates a bug when attempting to resolve a module source from an Azure Container Registry (ACR) using OpenTofu

## Steps to Reproduce

1. Create an ACR - Use [./scripts/create-acr.sh](./scripts/create-acr.sh) to do this.
2. Build and push the module to the ACR - Use [./scripts/publish-module.sh](./scripts/publish-module.sh) to do this.
3. Run `tofu init` in the root directory of this repository.

### Expected Behaviour
Module should be downloaded successfully from the ACR and the init should execute without errors.

### Actual Behaviour

The init fails with the following error:

```
│ Could not download module "example" (main.tf:1) source code from "oci://<myacr>.azurecr.io/example-module?tag=latest": error downloading
│ 'oci://<myacr>.azurecr.io/example-module?tag=latest': configuring client for <myacr>.azurecr.io/example-module: failed to contact OCI registry at  
│ "<myacr>.azurecr.io": GET "https://<myacr>.azurecr.io/v2/": GET "https://<myacr>.azurecr.io/oauth2/token?service=<myacr>.azurecr.io":      
│ response status code 401: unauthorized: authentication required, visit https://aka.ms/acr/authorization for more information. CorrelationId:
│ 4acffa84-ceb8-4722-aabb-a280894c0696
```

This is expected to work as we have previously run `az acr login --name <myacr>` to authenticate with the ACR so the docker credential store has an entry for the ACR. This can be validated by running `oras pull <my-acr>.azurecr.io/example-module:latest`.