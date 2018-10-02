---
title: What's new in Windows Server 2019
description: "What's new in Windows Server 2019"
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: dawnwood
ms.author: dawn.wood
ms.localizationpriority: high
ms.date: 10/02/2018
---

# What's new in Windows Server 2019

This topic describes some of the new features in Windows Server 2019. 

### Desktop experience

The <b>Desktop Experience</b> is back in Windows Server 2019!  It is not included in Windows Server, version 1709, Windows Server, version 1803, or Windows Server, version 1809.  
As with Windows Server 2016, during setup of the operating system it is possible to choose between Server Core installations or Server with Desktop Experience installations.

### System insights

System Insights</b> is a new feature available in Windows Server 2019 that brings local predictive analytics capabilities natively to Windows Server. These predictive capabilities—each backed by a machine-learning model—locally analyze Windows Server system data, such as performance counters and events, 
providing insight into the functioning of your deployments and helping you reduce the operational expenses associated with monitoring your Windows Server instances. 

## Hybrid Cloud

### Windows Admin Center

[Windows Admin Center](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/overview) is an evolution of Windows Server in-box management tools; it’s a single pane of glass that consolidates all aspects of local and remote server management. 
As a locally deployed, browser-based management experience, an Internet connection and Azure aren’t required. Windows Admin Center gives you full control of all aspects of your deployment, 
including private networks that aren’t Internet-connected.
<br/><br/>
* Windows Admin Center is a free download, separate from the Windows Server 2019 download, for enhanced flexibility and remote management strategies.  See the Windows Admin Center OS support [matrix](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/plan/installation-options) for installation and management compatibility.


### Storage Migration Service

Storage Migration Service (SMS) is a new role included in Windows Server Standard and Datacenter editions. SMS is a job-based orchestration and proxy that:
Allows administrators to inventory existing servers for their data, security, and network settings.
Migrates that data, security, and network settings to a new, modern target by using the SMB protocol.
Takes over the identity of the old server completely, while decommissioning the original source, in such a way that users and applications are unaffected and unaware that migration has taken place.

### Server Core app compatibility feature on demand

