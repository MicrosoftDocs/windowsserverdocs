---
title: Cluster to Cluster Storage Replica cross region in Azure
description: Cluster to Cluster Storage Replication cross region in Azure
keywords: Storage Replica, Server Manager, Windows Server, Azure, Cluster, cross region, different region
author: arduppal
ms.author: arduppal
ms.date: 5/04/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-replica
manager: mchad
---
# Cluster to Cluster Storage Replica cross region in Azure
For documentation purpose I will be using 2 node cluster. Please understand the feature is not restricted to 2 node cluster.

Below diagram-1 showcases 2 node Storage Spaces Direct (S2D) cluster cross region in azure which can communicate to each other and are in same domain.

Through out this documentation I will be using the resource names as shown in the diagram-1

Diagram-1
![The architecture diagram showcasing C2C SR in Azure withing same region.](media\Cluster-to-cluster-azure-cross-region\architecture.png)

Go to your azure portal:
### Step 1: Create two "Resource group".
Create resource groups in two different regions. 
For example SR-AZ2AZ in West US 2 and SR-AZCROSS in West Central US, as shown in diagram-1.

### Step 2: Create two "Availability set" one in each resource group for each cluster.
Create the two availability set in the resource group (SR-AZ2AZ) created above.
1. Availability set (az2azAS1)
2. Availability set (azcross-AS)

You can choose to create a 3rd availability set for your domain controller or add the domain controller in one of the two availability set.

### Step 3: Create two "Virtual network".
For example, as shown in diagram-1
1. Create virtual network (az2az-Vnet) in the 1st resource group (SR-AZ2AZ), having one subnet and one Gateway subnet.
2. Create virtual network (azcross-VNET) in the 2nd resource group (SR-AZCROSS), having one subnet and one Gateway subnet.

### Step 4: Create two "Network security group".
For example, as shown in diagram-1
1. Create network security group (az2az-NSG) in 1st resource group (SR-AZ2AZ).
2. Create network security group (azcross-NSG) in 2nd resource group (SR-AZCROSS).  

And add one Inbound security rule for RDP:3389 to both Network Security Group. You can choose to remove this rule once you finish your setup.

### Step 5: Create Windows Server "Virtual machines".
Create the virtual machines in the previously created Resource groups.

1. Domain Controller (az2azDC). If you are adding this to the availability set created for the two cluster, assign it a Standard public IP address during VM creation.
    a. Install Active Directory Domain Service.
    b. Create a domain (Contoso.com)
    c. User with administrator previleges (contosoadmin)
2. Create two Virtual Machines (az2az1, az2az2) in the Resource group (SR-AZ2AZ) using Virtual network (az2az-Vnet) and Network security group (az2az-NSG) in availability set (az2azAS1). Assign Standard Public IP address to each virtual machine during the creation itself
    a. Add atleast 2 managed disks to each machine
    b. Install "Failover Clustering" and "Storage Replica" feature
3. Create two Virtual Machines (azcross1, azcross2) in the Resource group (SR-AZCROSS) using Virtual network (azcross-VNET) and Network security group (azcross-NSG) in availability set (azcross-AS). Assign Standard Public IP address to each virtual machine during the creation itself
    a. Add atleast 2 managed disks to each machine
    b. Install "Failover Clustering" and "Storage Replica" feature

### Step 6: Connect all the nodes to the domain and provide Administrator previleges to the previously created user.
- Change the DNS Server of virtual network to domain controller private ip address.
    - In our example, the domain controller az2azDC has private ip address (10.3.0.8). In the Virtual Network (az2az-Vnet and azcross-VNET) change DNS Server 10.3.0.8

- In our example connect all the nodes to "Contoso.com" and provide administrator previleges to "contosoadmin".
 
### Step 7: Create clusters.

