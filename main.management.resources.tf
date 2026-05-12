module "management_resources" {
  source  = "Azure/avm-ptn-alz-management/azurerm"
  version = "0.9.0"
  count   = var.management_resources_enabled ? 1 : 0
  providers = {
    azurerm = azurerm.management
  }

  automation_account_name                                    = null
  location                                                   = module.config.outputs.management_resource_settings.location
  log_analytics_workspace_name                               = coalesce(module.config.outputs.management_resource_settings.log_analytics_workspace_name, "law-management-${module.config.outputs.management_resource_settings.location}")
  resource_group_name                                        = coalesce(module.config.outputs.management_resource_settings.resource_group_name, "rg-management-${module.config.outputs.management_resource_settings.location}")
  data_collection_rules                                      = module.config.outputs.management_resource_settings.data_collection_rules
  enable_telemetry                                           = var.enable_telemetry
  linked_automation_account_creation_enabled                 = false
  log_analytics_solution_plans                               = module.config.outputs.management_resource_settings.log_analytics_solution_plans
  log_analytics_workspace_allow_resource_only_permissions    = module.config.outputs.management_resource_settings.log_analytics_workspace_allow_resource_only_permissions
  log_analytics_workspace_cmk_for_query_forced               = module.config.outputs.management_resource_settings.log_analytics_workspace_cmk_for_query_forced
  log_analytics_workspace_daily_quota_gb                     = module.config.outputs.management_resource_settings.log_analytics_workspace_daily_quota_gb
  log_analytics_workspace_internet_ingestion_enabled         = module.config.outputs.management_resource_settings.log_analytics_workspace_internet_ingestion_enabled
  log_analytics_workspace_internet_query_enabled             = module.config.outputs.management_resource_settings.log_analytics_workspace_internet_query_enabled
  log_analytics_workspace_local_authentication_enabled       = module.config.outputs.management_resource_settings.log_analytics_workspace_local_authentication_enabled
  log_analytics_workspace_reservation_capacity_in_gb_per_day = module.config.outputs.management_resource_settings.log_analytics_workspace_reservation_capacity_in_gb_per_day
  log_analytics_workspace_retention_in_days                  = module.config.outputs.management_resource_settings.log_analytics_workspace_retention_in_days
  log_analytics_workspace_sku                                = module.config.outputs.management_resource_settings.log_analytics_workspace_sku
  resource_group_creation_enabled                            = true
  sentinel_onboarding                                        = module.config.outputs.management_resource_settings.sentinel_onboarding
  tags                                                       = coalesce(module.config.outputs.management_resource_settings.tags, module.config.outputs.tags)
  timeouts                                                   = module.config.outputs.management_resource_settings.timeouts
  user_assigned_managed_identities                           = module.config.outputs.management_resource_settings.user_assigned_managed_identities
}

moved {
  from = module.management_resources[0].module.management_resources
  to   = module.management_resources[0]
}
locals {
  root_management_group_name = yamldecode(file("${path.root}/lib/architecture_definitions/alz_custom.alz_architecture_definition.yaml")).management_groups[0].id

  # root_management_group_name = jsondecode(file("${path.root}/lib/architecture_definitions/alz_custom.alz_architecture_definition.json")).management_groups[0].id
}

module "amba" {
  source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
  version = "0.3.0"
  providers = {
    azurerm = azurerm.management
  }
  location                            = var.starter_locations[0]
  root_management_group_name          = local.root_management_group_name
  resource_group_name                 = module.config.custom_replacements.amba_resource_group_name
  user_assigned_managed_identity_name = module.config.custom_replacements.amba_user_assigned_managed_identity_name
}

