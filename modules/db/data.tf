data "aws_vpc" "vpc" {  
    filter {    
        name   = "tag:Name"    
        values = [var.vpc_name]  
        }
    }


    
data "aws_subnet" "db-a" {  
    filter {    
        name   = "tag:Name"    
        values = [var.db_subnet_1]  
        }
    }

data "aws_subnet" "db-b" {  
    filter {    
        name   = "tag:Name"    
        values = [var.db_subnet_2]  
        }
    }


