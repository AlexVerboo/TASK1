# TASK1
Author: Alex Verboonen Cabrera
This repo holds the terraform files which will deploy and destroy infrastructure on GCP
All of the compnents used in this proyect are for educational propurses only, the use of this proyect will be set to be private one its use is over.
Instructions:
1. Create a service account (SA) with a custom role that has the minimum roles/permissions to 
read from PubSub and write into GCS (Cloud Storage). 
a. Create a Compute Engine instance setting up the SA created before.
b. Create a PubSub Topic and Subscription.
c. Create a Cron job which uses gcloud command to read the PubSub messages and write 
it into GCS as a json file (you should store “data” key:value).
d. Create a Cloud Scheduler to publish a new message to the PubSub topic every 1 minute 
at Mexico City time zone (CST). 
To finish the task, you should:
1. Write the Terraform scripts to create and configure the resources described above. 
2. Integrate the Terraform scripts in a Jenkins pipeline, where it should deploy and destroy the 
GCP resources.

Architecture Description:

All the infrastructural elements have been declared on Terrafor files, this proyect is connected to GCP.




b. Provide an overview of the terraform scripts.
c. The integration with Jenkins.
d. Some improvements that you could recommend