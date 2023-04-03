#____________________________________________Elastic IPs
resource "aws_eip" "nat" {
  count = var.has_single_nat_gateway ? 1 : length(var.zones)
  vpc   = true
}

#____________________________________________Attach managed NAT
resource "aws_nat_gateway" "nat" {
  count         = var.has_single_nat_gateway ? 1 : length(var.zones)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    Name = "${var.environment_name}-NAT"
  }
}