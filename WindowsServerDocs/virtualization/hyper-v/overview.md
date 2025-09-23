---
title: Hyper-V virtualization in Windows Server and Windows
description: Learn about Hyper-V virtualization technology to run virtual machines, its key features, benefits, and how to get started in Windows Server and Windows. Discover common uses and scenarios.
ms.topic: overview
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/28/2025
#customer-intent: As an IT professional, I want to understand Hyper-V's capabilities and how it can benefit my organization, so I can make informed decisions about virtualization solutions.
---

# Hyper-V virtualization in Windows Server and Windows

Hyper-V is Microsoft's enterprise-grade hypervisor technology built into Windows Server and Windows. It provides hardware virtualization capabilities that enable organizations to create, manage, and run virtual machines at scale. As a type-1 hypervisor, Hyper-V runs directly on computing hardware, delivering near-native performance and robust isolation for virtualized workloads.

Virtualizing your workloads with Hyper-V enables you to maximize hardware utilization, streamline IT operations, and enhance business continuity. It supports a wide range of operating systems for guest virtual machines, including many versions of Windows, Linux, and FreeBSD, making it a versatile solution for diverse IT environments.

Whether you're consolidating servers, spanning on-premises and hyperscale cloud providers, or enabling flexible development and testing environments, Hyper-V offers scalable solutions for modern IT needs.

Hyper-V in Windows Server and Windows has different capabilities and features, but both provide a solid foundation for virtualization. Hyper-V in Windows Server is designed for enterprise deployments with advanced features like live migration, high availability, and disaster recovery. Hyper-V in Windows provides IT professionals and developers a lightweight solution suitable for development and testing scenarios.

This overview explains Hyper-V's benefits, key features, and common use cases, and provides guidance on getting started.

## Benefits of Hyper-V

Hyper-V delivers significant organizational benefits across many areas, including:

- **Cost optimization**: reduce hardware acquisition and maintenance costs through server consolidation, while lowering datacenter space, power, and cooling requirements. Organizations can achieve high consolidation ratios, dramatically reducing total cost of ownership. Hyper-V is included with Windows Server and Windows, eliminating additional hypervisor licensing costs.

- **Operational efficiency**: streamline IT operations with centralized management, automated provisioning, and simplified backup and disaster recovery processes. Virtual machine templates and PowerShell automation reduce deployment time from hours to minutes.

- **Business agility**: rapidly provision new environments to support business initiatives, scale resources up or down based on demand, and quickly adapt to changing market conditions without lengthy hardware procurement cycles.

- **Enhanced security**: implement strong workload isolation, use shielded virtual machines for sensitive data, and maintain secure environments with features like Secure Boot and TPM 2.0 support.

- **Improved resilience**: minimize downtime through high availability features, implement comprehensive disaster recovery strategies with Hyper-V Replica, and ensure business continuity with live migration capabilities.

- **Development acceleration**: enable rapid creation of development and testing environments, support DevOps practices with consistent infrastructure, and reduce time-to-market for new applications and services.

- **Simplified compliance**: meet regulatory requirements more easily through consistent configurations, centralized monitoring, and comprehensive audit trails across virtualized environments.

## Technical capabilities of Hyper-V

Here's a video that provides a comprehensive technical overview of Hyper-V, covering its hypervisor architecture, performance characteristics, and scalability features. It demonstrates how Hyper-V delivers enterprise-grade virtualization capabilities, discusses high availability and clustering features, and showcases real-world deployment scenarios for organizations looking to implement virtualization solutions.<br /><br />

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=580e0b14-6d99-4fcf-9c6a-549da414c67c]

The following sections provide an overview into some of the key enterprise-grade features available in Hyper-V that address critical business requirements around security, availability, management, and cost optimization.

### Extensibility and integration

An important aspect of Hyper-V is its extensibility and integration with other Windows Server features and other Microsoft and third-party products and services to create a comprehensive virtualization solution ready for enterprise deployments.

For example, Hyper-V works seamlessly with Windows Server Failover Clustering to provide high availability, connects to a range of storage providers for flexible storage options, supports Azure integration for hybrid cloud scenarios, and integrates with Windows Admin Center or System Center Virtual Machine Manager for advanced management.

