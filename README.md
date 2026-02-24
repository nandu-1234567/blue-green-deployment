Strapi Blue/Green Deployment on AWS – Process Guide

This document outlines the end-to-end process for deploying a Strapi application on AWS using ECS Fargate, Application Load Balancer (ALB), and CodeDeploy Blue/Green deployments. The goal is to achieve zero-downtime deployments with automated rollback in case of failures.

1. Plan the Deployment Architecture

Decide to use ECS Fargate to run containers without managing servers.

Deploy Strapi as a containerized application.

Use an Application Load Balancer (ALB) to route traffic.

Implement Blue/Green deployment strategy using CodeDeploy to avoid downtime.

2. Set Up AWS Infrastructure

VPC and Networking

Create or use an existing VPC with subnets in multiple availability zones for high availability.

Set up security groups for ECS tasks and ALB.

ECS Cluster and Service

Create an ECS cluster with the Fargate launch type.

Define an ECS service to run Strapi tasks.

Configure the service to register tasks with the ALB target groups.

Application Load Balancer (ALB)

Set up an ALB to distribute traffic across ECS tasks.

Configure the ALB listener to accept HTTP and HTTPS traffic.

Create two target groups: one for the blue environment, one for the green environment.

Configure health checks for the target groups to ensure traffic only goes to healthy tasks.

ECS Task Definition

Define a placeholder ECS task definition for the Strapi container.

Ensure it can be updated dynamically with new container images for deployments.

3. Set Up CodeDeploy for Blue/Green Deployment

Create a CodeDeploy Application

Choose ECS as the compute platform.

Create a CodeDeploy Deployment Group

Assign the deployment group to the ECS cluster and service.

Attach the CodeDeploy service role with permissions to manage ECS and ALB resources.

Configure Deployment Strategy

Use Canary (10% traffic, 5 minutes) or AllAtOnce strategies.

Set automatic rollback in case of deployment failure.

Configure CodeDeploy to terminate old tasks after a successful deployment.

Configure Traffic Routing

Map the ALB listener to the Blue and Green target groups.

During deployment, CodeDeploy switches traffic between the blue and green environments.

4. Security Configuration

ALB Security Group

Allow inbound HTTP (port 80) and HTTPS (port 443) from the internet.

ECS Security Group

Allow traffic from the ALB on the Strapi port (typically 1337).

IAM Roles

ECS Execution Role: Grants ECS tasks permissions to pull images and interact with AWS services.

CodeDeploy Role: Grants CodeDeploy permission to manage ECS, ALB, and tasks.

Ensure users deploying via Terraform or CI/CD have iam:PassRole permission for these roles.

5. Deployment Workflow

Build and push the Strapi Docker image to your container registry (ECR or public).

Update the ECS task definition with the new image version.

Trigger CodeDeploy deployment:

CodeDeploy launches tasks in the green target group.

Performs health checks to ensure new tasks are running correctly.

Gradually shifts traffic from blue to green according to the deployment strategy.

Terminates old blue tasks after successful traffic shift.

Monitor deployment for any failures. Automatic rollback occurs if the deployment fails.

6. Post-Deployment

Test the Strapi application via the ALB DNS to ensure traffic is routed correctly.

Update the ECS task definition for future releases.

Monitor application logs and CloudWatch metrics to verify performance and health.

7. Benefits of This Approach

Zero-downtime deployments with Blue/Green strategy.

Automated rollback on deployment failure.

Scalable ECS Fargate architecture with minimal server management.

Traffic safety through ALB health checks and Canary deployment strategies.

