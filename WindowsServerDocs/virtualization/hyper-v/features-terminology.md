---
title: Hyper-V Features and Terminology Overview
description: Discover key Hyper-V features and terminology for Windows Server and Windows. Learn about virtual machine generations, processor compatibility, memory management, security features, storage options, networking capabilities, and more.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 08/06/2025
---

# Hyper-V features and terminology

Hyper-V has many features and terms that are specific to virtualization. This article provides an overview of the most common Hyper-V features and terminology, which can help you understand and optimize your virtualization environment and improve performance. The features and terms are grouped into categories for easier reference.

## Virtual machine generations

Hyper-V supports two generations of virtual machines that determine available features and virtual hardware:

- **Generation 1** virtual machines use legacy BIOS firmware and provide compatibility with legacy applications that require older hardware support, including 32-bit systems and legacy hardware emulation such as IDE controllers and virtual floppy disk files.

- **Generation 2** virtual machines use modern UEFI firmware and offer enhanced security features like Secure Boot and vTPM, improved performance, SCSI boot support, and hot add/remove capabilities for network adapters and memory. Generation 2 virtual machines are recommended for most workloads.

You can't change a virtual machine's generation after creation, so choose carefully based on your requirements. For more information, see [Virtual machine generations](plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md).

## Processor/CPU

Hyper-V supports various processor features and capabilities to optimize virtual machine performance and compatibility, which are covered in the following sections.

### Processor compatibility

Processor instruction sets pass through to virtual machines from the Hyper-V host by default. Processor compatibility mode enables virtual machines to run on Hyper-V hosts with different processor generations by masking newer CPU features and instructions, providing a fixed commonality. With Hyper-V hosts running Windows Server, you can use live migration to move virtual machines between hosts with different processor models within the same vendor family. Virtual machines remain portable across your Hyper-V infrastructure even when hardware varies, such as migrating virtual machines to a new cluster or replacing hardware.

Dynamic processor compatibility, introduced in Windows Server 2025, dynamically calculates the common set of processor features across all nodes, enabling virtual machines to take advantage of the maximum capabilities available across the cluster.

For more information, see [Processor compatibility mode](manage/dynamic-processor-compatibility-mode.md).

### Resource control

Resource control in Hyper-V enables you to manage and allocate CPU resources for virtual machines. You can set limits, reserves, and weights for CPU usage, ensuring that critical workloads receive the necessary resources while preventing resource contention among virtual machines.

### NUMA

Non-Uniform Memory Access (NUMA) is a memory architecture that allows multiple processors to access memory in a way that optimizes performance. Hyper-V supports NUMA configurations, enabling virtual machines to take advantage of the underlying hardware's NUMA topology for improved memory access and performance.

NUMA spanning is a feature that allows virtual machines to use memory from multiple NUMA nodes, which can be beneficial for workloads that require large amounts of memory or have high memory bandwidth requirements. This feature is useful in scenarios where virtual machines need to access more memory or virtual processors than available in a single NUMA node. Virtual NUMA presents the host's NUMA topology to the virtual machine operating system.

## Memory

Hyper-V provides several memory management features to optimize resource utilization and performance for virtual machines, which are covered in the following sections.

### Dynamic memory

Hyper-V hosts can dynamically adjust the amount of memory allocated to a virtual machine based on its current workload while it's in operation, based on maximum, minimum, and startup values. Dynamically increasing or decreasing memory allocation as needed helps optimize resource utilization by ensuring that virtual machines have the right amount of memory for their workloads without wasting resources.

The operating system of the virtual machine must support dynamic memory, and it must be enabled in the virtual machine settings. All supported Windows Server and Windows operating systems support dynamic memory, as do many Linux distributions.

### Smart paging file

Smart paging provides temporary memory relief when a virtual machine's memory demand exceeds available physical memory during startup. Hyper-V creates a smart paging file on disk that serves as a temporary memory buffer, enabling the virtual machine to start successfully even under memory-constrained conditions. This feature is useful in environments where virtual machines might temporarily require more memory than initially allocated, helping to prevent startup failures while maintaining system stability.

### Memory weight