The [Server Core App Compatibility feature on demand (FOD)](https://docs.microsoft.com/en-us/windows-server/get-started-19/install-fod-19) significantly improves the app compatibility of the Windows Server Core installation option by including a subset of binaries and components from Windows Server with the Desktop Experience, without adding the Windows Server Desktop Experience graphical environment itself.  This is done to increase the functionality and compatibility of Server Core while keeping it as lean as possible.  
This optional feature on demand is available on a separate ISO and can be added to Windows Server Core installations and images only, using DISM. 

### Azure Network Adapter

Azure Network Adapter – Now with Windows Server 2019, Windows Admin Center enables a one-click experience to configure a point-to-site VPN connection between an on-premises Windows Server and an Azure Virtual Network.
This automates the configuration for the Azure Virtual Network gateway as well as the on-premises VPN client. 

## Security

### Windows Defender Advanced Threat Protection (ATP)

We provide deep platform sensors and response actions, providing visibility to
memory and kernel level attacker activities and abilities to take actions on
compromised machines in response to incidents such as remote collection of
additional forensic data, remediating malicious files, terminating malicious
processes etc.

-   For more information about Windows Defender ATP, see [Overview of Windows
    Defender ATP
    capabilities](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-atp/overview).

-   For more information on onboarding servers, see [Onboard servers to Windows
    Defender ATP
    service](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-atp/configure-server-endpoints-windows-defender-advanced-threat-protection).

**Windows Defender ATP Exploit Guard** is a new set of host-intrusion prevention capabilities. The four components of Windows Defender Exploit Guard are designed to lock down the device against a wide variety of attack vectors and block behaviors commonly used in malware attacks, while enabling enterprises to balance their security risk and productivity requirements.

-   [Attack Surface
    Reduction(ASR)](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/attack-surface-reduction-exploit-guard?ocid=cx-blog-mmpc
)
    is set of controls that enterprises can enable to prevent malware from
    getting on the machine by blocking suspicious malicious files (for example,
    Office files), scripts, lateral movement, ransomware behavior, and
    email-based threats.

-   [Network
    protection](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/network-protection-exploit-guard?ocid=cx-blog-mmpc)
    protects the endpoint against web-based threats by blocking any outbound
    process on the device to untrusted hosts/IP addresses through Windows
    Defender SmartScreen.

-   [Controlled folder
    access](https://cloudblogs.microsoft.com/microsoftsecure/2017/10/23/stopping-ransomware-where-it-counts-protecting-your-data-with-controlled-folder-access/?ocid=cx-blog-mmpc?source=mmpc)
    protects sensitive data from ransomware by blocking untrusted processes from
    accessing your protected folders.

-   [Exploit
    protection](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/exploit-protection-exploit-guard) is a set of mitigations for vulnerability exploits (replacing EMET)that can
    be easily configured to protect your system and applications.



[Windows Defender Application
Control](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control)—also
known as Code Integrity (CI) policy—was released in Windows Server 2016.
Customer feedback has suggested that it is a great concept, but hard to deploy.
To address this, we have built default CI policies, which will allow all Windows
in-box files and Microsoft applications, such as SQL Server, and block known
executables that can bypass CI. 

### Security with Software Defined Networking (SDN)

[Security with SDN](https://docs.microsoft.com/en-us/windows-server/networking/sdn/security/sdn-security-top) delivers many features to increase customer confidence in running workloads either on-premises or as a service provider in the cloud. 
These security enhancements are integrated into the comprehensive SDN platform that our customers have already been using since Windows Server 2016.
For a complete list of what’s new in SDN see, [What’s New in SDN for Windows Server 2019](https://docs.microsoft.com/en-us/windows-server/networking/sdn/sdn-whats-new).

### Shielded Virtual Machines improvements

* You can now run shielded virtual machines on machines with intermittent connectivity to the Host Guardian Service by leveraging the new fallback HGS and offline mode features. Fallback HGS allows you to configure a second set of URLs for Hyper-V to try if it can't reach your primary HGS server. 
Offline mode allows you to continue to start up your shielded VMs, even if HGS can't be reached, as long as the VM has started successfully once, and the host's security configuration has not changed.
* We've also made it easier to troubleshoot your shielded virtual machines by enabling support for VMConnect Enhanced Session Mode and PowerShell Direct. These tools are particularly useful if you've lost network connectivity to your VM and need to update its configuration to restore access. 
These features do not need to be configured, and they will automatically become available when a shielded VM is placed on a Hyper-V host running build 17040 or later.
* For customers who run mixed-OS environments, Windows Server 2019 now supports running Ubuntu, Red Hat Enterprise Linux, and SUSE Linux Enterprise Server inside shielded virtual machines.

### HTTP/2 for a faster and safer Web

* Improved coalescing of connections to deliver an uninterrupted and properly encrypted browsing experience.
* Upgraded HTTP/2’s server-side cipher suite negotiation for automatic mitigation of connection failures and ease of deployment.
* Changed our default TCP congestion provider to Cubic to give you more throughput!

## Application Platform

### Container Networking with Kubernetes

[Container Networking with Kubernetes](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/containers/container-networking-overview) in Windows Server 2019 greatly improves usability of Kubernetes on Windows by enhancing platform networking resiliency and support of container networking plugins. 
Additionally, customers deploying workloads on Kubernetes network security to protect both Linux and Windows services using embedded tooling.

## Hyper-converged infrastructure


### Storage Spaces Direct

- **Deduplication and compression**

    Get up to 10X more storage for free with deduplication and compression for the ReFS filesystem. (It’s [just one click](https://www.youtube.com/watch?v=PRibTacyKko&feature=youtu.be) to turn on with Windows Admin Center.) The variable-size chunk store with optional compression maximizes savings rates, while the multi-threaded post-processing architecture keeps performance impact minimal. Supports volumes up to 64 TB and files up to 1 TB each.

- **Native support for persistent memory**

    Unlock unprecedented performance with native Storage Spaces Direct support for persistent memory modules, including Intel® Optane™ DC PM and NVDIMM-N. Use persistent memory as cache to accelerate the active working set, or as capacity to guarantee consistent low latency on the order of microseconds. Manage persistent memory just as you would any other drive in PowerShell or Windows Admin Center.

- **Nested resiliency for two-node HCI at the edge**

    Survive two hardware failures at once with an all-new software resiliency option inspired by RAID 5+1. With nested resiliency, a two-node Storage Spaces Direct cluster can provide continuously accessible storage for apps and virtual machines even if one server node goes down and a drive fails in the other server node.

- **Windows Admin Center**

    Manage and monitor Storage Spaces Direct with the new [purpose-built Dashboard](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/use/manage-hyper-converged) and experience in Windows Admin Center. Create, open, expand, or delete volumes with just a few clicks. Monitor performance like IOPS and IO latency from the overall cluster down to the individual SSD or HDD. Available at no additional cost for Windows Server 2016 and Windows Server 2019.

- **Performance history**

    Get effortless visibility into resource utilization and performance with [built-in history](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/performance-history-for-vhds). Over 50 essential counters spanning compute, memory, network, and storage are automatically collected and stored on the cluster for up to one year. Best of all, there’s nothing to install, configure, or start – it just works. Visualize in Windows Admin Center or query and process in PowerShell.

- **Scale up to 4 PB per cluster**

    Achieve multi-petabyte scale – great for media, backup, and archival use cases. In Windows Server 2019, Storage Spaces Direct supports up to 4 petabytes (PB) = 4,000 terabytes of raw capacity per storage pool. Related capacity guidelines are increased as well: for example, you can create twice as many volumes (64 instead of 32), each twice as large as before (64 TB instead of 32 TB). Stitch multiple clusters together into a cluster set for even greater scale within one storage namespace.

- **Mirror-accelerated parity is 2X faster**

    With mirror-accelerated parity you can create Storage Spaces Direct volumes that are part mirror and part parity, like mixing RAID-1 and RAID-5/6 to get the best of both. (It’s [easier than you think](https://www.youtube.com/watch?v=R72QHudqWpE) in Windows Admin Center.) In Windows Server 2019, the performance of mirror-accelerated parity is more than doubled relative to Windows Server 2016 thanks to important architectural optimizations.

- **Drive latency outlier detection**

    Easily identify drives with abnormal latency with proactive monitoring and built-in outlier detection, inspired by Microsoft Azure’s long-standing and successful approach. Whether it’s average latency or something more subtle like 99th percentile latency that stands out, slow drives are automatically labeled in PowerShell and Windows Admin Center with ‘Abnormal Latency’ status.


### Failover Clustering

- **Cluster Sets**

    Hyperscale a hyper-converged infrastructure by federating multiple Failover Clusters into a Cluster Set.  Virtual Machines achieve fluidity across loosely coupled grouping of clusters for balancing and maintenance.

- **Azure Enlightened Clusters**

    Failover Clusters automatically detect and optimize the configuration when running in Azure IaaS virtual machines.  Proactive failover and logging of Azure planned maintenance events to achieve the highest levels of availability.  Simplified deployment by removing the need to configure the load balancer with Dynamic Network Name for Cluster Name.

- **Cross-domain Cluster Migration**

    Failover Clusters can now dynamically move from one Active Directory domain to another.  Simplifying domain consolidation and allowing clusters to be pre-built and then shipped and domain joined onsite.

- **Cluster Hardening**

    Intra-cluster communication over Server Message Block (SMB) for Cluster Shared Volumes and Storage Spaces Direct now leverages certificates to provide the most secure platform.  This allows Failover Clusters to operate with no dependencies on NTLM and enable security baselines.

- **USB Witness**

    A simple USB drive in a switch or device can now be used as a witness in determining quorum for a cluster.  This extends the File Share Witness to support any SMB2 compliant device.

- **Cluster Infrastructure**

    The CSV Cache is now enabled by default to turbo boost virtual machine performance.  MSDTC now supports Cluster Shared Volumes, to allow deploying MSDTC workloads on Storage Spaces Direct such as with SQL Server.  Enhanced logic to detect partitioned nodes with self-healing to return nodes to cluster membership.  Enhanced cluster network route detection and self-healing.

- **Cluster Aware Updating**

    Cluster Aware Updating (CAU) is now integrated and aware of Storage Spaces Direct, validating and ensuring data resynchronization completes on each node.  Inspects updates to intelligently patch by only rebooting if necessary.  Enables orchestrating restarts of all nodes in the cluster for planned maintenance, even when not patching.

### Encrypted Networks

[Encrypted Networks](https://docs.microsoft.com/en-us/windows-server/networking/sdn/sdn-whats-new) - Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as ‘Encryption Enabled.’ 
It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network.

### Network performance improvements for virtual workloads

[Network performance improvements for virtual workloads](https://docs.microsoft.com/en-us/windows-server/networking/technologies/hpn/hpn-insider-preview) will maximize the network throughput to virtual machines without requiring you to constantly tune or over-provision your host. This lowers the Operations & Maintenance cost while increasing the available density of your hosts. These new features are:

* Receive Segment Coalescing in the vSwitch
* Dynamic Virtual Machine Multi-Queue (d.VMMQ)
 
### Storage Replica expanded to include:

- Test failover is a new feature that allows mounting of destination storage in order to validate replication or backup data. For more information, see [Frequently Asked Questions about Storage Replica](https://docs.microsoft.com/en-us/windows-server/storage/storage-replica/storage-replica-frequently-asked-questions).
- Log Performance improvements v1.1
- Storage Replica is available in Standard Edition and can create 1 Partnership with 1 Resource Group with single 2TB volumes. The feature can replicate between clusters, asynchronously and synchronously.

### Low Extra Delay Background Transport

Low Extra Delay Background Transport (LEDBAT) is a latency optimized, network congestion control provider designed to automatically yield bandwidth to users and applications, while consuming the entire bandwidth available when the network is not in use.   
This technology is intended for use in deploying large, critical updates across an IT environment without impacting customer facing services and associated bandwidth.

### Windows Time Service

The [Windows Time Service](https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/insider-preview) includes true UTC-compliant leap second support, a new time protocol called Precision Time Protocol, and end-to-end traceability.


### High performance SDN gateways

[High performance SDN gateways](https://docs.microsoft.com/en-us/windows-server/networking/sdn/gateway-performance) in Windows Server 2019 greatly improves the performance for IPsec and GRE connections. 
All this, with huge reductions in the CPU cycles/per byte, thereby providing ultra-high-performance throughput with much less CPU utilization.
<br/>

### New Deployment UI and Windows Admin Center extension for SDN

Now, with Windows Server 2019, it’s easy to deploy and manage through a new deployment UI and Windows Admin Center extension that will enable anyone to harness the power of SDN. 


