---
title: Cluster-to-Cluster Storage Replication Cross-Region in Azure
description: Cluster-to-cluster storage replication cross-region in Azure.
author: arduppal
ms.author: roharwoo
ms.date: 12/19/2018
ms.topic: article
manager: mchad
---
# Cluster-to-cluster storage replication cross-region in Azure

You can configure Storage Replica in Windows Server for cluster-to-cluster replication of cross-region applications in Azure. In the examples below, we use a two-node cluster, but Cluster to Cluster storage replica isn't restricted to a two-node cluster. The illustration below is a two-node Storage Space Direct cluster that can communicate with each other, are in the same domain, and are cross-region.

Watch the following video for a complete walkthrough of the process:
> [!video https://learn-video.azurefd.net/vod/player?id=677e525a-62b6-44c6-bf88-03de796b54ce]

![The architecture diagram showcasing C2C SR in Azure withing same region.](media/Cluster-to-cluster-azure-cross-region/architecture.png)
> [!IMPORTANT]
> All referenced examples are specific to the illustration above.

1. In the Azure portal, create [resource groups](https://ms.portal.azure.com/#create/Microsoft.ResourceGroup) in two different regions.

   For example:

   - Create **SR-AZ2AZ** in **West US 2**.
   - Create **SR-AZCROSS** in **West Central US**.

1. Create two [availability sets](https://ms.portal.azure.com/#create/Microsoft.AvailabilitySet-ARM), one in each resource group for each cluster.

   For example:

   - Create availability set **az2azAS1** in **SR-AZ2AZ**.
   - Create availability set **azcross-AS** in **SR-AZCROSS**.

1. Create two virtual networks.

   For example:

   1. Create [virtual network](https://ms.portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) **az2az-Vnet** in resource group **SR-AZ2AZ**. The virtual network should have one subnet and one gateway subnet.
   1. Create [virtual network](https://ms.portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) **azcross-VNET** in resource group **SR-AZCROSS**. The virtual network should have one subnet and one gateway subnet.

1. Create two network security groups.

   For example:

   1. Create [network security group](https://ms.portal.azure.com/#create/Microsoft.NetworkSecurityGroup-ARM) **az2az-NSG** in resource group **SR-AZ2AZ**.
   1. Create [network security group](https://ms.portal.azure.com/#create/Microsoft.NetworkSecurityGroup-ARM) **azcross-NSG** in resource group **SR-AZCROSS**.

   Add an inbound security rule for Remote Desktop Protocol (RDP) port 3389 to each network security group. You can choose to remove this rule after you finish setup.

1. Create Windows Server [virtual machines (VMs)](https://ms.portal.azure.com/#create/Microsoft.WindowsServer2016Datacenter-ARM) in the resource groups.

   For example:

   1. Create domain controller **az2azDC**. You can choose to create a third availability set for your domain controller or add the domain controller in one of the two availability sets. If you add the domain controller to the availability set you created for the two clusters, assign it a standard public IP address when you create the VM.

     To create the domain controller:

     - Install Active Directory Domain Service.
     - Create a domain (for example, `contoso.com`).
     - Create a user who has administrator permissions (for example, contosoadmin).

   1. Create VMs **az2az1** and **az2az2** in the resource group **SR-AZ2AZ** by using virtual network **az2az-Vnet** and network security group **az2az-NSG** in availability set **az2azAS1**. Configure the VMs:

      - Assign a standard public IP address to each VM when you create the VMs.
      - Add at least two managed disks to each VM.
      - Install Failover Clustering and the Storage Replica feature to each VM.

   1. Create VMs **azcross1** and **azcross2** in the resource group **SR-AZCROSS** by using virtual network **azcross-VNET** and network security group **azcross-NSG** in availability set **azcross-AS**. Configure the VMs:

      - Assign a standard public IP address to each VM when you create the VMs.
      - Add at least two managed disks to each VM.
      - Install Failover Clustering and the Storage Replica feature to each VM.

   Connect all the nodes to the domain and provide administrator permissions to the user you created.

   Change the DNS server of the virtual network to domain controller private IP address.
   - In the example, the domain controller **az2azDC** has private IP address (10.3.0.8). In the Virtual Network (**az2az-Vnet** and **azcross-VNET**) change DNS Server 10.3.0.8.

     In the example, connect all the nodes to "contoso.com" and provide administrator privileges to "contosoadmin".

   - Login as contosoadmin from all the nodes.

1. Create the clusters (**SRAZC1**, **SRAZCross**).

   Below is the PowerShell commands for the example

   ```powershell
      New-Cluster -Name SRAZC1 -Node az2az1,az2az2 –StaticAddress 10.3.0.100
   ```

   ```powershell
      New-Cluster -Name SRAZCross -Node azcross1,azcross2 –StaticAddress 10.0.0.10
   ```

1. Enable Storage Spaces Direct:

   ```powershell
      Enable-clusterS2D
   ```

   > [!NOTE]
   > For each cluster create virtual disk and volume. One for the data and another for the log.

1. Create an internal Standard SKU [Load Balancer](https://ms.portal.azure.com/#create/Microsoft.LoadBalancer-ARM) for each cluster (**azlbr1**, **azlbazcross**).

   Provide the Cluster IP address as static private IP address for the load balancer.
      - azlbr1 => Frontend IP: 10.3.0.100 (Pick up an unused IP address from the Virtual network (**az2az-Vnet**) subnet)
      - Create Backend Pool for each load balancer. Add the associated cluster nodes.
      - Create Health Probe: port 59999
      - Create Load Balance Rule: Allow HA ports, with enabled Floating IP.

   Provide the Cluster IP address as static private IP address for the load balancer.
      - azlbazcross => Frontend IP: 10.0.0.10 (Pick up an unused IP address from the Virtual network (**azcross-VNET**) subnet)
      - Create Backend Pool for each load balancer. Add the associated cluster nodes.
      - Create Health Probe: port 59999
      - Create Load Balance Rule: Allow HA ports, with enabled Floating IP.

1. Create [Virtual network gateway](https://ms.portal.azure.com/#create/Microsoft.VirtualNetworkGateway-ARM) for Vnet-to-Vnet connectivity.

   - Create the first virtual network gateway (**az2az-VNetGateway**) in the first resource group (**SR-AZ2AZ**)
   - Gateway Type = VPN, and VPN type = Route-based

   - Create the second Virtual network gateway (**azcross-VNetGateway**) in the second resource group (**SR-AZCROSS**)
   - Gateway Type = VPN, and VPN type = Route-based

   - Create a Vnet-to-Vnet connection from first Virtual network gateway to second Virtual network gateway. Provide a shared key

   - Create a Vnet-to-Vnet connection from second Virtual network gateway to first Virtual network gateway. Provide the same shared key as provided in the step above.

1. On each cluster node, open port 59999 (Health Probe).

    Run the following command on each node:

    ```powershell
      netsh advfirewall firewall add rule name=PROBEPORT dir=in protocol=tcp action=allow localport=59999 remoteip=any profile=any
    ```

1. Instruct the cluster to listen for Health Probe messages on Port 59999 and respond from the node that currently owns this resource.

    Run it once from any one node of the cluster, for each cluster.

    In our example, make sure to change the "ILBIP" according to your configuration values. Run the following command from any one node **az2az1**/**az2az2**

    ```powershell
     $ClusterNetworkName = "Cluster Network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or higher to find the name. And use Get-ClusterResource to find the IPResourceName.)
     $IPResourceName = "Cluster IP Address" # IP Address cluster resource name.
     $ILBIP = "10.3.0.100" # IP Address in Internal Load Balancer (ILB) - The static IP address for the load balancer configured in the Azure portal.
     [int]$ProbePort = 59999
     Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"ProbeFailureThreshold"=5;"EnableDhcp"=0}
    ```

1. Run the following command from any one node **azcross1**/**azcross2**

    ```powershell
     $ClusterNetworkName = "Cluster Network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or later to find the name. Use Get-ClusterResource to find the IPResourceName.)
     $IPResourceName = "Cluster IP Address" # IP Address cluster resource name.
     $ILBIP = "10.0.0.10" # IP Address in Internal Load Balancer (ILB) - The static IP address for the load balancer configured in the Azure portal.
     [int]$ProbePort = 59999
     Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"ProbeFailureThreshold"=5;"EnableDhcp"=0}
    ```

    Make sure that both clusters can connect and communicate with each other.

    Either use the Connect to Cluster feature in Failover Cluster Manager to connect to the other cluster or verify that the other cluster responds from one of the nodes of the current cluster.

    For example:

    ```powershell
      Get-Cluster -Name SRAZC1 (run from azcross1)
    ```

    ```powershell
      Get-Cluster -Name SRAZCross (run from az2az1)
    ```

1. Create a cloud witness for both clusters.

   Create two [storage accounts](https://ms.portal.azure.com/#create/Microsoft.StorageAccount-ARM) (**az2azcw**, **azcrosssa**) in Azure, one for each cluster in each resource group (**SR-AZ2AZ**, **SR-AZCROSS**).

    - Copy the storage account name and key from "access keys".
    - In Failover Cluster Manager, create the cloud witness. Use the copied account name and key to create it.

1. Run [cluster validation tests](../../failover-clustering/create-failover-cluster.md#run-cluster-validation-tests) before you go to the next step.

1. Start Windows PowerShell and use the [Test-SRTopology](/powershell/module/storagereplica/test-srtopology) cmdlet to determine if you meet all the Storage Replica requirements. You can use the cmdlet in a requirements-only mode for a quick test and in long-running performance evaluation mode.

1. Configure cluster-to-cluster storage replication.

    Grant access from one cluster to another cluster in both directions:

    From our example:

    ```powershell
     Grant-SRAccess -ComputerName az2az1 -Cluster SRAZCross
    ```

    If you're using Windows Server 2016, then also run this command:

    ```powershell
     Grant-SRAccess -ComputerName azcross1 -Cluster SRAZC1
    ```

1. Create SR-Partnership for the two clusters:

    - For cluster **SRAZC1**:

      - Volume location: c:\ClusterStorage\DataDisk1
      - Log location: g:

    - For cluster **SRAZCross**:

      - Volume location: c:\ClusterStorage\DataDiskCross
      - Log location: g:

Run the command:

```powershell
PowerShell

New-SRPartnership -SourceComputerName SRAZC1 -SourceRGName rg01 -SourceVolumeName c:\ClusterStorage\DataDisk1 -SourceLogVolumeName  g: -DestinationComputerName SRAZCross -DestinationRGName rg02 -DestinationVolumeName c:\ClusterStorage\DataDiskCross -DestinationLogVolumeName  g: -LogType Raw
```
