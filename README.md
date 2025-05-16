# Azure Policy Automation Scripts

This repository contains PowerShell, Azure CLI, ARM, Bicep, and Terraform scripts for automating Azure policy deployments, security enforcement, and governance tasks across single and multiple Azure tenants.

## 📁 Folder Structure

```text
.
├── .github/workflows/
│   └── deploy-policies.yml             # GitHub Actions workflow
├── azure-pipelines/
│   └── azure-pipelines.yml             # Azure DevOps pipeline for ARM/Bicep
├── terraform/
│   ├── azure-policy.tf                 # Terraform deployment script
│   └── azure-pipelines.yml             # Azure DevOps pipeline for Terraform
├── arm-templates/
│   └── enforce-storage-encryption.json # ARM template to enforce encryption
├── bicep/
│   └── require-private-endpoints.bicep # Bicep template to enforce private endpoints
├── powershell/
│   ├── enforce-tag.ps1                 # PowerShell script for tag policy assignment
│   └── multi-tenant-role-assignment.ps1# Multi-tenant role assignment script
├── azure-cli/
│   └── setup-loganalytics.sh           # Shell script to deploy log analytics and diagnostics
├── auto-remediation/
│   └── auto-remediate-missing-tags.json # Auto-remediation policy
└── README.md                           # This file
```

## 🚀 Getting Started

### Prerequisites

- Azure CLI or Az PowerShell Module
- Azure Subscription or Management Group
- Role: `Owner` or `Policy Contributor` (for policy assignments)

---

## 🛠️ Usage Instructions

### 🔹 GitHub Actions

1. Create a Service Principal:
   ```bash
   az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription-id>" --sdk-auth
   ```
2. Save the output as a secret named `AZURE_CREDENTIALS` in your GitHub repo.
3. Push the contents of this repository to GitHub.
4. GitHub Actions will automatically trigger on push to ARM/Bicep scripts.

---

### 🔹 Azure DevOps Pipelines

1. Create a service connection in Azure DevOps:
   - Go to Project Settings → Service connections → New → Azure Resource Manager.
2. Reference it in the pipelines under `azureSubscription`.

---

### 🔹 PowerShell Scripts

To assign a tag policy:

```powershell
.\powershell\enforce-tag.ps1
```

To assign a role across multiple tenants:

```powershell
.\powershell\multi-tenant-role-assignment.ps1
```

---

### 🔹 Terraform Deployment

```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

Ensure you have configured remote state backend in `azure-pipelines.yml`.

---

## 🔒 Auto-Remediation

To deploy the auto-remediation policy:

```bash
az policy definition create --name "auto-remediate-missing-tags" \
  --rules auto-remediation/auto-remediate-missing-tags.json \
  --params '{ "tagName": {"value": "Environment"}, "tagValue": {"value": "Dev"} }' \
  --mode All --display-name "Auto-remediate missing tags"
```

---

## 🧾 License

MIT License

---

## 📬 Contributions

Feel free to submit PRs or open issues to enhance automation, add support for additional resource types, or integrate with GitHub Actions, Terraform Cloud, or Azure Lighthouse.

---

## 👤 Author

Created by: Samuel Navarro
