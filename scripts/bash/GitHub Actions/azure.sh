#!/bin/bash

az ad sp create-for-rbac --name "github-actions" --role contributor \
    --scopes /subscriptions/<subscription-id> --sdk-auth