1. Create the clusters (SRAZC1, SRAZCross). 
Below is the powershell commands for our example
```PowerShell
    New-Cluster -Name SRAZC1 -Node az2az1,az2az2 – StaticAddress 10.3.0.100
```
```PowerShell
    New-Cluster -Name SRAZCross -Node azcross1,azcross2 – StaticAddress 10.0.0.10
```

2. For each cluster
```PowerShell
    Enable-clusterS2D
```

3. For each cluster create virtual disk and volume. One for data and another for log.

### Step 8: Create Load Balancer for each cluster.
As shown in the diagram-1
1. Create Standard SKU Load Balancer for each cluster (azlbr1,azlbazcross). Provide the Cluster IP address as private IP address for the load balancer.
    a. azlbr1 => Frontend IP: 10.3.0.100
    b. azlbazcross => Frontend IP: 10.0.0.10
2. Create Backend Pool for each load balancer. Add the associated cluster nodes.
3. Create Health Probe: port 59999
4. Create Load Balance Rule: Allow HA ports, with enabled Floating IP.

### Step 9: Create "Virtual network gateway" for Vnet-to-Vnet connectivity
As shown in the diagram-1
1. Create 1st Virtual network gateway(az2az-VNetGateway) in 1st resource group (SR-AZ2AZ)
2. Create 2nd Virtual network gateway(azcross-VNetGateway) in 2nd resource group (SR-AZCROSS)
3. Create Vnet-to-Vnet connection from 1st Virtual network gateway to 2nd Virtual network gateway. Provide a shared key
4. Create Vnet-to-Vnet connection from 2nd Virtual network gateway to 1st Virtual network gateway. Provide the same shared key as step 3

### Step 10: On each cluster node, open ports 59999 (Health Probe).
Run the below command on each node
```PowerShell
netsh advfirewall firewall add rule name=PROBEPORT dir=in protocol=tcp action=allow localport=59999 remoteip=any profile=any 
```

### Step 11: Instruct the cluster to listen for Health Probe messages on Port 59999 and respond from the node that currently owns this resource.

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
$ILBIP = "10.0.0.10" # IP Address in Internal Load Balancer (ILB) - The static IP address for the load balancer configured in the Azure portal.
[int]$ProbePort = 59999
Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";”ProbeFailureThreshold”=5;"EnableDhcp"=0}  
```

### Step 12: Make sure both cluster can connect / communicate with each other.
Either use "Connect to Cluster" feature in Failover cluster manager to connect to the other cluster or check other cluster responds from one of the nodes of current cluster.

For our example:
```PowerShell
Get-Cluster -Name SRAZC1 (ran from azcross1)
```
```PowerShell
Get-Cluster -Name SRAZCross (ran from az2az1)
```

### Step 13: Create cloud witness for both the clusters.
1. Create 2 storage accounts (az2azcw,azcrosssa) in azure one for each cluster in each resource group (SR-AZ2AZ, SR-AZCROSS)
2. Copy the storage account name and key from "access keys"
3. Create the cloud witness from “failover cluster manager” and use the above account name and key to create it.

### Step 14: Grant SR-Access of one cluster to other cluster in both direction.
For our example:
```PowerShell
Grant-SRAccess -ComputerName az2az1 -Cluster SRAZCross
```
```PowerShell
Grant-SRAccess -ComputerName azcross1 -Cluster SRAZC1
```

### Step 15: Create Partnership.
1.	For cluster SRAZC1
    a.	Volume location:-  c:\ClusterStorage\DataDisk1
    b.	log location :- g:
2.	For cluster SRAZCross
    a.	Volume location:- c:\ClusterStorage\DataDiskCross
    b.	Log location:- g:
3.	Run the command

```PowerShell

New-SRPartnership -SourceComputerName SRAZC1 -SourceRGName rg01 -SourceVolumeName c:\ClusterStorage\DataDisk1 -SourceLogVolumeName  g: -DestinationComputerName SRAZCross -DestinationRGName rg02 -DestinationVolumeName c:\ClusterStorage\DataDiskCross -DestinationLogVolumeName  g:

```