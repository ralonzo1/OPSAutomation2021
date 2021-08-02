resource "aws_instance" "tfer--i-002D-0043912a6b6f591fe_moodle_dev1" {
  ami                         = "ami-07dd19a7900a1f049"
  associate_public_ip_address = "true"
  availability_zone           = "us-west-2d"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "2"

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_termination = "false"

  ebs_block_device {
    delete_on_termination = "true"
    device_name           = "/dev/sdb"
    encrypted             = "false"
    iops                  = "100"
    throughput            = "0"
    volume_size           = "20"
    volume_type           = "gp2"
  }

  ebs_optimized = "false"

  enclave_options {
    enabled = "false"
  }

  get_password_data  = "false"
  hibernation        = "false"
  instance_type      = "t3.medium"
  ipv6_address_count = "0"
  key_name           = "moodle"

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "optional"
  }

  monitoring = "false"
  private_ip = "172.31.56.181"

  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    volume_size           = "8"
    volume_type           = "gp2"
  }

  security_groups   = ["default"]
  source_dest_check = "true"
  subnet_id         = "subnet-cd0432e6"

  tags = {
    Name       = "moodle_dev1"
    moodle_dev = "True"
  }

  tenancy                = "default"
  vpc_security_group_ids = ["sg-fb39dade"]
}
