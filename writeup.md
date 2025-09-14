Project Write-up – DevOps Task
Tools and Services Used

GitHub was used for source code management with two branches, main and dev, to follow a clear branching strategy.

Jenkins was used to set up the CI/CD pipeline and automate the process.

Docker was used to containerize the Node.js application.

AWS Elastic Container Registry (ECR) was used to store Docker images.

AWS Elastic Kubernetes Service (EKS) was used to deploy and manage the application.

Terraform was used as a starting point for Infrastructure as Code with basic scaffolding created.

AWS CloudWatch was used for monitoring and logging of the application.

Challenges Faced and How They Were Solved

GitHub authentication in Jenkins
At first, the pipeline failed when trying to push changes from the dev branch to the main branch. This was because Jenkins did not have proper GitHub credentials. The issue was resolved by storing the GitHub username and token in Jenkins credentials and using them inside the pipeline.

Updating deployments on EKS
Another challenge was ensuring that the application deployed on EKS was updated whenever a new Docker image was built. This was solved by using the kubectl set image command in the Jenkins pipeline, which triggered a rolling update on the Kubernetes deployment.

Limited scope for Terraform
Due to time limitations, it was not possible to write full Terraform scripts to provision all resources. Instead, the basic structure of Terraform files was created (main.tf, variable.tf, output.tf) so that infrastructure automation can be extended later.

Possible Improvements

Expanding the Terraform code to manage the complete AWS infrastructure, including the EKS cluster, networking, IAM roles, and ECR.

Replacing the placeholder test stage with proper unit and integration tests for the Node.js application.

Using Helm charts instead of plain kubectl commands to make Kubernetes deployments easier to manage and upgrade.

Setting up a complete monitoring stack using Prometheus and Grafana for better observability.

Adding security enhancements like image scanning and secret management tools such as Vault or AWS Systems Manager.

Key Learnings

By completing this task, I was able to gain practical experience in setting up an end-to-end CI/CD pipeline with Jenkins. I learned how to connect different tools such as GitHub, Docker, ECR, and EKS into one workflow. I also understood how a branching strategy combined with approvals helps in controlled deployments. Finally, I got an introduction to Infrastructure as Code with Terraform and identified areas where it can be expanded further.