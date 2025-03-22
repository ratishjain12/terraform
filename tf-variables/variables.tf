variable "region" {
  type = string
  default = "ap-south-1"
  description = "region"
}

variable "ec2_config" {
  type = object({
    instance_type = string
    v_size = number
    v_type = string
  })
  description = "ec2 config"
  default = {
    instance_type = "t3.micro"
    v_size = 30
    v_type = "gp2"
  }
  validation {
    condition = var.ec2_config.instance_type  == "t3.micro" || var.ec2_config.instance_type == "t3.small"
    error_message = "instance type must be t3.micro or t3.small"
  }
}
 
variable "additional_tags" {
  type = map(string)
  description = "additional tags"
  default = {}
}
