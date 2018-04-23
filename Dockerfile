FROM vault:0.10.0

# Install envsubst
RUN apk add --update gettext libintl

# Add the config file template and startup script
ADD vault-config.tmpl /vault/config/
ADD start-vault.sh /vault/

WORKDIR /vault

ENTRYPOINT ["/bin/sh", "./start-vault.sh"]
