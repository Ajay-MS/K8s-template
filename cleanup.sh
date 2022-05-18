#!/bin/sh

# TODO: Extract clusters mapped to the partner namespace from Griffin D2 - Cluster Deployment - Inventory
declare -A subIdClusterRGNameMap=()

# Name of the daemonset need to be cleaned up
configDaemonSetName="pid-configure-ds"

for subscriptionId in "${!subIdClusterRGNameMap[@]}"
do 
    # Extract cluster name
    clusterRGName = ${subIdClusterRGNameMap[$subscriptionId]}

    # Set subscription to the current cluster subscription
    az account set --subscription $subscriptionId

    # Set the cluster config
    az aks get-credentials --name ${clusterRGName}-aks --resource-group ${clusterRGName} --admin

    # Trigger delete for the daemonset
    kubectl delete daemonset ${configDaemonSetName}
done
