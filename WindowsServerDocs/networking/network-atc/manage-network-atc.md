---
title: Manage Network ATC
description: This topic covers how to manage your Network ATC deployment.
author: robinharwood
ms.topic: how-to
ms.date: 05/20/2025
ms.author: roharwoo
---

# Manage Network ATC

> Applies to: Windows Server 2025; Azure Local 2311.2 and later

This article discusses how to manage Network ATC after it has been deployed. Network ATC simplifies the deployment and network configuration management for Windows Server and Azure Local clusters. You use Windows PowerShell to manage Network ATC.

## Add a server node

You can add nodes to a cluster. Each node in the cluster receives the same intent, improving the reliability of the cluster. The new server node must meet all requirements as listed in the Requirements and best practices section of [Host networking with Network ATC](network-atc.md).

In this task, you add additional nodes to the cluster and observe how a consistent networking configuration is enforced across all nodes in the cluster.

1. Use the `Add-ClusterNode` cmdlet to add the additional (not configured) nodes to the cluster. You only need management access to the cluster at this time. Each node in the cluster should have all pNICs named the same.

    ```powershell
    Add-ClusterNode -Cluster CLUSTER01
    Get-ClusterNode
    ```

1. Check the status across all cluster nodes. You need to use the `-ClusterName` parameter in version 21H2. Network ATC auto detects cluster name from version 22H2 and later.

   ```powershell
   Get-NetIntentStatus
   ```

    > [!NOTE]
    > If one of the servers you're adding to the cluster is missing a network adapter that's present on the other servers, `Get-NetIntentStatus` reports the error `PhysicalAdapterNotFound`.

1. Check the provisioning status of all nodes using `Get-NetIntentStatus`. The cmdlet reports the configuration for both nodes. This may take a similar amount of time to provision as the original node.

   ```powershell
   Get-NetIntentStatus
   ```

    You can also add several nodes to the cluster at once.

## Modify default VLANs for storage or management systems

You can use default VLANs specified by Network ATC or use values specific to your environment. To do this use -ManagementVLAN and -StorageVLANs parameter on Add-NetIntent.

``` powershell
Add-NetIntent -Name MyIntent -StorageVLANs 101, 102 -ManagementVLAN 10
```

## Add or remove network adapters from an intent

This task helps you update the network adapters assigned to an intent. If there are changes to the physical adapters in your cluster, you can use `Update-NetIntentAdapter` to update the relevant intents.

In this example, we installed two new adapters, pNIC03 and pNIC04, and we want them to be used in our intent named 'Cluster_Compute'.

1. On one of the cluster nodes, run `Get-NetAdapter` to check that both adapters are present and report status of 'Up' on each cluster node. 

    ``` powershell
    Get-NetAdapter -Name pNIC03, pNIC04 -CimSession (Get-ClusterNode).Name | Select Name, PSComputerName
    ```

1. Run the following command to update the intent to include the old and new network adapters. 

   ```powershell
   Update-NetIntentAdapter -Name Cluster_Compute -AdapterName pNIC01,pNIC02,pNIC03,pNIC04
   ```

1. Check that the net adapters were successfully added to the intent.

   ```powershell
       Get-NetIntent -Name Cluster_Compute 

   ```

## Global overrides and cluster network settings

Network ATC mainly consists of two kinds of global overrides: Proxy Configurations and Cluster Network Features.

### Cluster network features

In this section, we go over the set of new Cluster Network Features. The new Cluster Network Features enable and optimize cluster network naming, managing cluster networks by controlling performance options, bandwidth limits, and managing live migrations.

###### Cluster network naming

Description: By default, failover clustering always names unique subnets like this: "Cluster Network 1", "Cluster Network 2", and so on. This is unconnected to the actual use of the network because there's no way for clustering to know how you intended to use the networks – until now!

Once you define your configuration through Network ATC, we now understand how the subnets are going to be used, and we can name the cluster networks more appropriately. For example, we know which subnet is used for management, storage network 1, storage network 2 (and so on, if applicable). As a result we can name the networks more contextually.

In the following screenshot, you can see the storage intent was applied to this set of adapters. There's another unknown cluster network shown which the administrator may want to investigate.

:::image type="content" source="../media/manage-network-atc/cluster-network-naming.png" alt-text="Screenshot of Cluster Network Selection." lightbox="../media/manage-network-atc/cluster-network-naming.png":::

