
# Octupus Project

This project demonstrates the use of Docker and Terraform to deploy an NGINX server in a containerized environment. The project is designed to showcase the advantages of using containers in a DevOps pipeline.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- Docker
- Terraform
- Git

## Getting Started

### 1. Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/yp3yp3/octupus.git
cd octupus
```

### 2. Set Execution Permission for `init.sh`

The `init.sh` script is responsible for initializing the environment. You need to give it execution permissions:

```bash
chmod +x init.sh
```

### 3. Run the Initialization Script

Now, run the initialization script to set up the environment:

```bash
./init.sh
```

This script will:

- Initialize Terraform
- Deploy the infrastructure defined in the Terraform configuration
- Build and deploy the web app

