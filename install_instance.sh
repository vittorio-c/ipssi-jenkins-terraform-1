#!/bin/bash

SUBNET_ID=${1}
SECURITY_GROUP_ID=${2}

cp TEMPLATES/instances.template ARCHITECTURE/instances.tf
sed -i "s|<##SECURITY_GROUP##>|${SECURITY_GROUP_ID}|g" ARCHITECTURE/instances.tf
sed -i "s|<##SUBNET_ID##>|${SUBNET_ID}|g" ARCHITECTURE/instances.tf

cat ARCHITECTURE/instances.tf

pwd
cd ARCHITECTURE

terraform apply -auto-approve

