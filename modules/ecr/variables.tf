variable "ecr_name" {
  
}
variable "ecr_repositories" {
  default = ["application","gateway","administration","reference"]
}

variable "eks_nodes_role_arn" {
  
}