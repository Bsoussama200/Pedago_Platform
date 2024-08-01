# data "aws_vpc" "vpc" {  
#     filter {    
#         name   = "tag:Name"    
#         values = [local.resource_name]  
#         }
#     }


    
data "aws_subnet" "private-a" {  
    filter {    
        name   = "tag:Name"    
        values = [var.private_subnet_1]  
        }
    }

data "aws_subnet" "private-b" {  
    filter {    
        name   = "tag:Name"    
        values = [var.private_subnet_2]  
        }
    }


