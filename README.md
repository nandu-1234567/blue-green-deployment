Strapi Blue/Green Deployment on AWS

This repository contains the process and Terraform/AWS configuration for deploying a Strapi application on AWS using ECS Fargate, Application Load Balancer (ALB), and CodeDeploy with a Blue/Green deployment strategy. The setup ensures zero-downtime deployments with automated rollback in case of failures.

Table of Contents

Architecture Overview

AWS Infrastructure Setup

Blue/Green Deployment with CodeDeploy

Security Configuration

Deployment Workflow

Post-Deployment Steps

Benefits

Architecture Overview

ECS Fargate is used to run Strapi containers without managing servers.

Application Load Balancer (ALB) routes traffic to ECS tasks.

Blue/Green deployment strategy with CodeDeploy ensures zero downtime.

Two target groups (Blue & Green) handle traffic routing during deployment.

AWS Infrastructure Setup
VPC and Networking

Create or use an existing VPC with subnets in multiple availability zones for high availability.

Set up security groups for ECS tasks and ALB.

ECS Cluster and Service

Create an ECS cluster with Fargate launch type.

Define an ECS service for Strapi tasks.

Configure the service to register tasks with the ALB target groups.

Application Load Balancer (ALB)

Set up an ALB to distribute traffic across ECS tasks.

Configure listeners for HTTP (80) and HTTPS (443).

Create two target groups:

Blue Target Group – current production environment

Green Target Group – staging/next release environment

Configure health checks to ensure traffic is only routed to healthy tasks.

ECS Task Definition

Define a placeholder ECS task definition for the Strapi container.

Allow dynamic updates for new container image deployments.

Blue/Green Deployment with CodeDeploy
Create CodeDeploy Application

Select ECS as the compute platform.

Create Deployment Group

Assign to ECS cluster and service.

Attach a CodeDeploy service role with permissions for ECS and ALB.

Deployment Strategy

Canary: e.g., 10% traffic for 5 minutes

AllAtOnce: shifts all traffic at once

Enable automatic rollback for deployment failures.

Terminate old tasks after successful deployment.

Traffic Routing

Map ALB listener to Blue and Green target groups.

CodeDeploy switches traffic between Blue and Green during deployment.

Security Configuration
ALB Security Group

Allow inbound HTTP (80) and HTTPS (443) from the internet.

ECS Security Group

Allow traffic from ALB on Strapi port (default 1337).

IAM Roles

ECS Execution Role: Permissions to pull images and interact with AWS services.

CodeDeploy Role: Permissions to manage ECS, ALB, and tasks.

Ensure users deploying via Terraform/CI-CD have iam:PassRole for these roles.

Deployment Workflow

Build and push Strapi Docker image to a container registry (ECR or public).

Update ECS task definition with the new image version.

Trigger CodeDeploy deployment:

CodeDeploy launches tasks in the Green target group.

Performs health checks to validate new tasks.

Gradually shifts traffic from Blue to Green according to strategy.

Terminates old Blue tasks after a successful traffic shift.

Monitor deployment for failures. Automatic rollback occurs if the deployment fails.

Post-Deployment Steps

Test Strapi application via the ALB DNS to ensure traffic is correctly routed.

Update ECS task definitions for future releases.

Monitor logs and CloudWatch metrics for performance and health.

Benefits

Zero-downtime deployments using Blue/Green strategy.

Automated rollback on deployment failure.

Scalable ECS Fargate architecture with minimal server management.

Safe traffic routing through ALB health checks and canary strategies.

