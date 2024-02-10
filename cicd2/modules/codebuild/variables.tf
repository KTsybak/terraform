variable "project_name" {
  type        = string
  default = "gitbucket"
}
variable "codebuild-timeout" {
  type        = string
  default = "5"
}

variable "region"{
  type        = string
  default = "us-east-1"
}

variable "aws-iam-role-name"{
  type = string
  default = "AWSCodeBuild"
}

