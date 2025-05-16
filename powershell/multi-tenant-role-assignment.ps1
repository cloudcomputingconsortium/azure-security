# Assign Contributor role to a user/service principal across multiple tenants/subscriptions

$tenants = @("tenant1-id", "tenant2-id")
$userId = "<object-id-of-user-or-service-principal>"
$role = "Contributor"

foreach ($tenant in $tenants) {
    Connect-AzAccount -TenantId $tenant
    $subscriptions = Get-AzSubscription
    foreach ($sub in $subscriptions) {
        Set-AzContext -SubscriptionId $sub.Id
        New-AzRoleAssignment -ObjectId $userId -RoleDefinitionName $role -Scope "/subscriptions/$($sub.Id)"
    }
}
