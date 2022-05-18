#!/bin/sh

# TODO: Manually identify the clusters mapping for the partner's namespaces

declare -A subIdClusterRGNameMap=()
configDaemonSetName="pid-configure-ds"

for subscriptionId in "${!subIdClusterRGNameMap[@]}"
do 
   
    clusterRGName = ${subIdClusterRGNameMap[$subscriptionId]}

    az account set --subscription $subscriptionId

    # Set the cluster config
    az aks get-credentials --name ${clusterRGName}-aks --resource-group ${clusterRGName} --admin

    kubectl delete daemonset ${configDaemonSetName}
done
