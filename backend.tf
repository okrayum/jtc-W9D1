# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/docs/backends/types/remote.html
terraform {
  cloud {
     organization = "TechSolutions_Inc"

    workspaces {
      name = "workspace_W9D1"
    }
  }

  required_version = ">= 1.1.2"
}
