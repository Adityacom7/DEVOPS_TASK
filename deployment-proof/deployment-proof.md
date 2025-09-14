![alt text](image.png)

Started by user Aditya Singh
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/devops_task
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] echo
 Checking out code...
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/devops_task/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Adityacom7/DEVOPS_TASK.git # timeout=10
Fetching upstream changes from https://github.com/Adityacom7/DEVOPS_TASK.git
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
 > git fetch --tags --force --progress -- https://github.com/Adityacom7/DEVOPS_TASK.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/dev^{commit} # timeout=10
Checking out Revision a639af400b950a84704bff2d1f7a7b8e62dc4014 (refs/remotes/origin/dev)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f a639af400b950a84704bff2d1f7a7b8e62dc4014 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D dev # timeout=10
 > git checkout -b dev a639af400b950a84704bff2d1f7a7b8e62dc4014 # timeout=10
Commit message: "Test"
 > git rev-list --no-walk a639af400b950a84704bff2d1f7a7b8e62dc4014 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build)
[Pipeline] echo
 Installing dependencies...
[Pipeline] sh
+ npm install

up to date, audited 70 packages in 958ms

14 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Dockerize)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
 Building Docker image...
[Pipeline] sh
+ docker build -t devops-task:latest .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 332B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:18-alpine
#2 DONE 1.8s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/5] FROM docker.io/library/node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 122.16kB 0.0s done
#5 DONE 0.1s

#6 [2/5] WORKDIR /usr/src/app
#6 CACHED

#7 [3/5] COPY package*.json ./
#7 CACHED

#8 [4/5] RUN npm install --production
#8 CACHED

#9 [5/5] COPY . .
#9 DONE 0.5s

#10 exporting to image
#10 exporting layers
#10 exporting layers 0.2s done
#10 writing image sha256:42820d718247f4b25e402aebe321493a70b715ba24d43b913c453f9440f671e2 done
#10 naming to docker.io/library/devops-task:latest done
#10 DONE 0.2s
+ docker tag devops-task:latest 975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task:26
+ docker tag devops-task:latest 975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task:latest
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push to AWS ECR)
[Pipeline] echo
 Pushing Docker image to AWS ECR...
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] sh
+ set -x
+ aws ecr get-login-password --region ap-south-1
+ docker login --username AWS --password-stdin 975050277554.dkr.ecr.ap-south-1.amazonaws.com

WARNING! Your credentials are stored unencrypted in '/var/lib/jenkins/.docker/config.json'.
Configure a credential helper to remove this warning. See
https://docs.docker.com/go/credential-store/

Login Succeeded
+ echo Pushing image to ECR...
Pushing image to ECR...
+ docker push 975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task:26
The push refers to repository [975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task]
3df518323539: Preparing
ade4e89faa70: Preparing
35fe15dec614: Preparing
cdebb9cca9b8: Preparing
82140d9a70a7: Preparing
f3b40b0cdb1c: Preparing
0b1f26057bd0: Preparing
08000c18d16d: Preparing
0b1f26057bd0: Waiting
08000c18d16d: Waiting
f3b40b0cdb1c: Waiting
82140d9a70a7: Layer already exists
35fe15dec614: Layer already exists
ade4e89faa70: Layer already exists
cdebb9cca9b8: Layer already exists
f3b40b0cdb1c: Layer already exists
0b1f26057bd0: Layer already exists
08000c18d16d: Layer already exists
3df518323539: Pushed
26: digest: sha256:f6774176e91cf0f56b6d6dac69171a577388f808be186adc5399c4d3626d0f83 size: 1994
+ docker push 975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task:latest
The push refers to repository [975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task]
3df518323539: Preparing
ade4e89faa70: Preparing
35fe15dec614: Preparing
cdebb9cca9b8: Preparing
82140d9a70a7: Preparing
f3b40b0cdb1c: Preparing
0b1f26057bd0: Preparing
08000c18d16d: Preparing
f3b40b0cdb1c: Waiting
0b1f26057bd0: Waiting
08000c18d16d: Waiting
35fe15dec614: Layer already exists
ade4e89faa70: Layer already exists
3df518323539: Layer already exists
82140d9a70a7: Layer already exists
cdebb9cca9b8: Layer already exists
f3b40b0cdb1c: Layer already exists
0b1f26057bd0: Layer already exists
08000c18d16d: Layer already exists
latest: digest: sha256:f6774176e91cf0f56b6d6dac69171a577388f808be186adc5399c4d3626d0f83 size: 1994
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Test)
[Pipeline] echo
🔹 Running tests...
[Pipeline] sh
+ echo  All tests passed!
 All tests passed!
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Approval for Merge)
[Pipeline] script
[Pipeline] {
[Pipeline] timeout
Timeout set to expire in 1 hr 0 min
[Pipeline] {
[Pipeline] input
Approve merging dev → main and deploying to EKS?
Approve & Continue or Abort
Approved by Aditya Singh
[Pipeline] }
[Pipeline] // timeout
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Merge to main)
[Pipeline] echo
 Merging dev → main...
