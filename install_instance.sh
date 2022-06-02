#!/bin/bash

echo "Installing instances ... "

mkdir GENERATED
cp -R SCRIPTS/ ARCHITECTURE/

I=0

while read line
do
    if [ $I -gt 0 ]
    then
        if [ ! -z $line ]
        then
            INSTANCE_NAME=$(echo $line | cut -d";" -f1)
            SUBNET_NAME=$(echo $line | cut -d";" -f2)
            USER_DATA=$(echo $line | cut -d";" -f3)
            SGROUP=$(echo $line | cut -d";" -f4)

            cp TEMPLATES/instances.template new_instance

            sed -i "s|<##INSTANCE_NAME##>|${INSTANCE_NAME}|g" new_instance
            sed -i "s|<##SUBNET_ID##>|${SUBNET_NAME}|g" new_instance
            sed -i "s|<##USER_DATA##>|SCRIPTS/${USER_DATA}|g" new_instance
            sed -i "s|<##SECURITY_GROUP##>|${SGROUP}|g" new_instance

            mv new_instance GENERATED/${INSTANCE_NAME}.tf
        fi
    else
        I=1
    fi
done < instances_matrix.csv

cat GENERATED/VITTORIO-MACHINE-*.tf > ARCHITECTURE/instances.tf && rm -f GENERATED/*

cp TEMPLATES/output.template ARCHITECTURE/output.tf

cd ARCHITECTURE
terraform apply -auto-approve

