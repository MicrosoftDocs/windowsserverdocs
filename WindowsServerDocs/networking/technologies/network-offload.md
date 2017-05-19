---
title: Network Offload and Optimization Technologies
description: This topic provides an overview of the Offload and Optimization Technologies in Windows Server 2016, and includes links to additional guidance about these technologies.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
ms.author: jamesmci 
author: jamesmci
---

# Network Offload and Optimization Technologies

>Applies To: Windows Server 2016

You can use this topic for a brief overview of Network Offload and Optimization technologies that are available in Windows Server 2016.

>[!NOTE]
>In addition to this topic, the following Network Offload and Optimization Technologies documentation is available.
>
> - [Converged Network Interface Card (NIC) Configuration Guide](conv-nic/cnic-top.md)
> - [Data Center Bridging (DCB)](dcb/dcb-top.md)
> - [Virtual Receive Side Scaling (vRSS)](vrss/vrss-top.md)

The guide [Network Offload and Optimization Technologies in Windows Server 2016](https://aka.ms/j2e2b6) is now available for download in Word format from TechNet Gallery and provides additional detail on each technology and feature mentioned in this topic, and discusses how these features help make networking more efficient.

These technologies include Software Only (SO) features and technologies, Software and Hardware (SH) integrated features and technologies, and Hardware Only (HO) features and technologies.

>[!IMPORTANT]
>SO features and technologies are available in all hardware architectures, regardless of NIC speed or NIC capabilities, while SH and HO features are available only when the features or technologies are supported by your network adapter.

Following are details on the SO, SH, and HO features and technologies that are available in Windows Server 2016.

## Software Only (SO) features and technologies

The following SO features and technologies are available in Windows Server 2016 and are documented in the **Network Offload and Optimization Technologies** guide.

- **Access Control Lists \(ACLs\)**. Access Control Lists are a Hyper-V and Software Defined Networking \(SDN\) version 1 \(v1\) feature for managing security for a VM.
- **Extended ACLs**. Hyper-V Virtual Switch extended ACLs enable you to configure the Hyper-V Virtual Switch Extended Port Access Control Lists to provide firewall protection and enforce security policies for the tenant Virtual Machines \(VMs\) in datacenters. For information about Extended Port Access Control Lists in this library, see [Create Security Policies with Extended Port Access Control Lists](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/Create-Security-Policies-with-Extended-Port-Access-Control-Lists).
- **NIC Teaming**. NIC Teaming is the aggregation of multiple NIC ports into an entity the host perceives as a single NIC port. This provides protection against the failure of a single NIC port \(or the cable that is connected to it\). It also aggregates network traffic for faster throughput. For information about NIC Teaming in this library, see [NIC Teaming](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming).
- **Software Defined Networking \(SDN\) ACLs**. The SDN-extension in Windows Server 2016 has a new, improved way to support ACLs. In the Windows Server 2016 SDN v2 stack, SDN ACLs are used instead of ACLs and Extended ACLs. You can use Network Controller to manage SDN ACLs.
- **SDN Quality of Service \(QoS\)**. The SDN extension in Windows Server 2016 has a new, improved way to provide bandwidth control \(egress reservations, egress limits, and ingress limits\) on a 5-tuple basis. Typically, these policies are applied at the vNIC or vmNIC level, but they can be made much more specific. In the Windows Server 2016 SDN v2 stack, SDN QoS is used instead of vmQoS. You can use Network Controller to manage SDN QoS.
- **Switch Embedded Teaming \(SET\)**. SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch. For information about Switch Embedded Teaming in this library, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming).
- **Virtual Receive Side Scaling \(vRSS\)**. Software vRSS is used to spread incoming traffic destined for a VM across multiple logical processors \(LPs\) of the VM.  This enables the VM to handle more networking traffic than a single LP would be able to handle. For more information, see [Virtual Receive Side Scaling (vRSS)](vrss/vrss-top.md).
- **Virtual Machine Quality of Service \(vmQoS\)**. Virtual Machine Quality of Service is a Hyper-V feature that allows the switch to set limits on traffic generated by each VM. It also enables a VM to reserve an amount of bandwidth on the external network connection so that one VM can’t starve another VM for bandwidth. In the Windows Server 2016 SDN v2 stack, vmQoS is replaced by SDN QoS. 


## Software and Hardware (SH) integrated features and technologies

The following SH features and technologies are available in Windows Server 2016 and are documented in the **Network Offload and Optimization Technologies** guide.

- **Converged NIC**. Converged NIC is a technology that allows virtual NICs in the Hyper-V host to expose RDMA services to host processes. In Windows Server 2016, separate NICs are no longer required for RDMA. The Converged NIC feature allows the Virtual NICs in the Host partition (vNICs) to expose RDMA to the host partition and share the bandwidth of the NICs between the RDMA traffic and the VM and other TCP/UDP traffic in a fair and manageable manner.

- **Data Center Bridging \(DCB\)**. DCB is a suite of Institute of Electrical and Electronics Engineers \(IEEE\) standards that enable Converged Fabrics in the data center, where storage, data networking, cluster Inter\-Process Communication \(IPC\), and management traffic all share the same Ethernet network infrastructure. For more information, see [Data Center Bridging (DCB)](dcb/dcb-top.md).

- **Hyper-V Network Virtualization - v1 \(HNVv1\)**. Introduced in Windows Server 2012, Hyper-V Network Virtualization (HNV) enables virtualization of customer networks on top of a shared physical network infrastructure. With minimal changes necessary on the physical network fabric, HNV gives service providers the agility to deploy and migrate tenant workloads anywhere across the three clouds: the service provider cloud, the private cloud, or the Microsoft Azure public cloud.

