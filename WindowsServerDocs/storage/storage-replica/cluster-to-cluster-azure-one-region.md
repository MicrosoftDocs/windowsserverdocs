---
title: Cluster-to-Cluster Replication in the Same Azure Region
description: Learn how to use cluster-to-cluster Storage Replica in Windows Server for storage replication in the same region in Azure.
ms.author: roharwoo
author: robinharwood
ms.date: 02/18/2025
ms.topic: how-to
ms.custom: sfi-image-nochange
---
# Set up cluster-to-cluster storage in the same Azure region by using Storage Replica

You can configure Storage Replica in Windows Server for cluster-to-cluster replication within the same Azure region. In the article example, we use a two-node cluster, but you can use Storage Replica if you have more than two nodes in your clusters.

For a complete walkthrough of the process, see the following videos:

Part one:  

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=f95b2b39-1000-4b43-ae2b-534b70cc0667]

Part two:  

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=65d7d183-938e-48fc-bc46-df5cb8216393]

The following figure depicts a two-node Storage Space Direct cluster. The nodes are in the same domain in the same region, and they can communicate with each other.

:::image type="content" source="media/Cluster-to-cluster-azure-one-region/architecture.png" border="false" alt-text="Diagram that depicts the architecture of cluster-to-cluster Storage Replica in Azure in the same region.":::

The figure and the videos refer to the article examples.

