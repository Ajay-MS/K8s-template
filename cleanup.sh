#!/bin/sh

# TODO: Manually identify the clusters mapping for the partner's namespaces

clusterRGNames=()
configDaemonSetName="pid-configure-ds"

for clusterRGName in clusterRGNames
do
    # Set the cluster config
    az aks get-credentials --name ${clusterRGName}-aks --resource-group ${clusterRGName} --admin

    kubectl delete daemonset ${configDaemonSetName}
done
