output "cluster_name" {
    value = module.ecs.cluster_name
}

output "service_name" {
    value = module.ecs.service_name
}

output "codedeploy_app_name" {
    value = module.codedeploy.app_name
}

output "deployment_group_name" {
    value = module.codedeploy.deployment_group_name
}