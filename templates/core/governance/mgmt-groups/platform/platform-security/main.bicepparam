using './main.bicep'

// General Parameters
param parLocations = [
  'eastus2'
  'westus2'
]
param parEnableTelemetry = true

param platformSecurityConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: 'security'
  managementGroupParentId: 'platform'
  managementGroupIntermediateRootName: 'alz'
  managementGroupDisplayName: 'Security'
  managementGroupDoNotEnforcePolicyAssignments: []
  managementGroupExcludedPolicyAssignments: []
  customerRbacRoleDefs: []
  customerRbacRoleAssignments: []
  customerPolicyDefs: []
  customerPolicySetDefs: []
  customerPolicyAssignments: []
  subscriptionsToPlaceInManagementGroup: ['4cd2d732-1cae-47ee-8f32-adb56d401dbd']
  waitForConsistencyCounterBeforeCustomPolicyDefinitions: 30
  waitForConsistencyCounterBeforeCustomPolicySetDefinitions: 30
  waitForConsistencyCounterBeforeCustomRoleDefinitions: 30
  waitForConsistencyCounterBeforePolicyAssignments: 30
  waitForConsistencyCounterBeforeRoleAssignments: 30
  waitForConsistencyCounterBeforeSubPlacement: 30
}

// Only specify the parameters you want to override - others will use defaults from JSON files
param parPolicyAssignmentParameterOverrides = {
  // No policy assignments in platform-security currently
}
