variable "loc" {
    description             = "Default Azure Region"
    default                 = "West US 2"
}

variable "tags" {
    default = {
        source              = "citadel"
        env                 = "training"
    }
}