###### Live migration network selection

This value enables or disables the intent-based live migration cluster network selection logic. By default, this is enabled ($true) and results in cluster networks being selected based on the submitted intent information. If Live Migration Network Selection is disabled, the user can set a live migration network and default behavior would revert to what you would expect in the absence of Network ATC. 

###### Enable virtual machine migration: performance selection

This value enables or disables the intent-based selection of virtual machine live migration transports. By default, this is enabled and results in the system automatically determining the best live migration transport, for example: SMB, Compression, TCP.

If disabled:

- Live migration transport selection uses the transport specified in VirtualMachineMigrationPerformanceOption override value.
- If the VirtualMachineMigrationPerformanceOption override value isn't specified, Network ATC reverts to behavior when Network ATC was absent.
- If null, but VirtualMachineMigrationPerformanceOption is configured, configure this option to $false and use the option specified in the VirtualMachineMigrationPerformanceOption override

###### Virtual machine migration performance option

Network ATC configures the live migration transport to TCPIP, Compression, or SMB. If null, the system calculates the best option based on the system configuration and capabilities.

###### Maximum concurrent virtual machine migrations

Network ATC sets the default number of concurrent Virtual Machine migrations to one. The range of possible, allowed values for this property is one through 10.

###### Maximum SMB migration bandwidth

This value enforces a specific bandwidth limit (in Gbps) on SMB-transported live migration traffic to prevent consumption of the SMB traffic class. This value is only usable if the live migration transport is SMB. Default value is calculated.

#### Customize cluster network settings  

Cluster Network Features work through their defined defaults. Since disabling cluster network features doesn't land you in an unsupported scenario, Network ATC has an option for a globaloverride. You can use the global override to adjust properties and make cluster network feature properties customized to your needs.

To add a GlobalOverride with Network ATC:

```powershell
$clusterOverride = New-NetIntentGlobalClusterOverrides

```

The 'clusterOverride' variable has the following properties:

:::image type="content" source="../media/manage-network-atc/cluster-override.png" alt-text="Screenshot of Cluster Override Object." lightbox="../media/manage-network-atc/cluster-override.png":::

Once you set any property for the override, you can add it as a GlobalOverride for your cluster with the following command:

```powershell
Set-NetIntent -GlobalClusterOverrides $clusterOverride
```

And to verify a successful deployment of your clusterOverride run:

```powershell
Get-NetIntentStatus -Globaloverrides
```

To remove the GlobalClusterOverride, run the following:

```powershell
Remove-NetIntent -GlobalOverrides $clusterOverride
```

### Proxy configurations

Proxy is unlike the existing ATC overrides because it isn't tied to a specific intent. In fact, we support proxy configuration when there are no intents. We support this scenario best by implementing new global override parameters on Add/Set/Get-NetIntent, similar to Cluster Network Features.

The `New-NetIntentGlobalProxyOverrides` command is used to create an override object similar to existing QoS, RSS, and SwitchConfig overrides. The command will have two parameter sets:

###### Default parameter set

ProxyServer: The ProxyServer parameter takes strings as inputs, which represent the URL of the proxy server to use for https traffic. ProxyServer is a required parameter when setting up Proxy.

ProxyBypass: The ProxyBypass parameter takes a list of sites that should be visited by bypassing the proxy. To bypass all short name hosts, use `local`.  

AutoDetect: AutoDetect is a true or false parameter that dictates if Web Proxy Auto-Discovery (WPAD) should be enabled.

###### AutoDetect parameter set

AutoConfigUrl: The AutoConfigUrl parameter takes a string with the URL of the proxy server to use for http and/or https traffic as input. For both traffic classes, use a semi-colon to separate. This is a required parameter. 

AutoDetect: Similar to the AutoDetect parameter above, this is a true or false parameter that dictates if Web Proxy Auto-Discovery (WPAD) should be enabled.

##### Setting-up proxy

You can set your proxy configurations in the following ways:

```powershell
$ProxyOverride = New-NetIntentGlobalProxyOverrides -ProxyServer https://itg.contoso.com:3128 -ProxyBypass *.foo.com
```

Using the `AutoConfigURL` switch, you can set your proxy configuration in the following way:

```powershell
$ProxyOverride = New-NetIntentGlobalProxyOverrides -AutoConfigUrl https://itg.contoso.com
```

