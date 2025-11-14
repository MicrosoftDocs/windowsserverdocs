---
title: Deploy host networking with Network ATC
description: Learn how to deploy host networking with Network ATC for Windows Server and Azure Local clusters. Simplify network configuration management using intent-based automation for compute, storage, and management networks.
#customer intent: As a network administrator, I want to deploy host networking using Network ATC so that I can manage compute, storage, and management networks across all cluster nodes using the same adapters.
author: robinharwood
ms.topic: how-to
ms.date: 07/18/2025
ms.author: roharwoo
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-description
  - ai-seo-date:07/18/2025
---

# Deploy host networking with Network ATC

This article guides you through the requirements, best practices, and deployment of Network ATC. Network ATC simplifies the deployment and network configuration management for Windows Server and Azure Local clusters. Network ATC provides an intent-based approach to host network deployment. By specifying one or more intents (management, compute, or storage) for a network adapter, you can automate the deployment of the intended configuration. For more information on Network ATC, including an overview and definitions, see [Network ATC overview](/azure/azure-local/concepts/network-atc-overview?pivots=windows-server).

If you have feedback or encounter any issues, review the requirements and best practices section, check the Network ATC event log, and work with your Microsoft support team.

## Prerequisites

Complete the following prerequisites for using Network ATC:

- All servers in the cluster must be running Windows Server 2025 or later for Windows Server, and version 2311.2 or later for Azure Local environments.

