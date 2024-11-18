from diagrams import Diagram, Cluster
from diagrams.aws.network import PrivateSubnet,PublicSubnet, ALB, InternetGateway, NATGateway
from diagrams.aws.compute import EC2AutoScaling, EC2

with Diagram("Simple Production Architecture", show=True):
    internet_gateway = InternetGateway("Internet Gateway")
    
    # VPC
    with Cluster("VPC"):
        # Public and Private Subnets
        with Cluster("ALB"):
            alb = ALB("Application Load Balancer")
        with Cluster("Availability Zone 1"):
            public_subnet_az1 = PublicSubnet("Public Subnet AZ1")
            private_subnet_az1 = PrivateSubnet("Private Subnet AZ1")
            nat_gateway_az1 = NATGateway("NAT Gateway AZ1")
            Bastion_Host=EC2("Bastion-Host")

           #connections
            internet_gateway - public_subnet_az1 << nat_gateway_az1
            nat_gateway_az1 - private_subnet_az1
            Bastion_Host >> public_subnet_az1

        with Cluster("Availability Zone 2"):
            public_subnet_az2 = PublicSubnet("Public Subnet AZ2")
            private_subnet_az2 = PrivateSubnet("Private Subnet AZ2")
            nat_gateway_az2 = NATGateway("NAT Gateway AZ2")

            #connections
            internet_gateway - public_subnet_az2 << nat_gateway_az2
            nat_gateway_az2 - private_subnet_az2

        # Application Load Balancer (ALB) spanning two public subnets
        
        alb << [public_subnet_az1, public_subnet_az2]

        # Auto Scaling Group within private subnets
        with Cluster("Auto Scaling Group"):
            auto_scaling_group = EC2AutoScaling("ASG")
            ec2_instance_az1 = EC2("EC2 in Private AZ1")
            ec2_instance_az2 = EC2("EC2 in Private AZ2")

            private_subnet_az1 << ec2_instance_az1
            private_subnet_az2 << ec2_instance_az2
            auto_scaling_group - [ec2_instance_az1, ec2_instance_az2]

        
        alb >> auto_scaling_group
        

        
