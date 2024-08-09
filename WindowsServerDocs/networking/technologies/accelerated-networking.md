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

      - [Enable-NetAdapterSriov (NetAdapter)](/powershell/module/netadapter/enable-netadaptersriov?view=windowsserver2022-ps)

- You may also need to expose the Virtual Functions from the BIOS. We recommend exposing the PUT REC function.

## Common error messages

