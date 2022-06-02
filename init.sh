#!/bin/bash

echo "Verifying if environnement is ready..."

bash ./job_verif_env.sh

mkdir ARCHITECTURE

source /var/jenkins_home/.aws_credentials
cp TEMPLATES/provider.template ARCHITECTURE/provider.tf
sed -i "s|<##ACCESS_KEY##>|${ACCESS_KEY}|g" ARCHITECTURE/provider.tf
sed -i "s|<##SECRET_KEY##>|${SECRET_KEY}|g" ARCHITECTURE/provider.tf

cat ARCHITECTURE/provider.tf

cd ARCHITECTURE
terraform init

