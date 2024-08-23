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
  csi_driver = "v1.33.0-eksbuild.1"
  ##### Nodes Autoscaling desired instance size #####
  instance_types  = "t3.large"
  # ami_id          = "ami-05d018b6c09ba06ab" #amazon-eks-node-al2023-x86_64-standard-1.28
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
  private_subnet_1 = "${local.resource_name}-private-${local.az_names[0]}"
  private_subnet_2 = "${local.resource_name}-private-${local.az_names[1]}"
  ##### Logs #####
  enable_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
}
output "eks" {
  value = module.eks.eks
}

module "db" {
  source = "./modules/db"
  db_name = "${local.resource_name}-db"
  vpc_name = local.resource_name
  db_subnet_1 = "${local.resource_name}-database-${local.az_names[0]}"
  db_subnet_2 = "${local.resource_name}-database-${local.az_names[1]}"
  db_engine_version="14.10"
  db_family="postgres14"
  db_major_engine_version="14"
  db_instance_class="db.t3.small"
  db_multi_az= false
  kms_key_arn=""
  db_database_username= "postgres"
  db_maintenance_window=""
  db_apply_immediately=true
  db_force_ssl = false
  skip_final_snapshot = true
 
}

module "bastion" {
  source = "./modules/bastion"
  vpc_name = local.resource_name
  bastion_host_name = "${local.resource_name}-bastion"
  public_subnet_1 = "${local.resource_name}-public-${local.az_names[0]}"
  ssh_key = var.ssh_key
}

module "ecr"{
  source    = "./modules/ecr"
  ecr_name  = "${local.resource_name}-ecr"
  eks_nodes_role_arn = module.eks.nodes_role_arn
  depends_on = [ module.eks ]
}