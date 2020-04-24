#! /bin/bash

if [ -z $PROJECT ]
then
    echo "No project specified"
    exit 1
fi

CURRENT_DIR=$PWD

cd $CURRENT_DIR/$PROJECT

if [ -z $1 ]
then
    echo "No environment specified"
    exit 1
elif [ $1 = "dev" ]
then
    echo "Planning $PROJECT-dev"
    terraform workspace new dev
    terraform workspace select dev
    terraform init -backend-config prefix=terraform/state/$PROJECT
elif [ $1 = "prod" ]
then
    echo "Deploy $PROJECT-prod"
    terraform workspace new prod
    terraform workspace select prod
    terraform init -backend-config prefix=terraform/state/$PROJECT
else
    echo "Invalid environment specified"
    exit 1
fi

terraform plan -var-file $1.tfvars ${@:2}

cd $CURRENT_DIR