#!/bin/bash
INSTANCE_NAME=instance-20250322-171245
ZONE=asia-south-a

echo "Starting GCP instance $INSTANCE_NAME..."
gcloud compute instances start $INSTANCE_NAME --zone=$ZONE
