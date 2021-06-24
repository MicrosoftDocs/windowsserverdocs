---
title: What's new in Windows Server 2022
description: Find out what is new in Windows Server 2022.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 6/23/2021
ms.prod: windows-server
---

# What's new in Windows Server 2022

>Applies to: Windows Server 2022

This article describes some of the new features in Windows Server 2022. Windows Server 2022 is built on the strong foundation of Windows Server 2019 and brings many innovations on three key themes: security, Azure hybrid integration and management, and application platform. Also, Windows Server 2022 Datacenter: Azure Edition helps you use the benefits of cloud to keep your VMs up to date while minimizing downtime.

## Security

The new security capabilities in Windows Server 2022 combine other security capabilities in Windows Server across multiple areas to provide defense-in-depth protection against advanced threats. Advanced multi-layer security in Windows Server 2022 provides the comprehensive protection that servers need today.

### Secured-core server

Secured-core server provides protections that are useful against sophisticated attacks and can provide increased assurance when handling mission critical data in some of the most data sensitive industries.  It is built on three key pillars: simplified security, advanced protection, and preventative defense.

#### Simplified security

When you buy hardware from an OEM for Secured-core server, you have assurance that the OEM has provided a set of hardware, firmware, and drivers that satisfy the Secured-core promise. Windows Server systems will have easy configuration experiences in the Windows Admin Center to enable the security features of Secured-core.

#### Advanced protection

Secured-core servers use hardware, firmware, and operating system capabilities to the fullest extent to provide protection against current and future threats. The protections enabled by a Secured-core server are targeted to create a secure platform for critical applications and data used on that server. The Secured-core functionality spans the following areas:

* **Hardware root-of-trust**

  Trusted Platform Module 2.0 (TPM 2.0) come standard with servers capable of using Secured-core servers. TPM 2.0 provides a secure store for sensitive keys and data, such as measurements of the components loaded during boot. This hardware root-of-trust raises the protection provided by capabilities like BitLocker, which uses TPM 2.0 and facilitates creating attestation-based workflows that can be incorporated into zero-trust security strategies.

* **Firmware protection**

  There is a clear rise in security vulnerabilities being reported in the firmware space given the high privileges that firmware runs with and the relative opacity of what happens in firmware to traditional anti-virus solutions. Recent reports show that malware and ransomware platforms are adding firmware capabilities raising the risk of firmware attacks that have already been seen targeting enterprise resources like Active Directory domain controllers. Using processor support for Dynamic Root of Trust of Measurement (DRTM) technology, along with DMA protection, Secured-core systems isolate the security critical hypervisor from attacks such as this.

* **Virtualization-based security (VBS)**

  Secured-core servers support VBS and hypervisor-based code integrity (HVCI). VBS and HVCI protect against the entire class of vulnerabilities used in cryptocurrency mining attacks given the isolation VBS provides between the privileged parts of the operating system such as the kernel and the rest of the system. VBS also provides more capabilities that customers can enable, such as Credential Guard, which better protects domain credentials.

#### Preventative defense

Enabling Secured-core functionality helps proactively defend against and disrupt many of the paths attackers may use to exploit a system. This set of defenses also enables IT and SecOps teams better utilize their time across the many areas that need their attention.

### Secure connectivity

#### Transport: HTTPS and TLS 1.3 enabled by default on Windows Server 2022

Secure connections are at the heart of today’s interconnected systems. Transport Layer Security (TLS) 1.3 is the latest version of the internet’s most deployed security protocol, which encrypts data to provide a secure communication channel between two endpoints. HTTPS and TLS 1.3 is now enabled by default on Windows Server 2022, protecting the data of clients connecting to the server. It eliminates obsolete cryptographic algorithms, enhances security over older versions, and aims to encrypt as much of the handshake as possible.

#### Secure DNS: Encrypted DNS name resolution requests with DNS-over-HTTPS

Both DNS Server and DNS Client in Windows Server 2022 now support DNS-over-HTTPS (DoH) which encrypts DNS queries using the HTTPS protocol. This helps keep your traffic as private as possible by preventing eavesdropping and your DNS data being manipulated.

#### Server Message Block (SMB): SMB AES-256 encryption for the most security conscious

Windows Server now supports AES-256-GCM and AES-256-CCM cryptographic suites for SMB encryption and signing. Windows will automatically negotiate this more advanced cipher method when connecting to another computer that also supports it, and it can also be mandated through Group Policy. Windows Server still supports AES-128 for down-level compatibility.

#### SMB: East-West SMB encryption controls for internal cluster communications

Windows Server failover clusters now support granular control of encrypting and signing intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). This means that when using Storage Spaces Direct, you can decide to encrypt or sign east-west communications within the cluster itself for higher security.

#### SMB over QUIC

