<svg width="680" height="620" viewBox="0 0 680 620" xmlns="http://www.w3.org/2000/svg" role="img">
<title>EKS cluster architecture on AWS</title>
<desc>VPC across two availability zones with public and private subnets, worker nodes in private subnets, an EKS control plane, in-cluster add-ons, and an S3 state backend.</desc>
<defs>
<marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
<path d="M2 1L8 5L2 9" fill="none" stroke="#8a7f3c" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</marker>
</defs>

<rect width="680" height="620" fill="#ffffff"/>

<!-- Outer AWS region -->
<rect x="30" y="20" width="620" height="470" rx="20" fill="#F1EFE8" stroke="#5F5E5A" stroke-width="1"/>
<text x="50" y="46" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#2C2C2A">AWS · us-east-1</text>

<!-- VPC -->
<rect x="50" y="60" width="580" height="400" rx="16" fill="#E6F1FB" stroke="#185FA5" stroke-width="1"/>
<text x="70" y="86" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#042C53">VPC 10.0.0.0/16</text>

<!-- AZ a -->
<rect x="70" y="100" width="270" height="340" rx="12" fill="#F1EFE8" stroke="#5F5E5A" stroke-width="1"/>
<text x="86" y="122" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#444441">us-east-1a</text>
<!-- AZ b -->
<rect x="360" y="100" width="270" height="340" rx="12" fill="#F1EFE8" stroke="#5F5E5A" stroke-width="1"/>
<text x="376" y="122" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#444441">us-east-1b</text>

<!-- Public subnet a -->
<rect x="86" y="136" width="238" height="70" rx="10" fill="#FAEEDA" stroke="#854F0B" stroke-width="1"/>
<text x="100" y="158" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#412402">Public subnet</text>
<text x="100" y="176" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#633806">10.0.64.0/19 · NAT, ALB</text>

<!-- Public subnet b -->
<rect x="376" y="136" width="238" height="70" rx="10" fill="#FAEEDA" stroke="#854F0B" stroke-width="1"/>
<text x="390" y="158" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#412402">Public subnet</text>
<text x="390" y="176" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#633806">10.0.96.0/19 · NAT, ALB</text>

<!-- Private subnet a -->
<rect x="86" y="226" width="238" height="190" rx="10" fill="#E1F5EE" stroke="#0F6E56" stroke-width="1"/>
<text x="100" y="248" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#04342C">Private subnet</text>
<text x="100" y="266" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#085041">10.0.0.0/24</text>
<rect x="106" y="286" width="198" height="110" rx="8" fill="#9FE1CB" stroke="#0F6E56" stroke-width="1"/>
<text x="205" y="335" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#04342C" text-anchor="middle">Worker nodes</text>
<text x="205" y="353" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#085041" text-anchor="middle">t3.large</text>

<!-- Private subnet b -->
<rect x="376" y="226" width="238" height="190" rx="10" fill="#E1F5EE" stroke="#0F6E56" stroke-width="1"/>
<text x="390" y="248" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#04342C">Private subnet</text>
<text x="390" y="266" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#085041">10.0.1.0/24</text>
<rect x="396" y="286" width="198" height="110" rx="8" fill="#9FE1CB" stroke="#0F6E56" stroke-width="1"/>
<text x="495" y="335" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#04342C" text-anchor="middle">Worker nodes</text>
<text x="495" y="353" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#085041" text-anchor="middle">t3.large</text>

<!-- NAT arrows: public -> private -->
<path d="M205 206 L205 226" fill="none" stroke="#8a7f3c" stroke-width="1.5" marker-end="url(#arrow)"/>
<path d="M495 206 L495 226" fill="none" stroke="#8a7f3c" stroke-width="1.5" marker-end="url(#arrow)"/>

<!-- EKS control plane -->
<rect x="150" y="426" width="380" height="34" rx="8" fill="#CECBF6" stroke="#534AB7" stroke-width="1"/>
<text x="340" y="448" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#26215C" text-anchor="middle">EKS control plane (managed)</text>

