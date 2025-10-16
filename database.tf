# Create Database Tier Security Group
resource "aws_security_group" "database-sg" {
  name        = "Database-SG"
  description = "Allow inbound traffic from apptier "
  vpc_id      = aws_vpc.P1-3-tier-archi.id

  ingress {
    description     = "Allow mysql from apptier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.apptier-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-SG"
  } 
}

# Associate Database Subnet
resource "aws_db_subnet_group" "database-subnet" {
  name         = "database subnets"
  subnet_ids   = [for subnet in aws_subnet.private_database_subnet : subnet.id]
  tags         = {
    Name = "database-subnet"
  }
}
# Create Database Instance
resource "aws_rds_cluster_instance" "database-instance" {
  count                = 2
  identifier           = "aurora-database-${count.index + 1}"
  cluster_identifier   = aws_rds_cluster.database-tier.id
  instance_class       = "db.r5.2xlarge"
  engine               = aws_rds_cluster.database-tier.engine
  engine_version       = aws_rds_cluster.database-tier.engine_version
  db_subnet_group_name = aws_db_subnet_group.database-subnet.name
}

# Create Database Aurora Cluster
resource "aws_rds_cluster" "database-tier" {
  cluster_identifier        = "database"
  availability_zones        = var.azs
  db_subnet_group_name      = aws_db_subnet_group.database-subnet.name
  engine                    = "aurora-mysql"
  master_username           = var.username
  master_password           = var.password
  vpc_security_group_ids    = [aws_security_group.database-sg.id]
  skip_final_snapshot       = true
}
