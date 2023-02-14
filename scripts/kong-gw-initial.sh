#!/usr/bin/env bash

# Create License Secret
kubectl create namespace kong-enterprise
kubectl create secret generic kong-enterprise-license --from-file=license=./license.json -n kong-enterprise

# Create Super User Password 
kubectl create secret generic kong-enterprise-superuser-password \
-n kong-enterprise \
--from-literal=password=xxx # ChangeMe


# Generate Config File for Session Plugin
echo '{"cookie_name":"portal_session","cookie_samesite":"off","secret":"xxx","cookie_secure":false,"storage":"kong","cookie_domain": "gitops.kongtest.net"}' > portal_session_conf
echo '{"cookie_name":"admin_session","cookie_samesite":"off","secret":"xxx,"cookie_secure":false,"storage":"kong"}' > admin_gui_session_conf

# Create the secret for Kong Manager and Dev Portal
kubectl create secret generic kong-session-config \
-n kong-enterprise \
--from-file=admin_gui_session_conf \
--from-file=portal_session_conf
