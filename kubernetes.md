# Kubernetes

## Secrets

Secrets must be base64 encoded. Say you have a secret authentication token. The plaintext is 'password'. (Our system is very secure.)

Encode the password to base64:

`echo -n 'password' | base64`

Save the output as the secret key's value.

