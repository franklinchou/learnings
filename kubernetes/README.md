# Kubernetes

## Secrets

Secrets must be base64 encoded. Say you have a secret authentication token. The plaintext is 'password'. (Our system is very secure.)

Encode the password to base64:

`echo -n 'password' | base64`

Save the output as the secret key's value.

## Switching context

```
kubectl config use-context <context>
```

## Retrieving pod & job information

```
kubectl get pods --namespace=<namespace> # Returns only non-completed jobs (running, initializing, terminating)
kubectl get pods -a --namespace=<namespace> # Get all jobs (including completed)
```

Substitute `pods` for `jobs` to retrieve job information.

Get the logs for a particular job (same as accessing the logs on the web UI): 
```
kubectl logs <job>
kubectl logs --namespace=<namespace> <job> 
kubectl logs --namespace=<namespace> -c <container> job
```

Describe gives actual information about the sub-system/level supplied, i.e., job-level information if
`jobs` is supplied. Rather than logs which gives the same information that can be retrieved from the UI 
(information emitted by that application's logging system).

```
kubectl describe jobs --namespace=<namespace> <job-name>
```