<path d="M205 396 L205 412 L340 412 L340 426" fill="none" stroke="#7F77DD" stroke-width="1.5" marker-end="url(#arrow)"/>
<path d="M495 396 L495 412 L340 412" fill="none" stroke="#7F77DD" stroke-width="1.5"/>

<!-- Add-ons row -->
<rect x="70" y="500" width="180" height="56" rx="10" fill="#F5C4B3" stroke="#993C1D" stroke-width="1"/>
<text x="160" y="522" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#4A1B0C" text-anchor="middle">LB controller</text>
<text x="160" y="540" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#712B13" text-anchor="middle">Provisions ALB / NLB</text>

<rect x="260" y="500" width="180" height="56" rx="10" fill="#F5C4B3" stroke="#993C1D" stroke-width="1"/>
<text x="350" y="522" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#4A1B0C" text-anchor="middle">Cluster autoscaler</text>
<text x="350" y="540" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#712B13" text-anchor="middle">Scales node group</text>

<rect x="450" y="500" width="180" height="56" rx="10" fill="#F5C4B3" stroke="#993C1D" stroke-width="1"/>
<text x="540" y="522" font-family="Helvetica, Arial, sans-serif" font-size="14" font-weight="600" fill="#4A1B0C" text-anchor="middle">Metrics server</text>
<text x="540" y="540" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#712B13" text-anchor="middle">Feeds HPA</text>

<path d="M160 490 L160 500" fill="none" stroke="#999" stroke-width="1"/>
<path d="M350 490 L350 500" fill="none" stroke="#999" stroke-width="1"/>
<path d="M540 490 L540 500" fill="none" stroke="#999" stroke-width="1"/>

<!-- S3 backend, outside VPC -->
<rect x="230" y="580" width="220" height="34" rx="8" fill="#D3D1C7" stroke="#5F5E5A" stroke-width="1"/>
<text x="340" y="602" font-family="Helvetica, Arial, sans-serif" font-size="12" fill="#2C2C2A" text-anchor="middle">S3 state backend · versioned, encrypted</text>

</svg>

---

# EKS Cluster with Terraform

Infrastructure-as-code for a self-managed EKS setup on AWS — VPC, control plane, autoscaling worker nodes, and the add-ons you actually need to run something in it (ALB controller, cluster autoscaler, metrics server, pod identity). Built this to run staging workloads without relying on eksctl or a black-box module, so every resource here is explicit and easy to reason about.

## Why this exists

Most "EKS in Terraform" repos either hide everything behind the community EKS module or skip the networking layer entirely and assume you already have a VPC. This one doesn't do either — the VPC, subnets, routing, and IAM are all written out so you can see exactly what's being created and why, and swap pieces out without fighting someone else's abstraction.

## What gets built

The diagram above shows the shape of it: a VPC across two AZs, each with a public subnet (NAT gateway, load balancers) and a private subnet (worker nodes, no public IPs). The EKS control plane sits underneath both, and the in-cluster add-ons — load balancer controller, cluster autoscaler, metrics server — run on top of the node groups. Terraform state lives in S3, outside the VPC, versioned and encrypted.

## Repo layout

```
.
├── Backend.tf              S3 backend, versioning + encryption
├── providers.tf            AWS / Terraform / Helm provider config
├── locals.tf                shared env vars (region, AZs, cluster name)
├── vpc.tf                    VPC
├── subnets.tf                 public + private subnets
├── igw.tf                      internet gateway
├── nat-gateway.tf                NAT gateway(s)
├── route-tables.tf                routing for public/private
├── eks-controlplane.tf              EKS cluster resource
├── nodepools.tf                      managed node group
├── pod-identity.tf                    EKS Pod Identity addon
├── ingress-alb.tf                      ALB controller + its IAM role
├── cluster-autoscaler.tf                autoscaler deployment + IAM
├── metrics-server.tf                     metrics-server via Helm
├── iam-user-admin.tf                      admin role + user
├── IamUser.tf                              scoped-down engineer user
├── terraform-eks-auth.tf                    helm/kubernetes provider auth
├── values/metrics-server.yaml
└── terraform.tfvars                          (not committed — see below)
```