- **Hyper-V Network Virtualization - v2 NVGRE \(HNVv2 NVGRE\)**. In Windows Server 2016 and System Center Virtual Machine Manager, Microsoft provides an end-to-end network virtualization solution that includes RAS Gateway, Software Load Balancing, Network Controller, and more. For more information, see [Hyper-V Network Virtualization Overview in Windows Server 2016](https://technet.microsoft.com/windows-server-docs/networking/sdn/technologies/hyper-v-network-virtualization/hyperv-network-virtualization-overview-windows-server).

- **Hyper-V Network Virtualization - v2 VxLAN \(HNVv2 VxLAN\)**. See previous information.

- **IPsec Task Offload \(IPsecTO\)**. IPsec task offload is a NIC feature that enables the operating system to use the processor on the NIC for the IPsec encryption work.

>[!IMPORTANT]
>IPsec Task Offload is a deprecated technology. It is recommended that you do not use IPsec Task Offload because it might not be supported by Microsoft in the future.

- **Private virtual Local Area Network \(PVLAN\)**. PVLANs allow communication only between virtual machines on the same virtualization server. A private virtual network is not bound to a physical network adapter. A private virtual network is isolated from all external network traffic on the virtualization server, as well any network traffic between the management operating system and the external network. This type of network is useful when you need to create an isolated networking environment, such as an isolated test domain. The Hyper-V and SDN stacks support PVLAN Isolated Port mode only.

- **Remote Direct Memory Access \(RDMA\)**. RDMA is a networking technology that provides high-throughput, low-latency communication that minimizes CPU usage. For information about RDMA in this library, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming).

- **Receive Side Scaling \(RSS\)**. Receive Side Scaling is a NIC feature that segregates different sets of streams and delivers them to different processors for processing. This parallelizes the networking processing, enabling a host to scale to very high data rates. For more information, see [Receive Side Scaling (RSS)](https://technet.microsoft.com/library/hh997036.aspx).

- **Single Root Input\-Output Virtualization \(SR-IOV\)**. SR\-IOV allows VM traffic to move directly from the NIC to the VM without passing through the Hyper-V host. SR-IOV is an incredible improvement in performance for a VM.  It suffers, however, from a lack of ability for the host to manage that pipe.  SR-IOV must only be used when the workload is well-behaved, trusted, and generally the only VM in the host.

- **TCP Chimney Offload**. TCP Chimney Offload, also known as TCP Engine Offload (TOE), is a technology that allows the host to offload all TCP processing to the NIC. Because the Windows Server TCP stack is almost always more efficient than the TOE engine, using TCP Chimney Offload is not recommended.

>[!IMPORTANT]
>TCP Chimney Offload is a deprecated technology. It is recommended that you do not use TCP Chimney Offload because it might not be supported by Microsoft in the future.

- **Virtual Local Area Network \(VLAN\)**. VLAN is an extension to the Ethernet frame header to enable partitioning of a Local Area Network into multiple VLANs, each using its own address space.  For more information, see [NIC Teaming and Virtual Local Area Networks (VLANs)](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nict-and-vlans).

- **Virtual Machine Queue \(VMQ\)**. Virtual Machine Queue is a NIC feature that allocates a queue for each VM. The NIC divides the incoming traffic into the appropriate queues.  Interrupts for each queue are mapped to different processors. For more information, see [Virtual Receive Side Scaling (vRSS)](vrss/vrss-top.md) and the section "NIC Teaming and Virtual Machine Queues (VMQs)" in the topic [NIC Teaming](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming).

- **Virtual Machine Multi\-Queue \(VMMQ\)**. Virtual Machine Multi-Queue is a NIC feature that allows traffic for a VM to be spread across multiple queues, each processed by a different physical processor. The traffic is then passed to multiple LPs in the VM as it would be in vRSS.  This allows for very large networking bandwidth to be delivered to the VM.

## Hardware Only (HO) features and technologies

The following HO features and technologies are available in Windows Server 2016 and are documented in the **Network Offload and Optimization Technologies** guide.

- **Address Checksum Offload**. Address checksum offloads are a NIC feature that offloads the calculation of address checksums (IP, TCP, UDP) to the NIC hardware for both send and receive.

- **Tips on using Address Checksum Offloads**. Address Checksum Offloads should ALWAYS be enabled no matter what workload or circumstance.  This most basic of all offload technologies will always improve your network performance. Checksum offloading is also required for other stateless offloads to work including receive side scaling (RSS), receive segment coalescing (RSC), and large send offload (LSO).

- **Interrupt Moderation (IM)**. IM buffers multiple received packets before interrupting the operating system. When a NIC receives a packet it starts a timer.  When the buffer is full or the timer expires, whichever comes first, the NIC interrupts the operating system.

- **Jumbo Frames**. Jumbo frames is a NIC and network feature that allow an application to send frames that are much larger than the default 1500 bytes.

- **Large Send Offload (LSO)**. LSO allows an application to pass a large block of data to the NIC, and the NIC breaks the data into packets that fit within the Maximum Transfer Unit (MTU) of the network.

- **Receive Segment Coalescing \(RSC\)**. Receive Segment Coalescing, also known as Large Receive Offload, is a NIC feature that takes packets that are part of the same stream that arrive between network interrupts and coalesces them into a single packet before delivering them to the operating system. RSC is not available on NICs that are bound to the Hyper-V Virtual Switch. For more information, see [Receive Segment Coalescing (RSC)](https://technet.microsoft.com/library/hh997024.aspx).

For more information, you can download the guide [Network Offload and Optimization Technologies in Windows Server 2016](https://aka.ms/j2e2b6) from TechNet Gallery.