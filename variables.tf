variable "aws_region" {
  description = "The region name to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "client_instance_type" {
  description = "elasticsearch Client Instance Type"
  default = "t2.medium"
}

variable "elasticsearch_server_instance_type" {
  description = "EC2 instance type/size for elasticsearch nodes"
  type        = string
  default     = "t2.medium"
}

variable "elasticsearch_client_count" {
  description = "The number of server nodes (should be 3 or 5)"
  type        = number
  default     = 3
}

variable "subnet_count" {
  description = "The number of desired subnets"
  type        = number
  default     = 3
}

variable "elasticsearch_server_count" {
  description = "The number of server nodes (should be 3 or 5)"
  type        = number
  default     = 3
}

variable "az_map" {
  type = map(any)

  default = {
    0 = "a"
    1 = "b"
    2 = "c"
  }
}

# Load Balancer Variables
variable "health_check" {
   type = map(string)
   default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "8080"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}

# These are variables you need to change before run time
# --------------------------------------------------------
# Change the first element in the list to your IP address
variable "allowed_ip_network" {
  description = "Networks allowed in security group for ingress rules"
  type        = list(any)
  default     = ["184.98.50.94/32", "10.0.0.0/16"] # Modify this with your local machine IP. Only replace the 174.26.226.144 with your IP.
}

# This is the AMI for the Server node.  Change it to match the one generated with Packer server AMI build
variable "elasticsearch_server_ami_id" {
  description = "AMI ID to use for elasticsearch server nodes"
  type        = string
  default = "ami-05410cf0f076b18fa" # Modify this with the server AMI you created
}

variable "elasticsearch_client_amazon_ami_id" {
  description = "AMI ID to use for elasticsearch server nodes"
  type        = string
  default = "ami-0c0408c0144a15657" # Modify this with the Amazon client AMI you created
}

variable "elasticsearch_client_ubuntu_ami_id" {
  description = "AMI ID to use for elasticsearch server nodes"
  type        = string
  default = "ami-0d608de721309a282" # Modify this with the ubuntu client AMI you created
}

# This is your keypair name for connecting to the instance.  Change it to a valid keypair in our account/region.
variable "aws_key_name" {
  description = "SSH key name"
  type        = string
  default     = "test1-keypair" # Modify this with the keypair you created
}

variable "profile" {
  description = "This is your AWS profile"
  type = string
}