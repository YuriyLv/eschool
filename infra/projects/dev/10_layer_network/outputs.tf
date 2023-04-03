output "vpc_id" {
  value = module.aws_network.vpc_id
}

output "vpc_cidr" {
  value = module.aws_network.vpc_cidr
}

output "public_subnet_ids" {
  value = module.aws_network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.aws_network.private_subnet_ids
}

output "nat_private_ips" {
  value = module.aws_network.nat_private_ips
}

output "nat_public_ips" {
  value = module.aws_network.nat_public_ips
}

output "public_subnet_route_ids" {
  value = module.aws_network.public_subnet_route_ids
}

output "private_subnet_route_ids" {
  value = module.aws_network.private_subnet_route_ids
}

output "zones" {
  value = module.aws_network.zones
}

output "sg_private" {
  value = module.aws_network.sg_private
}

output "public_zone_id" {
  value = module.aws_network.public_zone_id
}

output "sg_https" {
  value = module.aws_network.sg_https
}

output "public_zone_name" {
  value = module.aws_network.public_zone_name
}