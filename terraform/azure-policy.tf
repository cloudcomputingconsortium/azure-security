provider "azurerm" {
  features {}
}

resource "azurerm_policy_definition" "enforce_tag" {
  name         = "enforce-environment-tag"
  policy_type  = "BuiltIn"
  mode         = "All"
  display_name = "Enforce Environment Tag"

  policy_rule = <<POLICY
{
  "if": {
    "not": {
      "field": "tags.Environment"
    }
  },
  "then": {
    "effect": "deny"
  }
}
POLICY
}

resource "azurerm_policy_assignment" "assign_tag_policy" {
  name                 = "assign-environment-tag-policy"
  policy_definition_id = azurerm_policy_definition.enforce_tag.id
  scope                = "/subscriptions/<subscription-id>"
}
