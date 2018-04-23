#/bin/sh
envsubst '${AWS_ACCESS_KEY_ID},${AWS_SECRET_ACCESS_KEY},${AWS_REGION},${DYNAMO_DB_TABLE},${SSL_CERT_PATH},${SSL_KEY_PATH}' < /vault/config/vault-config.tmpl > /vault/config/vault-config.hcl
vault server -config=/vault/config/vault-config.hcl
