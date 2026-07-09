using './main.bicep'

// General Parameters
param parLocations = [
  'eastus2'
  'westus2'
]
param parEnableTelemetry = true

param landingZonesConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: 'landingzones'
  managementGroupParentId: 'alz'
  managementGroupIntermediateRootName: 'alz'
  managementGroupDisplayName: 'Landing Zones'
  managementGroupDoNotEnforcePolicyAssignments: []
  managementGroupExcludedPolicyAssignments: [
    'Enable-DDoS-VNET'
  ]
  customerRbacRoleDefs: []
  customerRbacRoleAssignments: []
  customerPolicyDefs: []
  customerPolicySetDefs: []
  customerPolicyAssignments: []
  subscriptionsToPlaceInManagementGroup: []
  waitForConsistencyCounterBeforeCustomPolicyDefinitions: 10
  waitForConsistencyCounterBeforeCustomPolicySetDefinitions: 10
  waitForConsistencyCounterBeforeCustomRoleDefinitions: 10
  waitForConsistencyCounterBeforePolicyAssignments: 40
  waitForConsistencyCounterBeforeRoleAssignments: 40
  waitForConsistencyCounterBeforeSubPlacement: 10
}

// Only specify the parameters you want to override - others will use defaults from JSON files
param parPolicyAssignmentParameterOverrides = {
  'Enable-DDoS-VNET': {
    parameters: {
      ddosPlan: {
        value: '/subscriptions/c228b07c-eaaa-4f50-89c2-5dd6b5dfc916/resourceGroups/rg-alz-amer-conn-${parLocations[0]}/providers/Microsoft.Network/ddosProtectionPlans/ddos-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-AzSqlDb-Auditing': {
    parameters: {
      logAnalyticsWorkspaceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-vmArc-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VM-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VMSS-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-vmHybr-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VM-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VMSS-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-MDFC-DefSQL-AMA': {
    parameters: {
      userWorkspaceResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
      dcrResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-mdfcsql-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/141ce5b3-08b0-4589-86ce-2d077f913fe7/resourceGroups/rg-alz-amer-logging-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
}
