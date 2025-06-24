# NOTE: Take into account that the project_name must be unique and FULL LOWERCASE, 
#   since it will be used as a prefix for all the resources. It may fail if your name is too generic.
project_name = "myappv2testing" # the name of your app
#######


domain_name  = "tradenethub.com" # your domain
subdomain    = "mytest" # subdomain to use for the app


azs             = ["us-east-1a", "us-east-1b"] ## change according your case

cluster_name     = "myappv2testing-cluster"
container_image  = "nginx:latest"
desired_count    = 1
min_capacity     = 1 # minimum number of tasks
max_capacity     = 3 # maximum number of tasks

high_cpu_threshold    = 50
low_cpu_threshold     = 5
high_memory_threshold = 50
low_memory_threshold  = 5

emails = ["example@example.com"]  # SNS will notify this list if the system scales up or down
#     #NOTE: The email must accept the subcription which is sent to the email automatically