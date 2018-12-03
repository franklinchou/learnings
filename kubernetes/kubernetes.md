# Kubernetes

## Secrets

Secrets must be base64 encoded. Say you have a secret authentication token. The plaintext is 'password'. (Our system is very secure.)

Encode the password to base64:

`echo -n 'password' | base64`

Save the output as the secret key's value.

## Retrieving pod & job information

```
kubectl get pods --namespace=<namespace> # Returns only non-completed jobs (running, initializing, terminating)
kubectl get pods -a --namespace=<namespace> # Get all jobs (including completed)
```

Substitute `pods` for `jobs` to retrieve job information.

Get the logs for a particular pod (same as accessing the logs on the web UI): 
```
kubectl logs --namespace=<namespace> <job> 
```

Checking logs for an individual container:
```
kubectl describe jobs <job-name> --namespace=<namespace>
kubectl logs <pod-id> -c <container> --namespace=<namespace>
kubectl logs run-theorem-05shl -c ledger-theorem --namespace=cfm # for example
```
