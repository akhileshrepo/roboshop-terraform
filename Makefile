dev:
	rm -rf .terraform
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars
prod:
	rm -rf .terraform
	terraform init -backend-config=env-prod/state.tfvars
	terraform apply -auto-approve -var-file=env-prod/main.tfvars
<<<<<<< HEAD

=======
>>>>>>> 83026f6edcbcaa6d1433c8434b002a95d77d6aea
dev-destroy:
	rm -rf .terraform
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars
<<<<<<< HEAD

=======
>>>>>>> 83026f6edcbcaa6d1433c8434b002a95d77d6aea


	
