resource "aws_network_interface" "tfer--eni-002D-02e142394811bd035" {
  attachment {
    device_index = "0"
    instance     = "i-0043912a6b6f591fe"
  }

  ipv6_address_count = "0"
  private_ip         = "172.31.56.181"
  private_ips        = ["172.31.56.181"]
  private_ips_count  = "0"
  security_groups    = ["sg-fb39dade"]
  source_dest_check  = "true"
  subnet_id          = "subnet-cd0432e6"
}
