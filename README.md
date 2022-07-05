# NSX-T Terraform Demo

## Introduction

This repo is a logically laid out repo that creates a number of resources within an NSX-T install.
The following will be created:
- A new Tier-1 gateway of type LB-SMALL
- A new network segment (demo-10) with a range of 10.0.10.0/24


## Setup

Pull the code and open the variables.tf.
Add your NSX-T FQDN, username and password and save the file.

Open NSX-T UI, navigate to Network Services -> Load Balancing -> Profiles
Create a new Application Profile named https-redirect with the Redirection dropdown set to "HTTP to HTTPS Redirect" and click Save.

Run the following commands and check/fix errors shown:
```
terraform init
terraform plan
```