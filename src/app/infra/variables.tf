variable "devices" {
  description = "List of devices to register"
  type = list(object({
    order_identifier = string
    serial_number    = string
    product_key      = string
    group_tag        = string
  }))
}