## Before you run this

- Terraform ≥ 1.6 (repo currently uses 1.16)
- AWS CLI v2, with credentials for an account you're okay creating a cluster in
- kubectl and helm
- An S3 bucket for state — either create one yourself or let Terraform manage it, but decide before your first `init`

```bash
aws s3 mb s3://<your-state-bucket> --region us-east-1
aws s3api put-bucket-versioning --bucket <your-state-bucket> --versioning-configuration Status=Enabled
```

Update the bucket name in `Backend.tf` to match.

## Standing it up

```bash
git clone https://github.com/muntaha-24/EKS-Cluster-With_Terraform-Infra-AWS.git
cd EKS-Cluster-With_Terraform-Infra-AWS

terraform init -reconfigure
terraform plan
terraform apply
```

That gives you the VPC, the control plane, an initial node group (2 nodes, scales 0–10), and the three add-ons above. First apply usually takes 12–18 minutes — most of that is the EKS control plane provisioning.

Once it's up:

```bash
aws eks update-kubeconfig --name staging-eks-controlplane --region us-east-1
kubectl get nodes
```

Tear down with `terraform destroy` — it goes cleanly since everything's tracked in the same state, no orphaned ALBs or ENIs left behind if you destroy in order.

## IAM

Two IAM users are set up for day-to-day access, separate from the roles Terraform uses for the cluster components themselves:

| User | Can do | Notes |
|---|---|---|
| `DevOps_Manager` | assumes `eks_admin_role` | full cluster admin |
| `DevOps_Engineer` | `eks:DescribeCluster`, `eks:ListClusters` | read-only, no kubectl access by default |

Service-level roles (`eks-node-group-iam-role`, `loadbalancer_controller_role`, `Cluster-Autoscaler-IAM-Role`) are scoped to what each component actually needs via Pod Identity, not blanket node IAM permissions.

## Networking

| Subnet | CIDR | AZ | Used for |
|---|---|---|---|
| Private-1 | 10.0.0.0/24 | us-east-1a | worker nodes |
| Private-2 | 10.0.1.0/24 | us-east-1b | worker nodes |
| Public-1 | 10.0.64.0/19 | us-east-1a | NAT gateway, load balancers |
| Public-2 | 10.0.96.0/19 | us-east-1b | NAT gateway, load balancers |

## Debugging when things don't come up

**Cluster stuck in `CREATING`** — normal for the first 10-15 min, check with:
```bash
aws eks describe-cluster --name staging-eks-controlplane --region us-east-1 --query cluster.status
```

**Nodes not joining** — check the node group status and cross-reference EC2 instance logs:
```bash
aws eks describe-nodegroup --cluster-name staging-eks-controlplane --nodegroup-name EKS-Worker-Nodes --region us-east-1
```

**ALB controller not provisioning a load balancer** — almost always an IAM trust or webhook issue:
```bash
kubectl describe pod -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller
kubectl get validatingwebhookconfigurations
```

**Autoscaler not scaling** — check it's actually watching the right ASG:
```bash
kubectl logs -f -n kube-system deployment/cluster-autoscaler
aws autoscaling describe-auto-scaling-groups --region us-east-1
```

## What's not in here (yet)

No metrics/logging stack beyond metrics-server — wire up Prometheus + Grafana or CloudWatch Container Insights if you need dashboards or alerting. No service mesh. No multi-cluster / DR story. This is a solid base for staging-grade workloads, not a drop-in for a highly regulated production environment.

## Contributing

Fork it, branch off, PR it. Nothing fancy — just keep changes scoped and don't commit `terraform.tfvars` or state files.

## Contact

Muntaha Noorul Hassan Bhaiji — DevOps & Cloud Engineer
[GitHub](https://github.com/muntaha-24) · [LinkedIn](https://linkedin.com/in/muntaha-noorul-hassan-bhaiji) · [muntaha.bhaiji.ca@gmail.com](mailto:muntaha.bhaiji.ca@gmail.com)

If this saved you some setup time, a star on the repo is appreciated.
