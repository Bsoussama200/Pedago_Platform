module "eks" {
  source = "./modules/eks"
  #### EKS Cluster ####
  cluster_name    = "${local.resource_name}-eks"
  cluster_version = var.cluster_version
  environment     = var.environment
  ##### ALB Ingress Controller and External DNS #####
  external_dns          = "6.28.5"
  alb_ingress           = "1.6.1"
  alb_ingress_image_tag = "v2.6.1"
  csi_driver = "v1.32.0-eksbuild.1"
  ##### Nodes Autoscaling desired instance size #####
  instance_types  = "t3.large"
  ami_id          = "ami-05d018b6c09ba06ab" #amazon-eks-node-al2023-x86_64-standard-1.28
  desired_size    = 1
  max_size        = 5
  min_size        = 1
  max_unavailable = 1
  ##### Route53 Domain #####
  region         = "eu-west-3"
  domain         = "dev.pedago.ai"
  hosted_zone_id = "Z049375230K5WH95V9423"
  ##### Networking #####
  vpc_cidr         = data.aws_vpc.vpc.cidr_block
  private_subnet_1 = "${local.resource_name}-public-${local.az_names[0]}"
  private_subnet_2 = "${local.resource_name}-public-${local.az_names[1]}"
  ##### Logs #####
  enable_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
}
output "eks" {
  value = module.eks.eks
}

