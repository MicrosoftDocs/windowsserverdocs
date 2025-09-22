---
title: Cluster-to-Cluster Replication Cross-Region in Azure
description: Learn how to use cluster-to-cluster Storage Replica in Windows Server for cross-region storage replication in Azure.
ms.author: roharwoo
author: robinharwood
ms.date: 02/18/2025
ms.topic: how-to
ms.custom: sfi-image-nochange
---
# Set up cluster-to-cluster storage replication across Azure regions by using Storage Replica

You can configure Storage Replica in Windows Server for cluster-to-cluster replication of cross-region applications in Azure. In the article example, we use a two-node cluster, but you can use Storage Replica if you have more than two nodes in your clusters.

For a complete walkthrough of the process, see the following video:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=677e525a-62b6-44c6-bf88-03de796b54ce]

The diagram that follows depicts a two-node Storage Space Direct cluster that can communicate with each other, are in the same domain, and are cross-region.

:::image type="content" source="media/Cluster-to-cluster-azure-cross-region/architecture.png" border="false" alt-text="Diagram that depicts the architecture of cluster-to-cluster Storage Replica in Azure in different regions.":::

The figure and the videos refer to the article examples.

1. In the Azure portal, create [resource groups](https://ms.portal.azure.com/#create/Microsoft.ResourceGroup) in two different regions.

   For example:  

   1. Create **SR-AZ2AZ** in **West US 2**.
   1. Create **SR-AZCROSS** in **West Central US**.

1. Create two [availability sets](https://ms.portal.azure.com/#create/Microsoft.AvailabilitySet-ARM), one in each resource group for each cluster.

   For example: 

   1. Create availability set **az2azAS1** in resource group **SR-AZ2AZ**.
   1. Create availability set **azcross-AS** in resource group **SR-AZCROSS**.

1. Create two [virtual networks](https://ms.portal.azure.com/#create/Microsoft.VirtualNetwork-ARM).

   For example:  

   1. Create  virtual network **az2az-VNet** in resource group **SR-AZ2AZ**. The virtual network should have one subnet and one gateway subnet.
   1. Create [virtual network](https://ms.portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) **azcross-VNet** in resource group **SR-AZCROSS**. The virtual network should have one subnet and one gateway subnet.

1. Create two network security groups. Add an inbound security rule for Remote Desktop Protocol (RDP) port 3389 to each network security group. You can choose to remove this rule after you finish setup.

   For example:  

   1. Create [network security group](https://ms.portal.azure.com/#create/Microsoft.NetworkSecurityGroup-ARM) **az2az-NSG** in resource group **SR-AZ2AZ**.
   1. Create an inbound security rule for RDP:3389 to the **az2az-NSG** network security group.
   1. Create [network security group](https://ms.portal.azure.com/#create/Microsoft.NetworkSecurityGroup-ARM) **azcross-NSG** in resource group **SR-AZCROSS**.
   1. Create an inbound security rule for RDP:3389 to the **azcross-NSG** network security group.

1. Create Windows Server [virtual machines (VMs)](https://ms.portal.azure.com/#create/Microsoft.WindowsServer2016Datacenter-ARM) in the resource groups.

   For example:  

   1. Create domain controller **az2azDC**. You can choose to create a third availability set for your domain controller or add the domain controller in one of the two availability sets. If you add the domain controller to the availability set you created for the two clusters, assign it a standard public IP address when you create the VM.

     To create the domain controller:

     - Install Active Directory Domain Service.
     - Create a domain (for example, `contoso.com`).
     - Create a user who has administrator permissions (for example, *contosoadmin*).

   1. Create VMs **az2az1** and **az2az2** in the resource group **SR-AZ2AZ** by using virtual network **az2az-VNet** and network security group **az2az-NSG** in availability set **az2azAS1**. Configure the VMs:

      - Assign a standard public IP address to each VM when you create the VMs.
      - Add at least two managed disks to each VM.
      - Install Failover Clustering and the Storage Replica feature to each VM.

   1. Create VMs **azcross1** and **azcross2** in the resource group **SR-AZCROSS** by using virtual network **azcross-VNet** and network security group **azcross-NSG** in availability set **azcross-AS**. Configure the VMs:

      - Assign a standard public IP address to each VM when you create the VMs.
      - Add at least two managed disks to each VM.
      - Install Failover Clustering and the Storage Replica feature to each VM.

   1. Connect all the nodes to the domain and provide administrator permissions to the user you created.

      - Change the DNS server of the virtual network to the domain controller private IP address. In the example, the domain controller **az2azDC** has a private IP address (10.3.0.8). In the virtual networks (**az2az-VNet** and **azcross-VNet**), change **DNS Server** to **10.3.0.8**.

      - In the example, connect all the nodes to `contoso.com` and provide administrator permissions to the user *contosoadmin*.

      - Log in as *contosoadmin* from all the nodes.

1. Create two clusters: **SRAZC1** and **SRAZCross**.

   For the example, use the following PowerShell commands:

   ```powershell
      New-Cluster -Name SRAZC1 -Node az2az1,az2az2 -StaticAddress 10.3.0.100
   ```

   ```powershell
      New-Cluster -Name SRAZCross -Node azcross1,azcross2 -StaticAddress 10.0.0.10
   ```

1. Enable Storage Spaces Direct:

   ```powershell
      Enable-clusterS2D
   ```

   > [!NOTE]
   > For each cluster, create a virtual disk volume. One volume is for the data, and one is for the log.

1. Create an internal Standard SKU [load balancer](https://ms.portal.azure.com/#create/Microsoft.LoadBalancer-ARM) for each cluster (**azlbr1**, **azlbazcross**).

   1. Provide the cluster IP address as a static private IP address for the load balancer **azlbr1**:

      - Front-end IP: 10.3.0.100 (pick up an unused IP address from the virtual network **az2az-VNet** subnet).
      - Create a back-end pool for each load balancer. Add the associated cluster nodes.
      - Create a health probe on port 59999.
      - Create a load-balance rule. Allow high-availability ports, with floating IP enabled.

   1. Provide the cluster IP address as a static private IP address for the load balancer **azlbazcross**:

      - Front-end IP: 10.0.0.10 (pick up an unused IP address from the virtual network **azcross-VNet** subnet).
      - Create a back-end pool for each load balancer. Add the associated cluster nodes.
      - Create a health probe on port 59999.
      - Create a load-balance rule. Allow high-availability ports, with floating IP enabled.

1. Create a [virtual network gateway](https://ms.portal.azure.com/#create/Microsoft.VirtualNetworkGateway-ARM) for network-to-network connectivity.

   1. Create the first virtual network gateway (**az2az-VNetGateway**) in the first resource group (**SR-AZ2AZ**). For **Gateway Type**, select **VPN**. For **VPN type**, select **Route-based**.
   1. Create the second Virtual network gateway (**azcross-VNetGateway**) in the second resource group (**SR-AZCROSS**). For **Gateway Type**, select **VPN**. For **VPN type**, select **Route-based**.
   1. Create a network-to-network connection from the first virtual network gateway to the second virtual network gateway. Provide a shared key.
   1. Create a network-to-network connection from the second virtual network gateway to the first virtual network gateway. Provide the same shared key that you used in the preceding step.

1. On each cluster node, open port 59999 (the health probe).

    Run the following command on each node:

    ```powershell
      netsh advfirewall firewall add rule name=PROBEPORT dir=in protocol=tcp action=allow localport=59999 remoteip=any profile=any
    ```

1. Instruct the cluster to listen for health probe messages on port 59999 and respond from the node that currently owns this resource.

    For each cluster, run the health probe once from any one node of the cluster.

    In the following sample code, make sure that you change the value for `ILBIP` per your configuration values. Run the following command from any one node **az2az1**/**az2az2**:

    ```powershell
     $ClusterNetworkName = "Cluster network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or higher to find the name. Use Get-ClusterResource to find the IPResourceName.)
     $IPResourceName = "Cluster IP address" # IP address cluster resource name.
     $ILBIP = "10.3.0.100" # IP address in Internal Load Balancer (ILB). The static IP address for the load balancer is configured in the Azure portal.
     [int]$ProbePort = 59999
     Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"ProbeFailureThreshold"=5;"EnableDhcp"=0}
    ```

1. Run the following command from any node on **azcross1** and **azcross2**:

    ```powershell
     $ClusterNetworkName = "Cluster network 1" # Cluster network name (Use Get-ClusterNetwork on Windows Server 2012 or later to find the name. Use Get-ClusterResource to find the IPResourceName.)
     $IPResourceName = "Cluster IP address" # IP address cluster resource name.
     $ILBIP = "10.0.0.10" # IP address in Internal Load Balancer (ILB). The static IP address for the load balancer is configured in the Azure portal.
     [int]$ProbePort = 59999
     Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"=$ProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"ProbeFailureThreshold"=5;"EnableDhcp"=0}
    ```

1. Verify that both clusters can connect and communicate with each other.

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

    - Copy the storage account name and key from the **Access keys** section.
    - In Failover Cluster Manager, create the cloud witness. Use the copied account name and key to create it.

1. Run [cluster validation tests](../../failover-clustering/create-failover-cluster.md#run-cluster-validation-tests) before you go to the next step.

1. Start Windows PowerShell and use the [`Test-SRTopology`](/powershell/module/storagereplica/test-srtopology) cmdlet to determine if you meet all the Storage Replica requirements. You can use the cmdlet in a requirements-only mode for a quick test and in long-running performance evaluation mode.

1. Configure cluster-to-cluster storage replication.

    Grant access from one cluster to another cluster in both directions:

    From our example:  

    ```powershell
     Grant-SRAccess -ComputerName az2az1 -Cluster SRAZCross
    ```

    If you're using Windows Server 2016, run this command also:

    ```powershell
     Grant-SRAccess -ComputerName azcross1 -Cluster SRAZC1
    ```

1. Create a Storage Replica partnership for the two clusters:

    - Cluster **SRAZC1**: For volume location, use `C:\ClusterStorage\DataDisk1`. For log location, use `G:\*`.

    - Cluster **SRAZCross**: For volume location, use `C:\ClusterStorage\DataDiskCross`. For log location, use `G:\*`.

Then run the following command:

```powershell

New-SRPartnership -SourceComputerName SRAZC1 -SourceRGName rg01 -SourceVolumeName c:\ClusterStorage\DataDisk1 -SourceLogVolumeName  g: -DestinationComputerName SRAZCross -DestinationRGName rg02 -DestinationVolumeName c:\ClusterStorage\DataDiskCross -DestinationLogVolumeName  g: -LogType Raw
```

