# Notification System Infrastructure

## Overview

This project implements a **highly modular, scalable, and secure notification system** designed for deployment on AWS using Infrastructure as Code (IaC). The system enables multi-channel delivery (Email, SMS, Push, Webhook) and supports both AWS-native and third-party integrations. It is built with Terraform as the core provisioning tool, and includes support for other IaC frameworks (Terragrunt, CloudFormation, Pulumi) and multiple CI/CD pipelines.

The infrastructure is structured for **composability, reusability, security, and high availability**, following a layered architecture and clean separation of concerns.

---

## Repository Layout

```

ROOT/
├── README.md
├── Terraform/
├── Terragrunt/
├── CloudFormation/
├── Pulumi/
├── CICD/

```

### Directory Descriptions

- **README.md**  
  Project introduction, structure explanation, and usage guidance.

- **Terraform/**  
  Core Terraform infrastructure code. Organized into modules, environments, services, tenants, and global configurations. This is the primary provisioning framework.

- **Terragrunt/**  
  Terragrunt configurations for managing Terraform infrastructure with better DRY practices and environment layering.

- **CloudFormation/**  
  Alternative AWS-native IaC using YAML templates. Includes stacks, reusable templates, and parameter definitions.

- **Pulumi/**  
  IaC code using Pulumi with support for Python/TypeScript-based AWS provisioning as an alternative to Terraform.

- **CICD/**  
  All CI/CD automation configurations, including GitHub Actions, Jenkins, and AWS CodePipeline. Organized per IaC tool.
