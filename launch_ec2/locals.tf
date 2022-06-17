
locals {
  tags = { a_tag : "somevalue" }

#  Change in the Launch Template
  current_ami_name      = "PA-VM-AWS-10.0.6-7064e142-2859-40a4-ab62-8b0996b842e9"
  current_instance_type = "m5.xlarge"

  vpc_id = "vpc-03199d0eb30c33691"

  fw_01_name              = "aws-fw-oh-01"
  fw_01_template_version  = "5"
  fw_01_availability_zone = "us-east-2a"
  fw_01_eth0_subnet_id    = "subnet-03f9bf5f7e3c98d3b"
  fw_01_eth0_ip           = "10.0.1.5"
  fw_01_eth1_subnet_id    = "subnet-013cb1850b2714728"
  fw_01_eth1_ip           = "10.0.2.5"

  fw_02_name              = "aws-fw-oh-02"
  fw_02_template_version  = "5"
  fw_02_availability_zone = "us-east-2a"
  fw_02_eth0_subnet_id    = "subnet-03f9bf5f7e3c98d3b"
  fw_02_eth0_ip           = "10.0.1.6"
  fw_02_eth1_subnet_id    = "subnet-013cb1850b2714728"
  fw_02_eth1_ip           = "10.0.2.6"
}
