# Elastic Stack Sandbox Creation Code
This repository was created to help individuals that want to quickly and easily provision an Elastic Stack environment in AWS.  

# Disclaimer
1. If you chose to build an environment in AWS using this code there will be resources provisioned that will cost you $$. Review the resources that will be provisioned prior to the installation.
2. This repository should not be used to build your production environment and you should familiarize yourself with the proper security settings for running Elastic Stack and Docker in AWS.  

# Pre-deployment Requirements
1. You have an AWS account created
2. You have HashiCorp Terraform, HashiCorp Packer, git and AWS CLI installed on your local machine
3. You have created an IAM user assigned the appropriate permissions and created an access key (This will be needed by Terraform and Packer)
4. You have an IDE installed such as Visual Studio Code

# Pre-deployment Installation
* Terraform installation can be found at: https://developer.hashicorp.com/terraform/downloads
* Packer installation can be found at: https://developer.hashicorp.com/packer/downloads
* AWS CLI installation can be found at: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* Git installation can be found at: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

# Deployment Steps High Level Summary

## Configure AWS access key / secret key profile on local machine 
*(Requires AWS CLI client to be installed before step 1 - See Pre-deployment Installation)*
1. On your local machine run **aws configure --profile test-profile**
2. It will ask you for the access key, secret key, default region, etc.  You should have this information from step 3 in the Pre-deployment Requirements. 
3. Once this is completed the test-profile profile will be configured

## Clone this repository
1. On your local machine run **git clone https://github.com/mamos88/elasticstack**
2. This should clone the repository down to your local machine so you can update the required inputs

## Creating the Elastic Stack Server Amazon Machine Image (AMI) Using Packer
1. The packer folder contains two sub folders; server and client folders
2. It is recommended to build the server AMI first.  There are a few variables in the file that you should update and include:
   * ami_name
   * region
   * source_ami
3. At run time, you need to pass in the profile (which is *test-profile* based on the instructions above) and server_source_ami variables.  The server_source_ami would be the latest Amazon Linux AMI id in the region you will be deploying the environment.
4. Obtain the latest Amazon Linux AMI id from the region you want to deploy the image. The AMI id will be used in the next step.
5. 
6. 

   *NOTE: the server_source_ami value will most likely be different than in the example above since you would have obtained it yourself and it will be based on the region you select as well as if the source AMI has been updated since these instructions were written.*

   **Also, there is a period . at the end of the packer build command above, make sure you include that in the execution or you will observe and error**
   
7. If Packer is installed, the AWS CLI is installed and the AWS profile is set up as per the instructions above, Packer should connect to AWS, provision an EC2 instance, run the elasticstack-install-amazon-linux.sh file also found in the server folder and eventually build an AMI.  

Need to update the documentation below.  This information is not valid for this project.

## Creating the Nomad/Consul Client Amazon Machine Image (AMI) Using Packer
1. The steps for the client is simlilar to the server.  You need to be in the packer\client directory in the terminal.  
2. Update the NOMAD_VERSION and CONSUL_VERSION values to be the same as the server from step 5 in the previous section. The two files to update are: 
   *nomad-client-install-amazon-linux.sh* *nomad-client-install-ubuntu-linux.sh* 
*NOTE: I included two different client operating system types so you can see how easy it is to build a Nomad environment with more than one operating system.*
3. On your local machine  navigate your terminal to the packer\client folder and run **packer build -var "profile=test-profile" -var "server_source_ami=ami-08333bccc35d71140"**
4. If everything is successful, you will have three AMI's successfully created that when started by Terraform will run a fully functional Nomad/Consul environment with 3 server nodes and two client nodes.

## Deploying the Nomad/Consul Environment using Terraform
If you have gotten to this point you successfully created your AMI's in AWS and at this point you are ready to deploy the infrastructure/resources using Terraform. 

## Required variables.tf updates prior to deployment
There are a few updates you need to make to the Terraform code for it to be deployed for your use.  Most of the changes are to the variables.tf file and are found in the section *These are variables you need to change before run time*

The variables in the variables.tf have comments next to the lines you need to update. 

## Optional updates to auto_scaling_group.tf
The auto_scaling_group.tf creates two auto scaling groups, one for the Amazon linux client and the other for the Ubuntu linux client.  There are two secions with max_size = 1 and min_size = 1.  You can increase this or leave it alone. If left alone, the code will configure each auto scaling group with a single node.
**NOTE: if you decide to change the number of instances to a higher value, your cost will increase.**

## Optional updates to security_groups.tf
The security_groups.tf has many test ports that I have used over time in my testing.  You can reduce the ports down to the bare minimum by commenting out or removing un-necessary sections.  The required ports for Nomad and Consul can be found the addresses below.
**Nomad Ports:** https://developer.hashicorp.com/nomad/docs/install/production/requirements#ports-used
**Consul Ports:** https://developer.hashicorp.com/consul/docs/install/ports

# Deploying the infrastructure with Terraform
If you are not familiar with the required steps to deploy resources with Terraform you can find information here https://developer.hashicorp.com/terraform/tutorials/cli/plan.  

The following steps should be performed:
1. run *terraform init* in the same directory where the main.tf is located.  
2. run *terraform plan* 
    You will prompt you for the profile you created in the *Configure AWS access key* section.  In this example, it is test-profile.  The terraform plan will show you the resources that will be provisioned if applied.
3. If your are satisfied with the plan the next step is to run *terraform apply*.  If all goes well, it will provision the infrastructure.  The consul url and nomad url will be accessible.  

**NOTE: Dont forget to run a terraform destroy when you are done or your will accumulate expenses**

Good luck!!


 
