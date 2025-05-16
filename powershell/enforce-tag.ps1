# Enforce 'Environment' tag on all resources in a subscription
Connect-AzAccount
$policyDefinition = Get-AzPolicyDefinition -Name 'require-tag-on-resources'
$assignmentName = "Enforce-Environment-Tag"
$scope = "/subscriptions/<your-subscription-id>"

New-AzPolicyAssignment `
  -Name $assignmentName `
  -PolicyDefinition $policyDefinition `
  -Scope $scope `
  -PolicyParameterObject @{
    tagName = @{
      value = "Environment"
    }
  }
