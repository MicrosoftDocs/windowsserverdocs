---
title: Accelerated Networking
description: How to set up and validate Accelerated Networking on your VMs.
ms.topic: article
ms.author: helohr
author: Heidilohr
ms.date: 08/09/2024
---
# Accelerated Networking

On regular networking, all traffic entering and leaving a virtual machine (VM) goes between the host and the virtual switch. The virtual switch provides all policy enforcement for network traffic, including network security groups, access control lists, isolation, and other network virtualized services.

Accelerated networking offloads all network policies applied by the virtual switch, instead applying them using the hardware. When the hardware applies policies, the VM network interface (NIC) can forward network traffic directly to the VM. The NIC also bypasses the host and the virtual switch while maintaining all policies applied in the host.

The following diagram illustrates how two VMs communicate with and without Accelerated Networking.

<!--Image goes here-->

Accelerated Networking's high-performance data path enables single root I/O virtualization (SR-IOV) on supported VM types, greatly improving networking performance in the following ways:

- Lower latency and higher packets per second (pps). Removing the virtual switch from the data path eliminates the wait time that packets need to spend in the host for policy processing. Higher pps increases the number of packets that the VM can process.

- Reduced jitter. Processing time for virtual switches depends on how many policies the host needs to apply and the workload of the CPU that does the processing. Offloading policy enforcement to the hardware removes that variability by delivering packets directly to the VM. Offloading also removes the host-to-VM communication, all software interrupts, and all context switches.

- Decreased CPU utilization. Bypassing the virtual switch in the host leads to less CPU utilization for processing network traffic.

## Prerequisites

Your deployment needs to meet the following prerequisites in order to roperly set up and use Accelerated Networking:

- An Arc Premium subscription

- A functioning cluster on a Windows Server 2025 Datacenter

  - Non-clustered single servers and WS Standard don't support Accelerated Networking.

- Your hardware must support SR-IOV, and you must enable SR-IOV on BIOS. You may need to contact your hardware vendor to see if your machine supports SR-IOV.

- An SR-IOV supported NIC.

  - You may need to run the [Enable-NetAdapterSriov (NetAdapter)](/powershell/module/netadapter/enable-netadaptersriov?view=windowsserver2022-ps) cmdlet.

- You may also need to expose the Virtual Functions from the BIOS. We recommend exposing the PUT REC function.

- If you're running Azure Stack HCI, then after you enable SR-IOV, you must install and configure a valid Compute intent for a [Network Advanced Transfer Cache (ATC)](/azure-stack/hci/deploy/network-atc?tabs=22H2). You can only enable Accelerated Networking on vSwitches managed by a Network ATC Compute intent.

- If you're running Azure Stack HCI, you must install a [Network HUD](/azure-stack/hci/concepts/network-hud-overview) that runs Storage Spaces Direct.

## Enable Accelerated Networking on a cluster

#### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window as an administrator.

1. Run the following cmdlet to make sure your system meets all prerequisite requirements:

  ```powershell
  Get-AccelNetManagementPreReq
  ```

1. Go to any node that's on the cluster you want to enable Acellerated Networking for.

1. Run the following cmdlet to enable Accelerated Networking:

  ```powershell
  Enable-AccelNetManagement -IntentName -NodeReservePercentage
  ```

  >[!NOTE]
  >Intent name is a required parameter. If you leave the `NodeReservePercentage` value blank, the system defaults to 50%. This value must be an integer greater than or equal to 0 and less than or equal to 99.
#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Change Accelerated Networking settings on a cluster

#### [PowerShell](#tab/powershell)

On a node with Accelerated Networking enabled, run the following cmdlet with the vaues for the new intent and node reserve:

```powershell
Set-AccelNetManagement -IntentName -NodeReservePercentage
``` 

#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Disable Accelerated Networking on a cluster

#### [PowerShell](#tab/powershell)

1. In a PowerShell window, go to any node in the cluster you want to disable Accelerated Networking for.

1. Run the following cmdlet to disable AccelNet on the cluster:

  ```powershell
  Run Disable-AccelNetManagement 
  ```

1. After the cluster is disabled, the Network HUD no longer monitors the health of the feature.

>[!NOTE]
>Disabling AccelNet at the cluster doesn't change setting configurations on the virtual machines (VMs). VMs are no longer managed by AccelNet or tracked by the Network HUD.
#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Enable Accelerated Networking on a VM

#### [PowerShell](#tab/powershell)

1. Create a VM on a host in a cluster that has AccelNet enabled.

1. In a PowerShell window, go to the node containing the VM you want to enable AcceNet on.

1. Run the following cmdlet to enable AccelNet:

  ```powershell
  Enable-AccelNetVM -VMName -Performance
  ```

  VMName and Performance are required parameters. You can set the Performance value to Low, Medium, or High. Performance options have minimum vCPU requirements based on hyperthreading status, as shown in the following table:

  |Hyperthreading configuration| Performance setting | Minimum vCPUs required |
  |---|---|---|
  ||||
  ||||
  ||||
  ||||
  ||||
  ||||

1. To enable AccelNet for multiple VMs, divide each -VMName and -Performance value for each VM with the pipe symbol, as shown in the following example:

  ```powershell
  <example cmdlet>
  ```




VMName and Performance are required parameters. Performance can be selected from the following options: Low, Medium, High 

To enable on multiple, use the pipe “|” command in powershell 

These performance options have a minimum vCPU requirement based on the hyperthreading status 

#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Change Accelerated Networking settings on a VM

#### [PowerShell](#tab/powershell)

<!--- Content here  -->

#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Disable Accelerated Networking on a VM

#### [PowerShell](#tab/powershell)

<!--- Content here  -->

#### [Windows Admin Center](#tab/wac)

<!--- Content here  -->

---

## Known issues

The following error messages are possible issues you may encounter while using this feature.

### Accel_net_not_supported

Node {0} does not support Accelerated Networking. Windows Server 2025/Azure Stack HCI 24H2 or later is required.

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

Unknown 

Adapter {0} cannot be enabled for Accelerated Networking because it is not advertising SR-IOV Support.

To resolve this issue, make sure the computer hardware can support SR-IOV and that you enabled I/O virtualization in the BIOS.

### MissingAcs

Adapter {0} cannot be enabled for Accelerated Networking because it is in a PCIe slot that does not support Access Control Services (ACS).

To resolve this issue, either try moving the device to another PCIe slot or contact your hardware vendor.

### MissingPfDriver

Adapter {0} cannot be enabled for Accelerated Networking because the device driver does not support SR-IOV.

To resolve this issue, update the driver.

### NoBusResources

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
