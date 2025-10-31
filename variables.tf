variable "vpc_cidr" {
 type        = string
 description = "VPC CIDR value"
 default     = "10.0.0.0/16"
}

variable "public_webtier_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
 
variable "private_apptier_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_database_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}

variable "amis" {
  type        = string
  description = "Instance AMI"
  default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "username" {
  default = "DB12345"
  description = "The username for the DB master user"
  type        = string
  sensitive   = true
}
variable "password" {
  default = "Chioma145"
  description = "The password for the DB master user"
  type        = string
  sensitive   = true
}

variable "key_pair" {
  default = "olakp"
}