SMB over QUIC updates the SMB 3.1.1 protocol in Windows Server 2022 Datacenter: Azure Edition and supported Windows clients to use the QUIC protocol instead of TCP. By using SMB over QUIC along with TLS 1.3, users and applications can securely and reliably access data from edge file servers running in Azure. Mobile and telecommuter users no longer need a VPN to access their file servers over SMB when on Windows.

## Azure hybrid capabilities

You can increase your efficiency and agility with built-in hybrid capabilities in Windows Server 2022 that allow you to extend your data centers to Azure more easily than ever before.

### Azure Arc enabled Windows Servers

Azure Arc enabled servers with Windows Server 2022 brings on-premises and multi-cloud Windows Servers to Azure with Azure Arc. This management experience is designed to be consistent with how you manage native Azure virtual machines. When a hybrid machine is connected to Azure, it becomes a connected machine and is treated as a resource in Azure. More information can be found at the [Azure Arc enables servers documentation](/azure/azure-arc/servers/overview).

### Windows Admin Center

Improvements to Windows Admin Center to manage Windows Server 2022 include capabilities to both report on the current state of the Secured-core features mentioned above, and where applicable, allow customers to enable the features. More information on these and many more improvements to Windows Admin Center can be found at the [Windows Admin Center documentation](../../manage/windows-admin-center/understand/what-is.md).

### Azure Automanage - Hotpatch

Hotpatch, part of Azure Automanage, is supported in Windows Server 2022 Datacenter: Azure Edition. Hotpatching is a new way to install updates on new Windows Server Azure Edition virtual machines (VMs) that doesn’t require a reboot after installation. More information can be found at the [Azure Automanage documentation](/azure/automanage/automanage-hotpatch).

## Application platform

There are several platform improvements for Windows Containers, including application compatibility and the Windows Container experience with Kubernetes. A major improvement includes reducing the Windows Container image size, which leads to faster download time and better performance. You can now also run applications that depend on Azure Active Directory with group Managed Services Accounts (gMSA) without domain joining the container host, and containers support Microsoft Distributed Transaction Control (MSDTC) and Microsoft Message Queuing (MSMQ). Furthermore, there are several other enhancements that simplify the Windows Container experience with Kubernetes. These enhancements include support for host-process containers for node configuration, IPv6, and consistent network policy implementation with Calico.

In addition to platform improvements, Windows Admin Center has been updated to make it easy to containerize .NET applications. Once the application is in a container, you can host it on Azure Container Registry to then deploy it to other Azure services, including Azure Kubernetes Service.

With support for the Intel Ice Lake processors, Windows Server 2022 supports business-critical and large-scale applications, such as SQL Server, that require up to 48 TB of memory and 2,048 logical cores running on 64 physical sockets. Confidential computing with Intel Secured Guard Extension (SGX) on Intel Ice Lake improves application security by isolating applications from each other with protected memory.

## Other key features

### Nested virtualization for AMD processors

Nested virtualization is a feature that allows you to run Hyper-V inside of a Hyper-V virtual machine (VM). Windows Server 2022 brings support for nested virtualization using AMD processors, giving more choices of hardware for your environments. More information can be found at the [nested virtualization documentation](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization).

### Microsoft Edge browser

Microsoft Edge is included with Windows Server 2022, replacing Internet Explorer. It is built on Chromium open source and backed by Microsoft security and innovation. It can be used with Server Core or Server with Desktop Experience installation options. More information can be found at the [Microsoft Edge Enterprise documentation](/DeployEdge/). Note that Microsoft Edge, unlike the rest of Windows Server, follows the Modern Lifecycle for its support lifecycle. For details, see [Microsoft Edge lifecycle documentation](/lifecycle/products/microsoft-edge).

### Storage

#### Storage Migration Service

Enhancements to Storage Migration Service in Windows Server 2022 makes it easier to migrate storage to Windows Server or to Azure from more source locations. Here are the features that are available when running the Storage Migration Server orchestrator on Windows Server 2022:

* Migrate local users and groups to the new server.
* Migrate storage from failover clusters, migrate to failover clusters, and migrate between standalone servers and failover clusters.
* Migrate storage from a Linux server that uses Samba.
* More easily sync migrated shares into Azure by using Azure File Sync.
* Migrate to new networks such as Azure.
* Migrate NetApp CIFS servers from NetApp FAS arrays to Windows servers and clusters.

#### Adjustable storage repair speed

User adjustable storage repair speed is a new feature in Storage Spaces Direct that offers more control over the data resync process by allocating resources to either repair data copies (resiliency) or run active workloads (performance). This helps improve availability and allows you to service your clusters more flexibly and efficiently. More information can be found [here](/azure-stack/hci/manage/storage-repair-speed).

#### Storage bus cache with Storage Spaces on standalone servers

Storage bus cache is now available for standalone servers. It can significantly improve read and write performance, while maintaining storage efficiency and keeping the operational costs low. Similar to its implementation for Storage Spaces Direct, this feature binds together faster media (for example, NVMe or SSD) with slower media (for example, HDD) to create tiers. A portion of the faster media tier is reserved for the cache.
