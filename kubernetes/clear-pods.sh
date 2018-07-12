# Clear all non-running pods. Warning! Will clear initializing pods as well!

# Make sure you're set to the right kubernetes environment

NAMESPACE=$1

for j in $(kubectl get pods --namespace=$NAMESPACE | awk '{if (NR!=1 && $1 ~ /run/ && $3 !~ /Running/) {print $1}}'); do
    echo Deleting pod "${j}"
    kubectl delete pod $j --cascade=false --namespace=$NAMESPACE
done
