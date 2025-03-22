terraform {}

variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [{
    fname = "John"
    lname = "Doe"
    }, {
    fname = "Jane"
    lname = "Doe"
  }]
}

variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }
}

locals {

  mul = 2 * 2
  add = 2 + 2
  sub = 2 - 2
  div = 2 / 2

  double = [for num in var.num_list : num * 2]
  odd    = [for num in var.num_list : num if num % 2 != 0]
}

output "output" {
  value = local.odd
}