variable "loc" {
    description             = "Default Azure Region"
    default                 = "westus2"
}

variable "tags" {
    default = {}
}

variable "webapplocs" {
    description             = "Azure region locations for web apps"
    default                 = []
}