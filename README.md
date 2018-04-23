# Vault on Docker with AWS DynamoDB

A quick and easy way to run [Vault](https://www.vaultproject.io) on [Docker](https://www.docker.com/) against an [AWS DynamoDB](https://aws.amazon.com/dynamodb/).

## Usage

### Building the docker image
1. Build and tag an image by using the Dockerfile in this directory.
```
docker build --rm -t <image_name> .
```
2. Optionally, push the image to the registry.
```
docker push <image_name>
```

You can also use `docker-compose` and the provided `vault.yml` file to build the image. This is the preferred method if you intend to run via the compose as documented below.
```
docker-compose -f vault.yml build
```

### Running the Stack

#### Prerequisites
 * You must have an IAM user AWS_ACCESS_KEY_ID and an AWS_SECRET_ACCESS_KEY with permissions to [create and modify DynamoDB Tables](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/access-control-managing-permissions.html).

#### Usage
Fill in the required parameters in the vault.yml docker compose file as necessary for your environment. This example demonstrates using and mounting an external volume containing SSL certificates. These could also be “baked” in to your image via an ADD or COPY instruction in the Dockerfile.

```
- "VAULT_ADDR=https://127.0.0.1:8200"
- "AWS_ACCESS_KEY_ID=YOURKEYID"
- "AWS_SECRET_ACCESS_KEY=YOURKEYSECRET"
- "AWS_REGION=us-west-2"
- "DYNAMO_DB_TABLE=vault-test"
- "SSL_CERT_PATH=/path/to/your/cert.pem"
- "SSL_KEY_PATH=/path/to/your/key.pem"
```
##### VAULT_ADDR
This is the address at which vault listens for incoming requests. Typically should be set to `https://127.0.0.1:8200` as configured in this example for running inside a container.

##### AWS_ACCESS_KEY_ID
AWS access key ID credential with permissions to create/modify DynamoDB tables.

##### AWS_SECRET_ACCESS_KEY
AWS secret key credential with permissions to create/modify DynamoDB tables.

##### AWS_REGION
The region you wan the DynamoDB to be deployed in.

##### DYNAMO_DB_TABLE
The name of the DynamoDB table to deploy/connect to.

##### SSL_CERT_PATH
Path relative to inside the container to a valid SSL certificate.

##### SSL_KEY_PATH
Path relative to inside the container to a valid SSL key.

#### Running
Once configured, the application can be brought up with a simple `docker-compose` command.
```
docker-compose -f vault.yml up
```