gobuild:
	GOOS=linux GOARCH=amd64  go build -o build/main main.go

init:
	cd terraform && terraform init 

docs:
	terraform-docs markdown table . > README.md


plan:
	cd terraform && terraform plan 

apply:
	cd terraform && terraform apply --auto-approve 

destroy:
	cd terraform && terraform destroy --auto-approve 

test:
	aws lambda invoke --region=us-east-1 --function-name=test_lambda  output.txt


