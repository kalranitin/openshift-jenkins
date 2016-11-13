#!/bin/sh
read -s -p "Enter Github Username: " gitUsername
read -s -p "\nEnter Github Password: " gitPassword
oc new-project ci
#oc create serviceaccount jenkinsaccount -n ci
#oadm policy add-scc-to-user privileged system:serviceaccount:ci:jenkinsaccount
oadm policy add-scc-to-user privileged system:serviceaccount:ci:default
oc secrets new-basicauth scmsecret --username=$gitUsername --password=$gitPassword
oc secrets add serviceaccount/builder secrets/scmsecret
oc policy add-role-to-user edit system:serviceaccount:ci:default -n ci
#oc policy add-role-to-user edit system:serviceaccount:ci:jenkinsaccount -n ci
oc create -n ci -f master/jenkins-master-template.json
oc create -n ci -f slave/jenkins-slave-template.json