You can add a GlobalProxyOverride for your cluster as follows:

```powershell
Set-NetIntent -GlobalProxyOverride $ProxyOverride
```

To remove a GlobalProxyOverride for your cluster as follows:

```powershell
Remove-NetIntent -GlobalOverride $ProxyOverride
```

Finally, to access any global override, Proxy or Cluster, you can run the following commands:

```powershell
$Obj1 = Get-NetIntent -GlobalOverride
$Obj1
```

More specifically, you can access the Proxy and Cluster global overrides respectively, by calling their respective parameters for `$Obj1`:

```powershell
$Obj1.ProxyOverride
$Obj1.ClusterOverride
```

## Update or override network settings

This task helps you override the default configuration that has already been deployed. This example modifies the default bandwidth reservation for SMB Direct.

> [!IMPORTANT]
> We recommend using the default settings, which are based on Microsoft's best practices.

1. Get a list of possible override cmdlets. We use wildcards to see the options available:

    ```powershell
    Get-Command -Noun NetIntent*Over* -Module NetworkATC
    ```

1. Create an override object for the DCB Quality of Service (QoS) configuration:

    ```powershell
    $QosOverride = New-NetIntentQosPolicyOverrides
    $QosOverride
    ```

1. Modify the bandwidth percentage for SMB Direct:

    ```powershell
    $QosOverride.BandwidthPercentage_SMB = 25
    $QosOverride
    ```

    > [!NOTE]
    > Values are only shown for the properties that you override.

1. Submit the intent request specifying the override:

    ```powershell
    Set-NetIntent -Name Cluster_ComputeStorage -QosPolicyOverrides $QosOverride
    ```

1. Wait for the provisioning status to complete:

    ```powershell
    Get-NetIntentStatus -Name Cluster_ComputeStorage | Format-Table IntentName, Host, ProvisioningStatus, ConfigurationStatus
    ```

1. Check that the override has been properly set on all cluster nodes. In the example, the SMB_Direct traffic class was overridden with a bandwidth percentage of 25%:

    ```powershell
    Get-NetQosTrafficClass -Cimsession (Get-ClusterNode).Name | Select PSComputerName, Name, Priority, Bandwidth
    ```

## Test Network ATC in VMs

Running Azure Local inside VMs is useful for test environments. To do so, add an adapter property override to your intent that disables the **NetworkDirect** adapter property:

```powershell
$AdapterOverride = New-NetIntentAdapterPropertyOverrides
$AdapterOverride.NetworkDirect = 0
Add-NetIntent -Name MyIntent -AdapterName vmNIC01, vmNIC02 -Management -Compute -Storage -AdapterPropertyOverrides $AdapterOverride
```

> [!NOTE]
> Ensure you have multiple virtual CPUs on each VM.

## Remove an intent

Sometimes you might want to remove all intents and start over—for example, to test a different configuration. While you can remove intents using the Remove-NetIntent cmdlet, doing so won't clean up the virtual switches and DCB/NetQoS configurations created for the intents. Network ATC makes a point of not destroying things on your system, which is usually a good thing, but it does mean you must perform some manual steps to start over.

