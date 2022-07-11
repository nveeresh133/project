provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_iam_role" "k8s-iam-role" {
 name = var.k8s-iam-role-name

 path = "/"

 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = var.AmazonEKSClusterPolicy-policy_arn
 role    = aws_iam_role.k8s-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = var.AmazonEC2ContainerRegistryReadOnly-EKS-policy_arn
 role    = aws_iam_role.k8s-iam-role.name
}


resource "aws_eks_cluster" "veeresh-eks" {
 name = var.veeresh-eks-name
 role_arn = aws_iam_role.k8s-iam-role.arn

 vpc_config {
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]
 }

 depends_on = [
  aws_iam_role.k8s-iam-role,
 ]
}

resource "aws_iam_role" "workernodes" {
  name = var.workernodes-name

assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = var.AmazonEKSWorkerNodePolicy-policy_arn
  role    = aws_iam_role.workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = var.AmazonEKS_CNI_Policy-policy_arn
  role    = aws_iam_role.workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = var.EC2InstanceProfileForImageBuilderECRContainerBuilds-policy_arn
  role    = aws_iam_role.workernodes.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = var.AmazonEC2ContainerRegistryReadOnly-policy_arn
  role    = aws_iam_role.workernodes.name
 }


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.veeresh-eks.name
  node_group_name = var.worker-node-group-name
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [var.subnet_id_1, var.subnet_id_2]
  #capacity_type = "SPOT"
  instance_types = ["t2.medium"]

  scaling_config {
   desired_size = 1
   max_size   = 5
   min_size   = 1
  }

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }




