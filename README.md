

---

# Simple App in Production VPC Infrastructure  

This repository provides a Terraform configuration to deploy a production-ready Virtual Private Cloud (VPC) infrastructure on AWS. The infrastructure includes multiple subnets, an Auto Scaling Group (ASG) for EC2 instances, a central Application Load Balancer (ALB), and a remote backend configured with Amazon S3 and DynamoDB. 

As an example of how a real application works, the Auto Scaling Group's EC2 instances serve a **simple static web page**.

---

## Features

- **VPC with CIDR Block:** Configurable IPv4 CIDR block for the VPC.  
- **Availability Zones:** Supports two Availability Zones (AZs).  
- **Subnets:**  
  - **Public Subnets:** Two public subnets for external traffic.  
  - **Private Subnets:** Two private subnets for internal workloads.  
- **NAT Gateways:** To allow outbound internet access from private subnets.  
- **Internet Gateway:** To enable internet connectivity for public subnets.  
- **Auto Scaling Group:** Dynamically manages EC2 instances in private subnets.  
  - Instances serve a **simple static web page** to demonstrate how real applications can work in this infrastructure.  
- **Application Load Balancer (ALB):** Distributes incoming traffic across multiple instances.  
- **Remote Backend:**  
  - State files are stored in an S3 bucket for centralized state management.  
  - DynamoDB is used for state locking to prevent concurrent modifications.  
- **Modular Design:** Terraform modules for reusable components like VPC, subnets, ASG, ALB, etc.

---

## Architecture Diagram

The following diagram depicts the infrastructure's architecture:

*(Insert the generated diagram here using the [diagrams library](https://diagrams.mingrammer.com/))*

---

## Prerequisites

- AWS CLI installed and configured with appropriate credentials.
- Terraform v1.0.0 or newer.
- Graphviz (if using the Python diagrams library for visualization).
- Python 3.x for diagram generation.

---

## Usage

### Clone the Repository

```bash
git clone https://github.com/koushalAkash26/Production_Vpc_Infra.git
cd Production_Vpc_Infra
```

### Configure Terraform Variables

Edit the `.tfvars` file corresponding to your desired environment (e.g., `dev.tfvars`, `prod.tfvars`) to set values such as:

- `vpc_cidr`
- `availability_zones`
- `public_subnets`
- `private_subnets`
- `key_pair_name`  

### Initialize Terraform

```bash
terraform init
```

### Plan and Apply

To plan and visualize the changes:  
```bash
terraform plan -var-file="dev.tfvars"
```

To apply the changes and provision resources:  
```bash
terraform apply -var-file="dev.tfvars"
```

### Access the Static Web Page

Once the resources are created:
1. Note the DNS name or public IP of the Application Load Balancer (ALB).
2. Open it in your browser to view the **static web page** served by the EC2 instances.

### Destroy Resources

To remove all provisioned resources:  
```bash
terraform destroy -var-file="dev.tfvars"
```

---

## File Structure

```
.
├── main.tf                   # Root Terraform configuration
├── variables.tf              # Variable definitions
├── outputs.tf                # Outputs from Terraform
├── provider.tf               # Backend and provider configuration
├── modules/                  # Terraform modules
│   ├── vpc/                  # Module for VPC and subnets
│   ├── alb/                  # Module for ALB and target groups
│   ├── autoscaling/          # Module for ASG and EC2 instances
├── dev.tfvars                # Development environment variables
├── prod.tfvars               # Production environment variables
├── Diagram.py                # Python script to generate architecture diagram
├── userdata.sh               # Bash script which responsibe to sample webpage
```

---

## Remote Backend Configuration  

This Terraform setup uses a **remote backend**:  
- **State Storage:** AWS S3 bucket.  
- **State Locking:** DynamoDB table to prevent concurrent state modifications.  

Ensure the following resources are created in your AWS account before using this setup:  
1. An S3 bucket for storing the Terraform state file.  
2. A DynamoDB table for state locking.

---

## Diagram Generation

Use the [diagrams library](https://diagrams.mingrammer.com/) to generate architecture diagrams.  

Run the following command:  
```bash
python Diagram.py
```

Ensure Graphviz is installed and added to your system's PATH.

---


## License

This project is licensed under the MIT License.

---

## Author

👤 **[Koushal Akash](https://github.com/koushalAkash26)**  

---
