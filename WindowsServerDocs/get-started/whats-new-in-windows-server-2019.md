---
title: What's new in Windows Server 2019
description: This article describes some of the new features in Windows Server 2019.
ms.topic: article
author: robinharwood
ms.author: roharwoo
manager: femila
ms.date: 11/28/2022
ms.prod: windows-server
---

# What's new in Windows Server 2019

This article describes some of the new features in Windows Server 2019. Windows Server 2019 is built on the strong foundation of Windows Server 2016 and brings numerous innovations on four key themes: Hybrid Cloud, Security, Application Platform, and Hyper-Converged Infrastructure (HCI).

## General

### Windows Admin Center

Windows Admin Center is a locally deployed, browser-based app for managing servers, clusters, hyper-converged infrastructure, and Windows 10 PCs. It comes at no extra cost beyond Windows and is ready to use in production.

You can install Windows Admin Center on Windows Server 2019 and Windows 10 and earlier versions of Windows and Windows Server, and use it to manage servers and clusters running Windows Server 2008 R2 and later.

For more info, see [Windows Admin Center](../manage/windows-admin-center/overview.md).

### Desktop experience

Because Windows Server 2019 is a Long-Term Servicing Channel (LTSC) release, it includes the **Desktop Experience**. (Semi-Annual Channel \(SAC\) releases don't include the Desktop Experience by design; they're strictly Server Core and Nano Server container image releases.) As with Windows Server 2016, during setup of the operating system you can choose between Server Core installations or Server with Desktop Experience installations.

### System Insights

System Insights is a new feature available in Windows Server 2019 that brings local predictive analytics capabilities natively to Windows Server. These predictive capabilities, each backed by a machine-learning model, locally analyze Windows Server system data, such as performance counters and events. System Insights allows you to understand how your servers are functioning and helps you reduce the operational expenses associated with reactively managing issues in your Windows Server deployments.

## Hybrid Cloud

### Server Core App Compatibility Feature on Demand

[Server Core App Compatibility Feature on Demand (FOD)](../get-started/server-core-app-compatibility-feature-on-demand.md) significantly improves the app compatibility by including a subset of binaries and components from Windows Server with the Desktop Experience. Server Core is kept it as lean as possible by not adding the Windows Server Desktop Experience graphical environment itself, increasing the functionality and compatibility.

This optional feature on demand is available on a separate ISO and can be added to Windows Server Core installations and images only, using DISM.

### Windows Deployment Services (WDS) Transport Server role added to Server Core

Transport Server contains only the core networking parts of WDS. You can now use Server Core with the Transport Server role to create multicast namespaces that transmit data (including operating system images) from a standalone server. You can also use it if you want to have a PXE server that allows clients to PXE boot and download your own custom setup application.

### Remote Desktop Services integration with Azure AD

With Azure AD integration you can use Conditional Access policies, Multifactor Authentication, Integrated authentication with other SaaS Apps using Azure AD, and many more. For more information, see [Integrate Azure AD Domain Services with your RDS deployment](../remote/remote-desktop-services/rds-azure-adds.md).

## Networking

