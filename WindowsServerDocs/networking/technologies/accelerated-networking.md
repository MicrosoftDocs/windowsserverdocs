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

- Your hardware must support SR-IOV and that you can enable SR-IOV on BIOS. You may need to contact your hardware vendor.

- An SR-IOV supported NIC.

  - You may need to run the [Enable-NetAdapterSriov (NetAdapter)](/powershell/module/netadapter/enable-netadaptersriov?view=windowsserver2022-ps) cmdlet.

- You may also need to expose the Virtual Functions from the BIOS. We recommend exposing the PUT REC function.

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
