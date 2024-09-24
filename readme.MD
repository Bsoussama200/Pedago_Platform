
# Pedago Platform Terraform Infrastructure

This repository contains Terraform code to deploy the Pedago platform infrastructure on AWS. The infrastructure includes:

- **EKS (Elastic Kubernetes Service)**: For managing Kubernetes clusters.
- **RDS (Relational Database Service)**: For database hosting.
- **Bastion Host**: For secure access to private resources within the VPC.

## Prerequisites

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## How to Use

1. **Clone the repository**:
   ```bash
   git clone https://github.com/PEDAGO-AI/Pedago_Platform.git
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Create a new environment**:
   - Create a new Terraform workspace with the name of the environment (e.g., `dev`).
   ```bash
   terraform workspace new <env>
   ```

4. **Apply the Terraform code**:
   ```bash
   terraform apply
   ```

This will provision the EKS cluster, RDS database, and bastion host.