To remove all network intents and delete the virtual switches and NetQoS configurations created by Network ATC for these intents, run the following script in a PowerShell session running locally on one of the servers in the cluster (doesn't matter which).

```powershell
$clusname = Get-Cluster
$clusternodes = Get-ClusterNode    
$intents = Get-NetIntent -ClusterName $clusname

foreach ($intent in $intents)
{
    Remove-NetIntent -Name $intent.IntentName -ClusterName $clusname
}

foreach ($intent in $intents)
{
    foreach ($clusternode in $clusternodes)
    {
        Remove-VMSwitch -Name "*$($intent.IntentName)*" -ComputerName $clusternode -ErrorAction SilentlyContinue -Force
    }
}

foreach ($clusternode in $clusternodes)
{    
    New-CimSession -ComputerName $clusternode -Name $clusternode
    $CimSession = Get-CimSession
    Get-NetQosTrafficClass -CimSession $CimSession | Remove-NetQosTrafficClass -CimSession $CimSession
    Get-NetQosPolicy -CimSession $CimSession | Remove-NetQosPolicy -Confirm:$false -CimSession $CimSession
    Get-NetQosFlowControl -CimSession $CimSession | Disable-NetQosFlowControl -CimSession $CimSession
    Get-CimSession | Remove-CimSession
}
```

To remove the configuration on a per-node deployment, copy and paste the following commands on each node to remove all existing intents and their corresponding vSwitch:

```powershell
$intents = Get-NetIntent
foreach ($intent in $intents)
{
    Remove-NetIntent -Name $intent.IntentName
    Remove-VMSwitch -Name "*$($intent.IntentName)*" -ErrorAction SilentlyContinue -Force
}

Get-NetQosTrafficClass | Remove-NetQosTrafficClass
Get-NetQosPolicy | Remove-NetQosPolicy -Confirm:$false
Get-NetQosFlowControl | Disable-NetQosFlowControl
```

## Post-deployment tasks

The tasks to complete following a Network ATC deployment is depending on the Azure Stack HCI version used. For Azure Stack HCI 21H2 Clusters:

- **Add IP addresses to storage adapters:** Use DHCP on the storage VLANs or set static IP addresses using the NetIPAdress cmdlet. You can't use the Automatic Private IP Addressing (APIPA) addresses given to adapters that can't get an address from a DHCP server.

- **Set SMB bandwidth limits:** If live migration uses SMB Direct (RDMA), configure a bandwidth limit to ensure that live migration doesn't consume all the bandwidth used by Storage Spaces Direct and Failover Clustering.

- **Stretched cluster configuration:** To add Stretch S2D to your Network ATC managed system you must manually add the appropriate configuration (including vNICs, etc.) after Network ATC has implemented the specified intent.

Automatic IP Addressing for Storage Adapters, SMB Bandwidth Limits, and Stretch configurations can now be deployed with Network ATC in Azure Local. For more information, see:

- **Automatic Storage IP Addressing**: [Automatic Storage IP Addressing with Network ATC](./network-atc.md#automatic-storage-ip-addressing)

- **Cluster Network Settings and SMB Configuration**: [Automatic Storage IP Addressing with Network ATC](./network-atc.md#cluster-network-settings)

- **Stretch cluster configuration**: [Set-up Stretch Clustering with Network ATC](/azure/azure-local/deploy/create-cluster-powershell#step-54-set-up-stretch-clustering-with-network-atc)

## Validate automatic remediation

Network ATC ensures that the deployed configuration stays the same across all cluster nodes. In this optional section, we modify our configuration (without an override) emulating an accidental configuration change and observe how the reliability of the system is improved by remediating the misconfigured property.

1. Check the adapter's existing MTU (JumboPacket) value:

    ```powershell
    Get-NetAdapterAdvancedProperty -Name pNIC01, pNIC02, vSMB* -RegistryKeyword *JumboPacket -Cimsession (Get-ClusterNode).Name
    ```

1. Modify one of the physical adapter's MTU without specifying an override. This emulates an accidental change or "configuration drift", which must be remediated.

    ```powershell
    Set-NetAdapterAdvancedProperty -Name pNIC01 -RegistryKeyword *JumboPacket -RegistryValue 4088
    ```

1. Verify that the adapter's existing MTU (JumboPacket) value has been modified:

    ```powershell
    Get-NetAdapterAdvancedProperty -Name pNIC01, pNIC02, vSMB* -RegistryKeyword *JumboPacket -Cimsession (Get-ClusterNode).Name
    ```

1. Retry the configuration. This step is only performed to expedite the remediation. Network ATC will automatically remediate this configuration.

    ```powershell
    Set-NetIntentRetryState -ClusterName CLUSTER01 -Name Cluster_ComputeStorage -NodeName Node01
    ```

1. Verify that the consistency check has completed:

    ```powershell
    Get-NetIntentStatus -ClusterName CLUSTER01 -Name Cluster_ComputeStorage
    ```

1. Verify that the adapter's MTU (JumboPacket) value has returned to the expected value:

    ```powershell
    Get-NetAdapterAdvancedProperty -Name pNIC01, pNIC02, vSMB* -RegistryKeyword *JumboPacket -Cimsession (Get-ClusterNode).Name
    ```

For more validation examples, see the [Network ATC demo](https://youtu.be/Z8UO6EGnh0k).

## Next steps

- Learn more about [Network ATC](/azure/azure-local/concepts/network-atc-overview?pivots=azure-local).
- Learn more about [Stretched clusters](/azure/azure-local/concepts/stretched-clusters).