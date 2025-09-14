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