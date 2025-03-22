# Auto-Scaling to Google Cloud Platform (GCP) from Local VM

## Project Overview
This project demonstrates a resource monitoring system running on a local VM. It monitors CPU, RAM, and disk usage, and triggers auto-scaling to **Google Cloud Platform (GCP)** when the resource usage exceeds a defined threshold. This system ensures that your application scales automatically to handle increased resource demand.

### Key Features:
- **Local VM Monitoring**: Running a sample application (Node.js or Python).
- **Resource Monitoring**: A custom `monitor.sh` script checks CPU, RAM, and disk usage.
- **Auto-Scaling**: The `autoscale.sh` script triggers the creation of new instances in **GCP** when thresholds are exceeded.
- **Cloud Deployment**: New instances are automatically deployed and the app is launched on GCP.

## Prerequisites
- **Google Cloud Account** with **Compute Engine** access.
- **Google Cloud SDK** installed and configured (`gcloud` command-line tool).
- **VMware/VirtualBox** to create a local VM.
- **Linux-based Operating System** for the VM (Debian 11 recommended).

## Architecture Diagram
![architectureAssignment3](https://github.com/user-attachments/assets/4f3e3af4-1330-488b-9e9e-b7313ea91574)

## Getting Started

### 1. Clone the Repository
To get started, clone the repository to your local machine:

```bash
git clone https://github.com/sachinsingh2156/VCC-Assignment-3.git
cd VCC-Assignment-3
```
### 2. Set Up Google Cloud SDK
Follow the official guide to install and configure the Google Cloud SDK on your local machine.

Authenticate with your Google Cloud account:

```bash
gcloud auth login
```
Set your Google Cloud project:

```bash
gcloud config set project YOUR_PROJECT_ID
```

### 3. Create a Local VM (Using VirtualBox or VMware)
Install VirtualBox or VMware and create a new VM.

Install Debian 11 (or your preferred OS) and configure the VM (minimum 2GB RAM and 20GB storage recommended).

Ensure the VM has SSH access set up.

### 4. Deploy Sample Application to the Local VM
Set up your sample app (e.g., Node.js or Python) on the VM.

Run the application to ensure it's working correctly on your local VM.

OR

You can use stress-ng to overload your virtual machine and autoscale it to GCP

```bash
stress-ng --cpu 4 --vm 2 --timeout 300
```

### 5. Monitor Resources with monitor.sh
The monitor.sh script monitors CPU, RAM, and disk usage on the local VM.

Threshold: The script triggers auto-scaling when either CPU usage or RAM usage exceeds 75%.

To run the script manually:

```bash
./monitor.sh
```

To automate the monitoring, you can schedule the script to run at regular intervals using cron or run it in the background.

### 6. Set Up Auto-Scaling with autoscale.sh
The autoscale.sh script is triggered when resource usage exceeds the defined threshold.

Edit the script to include your GCP Instance Name and Zone.

Run the script to trigger the auto-scaling action:

```bash
./autoscale.sh
```
The script will automatically trigger the creation of a new instance in GCP based on the current resource usage.

### 7. Auto-Scaling in GCP
Ensure you have an Instance Group set up in GCP with auto-scaling enabled. For example:

```bash
gcloud compute instance-groups managed set-autoscaling my-instance-group --max-num-replicas=5 --target-cpu-utilization=0.75 --zone=ZONE
```
This command sets the auto-scaling policy for the instance group, triggering scaling when the CPU utilization exceeds 75%.

### 8. Viewing Logs and Debugging
Monitor the logs to ensure auto-scaling is working correctly:

Local VM logs: View the monitor.sh logs for resource usage.

GCP logs: Use the gcloud CLI to view instance creation logs.

```bash
gcloud logging read "resource.type=gce_instance" --limit 10
```
## Conclusion
This project showcases an automated system for monitoring resource usage on a local VM and triggering auto-scaling to Google Cloud when needed. By integrating resource monitoring and auto-scaling policies, the system ensures that your app can handle increased loads dynamically.

Feel free to modify and extend the project as needed!