- Must use physical hosts that are certified for Windows Server or Azure Local. For hardware certified for Secured-core server, see [Windows Server Catalog](https://www.windowsservercatalog.com/). For validated nodes or higher for Azure Local, see [Azure Local catalog](https://azurestackhcisolutions.azure.microsoft.com/).

- Adapters in the same Network ATC intent must be symmetric (of the same make, model, speed, and configuration) and available on each cluster node.

  - Asymmetric adapters lead to a failure in deploying any intent. Network ATC automatically confirms adapter symmetry for all nodes in the cluster before deploying an intent.

  - For more information on adapter symmetry, see [Switch Embedded Teaming (SET)](/azure/azure-local/concepts/host-network-requirements#switch-embedded-teaming-set).

- Each physical adapter specified in an intent must use the same name on all nodes in the cluster.

- Ensure each network adapter has an "Up" status, as verified by the PowerShell `Get-NetAdapter` cmdlet.

- Each node must have the following Windows Server features installed:

  - Network ATC
  - Hyper-V
  - Failover Clustering
  - Data Center Bridging
  - Failover cluster - SMB Bandwidth (FS-SMBBW)

   Here's an example of installing the required features via PowerShell:

   ```powershell
  Install-WindowsFeature -Name NetworkATC, Hyper-V, 'Failover-Clustering', 'Data-Center-Bridging', FS-SMBBW -IncludeManagementTools
   ```

- Insert each adapter in the same PCI slots in each host. This practice leads to ease in automated naming conventions by imaging systems.

- Configure the physical network (switches) before Network ATC including VLANs, MTU, and DCB configuration. For more information, please see [Physical Network Requirements](/azure/azure-local/concepts/physical-network-requirements).

> [!IMPORTANT]
> Deploying Network ATC in virtual machines might be used for test and validation purposes only. VM-based deployment requires an override to the default adapter settings to disable the NetworkDirect property. For more information on submission of an override, see: [Override default network settings](./manage-network-atc.md#update-or-override-network-settings).

## Common Network ATC commands

To identify the available Network ATC commands, run the `Get-Command -ModuleName NetworkATC` cmdlet in PowerShell. Ensure PowerShell is run as an administrator.

The `Remove-NetIntent` cmdlet removes an intent from the local node or cluster. This command doesn't destroy the invoked configuration.

## Example intents

Network ATC modifies how you deploy host networking, not what you deploy. You can deploy multiple scenarios so long as each scenario is a supported scenario from Microsoft. Here are some examples of common deployment options, and the PowerShell commands needed. These scenarios aren't the only combinations available but they should give you an idea of the possibilities.

For simplicity we only demonstrate two physical adapters per SET team, however it's possible to add more. For more information, please see [Plan Host Networking](/azure/azure-local/concepts/host-network-requirements).

### Fully converged intent

For this intent, compute, storage, and management networks are deployed and managed across all cluster nodes.

:::image type="content" source="../media/network-atc/network-atc-2-full-converge.png" alt-text="Fully converged intent" lightbox="../media/network-atc/network-atc-2-full-converge.png":::

```powershell
Add-NetIntent -Name ConvergedIntent -Management -Compute -Storage -AdapterName pNIC01, pNIC02
```

### Converged compute and storage intent; separate management intent

Two intents are managed across cluster nodes. Management uses pNIC01, and pNIC02; Compute and storage are on different adapters.

:::image type="content" source="../media/network-atc/network-atc-3-separate-management-compute-storage.png" alt-text="Storage and compute converged intent"  lightbox="../media/network-atc/network-atc-3-separate-management-compute-storage.png":::

```powershell
Add-NetIntent -Name Mgmt -Management -AdapterName pNIC01, pNIC02
Add-NetIntent -Name Compute_Storage -Compute -Storage -AdapterName pNIC03, pNIC04
```

### Fully disaggregated intent

For this intent, compute, storage, and management networks are all managed on different adapters across all cluster nodes.

:::image type="content" source="../media/network-atc/network-atc-4-fully-disaggregated.png" alt-text="Fully disaggregated intent"  lightbox="../media/network-atc/network-atc-4-fully-disaggregated.png":::

```powershell
Add-NetIntent -Name Mgmt -Management -AdapterName pNIC01, pNIC02
Add-NetIntent -Name Compute -Compute -AdapterName pNIC03, pNIC04
Add-NetIntent -Name Storage -Storage -AdapterName pNIC05, pNIC06
```

### Storage-only intent

For this intent, only storage is managed. Network ATC doesn't manage the Management and compute adapters.

:::image type="content" source="../media/network-atc/network-atc-5-fully-disaggregated-storage-only.png" alt-text="Storage only intent"  lightbox="../media/network-atc/network-atc-5-fully-disaggregated-storage-only.png":::

```powershell
Add-NetIntent -Name Storage -Storage -AdapterName pNIC05, pNIC06
```

### Compute and management intent

For this intent, compute and management networks are managed, but not storage.

:::image type="content" source="../media/network-atc/network-atc-6-disaggregated-management-compute.png" alt-text="Management and compute intent"  lightbox="../media/network-atc/network-atc-6-disaggregated-management-compute.png":::

```powershell
Add-NetIntent -Name Management_Compute -Management -Compute -AdapterName pNIC01, pNIC02
```

### Multiple compute (switch) intents

For this intent, multiple compute switches are managed.

:::image type="content" source="../media/network-atc/network-atc-7-multiple-compute.png" alt-text="Multiple switches intent"  lightbox="../media/network-atc/network-atc-7-multiple-compute.png":::

```powershell
Add-NetIntent -Name Compute1 -Compute -AdapterName pNIC03, pNIC04
Add-NetIntent -Name Compute2 -Compute -AdapterName pNIC05, pNIC06
```

## Default Network ATC values

Network ATC uses a set of default values to simplify the deployment and management of host networking. These defaults are applied when you create intents or modify network settings. Understanding these defaults can help you manage your network configuration effectively.

### Default values

This section describes other default values configured by Network ATC.

#### Default VLANs

Network ATC uses the following VLANs by default for adapters with the _storage_ intent type. If the adapters are connected to a _physical_ switch, these VLANs must be allowed on the physical network. If the adapters are switchless, no other configuration is required.

|Adapter Intent|Default Value|
|--|--|
|Management|Configured VLAN for management adapters isn't modified|
|Storage Adapter 1|711|
|Storage Adapter 2|712|
|Storage Adapter 3|713|
|Storage Adapter 4|714|
|Storage Adapter 5|715|
|Storage Adapter 6|716|
|Storage Adapter 7|717|
|Storage Adapter 8|718|
|Future Use|719|

Consider the following command:

```powershell
Add-NetIntent -Name MyIntent -Storage -AdapterName pNIC01, pNIC02, pNIC03, pNIC04
```

The physical NIC (or virtual NIC if necessary) is configured to use VLANs 711, 712, 713, and 714 respectively.

> [!NOTE]
> Network ATC allows you to change the VLANs used with the `StorageVlans` parameter on `Add-NetIntent`.

#### Automatic storage IP addressing

Network ATC automatically configures valid IP Addresses for adapters with the _storage_ intent type. Network ATC performs this configuration in a uniform manner across all nodes in your cluster and verifies that the address chosen isn't already in use on the network.

The default IP Address for each adapter on each node in the storage intent is set up as follows:

|Adapter|IP Address and Subnet|VLAN|
|--|--|--|
|pNIC1|10.71.1.X |711|
|pNIC2|10.71.2.X |712|
|pNIC3|10.71.3.X |713|

To override Automatic Storage IP Addressing, create a storage override and pass the override when creating an intent:

```powershell
$StorageOverride = New-NetIntentStorageOverrides
$StorageOverride.EnableAutomaticIPGeneration = $false
```

```powershell
Add-NetIntent -Name MyIntent -Storage -Compute -AdapterName 'pNIC01', 'pNIC02' -StorageOverrides $StorageOverride
```

#### Cluster network settings

Network ATC configures a set of Cluster Network Features by default. The defaults are listed as follows:

|Property|Default|
|--|--|
|`EnableNetworkNaming` |` $true`|
|`EnableLiveMigrationNetworkSelection` | `$true`|
|`EnableVirtualMachineMigrationPerformance` | `$true`|
|`VirtualMachineMigrationPerformanceOption` | Default is calculated: SMB, TCP, or Compression|
|`MaximumVirtualMachineMigrations` | 1 |
|`MaximumSMBMigrationBandwidthInGbps`  | Default is calculated based on set-up |

### Default Data Center Bridging (DCB) configuration

Network ATC establishes the following priorities and bandwidth reservations. This configuration should also be configured on the physical network.

|Policy|Use|Default Priority|Default Bandwidth Reservation|
|--|--|--|--|
|Cluster|Cluster Heartbeat reservation|7|2% if one or more adapters are <= 10 Gbps; 1% if one or more adapters are > 10 Gbps|
|SMB_Direct|RDMA Storage Traffic|3|50%|
|Default|All other traffic types|0|Remainder|

> [!NOTE]
> Network ATC allows you to override default settings like default bandwidth reservation. For examples, see [Update or override network settings](./manage-network-atc.md#update-or-override-network-settings).

## Common Error Messages

With the new event logs, there are some simplistic troubleshooting methods to identify intent deployment failures. This section outlines some of the common fixes when an issue is encountered. The following errors are from the output of the `Get-NetIntentStatus` cmdlet.

### Error: AdapterBindingConflict

:::image type="content" source="../media/network-atc/error-adapterbindingconflict.png" alt-text="Screenshot of Adapter Binding Error."  lightbox="../media/network-atc/error-adapterbindingconflict.png":::

Scenario 1: An adapter is bound to an existing vSwitch that conflicts with the new vSwitch that is being deployed by Network ATC.

**Solution:** Remove the conflicting vSwitch, then Set-NetIntentRetryState

Scenario 2: An adapter is bound to the component, but not necessarily a vSwitch.

**Solution:** Disable the vms_pp component (unbind the adapter from the vSwitch) then run Set-NetIntentRetryState.

### Error: ConflictingTrafficClass

:::image type="content" source="../media/network-atc/error-conflictingtrafficclass.png" alt-text="Screenshot of Conflicting Traffic Class error."  lightbox="../media/network-atc/error-conflictingtrafficclass.png":::

This issue occurs because a traffic class is already configured. Network ATC is attempting to deploy traffic classes that conflict with this preconfigured traffic class. For example, you might have deployed a traffic class called SMB when Network ATC tries to deploy a similar traffic class with a different name.

**Solution:**

Clear the existing DCB configuration on the system then run Set-NetIntentRetryState

```powershell

Get-NetQosTrafficClass | Remove-NetQosTrafficClass
Get-NetQosPolicy | Remove-NetQosPolicy -Confirm:$false
Get-NetQosFlowControl | Disable-NetQosFlowControl
```

### Error: Network Symmetry Check Failure

You might encounter a situation where functionally symmetric adapters have different component ID strings. It might occur if a substring is added to an adapter's component ID during an upgrade or when combining OCP and PCI NICs within the same intent. To work around this issue, you can disable the component ID based symmetry check by setting the `NicSymmetryCheckEnabled` registry key to 0. This setting allows Network ATC to proceed with the deployment without checking for symmetry based on component IDs. You should only use this workaround if you're certain that the adapters are functionally symmetric.

```powershell
Stop-Service -Name NetworkATC
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NetworkATC' -Name "NicSymmetryCheckEnabled" -Value 0 -PropertyType DWord
Start-Service -Name NetworkATC
```

After you disable the component ID based symmetry check, you can continue with the intent deployment.

### Error: RDMANotOperational

:::image type="content" source="../media/network-atc/error-rdmanotoperational.png" alt-text="Screenshot of RDMA Not Operational error."  lightbox="../media/network-atc/error-rdmanotoperational.png":::

You might see this message:

1. If the network adapter uses an inbox driver. Inbox drivers aren't supported and must be updated.

   **Solution:** Upgrade the driver for the adapter.

1. If SR-IOV is disabled in the BIOS.

   **Solution:** Enable SR-IOV for the adapter in the system BIOS

1. If RDMA is disabled in the BIOS

   **Solution:** Enable RDMA for the adapter in the system BIOS

### Error: InvalidIsolationID

:::image type="content" source="../media/network-atc/error-invalidisolationid.png" alt-text="Screenshot of Invalid Isolation ID error."  lightbox="../media/network-atc/error-invalidisolationid.png":::

This message occurs when you use RoCE RDMA and override the default VLAN with an invalid value. Meaning the value you chose can't be used with that protocol. For example, RoCE RDMA requires a nonzero VLAN so that Priority Flow Control (PFC) markings can be added to the frame. A VLAN value between 1 - 4094 must be used. Network ATC doesn't override the value you specified without administrator intervention for several reasons. To resolve this issue:

1. Choose iWARP as the RDMA (NetworkDirect) protocol

    **Solution:** If supported by the adapter, Network ATC automatically chooses iWARP as its RDMA protocol that might use a VLAN ID of 0. Remove the override that enforces RoCE as the chosen protocol.

1. Use the default VLANs

    **Solution:** We highly recommend using the Network ATC [Default VLANs](#default-vlans)

1. Use a valid VLAN

    When specifying a VLAN, use the -StorageVLANs parameter and specify comma separated values between 1 - 4094.

## Next steps

- Manage your Network ATC deployment. See [Manage Network ATC](./manage-network-atc.md).
- Learn more about [Stretched clusters](/azure/azure-local/concepts/stretched-clusters).
