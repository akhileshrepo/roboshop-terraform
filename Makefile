dev:
	rm -rf .terraform
	terraform init -backend-config -var-file=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars