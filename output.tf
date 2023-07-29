output "elastic_IP" {
  description = "Elastic IP address"
  value       = aws_eip.NAT-Gateway-EIP.public_ip
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.webtier-alb.dns_name
}

output "database_endpoint" {
  description = "The endpoint of the database"
  value       = aws_rds_cluster_instance.database-instance.*.endpoint
}


output "bastion_host_public_ip" {
  description = "Public IP address for bastion host"
  value       = aws_instance.bastion-host.public_ip
}