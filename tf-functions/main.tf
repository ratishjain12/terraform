terraform {}

locals {
  value = "Hello, World!"
}

variable "string_list" {
  type    = list(string)
  default = ["server1", "server2", "server3", "server1", "server2", "server3"]
}

output "output_upper" {
  value = upper(local.value)
}

output "output_lower" {
  value = lower(local.value)
}

output "starts_with" {
  value = startswith(local.value, "He")
}

output "split" {
  value = split(" ", local.value)
}

output "min" {
  value = min(1, 2, 3, 4, 5)
}

output "max" {
  value = max(1, 2, 3, 4, 5)
}

output "abs" {
  value = abs(-10)
}

output "ceil" {
  value = ceil(1.5)
}

output "floor" {
  value = floor(1.5)
}

output "length" {
  value = length(var.string_list)
}

output "join" {
  value = join(":", var.string_list)
}

output "contains" {
  value = contains(var.string_list, "server1")
}

output "toset" {
  value = toset(var.string_list)
}






