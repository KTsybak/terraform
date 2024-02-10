variable "instance_type" {
        default = "t2.micro"
}


variable "ami_id" {
        description = "The AMI to use"
        default = "ami-05c13eab67c5d8861"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}
variable "subnet_prv1" {
 
}
variable "myvpc" {
 
}