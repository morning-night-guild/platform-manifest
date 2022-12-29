include .env

.PHONY: tool
tool:
	@aqua i

.PHONY: keygen
keygen:
	@age-keygen

.PHONY: fmt
fmt:
	@yamlfmt

.PHONY: lint
lint:
	@helm lint k8s

.PHONY: encode
encode:
	@if [ -z "${secret}" ]; then echo "Please specify secret"; exit 1; fi
	@echo -n '${secret}' | base64

.PHONY: decode
decode:
	@if [ -z "${value}" ]; then echo "Please specify value"; exit 1; fi
	@echo -n '${value}' | base64 -D

.PHONY: encrypt
encrypt:
	@if [ -z "${name}" ]; then echo "Please specify name"; exit 1; fi
	@yq -i "(del.sops)" k8s/templates/secret/${name}
	@sops --encrypt \
		--age ${AGE_PUBLIC_KEY} \
		--encrypted-regex '^(data|stringData)$$' \
		--in-place \
		k8s/templates/secret/${name}
	@yamlfmt k8s/templates/secret/${name}

.PHONY: decrypt
decrypt:
	@if [ -z "${name}" ]; then echo "Please specify name"; exit 1; fi
	@sops --decrypt --in-place k8s/templates/secret/${name}
