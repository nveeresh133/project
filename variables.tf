 variable "subnet_id_1" {
  type = string
  default = "subnet-081d9614647b4b353"
 }

 variable "subnet_id_2" {
  type = string
  default = "subnet-09e0b60c9fe9ef8ad"
 }

 variable "workernodes-name" {
  default = "eks-node-group"
 }

 variable "veeresh-eks-name" {
  default = "veeryash-cluster"
 }


 variable "worker-node-group-name" {
  default = "veeryash-workernodes"
 }



 variable "k8s-iam-role-name" {
  default = "veerole-iam-role"
 }
 
variable "AmazonEKSClusterPolicy-policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 }

 variable "AmazonEC2ContainerRegistryReadOnly-EKS-policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 }

 variable "AmazonEKSWorkerNodePolicy-policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
 }

 variable "AmazonEKS_CNI_Policy-policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
 }

 variable "EC2InstanceProfileForImageBuilderECRContainerBuilds-policy_arn" {
  default = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
 }

 variable "AmazonEC2ContainerRegistryReadOnly-policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 }




