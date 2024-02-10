resource "aws_codebuild_project" "gitbucket" {
  name          = var.project_name
  build_timeout = var.codebuild-timeout
  service_role  = aws_iam_role.codebuild-iam-role.arn

  artifacts {
   type      = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    
 
    }


    source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }  
}
resource "aws_iam_role" "codebuild-iam-role" {
  name = var.aws-iam-role-name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "codebuild-role-policy" {
    role = aws_iam_role.codebuild-iam-role.name
     policy = file("./policyforcodebuild.json")
 
}