1. In the Azure portal, create a [resource group](https://ms.portal.azure.com/#create/Microsoft.ResourceGroup).

   For example, create **SR-AZ2AZ** in **West US 2**.

1. Create two [availability sets](https://ms.portal.azure.com/#create/Microsoft.AvailabilitySet-ARM) in the resource group, one for each cluster.

   For example:  

   1. Create availability set **az2azAS1** in resource group **SR-AZ2AZ**.
   1. Create availability set **az2azAS2** in resource group **SR-AZ2AZ**.

1. Create a [virtual network](https://ms.portal.azure.com/#create/Microsoft.VirtualNetwork-ARM) in the resource group. The virtual network should have one subnet.

   For example, create virtual network **az2az-VNet** in resource group **SR-AZ2AZ**.

1. Create a [network security group](https://ms.portal.azure.com/#create/Microsoft.NetworkSecurityGroup-ARM). Add one inbound security rule for Remote Desktop Protocol (RDP) port 3389 to the network security group. You can choose to remove this rule after you finish setup.

   For example:  

   1. Create network security group (**az2az-NSG**) in resource group **SR-AZ2AZ**.
   1. Create an inbound security rule for RDP:3389 to the network security group.

1. Create a Windows Server [virtual machine](https://ms.portal.azure.com/#create/Microsoft.WindowsServer2016Datacenter-ARM) in the resource group (**SR-AZ2AZ**). Use the previously created virtual network (**az2az-VNet**) and network security group (**az2az-NSG**).

   For example:  

   1. Create domain controller **az2azDC**. You can choose to create a third availability set for your domain controller or add the domain controller in one of the two availability sets. If you add the domain controller to the availability set you created for the two clusters, assign it a standard public IP address when you create the VM.

      To create the domain controller:

      - Install Active Directory Domain Service.
      - Create a domain (for example, `contoso.com`).
      - Create a user who has administrator permissions (for example, *contosoadmin*).

   1. Create two VMs (**az2az1**, **az2az2**) in the first availability set (**az2azAS1**).

       Then, configure the VMs.

       - Assign a standard public IP address to each VM when you create the VMs.
       - Add at least two managed disks to each VM.
       - Install Failover Clustering and the Storage Replica feature to each VM.

   1. Create two VMs (**az2az3**, **az2az4**) in the second availability set (**az2azAS2**).

       Then, configure the VMs.

       - Assign a standard public IP address to each VM when you create the VMs.
       - Add at least two managed disks to each VM.
       - Install Failover Clustering and the Storage Replica feature to each VM.

   1. Connect all the nodes to the domain and provide administrator permissions to the user you created.

      - Change the DNS server of the virtual network to the domain controller private IP address. In the example, the domain controller **az2azDC** has a private IP address (10.3.0.8). In the virtual network (**az2az-VNet**), change **DNS Server** to **10.3.0.8**.

      - In the example, connect all the nodes to `contoso.com` and provide administrator permissions to the user *contosoadmin*.

      - Log in as *contosoadmin* from all the nodes.

1. Create two clusters: **SRAZC1** and **SRAZC2**.

   For the example, use the following PowerShell commands:  

   ```powershell
    New-Cluster -Name SRAZC1 -Node az2az1,az2az2 –StaticAddress 10.3.0.100
   ```

   ```powershell
    New-Cluster -Name SRAZC2 -Node az2az3,az2az4 –StaticAddress 10.3.0.101
   ```

1. Enable Storage Spaces Direct:

    ```powershell
    Enable-clusterS2D
    ```

   > [!NOTE]
   > For each cluster, create a virtual disk volume. One volume is for the data, and one is for the log.

1. Create an internal Standard SKU [load balancer](https://ms.portal.azure.com/#create/Microsoft.LoadBalancer-ARM) for each cluster (**azlbr1**,**azlbr2**).

   1. Provide the cluster IP address as a static private IP address for the load balancer **azlbr1**:

      - Front-end IP: 10.3.0.100 (pick up an unused IP address from the virtual network **az2az-VNet** subnet).
      - Create a back-end pool for each load balancer. Add the associated cluster nodes.
      - Create a health probe on port 59999.
      - Create a load-balance rule. Allow high-availability ports, with floating IP enabled.

   1. Provide the cluster IP address as a static private IP address for the load balancer **azlbr2**:

      - Front-end IP: 10.0.0.10 (pick up an unused IP address from the virtual network **az2az-VNet** subnet).
      - Create a back-end pool for each load balancer. Add the associated cluster nodes.
      - Create a health probe on port 59999.
      - Create a load-balance rule. Allow high-availability ports, with floating IP enabled.

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

1. Run the following command from any node on **az2az3** or **az2az4**:

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
      Get-Cluster -Name SRAZC1 (run from az2az3)
    ```

    ```powershell
     Get-Cluster -Name SRAZC2 (run from az2az1)
    ```

1. Create a cloud witness for both clusters.

   Create two [storage accounts](https://ms.portal.azure.com/#create/Microsoft.StorageAccount-ARM) (**az2azcw**, **az2azcw2**) in Azure, one for each cluster in the same resource group (**SR-AZ2AZ**).

    - Copy the storage account name and key from the **Access keys** section.
    - In Failover Cluster Manager, create the cloud witness. Use the copied account name and key to create it.

1. Run [cluster validation tests](../../failover-clustering/create-failover-cluster.md#run-cluster-validation-tests) before you go to the next step.

1. Start Windows PowerShell and use the [`Test-SRTopology`](/powershell/module/storagereplica/test-srtopology) cmdlet to determine if you meet all the Storage Replica requirements. You can use the cmdlet in a requirements-only mode for a quick test and in long-running performance evaluation mode.

1. Configure cluster-to-cluster storage replication.

    Grant access from one cluster to another cluster in both directions:

    From our example:

    ```powershell
     Grant-SRAccess -ComputerName az2az1 -Cluster SRAZC2
    ```

    If you're using Windows Server 2016, run this command also:

    ```powershell
     Grant-SRAccess -ComputerName az2az3 -Cluster SRAZC1
    ```

1. Create a Storage Replica partnership for the two clusters:

    - Cluster **SRAZC1**: For volume location, use *C:\ClusterStorage\DataDisk1*. For log location, use *G:\\*.

    - Cluster **SRAZC2**: For volume location, use *C:\ClusterStorage\DataDiskCross*. For log location, use *G:\\*.

Then run the following command:

```powershell

New-SRPartnership -SourceComputerName SRAZC1 -SourceRGName rg01 -SourceVolumeName c:\ClusterStorage\DataDisk1 -SourceLogVolumeName  g: -DestinationComputerName **SRAZC2** -DestinationRGName rg02 -DestinationVolumeName c:\ClusterStorage\DataDisk2 -DestinationLogVolumeName  g: -LogType Raw
```

