resource "aws_vpc" "vpc-matiastest" {
    cidr_block = aws_vpc.vpc-matiastest.id
    tags = {
        Name = "Matias-test"
        Owner = "Endava"
    }
}

resource "aws_subnet" "public-subnet-1" {
    
}