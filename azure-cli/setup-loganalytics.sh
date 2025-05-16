#!/bin/bash
# Set variables
resourceGroup="rg-security"
location="eastus"
workspaceName="loganalytics-sec"

az group create --name $resourceGroup --location $location
az monitor log-analytics workspace create \
  --resource-group $resourceGroup \
  --workspace-name $workspaceName \
  --location $location

az monitor diagnostic-settings create \
  --name "send-activity-logs" \
  --resource "/subscriptions/<your-subscription-id>" \
  --workspace "/subscriptions/<your-subscription-id>/resourceGroups/$resourceGroup/providers/Microsoft.OperationalInsights/workspaces/$workspaceName" \
  --logs '[{"category": "Administrative", "enabled": true},{"category": "Security", "enabled": true}]'
