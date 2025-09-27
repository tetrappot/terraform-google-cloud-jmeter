# Terraform Google Cloud JMeter

This project deploys a JMeter master-slave environment on Google Cloud Platform (GCP) using Terraform.

## Architecture

The environment consists of the following components:

-   **VPC Network**: A dedicated VPC and subnet for the JMeter instances.
-   **JMeter Master**: A single Compute Engine instance that acts as the JMeter master node.
-   **JMeter Slaves**: A group of Compute Engine instances that act as JMeter slave nodes. The number of slave instances is configurable.
-   **Startup Scripts**: Scripts to install and configure JMeter on the master and slave instances upon startup.

## Prerequisites

Before you begin, ensure you have the following installed and configured:

-   [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/install)
-   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
-   A GCP project with the Compute Engine API enabled.
-   Authentication configured for Terraform to access your GCP project.

## Usage

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd terraform-google-cloud-jmeter
    ```

2.  **Navigate to the environment directory:**
    ```bash
    cd terraform/environments/pord
    ```

3.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

4.  **(Optional) Customize the configuration:**
    You can modify the `terraform.tfvars` file (you may need to create it) or the variables in `main.tf` and `local.tf` to suit your needs (e.g., change the number of slave instances, machine types, etc.).

5.  **Apply the Terraform plan:**
    ```bash
    terraform apply
    ```

    Review the plan and type `yes` to confirm.

6.  **Destroy the infrastructure:**
    When you are finished with the stress testing, you can destroy all the created resources:
    ```bash
    terraform destroy
    ```

## Terraform Modules

### `vpc`

-   **Source:** `modules/vpc`
-   **Description:** Creates a VPC network, a subnet, and reserves static IP addresses.

### `compute_engine`

-   **Source:** `modules/compute_engine`
-   **Description:** Creates Compute Engine instances for the JMeter master and slaves.

## Inputs

The following are some of the key input variables that can be configured.

### `compute_engine` Module

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `instance_name` | Name of the instance. | `string` | n/a |
| `machine_type` | Machine type of the instance. | `string` | n/a |
| `zone` | Zone where the instance will be created. | `string` | n/a |
| `disk_image` | Image name for the boot disk. | `string` | `"ubuntu-os-cloud/ubuntu-2204-lts"` |
| `instance_count`| The number of slave instances to create. | `number` | `1` |
| `provisioning_model`| Provisioning model (`STANDARD` or `SPOT`). | `string` | `"STANDARD"` |

### `vpc` Module

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `vpc_name` | The name of the VPC. | `string` | n/a |
| `routing_mode` | The network routing mode. | `string` | `"REGIONAL"` |
| `ip_number` | The number of IP addresses to reserve. | `number` | `1` |

## Outputs

| Name | Description |
| :--- | :--- |
| `ip_address` | The external IP addresses of the created instances. |
| `internal_ip_address` | The internal IP addresses of the created instances. |
