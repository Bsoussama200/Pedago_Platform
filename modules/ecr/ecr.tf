# resource "aws_ecr_repository" "ecr" {
#   name                 = var.ecr_name
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = false
#   }

# }

################################################################################
# ECR Repository
################################################################################
 data "aws_caller_identity" "current" {}

module "public_ecr" {
    count = length(var.ecr_repositories)
    source  = "terraform-aws-modules/ecr/aws"
    version = "2.2.1"
    repository_name = "${var.ecr_repositories[count.index]}"

    repository_read_write_access_arns = [data.aws_caller_identity.current.arn,var.eks_nodes_role_arn]
    repository_lifecycle_policy = jsonencode({
        rules = [
        {
            rulePriority = 1,
            description  = "Keep last 30 images",
            selection = {
            tagStatus     = "tagged",
            tagPrefixList = ["v"],
            countType     = "imageCountMoreThan",
            countNumber   = 30
            },
            action = {
            type = "expire"
            }
        }
        ]
    })

}