---
title: Accelerated Networking (preview)
description: How to set up and validate Accelerated Networking on your VMs.
ms.topic: article
ms.author: helohr
author: Heidilohr
ms.date: 10/21/2024
---
# Accelerated Networking (preview)

> [!IMPORTANT]
> Accelerated Networking is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Accelerated Networking enables single root input-output (IO) virtualization (SR-IOV) on supported virtual machine (VM) types, greatly improving networking performance. Accelerated Networking lets network traffic bypass the software switch layer of Hyper-V virtualization stacks. Because Accelerated Networking assigns the virtual function (VF) to a child partition, the network traffic flows directly between the VF and child partition. As a result, the IO overhead in the software emulation layer shrinks until network performance becomes almost the same as physical, on-premises environments.

The following diagram illustrates how two VMs communicate with and without Accelerated Networking.

:::image type="content" source="./media/accelerated-networking.png" alt-text="A diagram showing the difference between two deployments with and without Accelerated Networking. The deployment without accelerated networking has to send its network traffic through two virtual switches on physical servers, while the network with Accelerated Networking doesn't.":::

Accelerated Networking's high-performance data path enables single root I/O virtualization (SR-IOV) on supported VM types, greatly improving networking performance in the following ways:

- Lower latency and higher packets per second (pps). Removing the virtual switch from the data path eliminates the wait time that packets need to spend in the host for policy processing. Higher pps increases the number of packets that the VM can process.

- Reduced jitter. Processing time for virtual switches depends on how many policies the host needs to apply and the workload of the CPU that does the processing. Offloading policy enforcement to the hardware removes that variability by delivering packets directly to the VM. Offloading also removes the host-to-VM communication, all software interrupts, and all context switches.

- Decreased CPU utilization. Bypassing the virtual switch in the host leads to less CPU utilization for processing network traffic.

Accelerated Networking also adds an extra management layer with the following features:

- Built-in prerequisite checks that let you know if your deployment's compatible with Accelerated Networking by checking SR-IOV support, OS version, hyperthreading status, and so on.

- Host configuration ensures SR-IOV is enabled on the correct vSwitch hosting VM workloads, and also allows you to configure reserve nodes for failover scenarios and avoiding resource oversubscription.

- Simplified VM performance settings that show overall performance as Low, Medium, and High to make configuration easier.

These features make Accelerated Networking useful for environments that require high-peformance computing (HPC) for intensive computational tasks, real-time applications like financial trading platforms, or deployments that use Network Function Virtualization (NFV) to work around limits on network throughput.

## Prerequisites

Your deployment needs to meet the following prerequisites in order to be able to set up and use Accelerated Networking:

- You must set up a functioning cluster on a deployment running Windows Server 2025 Datacenter edition.

  >[!NOTE]
  >Non-clustered single servers and Windows Server Standard edition don't support Accelerated Networking.

- Your hardware must support SR-IOV and be enabled in the BIOS. You may need to contact your hardware vendor to see if your machine supports SR-IOV.

- An SR-IOV supported network interface card (NIC).

  - Run the following cmdlet to enable SR-IOV on your NIC if you haven't already:

    ```powershell
    Enable-NetAdapterSriov
    ```

- The Virtualization feature must be enabled in your BIOS.

>[!NOTE]
>The public preview version of Accelerated Networking currently doesn't support the following scenarios:
>
>- Switch Embedded Teaming (SET) NICs. You can only use one NIC at a time.
>
>- Network HUD support
>
>- Windows Admin Center UI

## Enable Accelerated Networking on a cluster

To enable Accelerated Networking on a cluster:

1. Open an elevated PowerShell window as an administrator.

1. Run the following cmdlet to make sure your system meets all prerequisite requirements:

  ```powershell
  Get-AccelNetManagementPreReq
  ```

1. Go to any node that's on the cluster where you want to enable Accelerated Networking.

1. Run the following command to enable Accelerated Networking:

  ```powershell
  Enable-AccelNetManagement -IntentName "MyIntent" -NodeReservePercentage
  ```

  >[!NOTE]
  > The `-IntentName` parameter is required.
  >
  >If you leave the `NodeReservePercentage` value blank, the system defaults to 50%. This value must be an integer greater than or equal to 0 and less than or equal to 99.

## Change Accelerated Networking settings on a cluster

To change Accelerated Networking settings on a cluster:

On a node with Accelerated Networking enabled, run the following command with the values for the new intent and node reserve:

```powershell
Set-AccelNetManagement -IntentName "MyIntent" -NodeReservePercentage
```

## Disable Accelerated Networking on a cluster

To disable Accelerated Networking on a cluster:

1. In a PowerShell window, go to any node in the cluster you want to disable Accelerated Networking for.

1. Run the following cmdlet to disable Accelerated Networking on the cluster:

  ```powershell
  Disable-AccelNetManagement 
  ```

After you disable the cluster, the Network HUD no longer monitors the health of the feature.