Hyper-V also is a key component of [Azure Local](https://azure.microsoft.com/products/local), enabling organizations to run Azure services on-premises with consistent management and development experiences. This integration allows for hybrid cloud scenarios where workloads can be seamlessly moved between on-premises environments and Azure, providing flexibility and scalability.

### Security and isolation

Robust security features help protect virtual machines and their data, ensuring that workloads run in isolated environments:

- **Shielded Virtual Machines** provide comprehensive protection for sensitive workloads through BitLocker encryption, Secure Boot verification, and TPM 2.0 attestation. Host Guardian Service (HGS) ensures only authorized hosts can run shielded VMs, protecting against compromised administrators and malicious insiders.

- **Generation 2 virtual machines** deliver enhanced security with UEFI firmware, Secure Boot capabilities, and improved malware resistance. Virtual TPM 2.0 support enables BitLocker encryption within guest operating systems and supports Windows Hello for Business authentication.

- **Network isolation** through Virtual LANs (VLANs), private virtual switches, and software-defined networking (SDN) creates secure network segments that prevent unauthorized lateral movement between workloads.

### Storage flexibility

Flexible storage options meet diverse organizational requirements, from local disks to cost-effective hyperconverged solutions to existing SAN deployments:

- **Storage Spaces Direct** creates hyperconverged infrastructure by pooling local storage across cluster nodes into a single, highly available storage namespace. This software-defined storage solution eliminates traditional SAN requirements while delivering enterprise-class features including fault tolerance, automatic repair, and performance optimization. Organizations achieve lower storage costs compared to traditional SAN solutions while gaining simplified management and improved performance through NVMe and persistent memory support.

- **Storage Spaces** enables disaggregated storage architectures by pooling Just a Bunch of Disks (JBOD) enclosures into resilient storage pools with configurable redundancy levels. This approach provides flexibility to scale storage independently from compute resources while maintaining high availability through mirror, parity, or dual-parity configurations.

- **Local storage** options support various deployment scenarios from development environments using single drives to production workloads with NVMe arrays. Direct-attached storage provides optimal performance for I/O-intensive applications while reducing complexity for smaller deployments or edge computing scenarios.

- **SAN connectivity** supports both iSCSI and Fibre Channel protocols for integration with existing enterprise storage infrastructure. Multipath I/O (MPIO) ensures high availability and load balancing across multiple storage paths, while support for SMB 3.0 and NFS enables file-based storage scenarios with features like transparent failover and scale-out file server clustering.

### High availability and business continuity

Comprehensive high availability and business continuity features help ensure mission-critical workloads remain operational:

- **Failover Clustering** with Cluster Shared Volumes (CSV) enables automatic failover of virtual machines between cluster nodes, providing valuable uptime for mission-critical applications. Live migration enables planned maintenance without service interruption. CSV Cache improves performance by caching frequently accessed data in memory, while CSV Block Cache uses system memory on storage-rich nodes to accelerate read operations.

- **Hyper-V Replica** delivers cost-effective disaster recovery by asynchronously replicating virtual machines to secondary sites over standard network connections, eliminating expensive SAN replication requirements. Recovery Point Objectives (RPO) can be as low as 30 seconds to ensure minimal data loss.

- **Shared nothing live migration** enables virtual machines to be moved between hosts without shared storage, enabling flexible resource allocation and load balancing across the cluster. This feature supports scenarios where hosts have different storage configurations or when migrating workloads between geographically distributed sites.

- **Storage Migration** enables moving virtual machine storage between different storage arrays without downtime, facilitating storage upgrades and load balancing across the infrastructure.

- **Azure Site Recovery** extends Hyper-V disaster recovery capabilities to the cloud, providing automated replication, failover, and failback for virtual machines. This integration enables organizations to use Azure as a secondary site for disaster recovery without complex configuration or extra hardware.

### Performance and scalability

High performance and scalability help meet demanding enterprise workloads:

- **Dynamic Memory** automatically adjusts memory allocation based on actual workload demands, maximizing host utilization while maintaining performance. Smart paging and memory overcommit ratios enable higher consolidation ratios.

- **SR-IOV and RDMA support** delivers near-native network performance by bypassing the hypervisor for high-bandwidth, low-latency networking scenarios.

- **GPU-Partitioning** (GPU-P) enables multiple virtual machines to share GPU resources for AI and graphics workloads.

- **Persistent Memory** integration provides ultra-low latency storage access for databases and in-memory computing scenarios.

### Advanced management capabilities

A range of management tools and automation capabilities simplify operations and enhance productivity:

- **Windows Admin Center** provides modern web-based management with hyperconverged infrastructure monitoring, performance analytics, and streamlined troubleshooting workflows accessible from any device.

- **Hyper-V Manager** provides intuitive graphical management for day-to-day operations, while the Hyper-V module for Windows PowerShell enables advanced scripting and automation scenarios.

- **System Center Virtual Machine Manager** delivers enterprise-scale management with automated provisioning, compliance monitoring, capacity planning, and self-service portals for delegated administration.

- **PowerShell Direct** enables secure management of virtual machines without network connectivity, simplifying automation and troubleshooting. Extensive PowerShell cmdlet library supports Infrastructure as Code practices.

- **Seamless Active Directory integration** as Hyper-V uses existing Windows authentication infrastructure without extra configuration. Domain-joined hosts inherit existing Group Policy settings and security configurations automatically.

### Cost optimization features

Optimize costs associated with virtualization:

- **Existing Windows Server licensing** enables you to run virtual machine without extra hypervisor licensing costs. Hyper-V is included with Windows Server and Windows, with the Datacenter edition of Windows Server providing unlimited virtual machine rights, meaning you can run Windows Server virtual machines at no extra cost. This approach simplifies licensing calculations and reduces overall costs.

- **Deduplication and compression** greatly reduce storage requirements in scenarios such as virtual desktop infrastructure (VDI) and data backup.

- **Nested virtualization** enables running hypervisors within virtual machines, supporting development scenarios and multitenant cloud environments without extra hardware.

## Benefits for developers and IT professionals

Hyper-V in both Windows Server and Windows provides developers and IT professionals with powerful virtualization capabilities that accelerate development workflows and streamline IT operations for Windows and Linux environments. Developers can rapidly create isolated development and testing environments that mirror production configurations, enabling them to test applications across multiple operating systems and versions without requiring dedicated hardware. IT professionals benefit from the ability to quickly provision sandbox environments for testing patches, updates, and new configurations before deploying to production systems.

The ability to snapshot virtual machines before making changes provides a safety net for experimentation and rollback scenarios, while virtual machine templates and PowerShell automation enable consistent environment provisioning in minutes rather than hours. This capability is valuable for both development teams creating standardized build environments and IT teams maintaining consistent infrastructure configurations.

For Windows 11 users, Hyper-V offers Quick Create for streamlined virtual machine setup, making it easy to spin up development environments for different projects or create isolated testing environments for IT evaluation scenarios. The integration with Visual Studio and development tools, combined with features like nested virtualization, enables developers to create complex multi-tier applications and test containerized workloads locally, while IT professionals can evaluate new technologies and solutions in isolated environments.

## Get started with Hyper-V

Hyper-V is readily available as a server role across all editions of Windows Server 2025, with multiple installation options to meet different organizational needs. Organizations can choose between Server with Desktop Experience for full GUI management or Server Core for reduced attack surface and resource usage.

For Windows 11, Hyper-V is included in the Pro, Enterprise, and Education editions, enabling developers and IT professionals to use virtualization capabilities directly on their desktops.

> [!div class="nextstepaction"]
> [Install Hyper-V](get-started/install-hyper-v.md)

## Related content

Here are some additional resources to help you learn more about Hyper-V and its capabilities:

- [Hardware requirements for Hyper-V](host-hardware-requirements.md).
- [Plan for Hyper-V networking](plan/plan-hyper-v-networking-in-windows-server.md).
- [Storage architectures for Hyper-V](storage-architecture.md).
- [Virtual machine generations](plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md).
- [Supported Windows virtual machine operating systems](supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).
- [Supported Linux and FreeBSD virtual machine operating systems](supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md).
