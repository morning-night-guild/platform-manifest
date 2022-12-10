# platform-manifest

## initialize project

1. `make tool`
2. `make keygen`
3. set public key to `AGE_PUBLIC_KEY` in `Makefile`
4. set secret key as name `SOPS_AGE_KEY` to `Settings` > `Secrets` in `Octeto`

## add secret

1. `make encode secret=xxx` ...(1)
2. `vim ./k8x/secret-${name}.yaml` 
    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
    name: platform-secret-${name}
    type: Opaque
    data:
    ${NAME}:
      (1)
    ```
3. `make encrypt secret-${name}.yaml`
4. add script `./sops --decrypt --in-place k8s/templates/secret-${name}.yaml` in `script/sops.sh`

## change secret

1. `make encode secret=xxx` ...(1)
2. change value to (1) `data.${SECRET_NAME}` in `./k8x/secret-${name}.yaml`
3. `make encrypt`
