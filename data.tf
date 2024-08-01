data "aws_vpc" "vpc" {  
    filter {    
        name   = "tag:Name"    
        values = [local.resource_name]  
        }
    }

# data "aws_subnet" "public-a" {
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-public-${local.az_names[0]}"]  
#         }
#     }

# data "aws_subnet" "public-b" {
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-public-${local.az_names[1]}"]  
#         }
#     }

# data "aws_subnet" "private-a" {  
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-private-${local.az_names[0]}"]  
#         }
#     }

# data "aws_subnet" "private-b" {  
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-private-${local.az_names[1]}"]  
#         }
#     }

# data "aws_subnet" "db-a" {  
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-database-${local.az_names[0]}"]  
#         }
#     }

# data "aws_subnet" "db-b" {  
#     filter {    
#         name   = "tag:Name"    
#         values = ["${local.resource_name}-database-${local.az_names[1]}"]  
#         }
#     }

data "aws_availability_zones" "available" {
  state = "available"
}

