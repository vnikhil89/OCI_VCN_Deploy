provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
 
resource "oci_core_virtual_network" "terraform-vcn" {
  cidr_block     = "192.168.0.0/24"
  dns_label      = var.vcn_dns_label
  compartment_id = var.compartment_ocid
  display_name   = "terraform-vcn"
}
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.vcn_dns_label}igw"
  vcn_id         = oci_core_virtual_network.terraform-vcn.id
}
# Public Route Table
resource "oci_core_route_table" "PublicRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.terraform-vcn.id
  display_name   = "${var.vcn_dns_label}pubrt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}
resource "oci_core_subnet" "subnet" {
  availability_domain = ""
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.terraform-vcn.id
  cidr_block          = var.vcn_cidr
  display_name        = var.subnet_dns_label
  dns_label           = var.subnet_dns_label
  route_table_id      = oci_core_route_table.PublicRT.id
  security_list_ids   = [oci_core_security_list.securitylist.id]
}
resource "oci_core_security_list" "securitylist" {
  display_name   = "SL_public"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.terraform-vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }
}  