We made several improvements to the core network stack, such as TCP Fast Open (TFO), Receive Window Autotuning, IPv6, and more. For more information, see the [Core Network Stack feature improvement](https://techcommunity.microsoft.com/t5/networking-blog/core-network-stack-features-in-the-creators-update-for-windows/ba-p/339676) post.

## Security

### Windows Defender Advanced Threat Protection (ATP)

ATP's deep platform sensors and response actions expose memory and kernel level attacks and respond by suppressing malicious files and terminating malicious processes.

- For more information about Windows Defender ATP, see [Overview of Windows Defender ATP capabilities](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint).

- For more information on onboarding servers, see [Onboard servers to Windows Defender ATP service](/windows/security/threat-protection/windows-defender-atp/configure-server-endpoints-windows-defender-advanced-threat-protection).

**Windows Defender ATP Exploit Guard** is a new set of host-intrusion prevention capabilities enabling you to balance security risk and productivity requirements. Windows Defender Exploit Guard is designed to lock down the device against a wide variety of attack vectors and block behaviors commonly used in malware attacks. The components are:

- [Attack Surface Reduction (ASR)](/windows/security/threat-protection/windows-defender-exploit-guard/attack-surface-reduction-exploit-guard?ocid=cx-blog-mmpc)
    ASR is set of controls that enterprises can enable to prevent malware from getting on the machine by blocking suspicious malicious files. For example, Office files, scripts, lateral movement, ransomware behavior, and email-based threats.

- [Network protection](/windows/security/threat-protection/microsoft-defender-atp/network-protection)
    protects the endpoint against web-based threats by blocking any outbound
    process on the device to untrusted hosts/IP addresses through Windows
    Defender SmartScreen.

- [Controlled folder access](https://cloudblogs.microsoft.com/microsoftsecure/2017/10/23/stopping-ransomware-where-it-counts-protecting-your-data-with-controlled-folder-access/?ocid=cx-blog-mmpc?source=mmpc)
    protects sensitive data from ransomware by blocking untrusted processes from
    accessing your protected folders.

- [Exploit protection](/windows/security/threat-protection/windows-defender-exploit-guard/exploit-protection-exploit-guard) is a set of mitigations for vulnerability exploits (replacing EMET)that can
    be easily configured to protect your system and applications.

- [Windows Defender Application Control](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control) (also known as Code Integrity (CI) policy) was released in Windows Server 2016. We've made deployment easier by including default CI policies. The default policy allows all Windows in-box files and Microsoft applications, such as SQL Server, and blocks known executables that can bypass CI.

### Security with Software Defined Networking (SDN)

[Security with SDN](/azure-stack/hci/manage/nc-security) delivers many features to increase customer confidence in running workloads, either on-premises, or as a service provider in the cloud.

These security enhancements are integrated into the comprehensive SDN platform introduced in Windows Server 2016.

For a complete list of what's new in SDN see, [What's New in SDN for Windows Server 2019](../networking/sdn/sdn-whats-new.md).

### Shielded Virtual Machines improvements

- **Branch office improvements**

    You can now run shielded virtual machines on machines with intermittent connectivity to the Host Guardian Service by using the new [fallback HGS](../security/guarded-fabric-shielded-vm/guarded-fabric-manage-branch-office.md#fallback-configuration) and [offline mode](../security/guarded-fabric-shielded-vm/guarded-fabric-manage-branch-office.md#offline-mode) features. Fallback HGS allows you to configure a second set of URLs for Hyper-V to try if it can't reach your primary HGS server.

    Even if the HGS can't be reached, offline mode will allow you to continue to start up your shielded VMs. Offline mode will allow you to start your VMs as long as the VM has started successfully once, and the host's security configuration hasn't changed.

- **Troubleshooting improvements**

    We've also made it easier to [troubleshoot your shielded virtual machines](../security/guarded-fabric-shielded-vm/guarded-fabric-troubleshoot-shielded-vms.md) by enabling support for VMConnect Enhanced Session Mode and PowerShell Direct. These tools are useful if you've lost network connectivity to your VM and need to update its configuration to restore access.

    These features don't need to be configured, and they become available automatically when a shielded VM is placed on a Hyper-V host running Windows Server version 1803 or later.

- **Linux support**

    If you run mixed-OS environments, Windows Server 2019 now supports running Ubuntu, Red Hat Enterprise Linux, and SUSE Linux Enterprise Server inside shielded virtual machines.

### HTTP/2 for a faster and safer Web

- Improved coalescing of connections to deliver an uninterrupted and properly encrypted browsing experience.

- Upgraded HTTP/2's server-side cipher suite negotiation for automatic mitigation of connection failures and ease of deployment.

- Changed our default TCP congestion provider to Cubic to give you more throughput!

## Storage

Here are some of the changes we've made to storage in Windows Server 2019. For details, see [What's new in Storage](../storage/whats-new-in-storage.md).

### Data Deduplication

- **Data Deduplication now supports ReFS**
    You can now enable Data Deduplication wherever you can enable ReFS, increasing storage efficiency by up to 95% with ReFS.

- **DataPort API for optimized ingress/egress to deduplicated volumes**
    Developers can now take advantage of the knowledge Data Deduplication has about how to store data efficiently to move data between volumes, servers, and clusters efficiently.

### File Server Resource Manager

It's now possible to prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on all volumes when the service starts. Preventing the creation of the change journey can conserve space on each volume, but will disable real-time file classification. For more information, see [File Server Resource Manager overview](../storage/fsrm/fsrm-overview.md).

### SMB

- **SMB1 and guest authentication removal**
    Windows Server no longer installs the SMB1 client and server by default. Additionally, the ability to authenticate as a guest in SMB2 and later is off by default. For more information, review [SMBv1 isn't installed by default in Windows 10, version 1709 and Windows Server, version 1709](https://support.microsoft.com/help/4034314/smbv1-is-not-installed-by-default-in-windows-10-rs3-and-windows-server).

- **SMB2/SMB3 security and compatibility**
    You now have the ability to disable oplocks in SMB2+ for legacy applications, and require signing or encryption on per-connection basis from a client. For more information, review the [SMBShare PowerShell module help](/powershell/module/smbshare/?view=windowsserver2019-ps&preserve-view=true).

### Storage Migration Service

Storage Migration Service is a new technology that makes it easier to migrate servers to a newer version of Windows Server. We've provided a graphical tool that inventories data on servers, then transfers the data and configuration to newer servers.  The Storage Migration Service will also optionally move the identities of the old servers to the new servers, so that apps and users don't need to change anything. For more info, see [Storage Migration Service](../storage/storage-migration-service/overview.md).

### Storage Spaces Direct

Here's a list of what's new in Storage Spaces Direct. For details, see [What's new in Storage Spaces Direct](../storage/whats-new-in-storage.md#storage-spaces-direct). Also see [Azure Stack HCI](/azure-stack/operator/azure-stack-hci-overview) for info on acquiring validated Storage Spaces Direct systems.

- Deduplication and compression for ReFS volumes
- Native support for persistent memory
- Nested resiliency for two-node hyper-converged infrastructure at the edge
- Two-server clusters using a USB flash drive as a witness
- Windows Admin Center support
- Performance history
- Scale up to 4 PB per cluster
- Mirror-accelerated parity is 2X faster
- Drive latency outlier detection
- Manually delimit the allocation of volumes to increase fault tolerance

### Storage Replica

Here's what's new in Storage Replica. For details, see [What's new in Storage Replica](../storage/whats-new-in-storage.md#storage-replica).

- Storage Replica is now available in Windows Server 2019 Standard Edition.
- Test failover is a new feature that allows mounting of destination storage to validate replication or backup data. For more information, see [Frequently Asked Questions about Storage Replica](../storage/storage-replica/storage-replica-frequently-asked-questions.yml).
- Storage Replica log performance improvements
- Windows Admin Center support

## Failover Clustering

Here's a list of what's new in Failover Clustering. For details, see [What's new in Failover Clustering](../failover-clustering/whats-new-in-failover-clustering.md).

- Cluster sets
- Azure-aware clusters
- Cross-domain cluster migration
- USB witness
- Cluster infrastructure improvements
- Cluster Aware Updating supports Storage Spaces Direct
- File share witness enhancements
- Cluster hardening
- Failover Cluster no longer uses NTLM authentication

## Application Platform

### Linux containers on Windows

It's now possible to run Windows and Linux-based containers on the same container host, using the same docker daemon. You can now have a heterogeneous container host environment providing flexibility to application developers.

### Built-in support for Kubernetes

Windows Server 2019 continues the improvements to compute, networking, and storage from the Semi-Annual Channel releases needed to support Kubernetes on Windows. More details are available in upcoming Kubernetes releases.

- [Container Networking](../networking/sdn/technologies/containers/container-networking-overview.md) in Windows Server 2019 greatly improves usability of Kubernetes on Windows. We've enhanced platform networking resiliency and support of container networking plugins.

- Deployed workloads on Kubernetes are able to use network security to protect both Linux and Windows services using embedded tooling.

### Container improvements

- **Improved integrated identity**

    We've made integrated Windows authentication in containers easier and more reliable, addressing several limitations from prior versions of Windows Server.

- **Better application compatibility**

    Containerizing Windows-based applications just got easier: The app compatibility for the existing **windowsservercore** image has been increased. For applications with more API dependencies, there's now a third base image: **windows**.

- **Reduced size and higher performance**

    The base container image download sizes, size on disk and startup times have been improved to speed up container workflows.

- **Management experience using Windows Admin Center \(preview\)**

    We've made it easier than ever to see which containers are running on your computer and manage individual containers with a new extension for Windows Admin Center. Look for the "Containers" extension in the [Windows Admin Center public feed](../manage/windows-admin-center/configure/using-extensions.md).

### Compute improvements

- **VM Start Ordering**
    VM Start Ordering is also improved with OS and Application awareness, bringing enhanced triggers for when a VM is considered started before starting the next.

- **Storage-class memory support for VMs** enables NTFS-formatted direct access volumes to be created on non-volatile DIMMs and exposed to Hyper-V VMs. Hyper-V VMs can now use the low-latency performance benefits of storage-class memory devices.

- **Persistent Memory support for Hyper-V VMs**
    To use the high throughput and low latency of persistent memory (also known as storage class memory) in virtual machines, it can now be projected directly into VMs. Persistent memory can help to drastically reduce database transaction latency or reduce recovery times for low latency in-memory databases on failure.

- **Container storage – persistent data volumes**
    Application containers now have persistent access to volumes. For more info, see [Container Storage Support with Cluster Shared Volumes (CSV), Storage Spaces Direct (S2D), SMB Global Mapping](https://techcommunity.microsoft.com/t5/failover-clustering/bg-p/FailoverClustering).

- **Virtual machine configuration file format (updated)**
    The VM guest state file (`.vmgs`) has been added for virtual machines with a configuration version of 8.2 and higher. The VM guest state file includes device state information that was previously part of the VM runtime state file.

### Encrypted Networks

[Encrypted Networks](../networking/sdn/sdn-whats-new.md) - Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as **Encryption Enabled**.
It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network.

### Network performance improvements for virtual workloads

[Network performance improvements for virtual workloads](../networking/what-s-new-in-networking.md) maximizes the network throughput to virtual machines without requiring you to constantly tune or over-provision your host. Improved performance lowers the operations and maintenance cost while increasing the available density of your hosts. These new features are:

- Dynamic Virtual Machine Multi-Queue (d.VMMQ)

- Receive Segment Coalescing in the vSwitch

### Low Extra Delay Background Transport

Low Extra Delay Background Transport (LEDBAT) is a latency optimized, network congestion control provider designed to automatically yield bandwidth to users and applications. LEDBAT consumes bandwidth available while the network isn't in use. The technology is intended for use when deploying large, critical updates across an IT environment without impacting customer facing services and associated bandwidth.

### Windows Time Service

The [Windows Time Service](../networking/windows-time-service/insider-preview.md) includes true UTC-compliant leap second support, a new time protocol called Precision Time Protocol, and end-to-end traceability.

### High performance SDN gateways

[High performance SDN gateways](../networking/sdn/gateway-performance.md) in Windows Server 2019 greatly improves the performance for IPsec and GRE connections, providing ultra-high-performance throughput with much less CPU utilization.

### New Deployment UI and Windows Admin Center extension for SDN

Now, with Windows Server 2019, it's easy to deploy and manage through a new deployment UI and Windows Admin Center extension that enable anyone to harness the power of SDN.

### Windows Subsystem for Linux (WSL)

WSL enables server administrators to use existing tools and scripts from Linux on Windows Server. Many improvements showcased in the [command line blog](https://devblogs.microsoft.com/commandline/tag/wsl/) are now part of Windows Server, including Background tasks, DriveFS, WSLPath, and much more.
