resource "google_folder" "this" {
  for_each = toset(var.folders)

  display_name = each.value
  parent       = "organizations/${var.org_id}"
}

# Organization policy: restrict resource locations org-wide.
resource "google_org_policy_policy" "resource_locations" {
  name   = "organizations/${var.org_id}/policies/gcp.resourceLocations"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      values {
        allowed_values = [for r in var.allowed_regions : "in:${r}-locations"]
      }
    }
  }
}

# Disable creation of service account keys (boolean constraint).
resource "google_org_policy_policy" "disable_sa_keys" {
  name   = "organizations/${var.org_id}/policies/iam.disableServiceAccountKeyCreation"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# Require OS Login on all VMs.
resource "google_org_policy_policy" "require_os_login" {
  name   = "organizations/${var.org_id}/policies/compute.requireOsLogin"
  parent = "organizations/${var.org_id}"

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}