>[!NOTE]
>Disabling Accelerated Networking at the cluster doesn't change setting configurations on the VMs. VMs are no longer managed by Accelerated Networking or tracked by the Network HUD.

## Enable Accelerated Networking on a VM

To enable Accelerated Networking on a VM:

1. Create a VM on a host in a cluster that has Accelerated Networking enabled.

1. In a PowerShell window, go to the node containing the VM you want to enable Accelerated Networking.

1. Run the following command to enable Accelerated Networking with high performance:

  ```powershell
  Enable-AccelNetVM -VMName "MyVM" -Performance High
  ```

  **VMName** and **Performance** are required parameters. You can set the performance value to Low, Medium, or High. Performance options have minimum vCPU requirements based on hyperthreading status, as shown in the following table:

  | Hyperthreading configuration | Performance setting | Minimum vCPUs required |
  |---|---|---|
  | Disabled | Low | 2 |
  | Disabled | Medium | 2 |
  | Disabled | High | 4 |
  | Enabled | Low | 4 |
  | Enabled | Medium | 4 |
  | Enabled | High | 4 |

1. To enable Accelerated Networking for multiple VMs to run in low performance, run the following command:

  ```powershell
  Get-VM -VMName "MyVM01, MyVM02" | Enable-AccelNetVM -Performance Low
  ```

## Change Accelerated Networking settings on a VM

To change the Accelerated Networking settings on a VM:

1. Go to the node that contains the VMs you want to reconfigure.

1. Run the following command to set your VM to run in medium performance:

   ```powershell
   Set-AccelNetManagement -VMName "MyVM" -Performance Medium
   ```

## Disable Accelerated Networking on a VM

To disable Accelerated Networking on a VM:

1. Go to the node that contains the VMs you want to disable Accelerated Networking for.

1. Run the following command:
  
   ```powershell
   Disable-AccelNetVM -VMName "MyVM"
   ```

1. To disable Accelerated Networking for multiple VMs, run the following command:

  ```powershell
  Get-VM -VMName "MyVM01, MyVM02" | Disable-AccelNetVM
  ```

## Known issues

The following error messages are possible issues you may encounter while using this feature.

### Accel_net_not_supported

Node {0} does not support Accelerated Networking. Windows Server 2025 24H2 or later is required.

To resolve this issue, update your OS to the latest version of Windows Server.

### Hyperthreading_check_failed

Hyperthreading validation: Failed. There is an inconsistency across the cluster. Either disable or enable hyperthreading on all nodes.

To resolve this issue, make sure the hyperthreading configuration is consistent for every node in your cluster.

### Intent_not_found

Intent validation: Failed. Intent {0} not found.  

To resolve this issue, make sure the intent name you entered is correct, then try again.

### Intent_type_check_failed

The selected intent {0} does not have Compute capabilities.

To resolve this issue, create or update an intent with the Compute state.

### Sriov_support_[KEY]

#### Unknown

Adapter {0} cannot be enabled for Accelerated Networking because it is not advertising SR-IOV Support.

To resolve this issue, make sure the computer hardware can support SR-IOV and that you enabled I/O virtualization in the BIOS.

#### MissingAcs

Adapter {0} cannot be enabled for Accelerated Networking because it is in a PCIe slot that does not support Access Control Services (ACS).

To resolve this issue, either try moving the device to another PCIe slot or contact your hardware vendor.

#### MissingPfDriver

Adapter {0} cannot be enabled for Accelerated Networking because the device driver does not support SR-IOV.

To resolve this issue, update the driver.

#### NoBusResources

Adapter {0} cannot be enabled for Accelerated Networking because there are not enough PCI Express bus numbers available.

There are no known solutions for this issue at this time.

### Get_network_adapter_failed

Failed to get network adapters for VM {0}.  

To resolve this issue, make sure the VM has at least one network adapter.

### ht_enabled_min_processor_counter

The minimum required processor count for requested performance with hyperthreading enabled/disabled is {0}.

To resolve this issue, add more vCPUs to the VM in order to meet the requirements.

### cannot_provision_performance

Cannot provision {0} on this system.

To resolve this issue, select a different Performance option or update your network adapters.

### enable_accel_net_failed

Failed to enable Accelerated Networking on the cluster {0}.  

To resolve this issue, make sure you're using a valid PayGo subscription license.

### vm_not_enough_vcpus

VM {0} does not have enough vCPUs to enable Accelerated Networking with the specified performance. 

There is no known way to resolve this issue at this time.

### cluster_not_enough_resources

The cluster does not have enough SRIOV resources to enable VM {0}.  

To resolve this issue, either lower the NodeReservePercentage value, select a different Performance option, or increase the number of SRIOV resources in your cluster.

## Next steps

- For more information about virtualized networking, see [Hyper-V overview](../../../virtualization/hyper-v/hyper-v-overview.md).

- For more information about Azure Arc-enabled servers, see [What are Azure Arc-enabled servers?](/azure/azure-arc/servers/overview)

- For more information about high-performance networking (HPN), see [High-performance networking (HPN)](../hpn/hpn-top.md).
