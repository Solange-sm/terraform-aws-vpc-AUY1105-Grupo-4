# --- VPC PRINCIPAL ---
resource "aws_vpc" "mi_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# --- CONECTIVIDAD (INTERNET GATEWAY) ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mi_vpc.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# --- SUBREDES PÚBLICAS ---
resource "aws_subnet" "subnet_publica_1" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = false # Solución CKV_AWS_130

  tags = {
    Name = "${var.environment}-subnet-publica-1"
  }
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = false # Solución CKV_AWS_130

  tags = {
    Name = "${var.environment}-subnet-publica-2"
  }
}

# --- SUBREDES PRIVADAS ---
resource "aws_subnet" "subnet_privada_1" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.environment}-subnet-privada-1"
  }
}

resource "aws_subnet" "subnet_privada_2" {
  vpc_id            = aws_vpc.mi_vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.environment}-subnet-privada-2"
  }
}

# --- NAT GATEWAY (CON EIP) ---
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_publica_1.id

  tags = {
    Name = "${var.environment}-nat-gw"
  }
}

# --- TABLAS DE RUTAS Y ASOCIACIONES PÚBLICAS ---
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.mi_vpc.id

  tags = {
    Name = "${var.environment}-public-rtb"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.subnet_publica_1.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.subnet_publica_2.id
  route_table_id = aws_route_table.public_rtb.id
}

# --- TABLAS DE RUTAS Y ASOCIACIONES PRIVADAS ---
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.mi_vpc.id

  tags = {
    Name = "${var.environment}-private-rtb"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.subnet_privada_1.id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.subnet_privada_2.id
  route_table_id = aws_route_table.private_rtb.id
}

# --- SECURITY GROUP (Para la EC2 de la EV1) ---
resource "aws_security_group" "sg_computo" {
  name        = "${var.environment}-sg"
  description = "Security Group gestionado por el modulo de redes para la instancia EC2"
  vpc_id      = aws_vpc.mi_vpc.id

  # checkov:skip=CKV_AWS_260: Requerido por la actividad para exponer el servidor web HTTP
  # checkov:skip=CKV2_AWS_5: El SG se asocia a la instancia en un modulo externo (EC2)

  # Entrada: SSH restringido por la IP inyectada del Orquestador
  ingress {
    description = "Acceso SSH seguro"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mi_ip_acceso]
  }

  # Entrada: HTTP abierto para el Web Server
  ingress {
    description = "Acceso Web HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida: Permitir todo el tráfico saliente
  egress {
    description = "Salida total permitida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg"
  }
}
