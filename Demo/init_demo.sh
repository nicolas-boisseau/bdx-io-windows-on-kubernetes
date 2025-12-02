#!/bin/bash

# Création d'un RG
az group create \
	--location francecentral \
	--resource-group myResourceGroup

# Création d'un cluster AKS (Linux nodes)
az aks create \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --node-count 1 \
    --enable-addons monitoring \
    --generate-ssh-keys \
    --network-plugin azure
    --node-pool-name tux

# Ajouter un node pool Windows
az aks nodepool add \
    --resource-group myResourceGroup \
    --cluster-name myAKSCluster \
    --os-type Windows \
    --name win \
    --node-count 1
	
# Création d'un Container registry
az acr create -n techideascr -g myResourceGroup --sku Standard

# Ajout accès AKS => registry
az aks update -n myAKSCluster -g myResourceGroup --attach-acr techideascr

# Récupération des accès pour Kubectl/K9s
az aks get-credentials --name myAKSCluster -g myResourceGroup
