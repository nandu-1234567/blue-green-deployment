output "blue_tg_name" {
  value = aws_lb_target_group.blue.name
}

output "green_tg_name" {
  value = aws_lb_target_group.green.name
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}