[Pipeline] withCredentials
Masking supported pattern matches of $GIT_PASS
[Pipeline] {
[Pipeline] sh
+ git config user.name jenkins
+ git config user.email jenkins@example.com
+ git fetch origin
+ git checkout main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
+ git merge origin/dev --no-ff -m Automated merge from dev to main by Jenkins
Already up to date.
+ git push https://adityacom7:****@github.com/Adityacom7/DEVOPS_TASK.git main
Everything up-to-date
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy to EKS)
[Pipeline] echo
 Deploying to EKS...
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] sh
+ set -x
+ aws eks --region ap-south-1 update-kubeconfig --name Devops_tas-clusterk
Added new context arn:aws:eks:ap-south-1:975050277554:cluster/Devops_tas-clusterk to /var/lib/jenkins/.kube/config
+ kubectl set image deployment/devops-task-deployment devops-task=975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task:26 --record
Flag --record has been deprecated, --record will be removed in the future
deployment.apps/devops-task-deployment image updated
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
 Pipeline executed successfully! Deployment complete.
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS



ECR 
![alt text](image.png)

975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task


EKS

![alt text](image.png)

![alt text](image-1.png)
![alt text](image-2.png)


deployed

![alt text](image-3.png)




INFRA
![alt text](image.png)

![alt text](image-1.png)

![alt text](image.png)

ubuntu@bastion:~/DEVOPS_TASK/infra$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the    
following symbols:
  + create

Terraform will perform the following actions:

  # aws_ecr_repository.devops_repo will be created
  + resource "aws_ecr_repository" "devops_repo" {
      + arn                  = (known after apply)
      + id                   = (known after apply)
      + image_tag_mutability = "MUTABLE"
      + name                 = "devops-task"
      + region               = "ap-south-1"
      + registry_id          = (known after apply)
      + repository_url       = (known after apply)
      + tags_all             = (known after apply)

      + encryption_configuration {
          + encryption_type = "AES256"
          + kms_key         = (known after apply)
        }

      + image_scanning_configuration {
          + scan_on_push = true
        }
    }

  # aws_eks_cluster.devops_cluster will be created
  + resource "aws_eks_cluster" "devops_cluster" {
      + arn                           = (known after apply)
      + bootstrap_self_managed_addons = true
      + certificate_authority         = (known after apply)
      + cluster_id                    = (known after apply)
      + created_at                    = (known after apply)
      + deletion_protection           = (known after apply)
      + endpoint                      = (known after apply)
      + id                            = (known after apply)
      + identity                      = (known after apply)
      + name                          = "Devops_tas-clusterk"
      + platform_version              = (known after apply)
      + region                        = "ap-south-1"
      + role_arn                      = "arn:aws:iam::975050277554:role/AmazonEKSAutoNodeRole"
      + status                        = (known after apply)
      + tags_all                      = (known after apply)
      + version                       = "1.33"

      + access_config (known after apply)

      + kubernetes_network_config (known after apply)

      + upgrade_policy (known after apply)

      + vpc_config {
          + cluster_security_group_id = (known after apply)
          + endpoint_private_access   = false
          + endpoint_public_access    = true
          + public_access_cidrs       = (known after apply)
          + subnet_ids                = [
              + "subnet-00f008188269e4dbf",
              + "subnet-0368a5018ee5dbab9",
              + "subnet-041ec962e92eca6ac",
            ]
          + vpc_id                    = (known after apply)
        }
    }

  # aws_eks_node_group.devops_nodes will be created
  + resource "aws_eks_node_group" "devops_nodes" {
      + ami_type               = "AL2023_x86_64_STANDARD"
      + arn                    = (known after apply)
      + capacity_type          = (known after apply)
      + cluster_name           = "Devops_tas-clusterk"
      + disk_size              = 20
      + id                     = (known after apply)
      + instance_types         = [
          + "t3.medium",
        ]
      + node_group_name        = "devops-task-nodes"
      + node_group_name_prefix = (known after apply)
      + node_role_arn          = "arn:aws:iam::975050277554:role/adieksnode"
      + region                 = "ap-south-1"
      + release_version        = (known after apply)
      + resources              = (known after apply)
      + status                 = (known after apply)
      + subnet_ids             = [
          + "subnet-00f008188269e4dbf",
          + "subnet-0368a5018ee5dbab9",
          + "subnet-041ec962e92eca6ac",
        ]
      + tags_all               = (known after apply)
      + version                = (known after apply)

      + node_repair_config (known after apply)

      + scaling_config {
          + desired_size = 2
          + max_size     = 3
          + min_size     = 1
        }

      + update_config (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + cluster_arn      = (known after apply)
  + cluster_endpoint = (known after apply)
  + cluster_name     = "Devops_tas-clusterk"
  + ecr_repo_url     = (known after apply)
  + nodegroup_name   = "devops-task-nodes"

──────────────────────────────────────────────────────────────────