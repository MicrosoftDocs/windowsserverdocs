---
title: Cluster to Cluster Storage Replica within same region in Azure
description: Cluster to Cluster Storage Replication within same region in Azure
keywords: Storage Replica, Server Manager, Windows Server, Azure, Cluster, same region
author: arduppal
ms.author: arduppal
ms.date: 5/03/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-replica
manager: mchad
---
# Cluster to Cluster Storage Replica within same region in Azure
For documentation purpose I will be using 2 node cluster. Please understand the feature is not restricted to 2 node cluster.

Below diagram-1 showcases 2 node Storage Spaces Direct (S2D) cluster within the same region in azure which can communicate to each other and are in same domain.

Through out this documentation I will be using the resource names as shown in the diagram-1

Diagram-1
![The architecture diagram showcasing C2C SR in Azure withing same region.](media\Cluster-to-cluster-azure-one-region\architecture.png)

Go to your azure portal:
### Step 1: Create a "Resource group".
As shown in diagram-1, create resource group in a region (SR-AZ2AZ in West US 2). 

### Step 2: Create two "Availability set" one for each cluster.
Create the two availability set in the resource group (SR-AZ2AZ) created above.
1. Availability set (az2azAS1)
2. Availability set (az2azAS2)

You can choose to create a 3rd availability set for your domain controller or add the domain controller in one of the two availability set.

### Step 3: Create a "Virtual network".
Create a virtual network (az2az-Vnet) in the previously created resource group (SR-AZ2AZ), having atleast one subnet.

### Step 4: Create a "Network security group".
Create a network security group (az2az-NSG). And add one Inbound security rule for RDP:3389. You can choose to remove this rule once you finish your setup.

### Step 5: Create Windows Server "Virtual machines".
Create the virtual machines in the previously created Resource group (SR-AZ2AZ). And use the previously created Virtual network (az2az-Vnet) and Network security group (az2az-NSG).

1. Domain Controller (az2azDC). If you are adding this to the availability set created for the two cluster, assign it a Standard public IP address during VM creation.
    a. Install Active Directory Domain Service.
    b. Create a domain (Contoso.com)
    c. User with administrator previleges (contosoadmin)
2. Create two Virtual Machines (az2az1, az2az2) in 1st availability set (az2azAS1). Assign Standard Public IP address to each virtual machine during the creation itself
    a. Add atleast 2 managed disks to each machine
    b. Install "Failover Clustering" and "Storage Replica" feature
3. Create two Virtual Machines (az2az3, az2az4) in 2nd availability set (az2azAS2). Assign Standard Public IP address to each virtual machine during the creation itself
    a. Add atleast 2 managed disks to each machine
    b. Install "Failover Clustering" and "Storage Replica" feature

### Step 6: Connect all the nodes to the domain and provide Administrator previleges to the previously created user.
- Change the DNS Server of virtual network to domain controller private ip address.
    - In our example, the domain controller az2azDC has private ip address (10.3.0.8). In the Virtual Network (az2az-Vnet) change DNS Server 10.3.0.8.

- In our example connect all the nodes to "Contoso.com" and provide administrator previleges to "contosoadmin".
 
### Step 7: Create clusters.

1. Create the clusters (SRAZC1, SRAZC2). 
Below is the powershell commands for our example
```PowerShell
    New-Cluster -Name SRAZC1 -Node az2az1,az2az2 – StaticAddress 10.3.0.100
```
```PowerShell
    New-Cluster -Name SRAZC2 -Node az2az3,az2az4 – StaticAddress 10.3.0.101
```

2. For each cluster
```PowerShell
    Enable-clusterS2D
```

3. For each cluster create virtual disk and volume. One for data and another for log.

### Step 8: Create Load Balancer for each cluster.
As shown in the diagram-1
1. Create Standard SKU Load Balancer for each cluster (azlbr1,azlbr2). Provide the Cluster IP address as private IP address for the load balancer.
    a. azlbr1 => Frontend IP: 10.3.0.100
    b. azlbr2 => Frontend IP: 10.3.0.101
2. Create Backend Pool for each load balancer. Add the associated cluster nodes.
3. Create Health Probe: port 59999
4. Create Load Balance Rule: Allow HA ports, with enabled Floating IP.

### Step 9: On each cluster node, open ports 59999 (Health Probe).
Run the below command on each node
```PowerShell
netsh advfirewall firewall add rule name=PROBEPORT dir=in protocol=tcp action=allow localport=59999 remoteip=any profile=any 
```

### Step 10: Instruct the cluster to listen for Health Probe messages on Port 59999 and respond from the node that currently owns this resource.

Run it once from any one node of the cluster, for each cluster.
Make sure to change the "ILBIP" according to your configuration values.

For our example.
Run the below command from any one node az2az1/az2az2
```PowerShell
$ClusterNetworkName = "Cluster Network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or higher to find the name. And use Get-ClusterResource to find the IPResourceName).
$IPResourceName = "Cluster IP Address" # IP Address cluster resource name.
$ILBIP = "10.3.0.100" # IP Address in Internal Load Balancer (ILB) - The static IP address for the load balancer configured in the Azure portal.
[int]$ProbePort = 59999
Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";”ProbeFailureThreshold”=5;"EnableDhcp"=0}  
```

Run the below command from any one node az2az3/az2az4
```PowerShell
$ClusterNetworkName = "Cluster Network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or higher to find the name. And use Get-ClusterResource to find the IPResourceName).
$IPResourceName = "Cluster IP Address" # IP Address cluster resource name.
$ILBIP = "10.3.0.101" # IP Address in Internal Load Balancer (ILB) - The static IP address for the load balancer configured in the Azure portal.
[int]$ProbePort = 59999
Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";”ProbeFailureThreshold”=5;"EnableDhcp"=0}  
```

### Step 11: Make sure both cluster can connect / communicate with each other.
Either use "Connect to Cluster" feature in Failover cluster manager to connect to the other cluster or check other cluster responds from one of the nodes of current cluster.

For our example:
```PowerShell
Get-Cluster -Name SRAZC1 (ran from az2az3)
```
```PowerShell
Get-Cluster -Name SRAZC2 (ran from az2az1)
```

### Step 12: Create cloud witness for both the clusters.
1. Create 2 storage accounts (az2azcw,az2azcw2) in azure one for each cluster in same resource group (SR-AZ2AZ)
2. Copy the storage account name and key from "access keys"
3. Create the cloud witness from “failover cluster manager” and use the above account name and key to create it.

### Step 13: Grant SR-Access of one cluster to other cluster in both direction.
For our example:
```PowerShell
Grant-SRAccess -ComputerName az2az1 -Cluster SRAZC2
```
```PowerShell
Grant-SRAccess -ComputerName az2az3 -Cluster SRAZC1
```

### Step 14: Create Partnership.
1. For cluster SRAZC1. 
    a. Volume location:- c:\ClusterStorage\DataDisk1
    b. Log location:- g:
2. For cluster SRAZC2
    a. Volume location:- c:\ClusterStorage\DataDisk2
    b. Log location:- g:
3. Run the command

```PowerShell

New-SRPartnership -SourceComputerName SRAZC1 -SourceRGName rg01 -SourceVolumeName c:\ClusterStorage\DataDisk1 -SourceLogVolumeName  g: -DestinationComputerName SRAZC2 -DestinationRGName rg02 -DestinationVolumeName c:\ClusterStorage\DataDisk2 -DestinationLogVolumeName  g:

```