Memory weight can prioritize memory allocation for virtual machines based on their importance or workload requirements. By assigning different memory weights to virtual machines, you can control how memory resources are distributed among them, ensuring that critical workloads receive the necessary memory while preventing resource contention.

### Physical Address Extension kernel support

Physical Address Extension (PAE) technology allows a 32-bit Linux kernel to access a physical address space that is larger than 4GB. Older Linux distributions such as RHEL 5.x used to ship a separate kernel that was PAE enabled. Newer distributions include prebuilt PAE support.

## Security

Hyper-V provides several security features to protect virtual machines and their data, which are covered in the following sections. These features help ensure the integrity, confidentiality, and availability of virtualized workloads.

### Secure Boot

Secure Boot helps protect virtual machines from unauthorized code execution during the boot process. It ensures that only trusted and signed boot components are loaded, preventing malware or unauthorized software from compromising the virtual machine's integrity. Secure Boot is available for Generation 2 virtual machines with both Windows and Linux operating systems and is enabled by default.

For more information, see [Secure Boot](generation-2-virtual-machine-security-features.md#secure-boot).

### Encryption support

Encryption for virtual machines helps protect data at rest and in transit. This support includes options for a virtual Trusted Platform Module (TPM), virtual machine saved state, and live migration network traffic.

Virtual TPM is available for Generation 2 virtual machines and enables the virtual machine operating system to use hardware-based security functions similar to those functions available on physical machines. A TPM is useful for scenarios requiring enhanced security, such as running Windows 11 or BitLocker drive encryption, that require a TPM.

Both Generation 1 and Generation 2 virtual machines can encrypt the virtual machine saved state and live migration network traffic with a key protector. For more information, see [Key storage drive](generation-1-virtual-machine-security-features.md#key-storage-drive-in-hyper-v-manager)

### Shielded virtual machines

Shielded virtual machines provides a secure environment for sensitive workloads with an extra layer of security by protecting virtual machines from unauthorized access and tampering, such as from a compromised host. These virtual machines work with guarded fabric so they can run only on healthy and approved hosts in the fabric, and use encryption, secure boot, and a virtual TPM to ensure that only trusted code runs within the virtual machine. Shielding is available for Generation 2 virtual machines.

An example use case for shielded virtual machines and guarded fabric enables cloud service providers to provide a more secure environment for tenant virtual machines.

For more information, see [Guarded fabric and shielded VMs overview](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md).

## Storage

Hyper-V provides various storage features to manage virtual machine disks and optimize storage performance, which are covered in the following sections.

### Storage architectures

Hyper-V supports a wide range of storage architectures to accommodate various storage requirements and performance needs. You can use:

- Storage area networks (SANs) for high-performance storage solutions that provide block-level access to virtual machine files.

- Storage Spaces Direct for building highly available and scalable storage solutions using local disks across multiple servers. Storage Spaces Direct is part of Windows Server and enables you to create a software-defined storage solution that provides redundancy, performance, and scalability, with hyperconverged or disaggregated storage architectures.

- Network-attached storage (NAS) for shared storage across multiple Hyper-V hosts, enabling high availability and failover clustering.

- Local storage, using NVMe, SSD or HDD, for fast access to virtual machine files.

You can use a combination of these storage architectures to meet your specific requirements. For more information, see [Storage architectures for Hyper-V](storage-architecture.md).

### Virtual hard disks

Virtual hard disks (VHDs) are files that represent a virtual machine's hard drive. Hyper-V supports two types of virtual hard disk formats:

- **VHD**: the original format, which supports up to 2TB of storage.

- **VHDX**: the newer format, which supports up to 64TB of storage. VHDX provides several benefits including better performance, enhanced data corruption protection, online resizing, support for larger logical sector sizes (4KB), and automatic data alignment and trimming for better storage utilization.

Virtual hard disks provide a flexible and efficient way to manage virtual machine storage with features such as:

- **Differencing disks**: create a new disk based on an existing parent disk. Changes made to the differencing disk don't affect the parent disk, enabling you to maintain a clean base image while allowing for modifications in the differencing disk. Differencing disks are useful for scenarios such as testing, development, or creating snapshots of virtual machines.

- **Pass-through disks**: physical disks that are directly attached to a virtual machine, bypassing the virtual hard disk layer. The virtual machine can access the physical disk directly, providing better performance for certain workloads that require low-level disk access. Pass-through disks are typically used for high-performance applications or scenarios where direct access to the physical disk is necessary.

- **Shared drives**: multiple virtual machines can access the same virtual hard disk simultaneously for Generation 2 virtual machines. Shared drives are useful for scenarios such as clustering or high availability, where multiple virtual machines need to share data or resources.

- **Storage Quality of Service**: manage and control the performance of virtual machine storage by setting minimum and maximum Input/Output Operations Per Second (IOPS) limits for virtual hard disks. Critical workloads receive the necessary storage performance while preventing resource contention among virtual machines.

### Virtual Fibre Channel

Support for Virtual Fibre Channel adapters enables virtual machines to connect to Fibre Channel storage area networks (SANs) directly, enabling them to access SAN resources as if they were physical servers. This feature is useful for scenarios where high-performance storage access is required, such as in enterprise environments with large databases or mission-critical applications.

Virtual Fibre Channel SAN aggregates multiple physical storage devices into a single logical storage pool. You can add a Virtual Fibre Channel adapter to a virtual machine to connect it to the Virtual Fibre Channel SAN.

## Network

Hyper-V provides various networking features to manage virtual machine connectivity and optimize network performance, which are covered in the following sections. To learn more about Hyper-V networking, see [Plan for Hyper-V networking](plan/plan-hyper-v-networking-in-windows-server.md).

### Virtual switch

A virtual switch is a software-based network switch that allows virtual machines to communicate with each other and with the external network. Hyper-V supports three types of virtual switches:

- **External**: connects virtual machines to the physical network, enabling them to communicate with external devices and services.

- **Internal**: allows communication between virtual machines on the same host and with the host operating system, but not with the external network.

- **Private**: allows communication only between virtual machines on the same host, without any connectivity to the host operating system or external network.

### Virtual network adapter

Virtual network adapters are virtualized network interface cards (NICs) that allow virtual machines to connect to virtual switches and communicate with other virtual machines or external networks. By default, virtual network adapters are high performing and use synthetic drivers, which provide better performance and lower CPU overhead compared to legacy network adapters.

Legacy network adapters are also available that provide compatibility with older operating systems or applications that don't support synthetic adapters.

Virtual network adapters can be configured with various settings, such as:

- **Static or dynamic MAC addresses**: assign a static MAC address to a virtual network adapter or allow Hyper-V to dynamically assign one.

- **MAC address spoofing**: enable virtual machines to change their MAC addresses, which can be useful for scenarios such as network testing or security analysis.

- **VLAN support**: virtual network adapters can be configured to use VLANs (Virtual Local Area Networks) for network segmentation and isolation.

- **Bandwidth management**: set bandwidth limits for virtual network adapters to control network traffic and ensure fair resource allocation among virtual machines.

- **Network virtualization**: create isolated virtual networks that can coexist on the same physical infrastructure. Network virtualization is useful for scenarios such as multitenant environments or testing different network configurations without affecting the physical network.

- **IPsec task offloading**: virtual machines can offload IPsec processing to the host's network adapter, which improves performance and reduces CPU overhead for secure network communication.

- **DHCP guard**: prevent virtual machines from acting as DHCP servers, ensuring that only authorized DHCP servers can provide IP addresses to virtual machines on the network.

- **Router advertisement guard**: prevent virtual machines from sending router advertisements, ensuring that only authorized routers can advertise their presence on the network.

- **Protected network**: create a secure network environment for virtual machines, ensuring that only authorized virtual machines can communicate with each other and with the external network.

- **Port mirroring**: monitor network traffic by mirroring the traffic of a virtual network adapter to another virtual network adapter or a physical network adapter. Port mirroring is useful for scenarios such as network troubleshooting, performance monitoring, or security analysis.

- **NIC teaming**: combine multiple physical network adapters into a single logical adapter for improved performance and redundancy. This feature is useful for scenarios where high network throughput or fault tolerance is required.

- **NIC device naming**: assign custom names to virtual network adapters, making it easier to identify and manage them in the Hyper-V Manager or PowerShell. Only available for Generation 2 virtual machines.

- **NIC teaming in the guest**: configure NIC teaming within the virtual machine itself, enabling the virtual machine to take advantage of multiple network adapters for improved performance and redundancy.

- **Static IP injection for Hyper-V Replica failover**: inject static IP addresses into virtual machines during Hyper-V Replica failover, ensuring that the virtual machines can maintain their network connectivity after failover. It supports both IPv4 and IPv6 addresses.

- **Virtual machine queue (VMQ)**: virtual machines can offload network processing to the host's network adapter, which improves network performance and reduces CPU overhead for network-intensive workloads.

- **Single Root I/O Virtualization (SR-IOV)**: virtual machines can directly access physical network hardware, providing improved performance and reduced latency for network-intensive workloads. SR-IOV is useful for scenarios where low-latency network access is critical, such as in high-frequency trading or real-time data processing applications.

## Controllers and ports

Hyper-V supports various controllers and ports to manage virtual machine hardware and connectivity.

- **SCSI controller**: connect virtual hard disks and DVD drives to a virtual machine as SCSI devices. It provides better performance and flexibility compared to IDE controllers, especially for Generation 2 virtual machines.

- **IDE controller**: connect virtual hard disks and DVD drives to a virtual machine as IDE devices. IDE controllers are only available for Generation 1 virtual machines.

- **COM ports**: connect serial devices or applications through a named pipe on a host or remote computer. COM ports are only available for Generation 1 virtual machines.

- **Fibre Channel adapter**: connect virtual machines to Fibre Channel storage area networks (SANs) for high-performance storage access, such as in enterprise environments with large databases or mission-critical applications.

- **Diskette drives**: connect virtual floppy disk (`.vfd`) files to Generation 1 virtual machines. Virtual floppy disks are used for booting from floppy disk images or for legacy applications that require floppy disk support.

## Integration Services

Integration Services in Hyper-V are a set of services and drivers that enhance the performance and functionality of virtual machines. To learn more about Integration Services, see [Hyper-V Integration Services](/virtualization/hyper-v-on-windows/reference/integration-services).

- **Operating system shutdown**: the host can gracefully shut down a virtual machine when the host itself is shutting down or when the virtual machine is being stopped. The guest operating system can perform a clean shutdown, preventing data loss or corruption.

- **Time synchronization**: synchronize the guest operating system's clock with the host's clock, ensuring accurate timekeeping within the virtual machine. Time synchronization is important for applications that rely on accurate timestamps or time-sensitive operations. Hyper-V benefits from time accuracy improvements, first introduced in Windows Server 2016, which provides more accurate time synchronization between the host and guest operating systems. For more information, see [Time accuracy improvements for Windows Server 2016](../../networking/windows-time-service/windows-server-2016-improvements.md).

- **Data Exchange**: a mechanism for exchanging data between the host and the guest operating system, enabling the host to retrieve information about the virtual machine, such as its name, IP address, and other configuration details.

- **Heartbeat**: a heartbeat mechanism that allows the host to monitor the health and status of the virtual machine. The host can detect if the guest operating system is responsive or unresponsive, enabling proactive management and troubleshooting.

- **Backup (volume shadow copy)**: uses the Volume Shadow Copy Service (VSS) for creating application-consistent backups of virtual machines, ensuring that data is in a consistent state during backup operations.

- **Guest services**: provides an interface for the Hyper-V host to bidirectionally copy files to or from the virtual machine. Guest services isn't enabled by default.

## Checkpoints

Checkpoints enable you to capture the state of a virtual machine at a specific point in time. You can use the checkpoint to roll back to that point, which can be useful for testing, development, or recovery purposes. There are two types of checkpoints:

- **Production checkpoints**: These checkpoints use the Volume Shadow Copy Service (VSS) to create application-consistent snapshots of the virtual machine. They're suitable for production environments and ensure that the virtual machine's data is in a consistent state.

- **Standard checkpoints**: captures the virtual machine's state (running or powered off), including memory, disk, and device states. They're suitable for testing and development scenarios but aren't application consistent.

Optional automatic checkpoints create a checkpoint automatically when a virtual machine is started and merged when the virtual machine is stopped, enabling you to quickly revert to a known good state if you forget to create a checkpoint manually.

To learn more about checkpoints, see [Hyper-V checkpoints](/virtualization/hyper-v-on-windows/user-guide/checkpoints).

## Migration and replication

Migration and replication are essential features to help maintain high availability and flexibility in Hyper-V environments, which are covered in the following sections.

### Live migration

Live migration allows you to move a running virtual machine from one Hyper-V host to another without downtime. Migrating virtual machines is useful for load balancing, hardware maintenance, or disaster recovery scenarios. Live migration can be performed over a network using a dedicated network SMB or TCP/IP, and it can also use RDMA (Remote Direct Memory Access) for faster transfers. Live migration is only available for Hyper-V in Windows Server.

Virtual machines can be migrated between hosts in the same cluster or between standalone hosts. In a cluster, automatic balancing can be configured to automatically migrate virtual machines based on host resource utilization, ensuring optimal performance and resource allocation.

To learn more about live migration, see [Live Migration Overview](manage/live-migration-overview.md).

### Storage migration

Storage migration allows you to move a virtual machine's storage files (such as virtual hard disks) from one location to another without downtime. Migrating storage is useful for scenarios such as moving virtual machines to different storage devices, optimizing storage performance, or reorganizing storage resources. Storage migration is only available for Hyper-V in Windows Server.

### Replication

Hyper-V Replica enables you to replicate virtual machines asynchronously from one Hyper-V host to another to maintain a secondary copy of a virtual machine on a different host for disaster recovery purposes. Hyper-V Replica is only available for Hyper-V in Windows Server.

Replication can be configured to replicate virtual machines between hosts in the same cluster or between standalone hosts. It supports both full and incremental replication, allowing you to choose the level of replication based on your requirements.

Replication can be configured with various options, such as:

- **Replication frequency**: configure the frequency of replication, such as every 30 seconds, 5 minutes, or 15 minutes, to balance performance and data consistency.

- **Authentication**: supports Kerberos and certificate-based authentication for secure replication.

- **Compression**: compress data during transfer to reduce bandwidth usage.

- **Recovery points**: specify how many recovery points to retain for each replicated virtual machine, allowing you to recover to a specific point in time.

- **VSS snapshots**: Hyper-V Replica uses Volume Shadow Copy Service (VSS) to create application-consistent snapshots of virtual machines during replication. VSS ensures that the replicated data is in a consistent state, even for applications running within the virtual machine.

- **Exclusion of disks from replication**: You can exclude specific virtual hard disks from replication, allowing you to control which disks are replicated and which aren't.

To learn more about Hyper-V Replica, see [Set up Hyper-V Replica](manage/set-up-hyper-v-replica.md).

## Graphics

GPUs can be used to enhance the graphics capabilities of virtual machines in Hyper-V environments, enabling scenarios that require high-performance graphics rendering, such as gaming, 3D modeling, or video editing.

Hyper-V supports two options for GPU usage in virtual machines:

- **Discrete Device Assignment**: assign a physical GPU directly to a virtual machine, providing it with exclusive access to the GPU's resources. Discrete Device Assignment is suitable for scenarios where high-performance graphics processing is required, such as running graphics-intensive applications or games within the virtual machine.

- **GPU partitioning**: allocate a portion of a physical GPU's resources to multiple virtual machines, enabling them to share the GPU for graphics processing. GPU partitioning is useful for scenarios where multiple virtual machines need access to graphics capabilities without requiring dedicated GPUs for each one.

To learn more about GPU acceleration in Hyper-V, see [Plan for GPU acceleration](plan/plan-for-gpu-acceleration-in-windows-server.md).

## Nested virtualization

Nested virtualization enables you to run Hyper-V within a virtual machine to run more virtual machines, enabling scenarios such as testing, development, or training without requiring physical hardware. This feature is useful for scenarios where you want to create and manage virtual machines within a virtualized environment, such as running Hyper-V on a laptop or desktop computer.

Nested virtualization is available for Generation 2 virtual machines. To learn more about nested virtualization, see [What is Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization).

## Management

To manage Hyper-V environments and virtual machines, you can use various tools and interfaces:

- **Hyper-V Manager**: a built-in graphical user interface (GUI) tool for managing Hyper-V hosts and virtual machines. It provides an easy way to create, configure, and maintain virtual machines. To learn more about Hyper-V Manager, see [Remotely manage Hyper-V hosts with Hyper-V Manager](manage/Remotely-manage-Hyper-V-hosts.md).

- **Windows Admin Center**: a web-based management tool that provides a centralized interface for managing Hyper-V hosts and virtual machines, along with other Windows Server features. To learn more about using Windows Admin Center for Hyper-V management, see [Manage virtual machines by using Windows Admin Center](../../manage/windows-admin-center/use/manage-virtual-machines.md).

- **PowerShell**: a powerful command-line interface that allows you to automate and script Hyper-V management tasks. PowerShell provides a rich set of cmdlets for managing virtual machines, hosts, and other Hyper-V features. To learn more about using PowerShell for Hyper-V management, see [Working with Hyper-V and Windows PowerShell](/virtualization/hyper-v-on-windows/quick-start/try-hyper-v-powershell).

- **System Center Virtual Machine Manager**: a comprehensive management solution for large-scale Hyper-V environments. Virtual Machine Manager provides advanced features for managing virtual machines, hosts, storage, and networking, along with support for multi-hypervisor environments. To learn more about Virtual Machine Manager, see [What is Virtual Machine Manager](/system-center/vmm/overview).

### Console access

Console access provides a way to interact with virtual machines through a graphical user interface (GUI) or command-line interface (CLI). Hyper-V supports several methods for console access:

- **Virtual Machine Connection**: a built-in tool in Hyper-V Manager that provides console access for connecting to and managing virtual machines. It enables you to interact with the virtual machine's desktop, perform administrative tasks, and troubleshoot issues. It's also referred to as **VMConnect**. To learn more about Virtual Machine Connection, see [Hyper-V Virtual Machine Connection](virtual-machine-connection.md).

- **Enhanced session mode**: part of Virtual Machine Connection, connect to a virtual machine using Remote Desktop Protocol (RDP) over a direct connection through the Hyper-V host. As it uses RDP, it also supports *RemoteFX* that provides extra capabilities, such as clipboard sharing, drive redirection, and printer redirection. Enhanced session mode is available for Generation 2 virtual machines and requires support from the virtual machine operating system. To learn more about enhanced session mode, see [Use local resources on Hyper-V virtual machine with VMConnect](use-local-resources-virtual-machine-connection.md).

- **PowerShell Direct**: run PowerShell commands directly on a virtual machine from the Hyper-V host without requiring network connectivity. It provides a secure way to manage virtual machines without exposing them to the network. To learn more about PowerShell Direct, see [Manage Windows virtual machines with PowerShell Direct](manage/manage-windows-virtual-machines-with-powershell-direct.md).

### Power management

Hyper-V enables you to control how your virtual machines start and stop on a host:

- **Automatic start action**: specifies what action to take when the Hyper-V service starts and the virtual machine was running when the service stopped. Options include **Nothing**, **Automatically start if it was running when the service stopped**, **Always start this virtual machine automatically**, and **Automatic start delay (in seconds)**.

- **Automatic stop action**: specifies what action to take when the Hyper-V service stops. Options include **Save the virtual machine state**, **Turn off the virtual machine**, and **Shut down the guest operating system**.

## Related content

Here are some other resources to help you learn more about Hyper-V and its capabilities:

- [Hardware requirements for Hyper-V](host-hardware-requirements.md).
- [Plan for Hyper-V networking](plan/plan-hyper-v-networking-in-windows-server.md).
- [Storage architectures for Hyper-V](storage-architecture.md).
- [Virtual machine generations](plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md).
- [Supported Windows virtual machine operating systems](supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).
- [Supported Linux and FreeBSD virtual machine operating systems](supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md).
