variable "vpc_cidr_block" {
    type= string
    default = "10.0.0.0/16"
}
variable "subnet_count" {
    type= map(number)
    default = {
        public = 1,
        private = 2
    }
}
variable "public_cidr" {
  type= string
  default = "10.0.1.0/24"
}
variable "public_zone" {
  type= string
   default =  "us-east-1b"
}
variable "private_cidr" {
  type= list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}
variable "private_zone" {
  type= list(string)
  default = [
    "us-east-1e",
    "us-east-1f"
  ]
}

