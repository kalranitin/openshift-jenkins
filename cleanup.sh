#!/bin/sh

oc delete all --all -n ci
oc delete project ci