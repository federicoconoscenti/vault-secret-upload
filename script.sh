#!/bin/bash

# Prompt for input for Vault URL, token, and secret information
read -p "Enter Vault URL (e.g. https://vault.example.com): " VAULT_URL
read -p "Enter Vault token: " VAULT_TOKEN
read -p "Enter secret name: " SECRET_NAME
read -s -p "Enter secret value: " SECRET_VALUE
echo ""

# Create a temporary file to store the secret
TEMP_FILE=$(mktemp)

# Write the secret value to the temporary file
echo -n "${SECRET_VALUE}" > "${TEMP_FILE}"

# Load the secret into Vault using the Vault API
curl --header "X-Vault-Token: ${VAULT_TOKEN}" \
     --request POST \
     --data-binary "@${TEMP_FILE}" \
     "${VAULT_URL}/v1/secret/data/${SECRET_NAME}"

# Remove the temporary file
rm "${TEMP_FILE}"
