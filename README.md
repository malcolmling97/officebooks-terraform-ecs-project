# officebooks-terraform-ecs-project
Storing Terraform code for officebooks project

Title: OfficeBooks booking system

Deliverables:
• Web application to be accessible over the internet and thus handle HTTP traffic.
• The database tier should have restricted access (not open to HTTP) and allow traffic only through the web tier. The database tier should allow outbound requests via NAT.
• They would like to reduce the administrative burden of managing their database and requires a managed database for their database engine in the proposed solution. They need the database to be highly available.
• Currently they experience medium to high traffic on their network. The traffic to the web tier is managed by a load balancer which diverts traffic to healthy instances. They would ideally like a Load Balancer with an ability to perform layer 4 (Transport Protocol) and layer 7 (Application) checks while balancing the load. There is no requirement at this point to balance the load on the database tier.
• In their current setup, the traffic being inconsistent, requires over provisioning resulting in increased costs. In order to overcome this issue, they would like the new system to allow automatic scaling in the event of a traffic spike.
• They have many reports to be generated on a daily basis to their customers, and these reports incur heavy read operations on the database. The setup should allow these report generations with minimal impact on the performance of their web application.


Design process: (as per git pushes)

To implement this:
- The env file is already stored within the s3, so take the variables from the env file of the application to run, and store it within 'officebooks.env'
- to adjust variables, edit 'terraform.tfvars'
- projects are properly tagged with "${var.project_name}-${var.environment}" so the tag names will show up accordingly after terraform applying
- terraform apply and it should run smoothly


Files and what they do:
- acm - certificate validation
- alb - creating load balancing to direct ports to subnets
- asg - set autoscale for cluster to be once tasks hit about 70% CPU utilization
- backend - used for backend
- ecs-role - creates the roles and permissions allowed for tasks within the ecs
- ecs - Creates my cluster, definitions and sercice. Set to run 2 tasks at all times.
- nat-gateway - to set up private subnets for application layer
- output - outputs the URL
- rds - to setup RDS database, is shut off temporarily cause I haven't used it 
- Database is highly available if the "multi_az_deployment" is switched on
- route-53 - to set IP addresses by routing to alb DNS from domain address
- s3 - to store env file located in my local directory
- security-group - determines the ingress and egress ports for alb, server and database
- terraform.tfvars - to assign constant variables throughout terraform
- variables - to define variables throughout terraform
- vpc - sets up local VPC network and define gateways and subnets within


To improve on / not implemented due to time constraint:
- Would understand how to authenticate, GET and POST variables within database 
- Could run the docker image on my EC2 instance by hosting the port on 6565:3000, but didn't have time to configure and manage to run it on a FARGATE on 80. Would need more time to experiment my docker
- Would have implemented gitclone in the dockerfile and included the information in .env file in order to have a better CICD process