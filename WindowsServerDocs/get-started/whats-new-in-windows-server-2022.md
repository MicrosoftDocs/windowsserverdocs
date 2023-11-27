---
title: What's new in Windows Server 2022
description: Find out what is new in Windows Server 2022.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 10/19/2023
ms.prod: windows-server
---

# What's new in Windows Server 2022

>Applies to: Windows Server 2022

This article describes some of the new features in Windows Server 2022. Windows Server 2022 is built
on the strong foundation of Windows Server 2019 and brings many innovations on three key themes:
security, Azure hybrid integration and management, and application platform.

## Azure Edition

Windows Server 2022 Datacenter: Azure Edition helps you use the benefits of cloud to keep your VMs
up to date while minimizing downtime. This section describes some of the new features in Windows
Server 2022 Datacenter: Azure Edition. Learn more about how Azure Automanage for Windows Server
brings these new capabilities to Windows Server Azure Edition in the [Azure Automanage for
Windows Server services](/azure/automanage/automanage-windows-server-services-overview) article.

Windows Server 2022 Datacenter: Azure Edition builds on Datacenter Edition to deliver a VM-only
operating system that helps to use the benefits of cloud, with advanced features like SMB over QUIC,
Hotpatch, and Azure Extended Networking. This section describes some of these new features.

Compare the
[differences in the editions in Windows Server 2022](../get-started/editions-comparison-windows-server-2022.md).
You can also learn more about how Azure Automanage for Windows Server brings these new capabilities
to Windows Server Azure Edition in the
[Azure Automanage for Windows Server services](/azure/automanage/automanage-windows-server-services-overview)
article.

### April 2023

#### Hotpatching

Windows Server 2022 Datacenter: Azure Edition Hotpatching is now public preview for the Desktop
Experience both in Azure and as a supported guest VM on Azure Stack HCI version 22H2.

### September 2022

