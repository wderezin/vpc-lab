
# How to Add a Firewall

1. Make a copy an existing firewall_#.tf and rename to the next largest number.
```shell
cp firewall_02.tf firewall_03.tf
```
2. Search and replace all instances of "fw_01" to "fw_02"
3. Make a copy of the locals variable for fw_01 to fw_02 and update.
4. Deploy changes through PR/CircleCI

# Updating Tags

Update the values in the `local.tags` and deploy updates.  
All currently deployed resources will be updated without interruption.

# Updating Base AMI Version ( Launch Template Changes)

    Note: Changes when deployed to individual EC2 instances will destroy/deploy, restart, or update in place.

    Note: This procedure can be used for any changes to the launch template.

1. Update `local.current_ami_name` to the new AMI.
2. Deploy changes through PR/CircleCI
3. Get the latest launch template version from the output:
```shell
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

latest_launch_template_version = 1
```
4. Update 1 firewall `local.fw_##_template_version` to the version from the previous step.
5. Deploy changes through PR/CircleCI
6. Once update is completed verify that load balancer is serving traffic correctly. (See Firewall working checklist below)
7. Repeat steps 4-7 until all firewalls have been upgraded.

# Updating change to `firewall_##`.tf file

    Note: Changes may destroy/deploy, restart, or update in place.

1. Make change to `firewall_01.tf`
2. Deploy changes through PR/CircleCI
3. Once update is completed verify that load balancer is serving traffic correctly. (See Firewall working checklist below)
4. Copy contents of `firewall_01.tf` to `firewall_02.tf`
5. In file `firewall_02.tf` Search and replace all instances of "fw_01" to "fw_02"
6. Deploy changes through PR/CircleCI
7. Once update is completed verify that load balancer is serving traffic correctly. (See Firewall working checklist below)
4. Copy contents of `firewall_01.tf` to `firewall_03.tf`
8. In file `firewall_03.tf` Search and replace all instances of "fw_01" to "fw_03"
9. Deploy changes through PR/CircleCI
10. Once update is completed verify that load balancer is serving traffic correctly. (See Firewall working checklist below)

# Firewall working checklist
- Add verification steps here
