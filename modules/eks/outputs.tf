
output "eks" {
  value = <<EOF
###################################### KUBECONFIG ###########################################

        aws eks --region us-east-1 update-kubeconfig --name ${var.cluster_name}

############################# N E T W O R K I N G ###########################################
        VPC ID                                  
        Private subnet 1                        ${data.aws_subnet.private-a.id}
        Private subnet 2                        ${data.aws_subnet.private-b.id}
###################################### ALB ASG ACM ##########################################
        EKS Cluster autoscaler role arn         ${aws_iam_role.eks_cluster_autoscaler.arn}
                
        AWS LoadBalancer controller arn         ${aws_iam_role.aws_load_balancer_controller.arn}

        ACM Certificate arn                     ${module.cert.arn}
###################################### EKS Cluster #####################################################

        ${var.cluster_name} EKS Cluster Role    ${aws_iam_role.dev.arn}
        EKS Nodes Group Role                    ${aws_iam_role.nodes.arn}
        EKS OIDC                                ${aws_iam_role.dev_oidc.arn}
        OpenID Connect Provider                 ${aws_iam_openid_connect_provider.eks.url}
        Launch Template ID                      ${aws_launch_template.dev.id}
    EOF
}
