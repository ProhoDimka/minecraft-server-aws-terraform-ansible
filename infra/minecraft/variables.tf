variable "region" {
  description = "List of regions to add cert"
  type        = string
  default     = "ap-south-1"
}
variable "vpc_id" {
  type = string
  default = ""
}

variable "environment" {
  type = string
  default = "minecraft"
}
variable "account_domain_init_name" {
  description = "account domain zone name"
  type        = string
  default     = "minecraft.example.com"
}
variable "account_domain_name" {
  description = "SHIT STICKS! IT MUST BE !NULL! BECAUSE DEPENDENCY WAITING ITS INITIALIZATION!"
  type        = string
  default     = null
}

variable "is_prebuilded_ami" {
  description = "Did you know ami_id instead?"
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "Known ami ID"
  type        = string
  default     = "ami-09cb52a45c0a64e7a"
}

