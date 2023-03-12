---
title: Performance Tuning Windows Server Containers
description: Performance tuning recommendations for containers on Windows Server 16
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: DavSo; Ericam; YaShi
author: akino
ms.date: 10/16/2017
---

# Performance tuning Windows Server containers

## Introduction
Windows Server 2016 is the first version of Windows to ship support for container technology built in to the OS. In Server 2016, two types of containers are available: Windows Server Containers and Hyper-V Containers. Each container type supports either the Server Core or Nano Server SKU of Windows Server 2016. 

These configurations have different performance implications which we detail below to help you understand which is right for your scenarios. In addition, we detail performance impacting configurations, and describe the tradeoffs with each of those options.

### Windows Server Container and Hyper-V Containers

Windows Server Container and Hyper-V containers offer many of the same portability and consistency benefits but differ in terms of their isolation guarantees and performance characteristsics.

**Windows Server Containers** provide application isolation through process and namespace isolation technology. A Windows Server container shares a kernel with the container host and all containers running on the host.

**Hyper-V Containers** expand on the isolation provided by Windows Server Containers by running each container in a highly optimized virtual machine. In this configuration the kernel of the container host is not shared with the Hyper-V Containers.

The additional isolation provided by Hyper-V containers is achieved in large part by a hypervisor layer of isolation between the container and the container host. This affects container density as, unlike Windows Server Containers, less sharing of system files and binaries can occur, resulting in an overall larger storage and memory footprint. In addition there is the expected additional overhead in some network, storage io, and CPU paths.

### Nano Server and Server Core

Windows Server Containers and Hyper-V containers offer support for Server Core and for a new installation option available in Windows Server 2016 : [Nano Server](https://technet.microsoft.com/windows-server-docs/compute/nano-server/getting-started-with-nano-server). 

Nano Server is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space and starts faster.

## Container Start Up Time
Container start up time is a key metric in many of the scenarios that containers offer the greatest benefit. As such, understanding how to best optimize for container start up time is critical. Below are some tuning trade-offs to understand to achieve improved start up time.

### First Logon

Microsoft ships a base image for both Nano Server and Server Core. The base image which ships for Server Core has been optimized by removing the start-up time overhead associated with first logon (OOBE). This is not the case with Nano Server base image. However, this cost can be removed from Nano Server based images by committing at least one layer to the container image. Subsequent container starts from the image will not incur the first logon cost.
### Scratch Space Location

Containers, by default, use a temporary scratch space on the container host’s system drive media for storage during the lifetime of the running container. This serves as the container’s system drive, and as such many of the writes and reads done in container operation follow this path. For host systems where the system drive exists on spinning disk magnetic media (HDDs) but faster storage media is available (faster HDDs or SSDs), it is possible to move the container scratch space to a different drive. This is achieved by using the dockerd –g command. This command is global, and will affect all containers running on the system.

### Nested Hyper-V Containers
Hyper-V for Windows Server 2016 introduces nested hypervisor support. That is, it is now possible to run a virtual machine from within a virtual machine. This opens up many useful scenarios but also exaggerates some performance impact that the hypervisor incurs, as there are two level of hypervisors running above the physical host.

For containers, this has an impact when running a Hyper-V container inside a virtual machine. Since a Hyper-V Container offers isolation through a hypervisor layer between itself and the container host, when the container host is a Hyper-V based virtual machine, there is performance overhead associated in terms of container start-up time, storage io, network io and throughput, and CPU.

## Storage
### Mounted Data Volumes

Containers offer the ability to use the container host system drive for the container scratch space. However, the container scratch space has a life span equal to that of the container. That is, when the container is stopped, the scratch space and all associated data goes away.

However, there are many scenarios in which having data persist independent of container lifetime is desired. In these cases, we support mounting data volumes from the container host into the container. For Windows Server Containers, there is neglible IO path overhead associated with mounted data volumes (near native performance). However, when mounting data volumes into Hyper-V containers, there is some IO performance degradation in that path. In addition, this impact is exaggerated when running Hyper-V containers inside of virtual machines.

### Scratch Space

Both Windows Server Containers and Hyper-V containers provide a 20GB dynamic VHD for the container scratch space by default. For both container types, the container OS takes up a portion of that space, and this is true for every container started. Thus it is important to remember that every container started has some storage impact, and depending on the workload can write up to 20GB of the backing storage media. Server storage configurations should be designed with this in mind.
(can we configure scratch size)

## Networking
Windows Server Containers and Hyper-V containers offer a variety of networking modes to best suit the needs of differing networking configurations. Each of these options present their own performance characteristics.

### Windows Network Address Translation (WinNAT)

Each container will receive an IP address from an internal, private IP prefix (e.g. 172.16.0.0/12). Port forwarding / mapping from the container host to container endpoints is supported. Docker creates a NAT network by default when the dockerd first runs.

Of these three modes, the NAT configuration is the most expensive network IO path, but has the least amount of configuration needed. 

Windows Server containers use a Host vNIC to attach to the virtual switch. Hyper-V Containers use a Synthetic VM NIC (not exposed to the Utility VM) to attach to the virtual switch. When containers are communicating with the external network, packets are routed through WinNAT with address translations applied, which incurs some overhead.

### Transparent

Each container endpoint is directly connected to the physical network. IP addresses from the physical network can be assigned statically or dynamically using an external DHCP server.

Transparent mode is the least expensive in terms of the network IO path, and external packets are directly passed through to the container virtual NIC giving direct access to the external network.

### L2 Bridge
Each container endpoint will be in the same IP subnet as the container host. The IP addresses must be assigned statically from the same prefix as the container host. All container endpoints on the host will have the same MAC address due to Layer-2 address translation.

L2 Bridge Mode is more performant than WinNAT mode as it provides direct access to the external network, but less performant than Transparent mode as it also introduces MAC address translation.




