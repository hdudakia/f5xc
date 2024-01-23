resource "volterra_aws_vpc_site" "site" {
  name                    = var.f5xc_aws_vpc_site_name
  namespace               = var.f5xc_namespace
  aws_region              = var.f5xc_aws_region
  tags                    = var.custom_tags
  labels                  = var.f5xc_labels
  enable_internet_vip     = var.f5xc_aws_vpc_enable_internet_vip
  disable_internet_vip    = var.f5xc_aws_vpc_enable_internet_vip ? false : true
  instance_type           = var.f5xc_aws_vpc_ce_instance_type
  logs_streaming_disabled = var.f5xc_aws_vpc_logs_streaming_disabled
  no_worker_nodes = var.f5xc_aws_vpc_no_worker_nodes
  nodes_per_az    = var.f5xc_aws_vpc_worker_nodes_per_az > 0 ? var.f5xc_aws_vpc_worker_nodes_per_az : null
  total_nodes     = var.f5xc_aws_vpc_total_worker_nodes > 0 ? var.f5xc_aws_vpc_total_worker_nodes : null
  ssh_key         = var.ssh_public_key

  aws_cred {
    name      = var.f5xc_aws_cred
    namespace = var.f5xc_namespace
  }

  vpc {
    vpc_id = var.f5xc_aws_vpc_existing_id
  }

  dynamic "ingress_gw" {
    for_each = var.f5xc_aws_ce_gw_type == var.f5xc_nic_type_single_nic ? [1] : []
    content {
      aws_certified_hw        = var.f5xc_aws_ce_certified_hw[var.f5xc_aws_ce_gw_type]
      allowed_vip_port {
        use_http_https_port = var.f5xc_aws_vpc_use_http_https_port
      }
    az_nodes {
      aws_az_name = "${var.f5xc_aws_region}a"
      local_subnet {
        existing_subnet_id = var.f5xc_aws_vpc_local_existing_subnet_id
      }
    }
      # dynamic "az_nodes" {
      #   for_each = var.f5xc_aws_vpc_az_nodes
      #   content {
      #     aws_az_name = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_az_name"]

      #     dynamic "local_subnet" {
      #       for_each = var.f5xc_aws_vpc_primary_ipv4 != "" ? [1] : []
      #       content {
      #         subnet_param {
      #           ipv4 = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_local_subnet"]
      #         }
      #       }
      #     }
      #     dynamic "local_subnet" {
      #       for_each = var.f5xc_aws_vpc_primary_ipv4 == "" ? [1] : []
      #       content {
      #         # existing_subnet_id = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_local_existing_subnet_id"]
      #         existing_subnet_id = var.f5xc_aws_vpc_local_existing_subnet_id
      #       }
      #     }
      #   }
      # }
    }
  }

  # dynamic "ingress_egress_gw" {
  #   for_each = var.f5xc_aws_ce_gw_type == var.f5xc_nic_type_multi_nic ? [1] : []
  #   content {
  #     aws_certified_hw        = var.f5xc_aws_ce_certified_hw[var.f5xc_aws_ce_gw_type]

  #     allowed_vip_port {
  #       use_http_https_port = var.f5xc_aws_vpc_use_http_https_port
  #     }
  #     allowed_vip_port_sli {
  #       use_http_https_port = var.f5xc_aws_vpc_use_http_https_port_sli
  #     }

  #     dynamic az_nodes {
  #       for_each = var.f5xc_aws_vpc_primary_ipv4 != "" && var.f5xc_aws_vpc_existing_id == "" ? var.f5xc_aws_vpc_az_nodes : {}
  #       content {
  #         aws_az_name = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_az_name"]


  #         workload_subnet {
  #           subnet_param {
  #             ipv4 = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_workload_subnet"]
  #           }
  #         }

  #         dynamic "inside_subnet" {
  #           for_each = contains(keys(var.f5xc_aws_vpc_az_nodes[az_nodes.key]), "f5xc_aws_vpc_inside_subnet") ? [1] : []
  #           content {
  #             subnet_param {
  #               ipv4 = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_inside_subnet"]
  #             }
  #           }
  #         }

  #         outside_subnet {
  #           subnet_param {
  #             ipv4 = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_outside_subnet"]
  #           }
  #         }
  #       }
  #     }

  #     dynamic az_nodes {
  #       for_each = var.f5xc_aws_vpc_primary_ipv4 == "" && var.f5xc_aws_vpc_existing_id != "" ? var.f5xc_aws_vpc_az_nodes : {}
  #       content {
  #         aws_az_name = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_az_name"]

  #         workload_subnet {
  #           existing_subnet_id = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_workload_existing_subnet_id"]
  #         }

  #         dynamic "inside_subnet" {
  #           for_each = contains(keys(var.f5xc_aws_vpc_az_nodes[az_nodes.key]), "f5xc_aws_vpc_inside_existing_subnet_id") ? [1] : []
  #           content {
  #             existing_subnet_id = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_inside_existing_subnet_id"]
  #           }
  #         }

  #         outside_subnet {
  #           existing_subnet_id = var.f5xc_aws_vpc_az_nodes[az_nodes.key]["f5xc_aws_vpc_outside_existing_subnet_id"]
  #         }
  #       }
  #     }
  #   }
  # }

  lifecycle {
    ignore_changes = [labels]
  }
}

resource "volterra_tf_params_action" "aws_vpc_action" {
  site_name       = volterra_aws_vpc_site.site.name
  site_kind       = var.f5xc_aws_site_kind
  action          = var.f5xc_tf_params_action
  wait_for_action = var.f5xc_tf_wait_for_action
  depends_on = [ volterra_aws_vpc_site.site ]
}