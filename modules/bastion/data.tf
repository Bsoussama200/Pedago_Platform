
data "aws_vpc" "vpc" {  
    filter {    
        name   = "tag:Name"    
        values = [var.vpc_name]  
        }
    }    
data "aws_subnet" "public-a" {  
    filter {    
        name   = "tag:Name"    
        values = [var.public_subnet_1]  
        }
    }



