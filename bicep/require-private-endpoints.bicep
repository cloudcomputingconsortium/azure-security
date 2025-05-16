resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'require-private-endpoints'
  properties: {
    displayName: 'Require private endpoints for PaaS'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type',
            equals: 'Microsoft.Sql/servers'
          },
          {
            not: {
              field: 'Microsoft.Sql/servers/publicNetworkAccess',
              equals: 'Disabled'
            }
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
