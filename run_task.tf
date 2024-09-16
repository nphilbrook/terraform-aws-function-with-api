locals {
  slug_parts = split(",", var.TFC_WORKSPACE_SLUG)
  org_name   = local.slug_parts[0]
  ws_name    = local.slug_parts[1]
}

data "tfe_workspace" "this" {
  organization = local.org_name
  name         = local.ws_name
}

data "tfe_organization_run_task" "packer" {
  organization = local.org_name
  name         = "HCP-Packer"
}

resource "tfe_workspace_run_task" "example" {
  workspace_id      = data.tfe_workspace.this.id
  task_id           = data.tfe_organization_run_task.packer.id
  enforcement_level = "advisory"
  stages            = ["post_plan"]
}