This section lists the features and improvements that are now available in Windows Server
Datacenter: Azure Edition beginning with the 2022-09 Cumulative Update for Microsoft
server operating system version 21H2 for x64-based Systems
([KB5017381](https://support.microsoft.com/help/5017381)). After you've install the Cumulative
Update, the OS build number will be 20348.1070 or higher.

#### Storage Replica compression for data transfer

This update includes Storage Replica compression for data transferred between the source
and destination servers. This new functionality compresses the replication data at the source
system, sent over the network and decompressed and saved on the destination. The compression results
in fewer network packets to transfer the same amount of data, allowing for more throughput, and less
network utilization. Higher data throughput should also result in lowering synchronization time for
when you need it most, for example in a disaster recovery scenario.

New Storage Replica PowerShell parameters are available for existing commands, review the [Windows
PowerShell StorageReplica reference](/powershell/module/storagereplica/) to learn more. For more
information about Storage Replica, see the
[Storage Replica overview](../storage/storage-replica/storage-replica-overview.md).

#### Support for Azure Stack HCI

With this release you can run Windows Server 2022 Datacenter: Azure Edition as a supported guest VM
on Azure Stack HCI version 22H2. With Azure Edition running on Azure Stack HCI, you'll be able to use
all the existing features including [Hotpatch](#azure-automanage---hotpatch) for Server Core and
[SMB over QUIC](#smb-over-quic) at your datacenter and edge locations.

Begin deploying Windows Server 2022 Datacenter: Azure Edition using the
[Azure Marketplace on Arc-enabled Azure Stack HCI](#deploy-from-azure-marketplace-on-arc-enabled-azure-stack-hci-preview)
or using an ISO. You can download the ISO from here:

- [Windows Server 2022 Datacenter: Azure Edition (EN-US) ISO](https://aka.ms/AAi4r31)
- [Windows Server 2022 Datacenter: Azure Edition (ZH-CN) ISO](https://aka.ms/AAi4bii)

Your Azure subscription permits you to use Windows Server Datacenter: Azure Edition on any virtual
machine instances running on Azure Stack HCI. For more information, see your product terms
[Product Terms](https://www.microsoft.com/licensing/terms/productoffering/WindowsServerStandardDatacenterEssentials/EAEAS).

Learn more about the latest Azure Stack HCI features in our
[What's new in Azure Stack HCI, version 22H2](/azure-stack/hci/whats-new) article.

#### Deploy from Azure Marketplace on Arc-enabled Azure Stack HCI (preview)

Windows Server 2022 Datacenter: Azure Edition images will be available in the Azure Marketplace for
Arc-enabled Azure Stack HCI, making it easy to try, buy, and deploy using Azure certified images.

Learn more about the Azure Marketplace integration for Azure Arc-enabled Azure Stack HCI features in
our
[What's new in Azure Stack HCI, version 22H2](/azure-stack/hci/whats-new#azure-arc-vm-changes-and-azure-marketplace)
article.

### Azure Edition (initial release)

This section lists the features and improvements available in Windows Server Datacenter: Azure
Edition with the release in September 2021.

#### Azure Automanage - Hotpatch

Hotpatching, part of Azure Automanage, is a new way to install updates on new Windows Server Azure
Edition virtual machines (VMs) that doesn't require a reboot after installation. More information
can be found at the [Azure Automanage documentation](/azure/automanage/automanage-hotpatch).

#### SMB over QUIC

SMB over QUIC updates the SMB 3.1.1 protocol to use the QUIC protocol instead of TCP in Windows
Server 2022 Datacenter: Azure Edition, Windows 11 and later, and third party clients if they support
it. By using SMB over QUIC along with TLS 1.3, users and applications can securely and reliably
access data from edge file servers running in Azure. Mobile and telecommuter users no longer need a
VPN to access their file servers over SMB when on Windows. More information can be found at the
[SMB over QUIC documentation](../storage/file-server/smb-over-quic.md) and
[SMB over QUIC management with Automanage machine best practices](/azure/automanage/automanage-smb-over-quic).

To learn more about QUIC, review [RFC 9000](https://datatracker.ietf.org/doc/rfc9000/).

#### Extended network for Azure

Azure Extended Network enables you to stretch an on-premises subnet into Azure to let on-premises
virtual machines keep their original on-premises private IP addresses when migrating to Azure. To
learn more, see
[Azure Extended Network](../manage/windows-admin-center/azure/azure-extended-network.md).

## All editions

This section describes some of the new features in Windows Server 2022 across all editions. To learn
more about the different editions, review the
[Comparison of Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022](editions-comparison-windows-server-2022.md)
article.

### Security

The new security capabilities in Windows Server 2022 combine other security capabilities in Windows Server across multiple areas to provide defense-in-depth protection against advanced threats. Advanced multi-layer security in Windows Server 2022 provides the comprehensive protection that servers need today.

#### Secured-core server

Certified Secured-core server hardware from an OEM partner provides more security protections that are useful against sophisticated attacks. Certified Secured-core server hardware can provide increased assurance when handling mission critical data in some of the most data sensitive industries. A Secured-core server uses hardware, firmware, and driver capabilities to enable advanced Windows Server security features. Many of these features are available in [Windows Secured-core PCs](/windows-hardware/design/device-experiences/oem-highly-secure) and are now also available with Secured-core server hardware and Windows Server 2022. For more information about Secured-core server, see [Secured-core server](../security/secured-core-server.md).

##### Hardware root-of-trust

Used by features such as [BitLocker drive encryption](/windows/security/information-protection/bitlocker/bitlocker-device-encryption-overview-windows-10), Trusted Platform Module 2.0 (TPM 2.0) secure crypto-processor chips provide a secure, hardware-based store for sensitive cryptographic keys and data, including systems integrity measurements. [TPM 2.0](/windows/security/information-protection/tpm/trusted-platform-module-top-node) can verify that the server has been started with legitimate code and can be trusted by subsequent code execution, known as a hardware root-of-trust.

##### Firmware protection

Firmware executes with high privileges and is often invisible to traditional anti-virus solutions, which has led to a rise in the number of firmware-based attacks. Secured-core servers measure and verify boot processes with [Dynamic Root of Trust for Measurement (DRTM) technology](/windows/security/threat-protection/windows-defender-system-guard/how-hardware-based-root-of-trust-helps-protect-windows#secure-launchthe-dynamic-root-of-trust-for-measurement-drtm). Secured-core servers can also isolate of driver access to memory with [Direct Memory Access (DMA) protection](/windows/security/information-protection/kernel-dma-protection-for-thunderbolt).

##### UEFI secure boot

[UEFI secure boot](/windows-hardware/design/device-experiences/oem-secure-boot) is a security standard that protects your servers from malicious rootkits. Secure boot ensures the server boots only firmware and software trusted by the hardware manufacturer. When the server is started, the firmware checks the signature of each boot component including firmware drivers and the OS. If the signatures are valid, the server boots and the firmware gives control to the OS.

##### Virtualization-based security (VBS)

Secured-core servers support virtualization-based security (VBS) and hypervisor-based code integrity (HVCI). [VBS](/windows-hardware/design/device-experiences/oem-vbs) uses hardware virtualization features to create and isolate a secure region of memory from the normal operating system, protecting against an entire class of vulnerabilities used in cryptocurrency mining attacks. VBS also allows for the use of [Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-how-it-works), where user credentials and secrets are stored in a virtual container that the operating system can't access directly.

[HVCI](/windows-hardware/design/device-experiences/oem-hvci-enablement) uses VBS to significantly strengthen code integrity policy enforcement. Kernel mode integrity prevents unsigned kernel mode drivers or system files from being loaded into system memory.

Kernel Data Protection (KDP) provides read-only memory protection of kernel memory containing non-executable data where memory pages are protected by Hypervisor. KDP protects key structures in the Windows Defender System Guard runtime from being tampered.

#### Secure connectivity

##### Transport: HTTPS and TLS 1.3 enabled by default on Windows Server 2022

Secure connections are at the heart of today's interconnected systems. Transport Layer Security (TLS) 1.3 is the latest version of the internet's most deployed security protocol, which encrypts data to provide a secure communication channel between two endpoints. HTTPS and TLS 1.3 is now enabled by default on Windows Server 2022, protecting the data of clients connecting to the server. It eliminates obsolete cryptographic algorithms, enhances security over older versions, and aims to encrypt as much of the handshake as possible. Learn more about [supported TLS versions](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-) and about [supported cipher suites](/windows/win32/secauthn/tls-cipher-suites-in-windows-server-2022).

Although TLS 1.3 in the protocol layer is now enabled by default, applications and services also need to actively support it. The Microsoft Security blog has more detail in the post [Taking Transport Layer Security (TLS) to the next level with TLS 1.3](https://www.microsoft.com/security/blog/2020/08/20/taking-transport-layer-security-tls-to-the-next-level-with-tls-1-3/).

##### Secure DNS: Encrypted DNS name resolution requests with DNS-over-HTTPS

DNS Client in Windows Server 2022 now supports DNS-over-HTTPS (DoH) which encrypts DNS queries using the HTTPS protocol. DoH helps keep your traffic as private as possible by preventing eavesdropping and your DNS data being manipulated. Learn more about [configuring the DNS client to use DoH](../networking/dns/doh-client-support.md).

##### Server Message Block (SMB): SMB AES-256 encryption for the most security conscious

Windows Server now supports AES-256-GCM and AES-256-CCM cryptographic suites for SMB encryption. Windows will automatically negotiate more advanced cipher method when connecting to another computer that also supports it, and it can also be mandated through Group Policy. Windows Server still supports AES-128 for down-level compatibility. AES-128-GMAC signing now also accelerates signing performance.

##### SMB: East-West SMB encryption controls for internal cluster communications

Windows Server failover clusters now support granular control of encrypting and signing intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). When using Storage Spaces Direct, you can now decide to encrypt or sign east-west communications within the cluster itself for higher security.

##### SMB Direct and RDMA encryption

SMB Direct and RDMA supply high bandwidth, low latency networking fabric for workloads like Storage Spaces Direct, Storage Replica, Hyper-V, Scale-out File Server, and SQL Server. SMB Direct in Windows Server 2022 now supports encryption. Previously, enabling SMB encryption disabled direct data placement; this was intentional, but seriously impacted performance. Now data is encrypted before data placement, leading to far less performance degradation while adding AES-128 and AES-256 protected packet privacy.

More information on SMB encryption, signing acceleration, secure RDMA, and cluster support can be found at [SMB security enhancements](../storage/file-server/smb-security.md).

### Azure hybrid capabilities

You can increase your efficiency and agility with built-in hybrid capabilities in Windows Server 2022 that allow you to extend your data centers to Azure more easily than ever before.

#### Azure Arc enabled Windows Servers

Azure Arc enabled servers with Windows Server 2022 brings on-premises and multicloud Windows Servers to Azure with Azure Arc. This management experience is designed to be consistent with how you manage native Azure virtual machines. When a hybrid machine is connected to Azure, it becomes a connected machine and is treated as a resource in Azure. More information can be found at the [Azure Arc enables servers documentation](/azure/azure-arc/servers/overview).

##### Add Windows Servers

As of the [KB5031364](https://support.microsoft.com/help/5031364) update, you can now add Windows Servers with an easy, simple process.

To add new Windows Servers, go to the Azure Arc icon in the bottom-right corner of the taskbar and launch the Azure Arc Setup program to install and configure an Azure Connected Machine Agent. Once installed, you can use the Azure Connected Machine Agent at no extra charge to your Azure account. Once you've enabled Azure Arc on your server, you can see the status information in the taskbar icon.

To learn more, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server).

#### Windows Admin Center

Improvements to Windows Admin Center to manage Windows Server 2022 include capabilities to both report on the current state of the Secured-core features mentioned above, and where applicable, allow customers to enable the features. More information on these and many more improvements to Windows Admin Center can be found at the [Windows Admin Center documentation](../manage/windows-admin-center/understand/what-is.md).

### Application platform

There are several platform improvements for Windows Containers, including application compatibility and the Windows Container experience with Kubernetes.

Some of the new features are:

- Reduced Windows Container image size by up to 40%, which leads to a 30% faster startup time and better performance.

- Applications can now use Azure Active Directory with group Managed Services Accounts (gMSA) [without domain joining the container host](/virtualization/windowscontainers/manage-containers/manage-serviceaccounts). Windows Containers now also support Microsoft Distributed Transaction Control (MSDTC) and Microsoft Message Queuing (MSMQ).

- Simple buses can now be assigned to process-isolated Windows Server containers. Applications running in containers that need to talk over SPI, I2C, GPIO, and UART/COM are now able to do so.

- We've enabled support for hardware acceleration of DirectX APIs in Windows containers to support scenarios such as Machine Learning (ML) inference using local graphical processing unit (GPU) hardware. For more information, see the [Bringing GPU acceleration to Windows containers](https://techcommunity.microsoft.com/t5/Containers/Bringing-GPU-acceleration-to-Windows-containers/ba-p/393939) blog post.

- There are several other enhancements that simplify the Windows Container experience with Kubernetes. These enhancements include support for host-process containers for node configuration, IPv6, and consistent network policy implementation with Calico.

- Windows Admin Center has been updated to make it easy to containerize .NET applications. Once the application is in a container, you can host it on Azure Container Registry to then deploy it to other Azure services, including Azure Kubernetes Service.

- With support for Intel Ice Lake processors, Windows Server 2022 supports business-critical and large-scale applications that require up to 48 TB of memory and 2,048 logical cores running on 64 physical sockets. Confidential computing with Intel Secured Guard Extension (SGX) on Intel Ice Lake improves application security by isolating applications from each other with protected memory.

To learn more about the new features, see [What's new for Windows containers in Windows Server 2022](/virtualization/windowscontainers/about/whats-new-ws2022-containers).

### Other key features

#### Remote Desktop IP virtualization

As of the [KB5030216](https://support.microsoft.com/help/5030216) update, you can now use Remote Desktop IP Virtualization.

Remote Desktop IP Virtualization simulates a single-user desktop by supporting per-session and per-program Remote Desktop IP Virtualization for Winsock applications. To learn more, see [Remote Desktop IP Virtualization in Windows Server](/troubleshoot/windows-server/remote/remote-desktop-ip-virtualization).

#### Task Scheduler and Hyper-V Manager for Server Core installations

We added two management tools to the App Compatibility Feature on Demand feature package in this version, Task Scheduler (taskschd.msc) and Hyper-V Manager (virtmgmt.msc). For more information, see [Server Core App Compatibility Feature on Demand (FOD)](../get-started/server-core-app-compatibility-feature-on-demand.md).

#### Nested virtualization for AMD processors

Nested virtualization is a feature that allows you to run Hyper-V inside of a Hyper-V virtual machine (VM). Windows Server 2022 brings support for nested virtualization using AMD processors, giving more choices of hardware for your environments. More information can be found at the [nested virtualization documentation](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization).

#### Microsoft Edge browser

Microsoft Edge is included with Windows Server 2022, replacing Internet Explorer. It's built on Chromium open source and backed by Microsoft security and innovation. It can be used with the Server with Desktop Experience installation options. More information can be found at the [Microsoft Edge Enterprise documentation](/DeployEdge/). Microsoft Edge, unlike the rest of Windows Server, follows the Modern Lifecycle for its support lifecycle. For details, see [Microsoft Edge lifecycle documentation](/lifecycle/products/microsoft-edge).

#### Networking performance

##### UDP performance improvements

UDP is becoming a popular protocol carrying more network traffic due to the increasing popularity of RTP and custom (UDP) streaming and gaming protocols. The QUIC protocol, built on top of UDP, brings the performance of UDP to a level on par with TCP. Significantly, Windows Server 2022 includes UDP Segmentation Offload (USO). USO moves most of the work required to send UDP packets from the CPU to the network adapter's specialized hardware. Complimenting USO is UDP Receive Side Coalescing (UDP RSC), which coalesces packets and reduces CPU usage for UDP processing. In addition, we have also made hundreds of improvements to the UDP data path both transmit and receive. Windows Server 2022 and Windows 11 both have this new capability.

##### TCP performance improvements

Windows Server 2022 uses TCP [HyStart++](https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-hystartplusplus-00) to reduce packet loss during connection start-up (especially in high-speed networks) and [RACK](https://datatracker.ietf.org/doc/html/rfc8985) to reduce Retransmit TimeOuts (RTO). These features are enabled in the transport stack by default and provide a smoother network data flow with better performance at high speeds. Windows Server 2022 and Windows 11 both have this new capability.

##### Hyper-V virtual switch improvements

Virtual switches in Hyper-V have been enhanced with updated Receive Segment Coalescing (RSC). RSC allows the hypervisor network to coalesce packets and process as one larger segment. CPU cycles are reduced and segments will remain coalesced across the entire data path until processed by the intended application. RSC results in improved performance for both network traffic from an external host, received by a virtual NIC, and from a virtual NIC to another virtual NIC on the same host.

#### System Insights disk anomaly detection

[System Insights](../manage/system-insights/overview.md) has another capability via Windows Admin Center, disk anomaly detection.

Disk anomaly detection is a new capability that highlights when disks are behaving *differently* than usual. While different isn't necessarily a bad thing, seeing these anomalous moments can be helpful when troubleshooting issues on your systems. This capability is also available for servers running Windows Server 2019.

#### Windows Update rollback improvements

Servers can now automatically recover from startup failures by removing updates if the startup failure was introduced after the installation of recent driver or quality Windows Updates. When a device is unable to start up properly after the recent installation of quality of driver updates, Windows will now automatically uninstall the updates to get the device back up and running normally.

This functionality requires the server to be using the [Server Core installation option](../get-started/getting-started-with-server-core.md) option with a [Windows Recovery Environment](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference) partition.

### Storage

#### Storage Migration Service

Enhancements to Storage Migration Service in Windows Server 2022 makes it easier to migrate storage to Windows Server or to Azure from more source locations. Here are the features that are available when running the Storage Migration Server orchestrator on Windows Server 2022:

* Migrate local users and groups to the new server.
* Migrate storage from failover clusters, migrate to failover clusters, and migrate between standalone servers and failover clusters.
* Migrate storage from a Linux server that uses Samba.
* More easily synchronize migrated shares into Azure by using Azure File Sync.
* Migrate to new networks such as Azure.
* Migrate NetApp CIFS servers from NetApp FAS arrays to Windows servers and clusters.

#### Adjustable storage repair speed

[User adjustable storage repair speed](/azure-stack/hci/manage/storage-repair-speed) is a new feature in Storage Spaces Direct that offers more control over the data resync process.  Adjustable storage repair speed enables you to allocate resources to either repair data copies (resiliency) or to run active workloads (performance). Controlling the repair speed helps improve availability and allows you to service your clusters more flexibly and efficiently.

#### Faster repair and resynchronization

Storage repair and resynchronization after events such as node reboots and disk failures are now twice as fast. Repairs have less variance in time taken so you can be more sure of how long the repairs will take, which has been achieved through adding more granularity to data tracking. Repairs now only move the data that needs to be moved, reducing the system resources used and time taken.

#### Storage bus cache with Storage Spaces on standalone servers

Storage bus cache is now available for standalone servers. It can significantly improve read and write performance, while maintaining storage efficiency and keeping the operational costs low. Similar to its implementation for Storage Spaces Direct, this feature binds together faster media (for example, NVMe or SSD) with slower media (for example, HDD) to create tiers. A portion of the faster media tier is reserved for the cache. To learn more, see [Enable storage bus cache with Storage Spaces on standalone servers](../storage/storage-spaces/storage-spaces-storage-bus-cache.md).

#### ReFS file-level snapshots

Microsoft's Resilient File System (ReFS) now includes the ability to snapshot files using a quick metadata operation. Snapshots are different than [ReFS block cloning](../storage/refs/block-cloning.md) in that clones are writable, whereas snapshots are read-only. This functionality is especially useful in virtual machine backup scenarios with VHD/VHDX files. ReFS snapshots are unique in that they take a constant time irrespective of file size. Support for snapshots is available in [ReFSUtil](../administration/windows-commands/refsutil.md) or as an API.

#### SMB compression

Enhancement to SMB in Windows Server 2022 and Windows 11 allows a user or application to compress files as they transfer over the network. Users no longer have to manually zip files in order to transfer much faster on slower or more congested networks. For details, see [SMB Compression](../storage/file-server/smb-compression.md).
