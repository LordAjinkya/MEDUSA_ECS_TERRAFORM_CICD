resource "aws_db_subnet_group" "medusa_db_subnet_group" {
  name       = "medusa-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "Medusa DB subnet group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow ECS access to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "PostgreSQL access from ECS"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_instance" "medusa_postgres" {
  identifier              = "medusa-postgres-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.7"
  instance_class          = "db.t3.micro"
  db_name                 = "medusadb"
  username                = "medusauser"
  password                = "MedusaDBStrongPassword123!" # Secure this
  db_subnet_group_name    = aws_db_subnet_group.medusa_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false

  tags = {
    Name = "Medusa PostgreSQL DB"
  }
}