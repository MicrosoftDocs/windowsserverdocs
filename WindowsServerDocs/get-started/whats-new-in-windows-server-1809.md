---
title: What's new in Windows Server
description: "What's new in Windows Server 1809 and Windows Server 2019"
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: dawnwood
ms.author: dawn.wood
ms.localizationpriority: high
ms.date: 10/02/2018
---

# What's new in Windows Server

This topic describes the new features in Windows Server, version 1809 (Semi-Annual Channel) and Windows Server 2019 (Long Term Servicing Channel). To learn more about SAC and LTSC, see [Windows Server Semi-Annual Channel overview](https://docs.microsoft.com/en-us/windows-server/get-started/semi-annual-channel-overview).

## What's new in Windows Server, version 1809 and in Windows Server 2019

This section contains new features that are common to both channels.

### Windows Defender Advanced Threat Protection (ATP)

We provide deep platform sensors and response actions, providing visibility to memory and kernel level attacker activities and abilities to take actions on compromised machines in response to incidents such as remote collection of additional forensic data, remediating malicious files, terminating malicious processes etc. 

For more information about Windows Defender ATP, see [Overview of Windows Defender ATP capabilities](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-atp/overview).
 
For more information on onboarding servers, see [Onboard servers to Windows Defender ATP service](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-atp/configure-server-endpoints-windows-defender-advanced-threat-protection).

### Windows Defender ATP Exploit Guard

Windows Defender ATP Exploit Guard is a new set of host-intrusion
prevention capabilities. The four components of Windows Defender Exploit
Guard are designed to lock down the device against a wide variety of
attack vectors and block behaviors commonly used in malware attacks,
while enabling enterprises to balance their security risk and
productivity requirements.

- <a href="https://docs.microsoft.com/en-us/windows/threat-protection/windows-defender-exploit-guard/attack-surface-reduction-exploit-guard?ocid=cx-blog-mmpc">Attack Surface Reduction
    (ASR)</a>:
    A set of controls that enterprises can enable to prevent malware
    from getting on the machine by blocking suspicious malicious files
    (for example, Office files), scripts, lateral movement, ransomware
    behavior, and email-based threats.

-   [**Network
    protection**](https://docs.microsoft.com/en-us/windows/threat-protection/windows-defender-exploit-guard/network-protection-exploit-guard?ocid=cx-blog-mmpc):
    Protects the endpoint against web-based threats by blocking any
    outbound process on the device to untrusted hosts/IP addresses
    through Windows Defender SmartScreen.

-   [**Controlled folder
    access**](https://blogs.technet.microsoft.com/mmpc/2017/10/23/stopping-ransomware-where-it-counts-protecting-your-data-with-controlled-folder-access?ocid=cx-blog-mmpc):
    Protects sensitive data from ransomware by blocking untrusted
    processes from accessing your protected folders.

-   [**Exploit
    protection**](https://docs.microsoft.com/en-us/windows/threat-protection/windows-defender-exploit-guard/exploit-protection-exploit-guard?ocid=cx-blog-mmpc):
    A set of mitigations for vulnerability exploits (replacing EMET)
    that can be easily configured to protect your system and
    applications.

To deploy a default set of Exploit Guard policy on Windows Server, run
the following cmdlets:
<pre>
Set-MpPreference -EnableControlledFolderAccess Enabled

Set-MpPreference -EnableNetworkProtection Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
3B576869-A4EC-4529-8536-B80A7769E899
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
D4F940AB-401B-4EfC-AADC-AD5F3C50688A
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
D3E037E1-3EB8-44C8-A917-57927947596D
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
5BEB7EFE-FD9A-4556-801D-275E5FFC04CC
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B
-AttackSurfaceReductionRules\_Actions Enabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
D1E49AAC-8F56-4280-B9BA-993A6D77406C
-AttackSurfaceReductionRules\_Actions Disabled

Add-MpPreference -AttackSurfaceReductionRules\_Ids
01443614-cd74-433a-b99e-2ecdc07bfc25
-AttackSurfaceReductionRules\_Actions Enabled

$url = 'https://demo.wd.microsoft.com/Content/ProcessMitigation.xml'

Invoke-WebRequest $url -OutFile ProcessMitigation.xml

Write-Host "Enabling Exploit Protection"

Set-ProcessMitigation -PolicyFilePath ProcessMitigation.xml
</pre>


### Windows Defender Application Control

Windows Defender Application Control—also known as Code Integrity (CI) policy—was released in Windows Server 2016. Customer feedback has suggested that it is a great concept, but hard to deploy. To address this, we are building default CI policies, which will allow all Windows in-box files and Microsoft applications, such as SQL Server, and block known executables that can bypass CI.  

The package contains an audit version and an enforced version. If the server doesn’t require additional drivers/applications, you can deploy the enforced version. Otherwise, you can use the audit policy, check uncovered executables, and then merge them into the default CI policy. 

To deploy the default code integrity policy, run the following commands:

<pre>
Copy-Item C:\\CI\\ServerDefault-EnforcedCI.bin<br/>
C:\\Windows\\System32\\CodeIntegrity\\SiPolicy.p7b
</pre>

Reboot the server to allow code integrity service to load the policy. For more information, see [Windows Defender Application Control](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control).


### Windows Admin Center

Windows Admin Center is an evolution of Windows Server in-box management tools; it’s a locally deployed, browser-based app for managing servers, clusters, hyper-converged infrastructure, and Windows 10 PCs.
For full details, see the [Windows Admin Center](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/overview).

## What's new in Windows Server, version 1809

>Applies To: Windows Server (Semi-Annual Channel)

The content in this section describes what's new and changed since the release of Windows Server, version 1803, and applies to Windows Server, version 1809. 

### App Compatibility Feature on Demand (FoD) for Server Core

This FoD significantly improves the app compatibility of Windows Server Core by including a set of binaries and packages from Windows Server with Desktop, without adding any of the Windows Server Desktop Windows 10 graphical user interface (gui) experiences. The FoD package is available on a separate ISO and installs on Windows Server Core OS only.

For more information, see [Install Windows Features On Demand](https://docs.microsoft.com/en-us/windows-server/get-started-19/install-fod-19).

### Group managed service accounts 

We’ve improved the scalability and reliability of containers that use group managed service accounts (gMSA) to access network resources. You should see fewer authentication errors when using a single gMSA with multiple container instances. Additionally, you no longer need to set the container's host name to be the same as the gMSA. We also fixed a bug that prevented you from using gMSAs with Hyper-V isolated containers.  

### Host device access for containers

You can assign simple buses to process-isolated Windows Server containers. Applications running in containers that need to talk over SPI, I2C, GPIO, and UART/COM will are now able to do so. To learn how to leverage the feature, see [Bringing Device Support to Windows Server Containers](https://blogs.technet.microsoft.com/virtualization/2018/08/13/bringing-device-support-to-windows-server-containers/) in the [Virtualization Blog](https://blogs.technet.microsoft.com/virtualization/).

### New container base image: Windows 

We added a new base image to the Windows Server container collection. In addition to nanoserver and windowsservercore container images, the new Windows Server image is now available. This image carries even more components than its nanoserver and servercore siblings, meaning it can support applications that have additional API dependencies. To learn more and get started, go to https://aka.ms/windowscontainer. 


### Deploying Kubernetes on Windows Server

Kubernetes is a popular orchestration tool for <i>containers</i> (see [What are Containers](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/#what-are-containers)) that makes deployment and management intuitive, scalable, and effective. This includes built-in features such as:

* Scheduling: Given a container image and a resource request, find a suitable machine on which to run the container.
* Health monitoring: Watch for container failures and automatically reschedule them.
* Networking: Provide a network for coordinating containers to communicate across machines.
* Service Discovery: Enable containers to locate each other automatically even as they switch hosts or change IP addresses.
* Scaling: Add or remove container instances to match demand, either manually or automatically.
And much more! For guidance that walks you through how to install Kubernetes onto your on-premise Windows datacenter, please see [How To Guide: Kubernetes for Windows Flannel (Host-Gateway)](https://1drv.ms/w/s!AgH65RVQdrbiglNr7P7P4VrO8Rxr). For more information about container orchestrators in general, see [Container orchestrators](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/#container-orchestrators) on docs.microsoft.com.


## What's new in Windows Server 2019

>Applies To: Windows Server 2019 (Long Term Servicing Channel)

The content in this section describes what's new and changed since the last release of Windows Server 2016, and applies to Windows Server 2019.

### Extending your clusters with cluster sets

“Cluster sets” is the new cloud scale-out technology that increases cluster node count in a single Software-Defined Data Center (SDDC)) cloud by orders of magnitude. A cluster set is a loosely-coupled grouping of multiple failover clusters: compute, storage and hyper-converged. Cluster sets technology enables virtual machine fluidity across member clusters within a cluster set and a unified storage namespace across the "set" in support of virtual machine fluidity.  While preserving existing failover cluster management experiences on member clusters, a cluster set instance additionally offers key use cases around lifecycle management of a cluster set at the aggregate.

### Failover clustering: file share witness

One of the witness options available for failover clustering, file share witness, has two new enhancements. 

The first enhancement blocks the use of a Distributed File System (DFS) share as a location. Adding a File Share Witness (FSW) to a DFS share can cause stability issues for your cluster, and this configuration has never been supported. We added logic to detect if a share uses DFS, and if DFS is detected, Failover Cluster Manager blocks creation of the witness and displays an error message about not being supported.

The second enhancement enables use of an FSW for several scenarios that were previously not supported: 
*  Absent or extremely poor Internet access because of a remote location, preventing the use of a cloud witness. 
*  Lack of shared drives for a disk witness. This could be a Storage Spaces Direct hyperconverged configuration, a SQL Server Always On Availability Groups (AG), or an *  Exchange Database Availability Group (DAG), none of which use shared disks. 
*  Lack of a domain controller connection due to the cluster being behind a DMZ. 
*  A workgroup or cross-domain cluster for which there is no Active Directory cluster name object (CNO). Find out more about these enhancements in the following post in Server & Management Blogs: [Failover Cluster File Share Witness and DFS](https://blogs.msdn.microsoft.com/clustering/2018/04/13/failover-cluster-file-share-witness-and-dfs/).

### Failover clustering: moving clusters between domains 
Moving a cluster from one domain to another has always been a daunting task because you must destroy the cluster to move it.  Depending on the roles in the cluster, that role must also be removed and recreated.  The following are two common scenarios:
* Company A purchases Company B and must move all servers to Company A's domain 
* A main office builds a cluster and ships it to another location 
We have added two new PowerShell commandlets to quickly take you from one domain to another without the need to destroy it.  For more information about this new capability, see [How to Switch a Failover Cluster to a New Domain](https://blogs.msdn.microsoft.com/clustering/2018/01/09/how-to-switch-a-failover-cluster-to-a-new-domain/) in Server & Management blogs. 

### Failover Cluster removing use of NTLM authentication

Windows Server Failover Clusters no longer use NTLM authentication by exclusively using Kerberos and certificate based authentication.  There are no changes required by the user, or deployment tools, to take advantage of this security enhancement. It also allows failover clusters to be deployed in environments where NTLM has been disabled. 

### System insights
System insights is a new feature available in Windows Server 2019 that brings local predictive analytics capabilities natively to Windows Server. These predictive capabilities—each backed by a machine-learning model—locally analyze Windows Server system data, such as performance counters and events, providing insight into the functioning of your deployments and helping you reduce the operational expenses associated with monitoring your Windows Server instances.

Because each of these capabilities runs locally, all your data is collected, persisted, and analyzed directly on your Windows Server instance, allowing you to use predictive analytics capabilities without any cloud connectivity. In Windows Server 2019, System insights introduces a set of capabilities focused on capacity forecasting, predicting future usage for compute, networking, and storage.

![System insights](media/system-insights.png "System insights")

You can manage system insights through an intuitive Windows Admin Center extension or directly through PowerShell, and system insights allows you to manage each capability individually. This includes configuring custom schedules to run each capability and adding remediation scripts to automatically address any issue detected by a capability.

You can add new predictive capabilities to system insights, without requiring any OS updates. This functionality enables developers, including Microsoft and third parties, to create and deliver new capabilities mid-release to address the scenarios you care about. New [developer documentation and resources](https://aka.ms/systeminsights-addcapabilities) are now available, which help you write your own custom capabilities.

Any new capability can integrate with and extend the existing system insights infrastructure:
* New capabilities can specify any performance counter or ETW event, which will be collected, persisted locally, and returned to the capability for analysis when the capability is invoked.
* New capabilities can leverage the existing Windows Admin Center and PowerShell management planes. Not only will new capabilities be discoverable in system insights, they also benefit from custom schedules and remediation actions.

In previous releases, system insights forecasted future usage for both local volumes and local storage consumption. After listening to the feedback from our cluster customers, we've added new functionality in this release, which allows you to optionally enable forecasting on clustered volumes and clustered storage. 

For more information about system insights, please visit [aka.ms/SystemInsights](https://aka.ms/SystemInsights).


### Congestion Control with LEDBAT

Keeping a network secure is a never-ending job for IT Pros, requiring regular updates to systems to protect against the latest threat vectors. This is one of the most common tasks that an IT Pro must perform. Unfortunately, it can result in dissatisfaction for end-users as the network bandwidth used for the update can compete with interactive tasks that the end-user requires to be productive.
With Windows Server 2019, we bring a latency optimized, network congestion control provider called LEDBAT which scavenges whatever network bandwidth is available on the network, and uses it.

For a full write up detailing this improvement, please see our announcement [LEDBAT – Latency Optimized Background Transport](https://blogs.technet.microsoft.com/networking/2018/07/25/ledbat/)



### Storage Migration Service

A common issue around Windows Server is a lack of data migration options from older operating systems and storage platforms. Many customers run Windows Server 2012 R2, Windows Server 2008 R2, or even Windows Server 2003 simply because in-place upgrades were impossible and manual data migrations were slow and likely to cause significant service interruption or even loss of access to users and applications.

Windows Server 2019 introduces the Storage Migration Service (SMS), a new role included in Windows Server Standard and Datacenter editions. SMS is a job-based orchestration and proxy that:
 
* Allows administrators to inventory existing servers for their data, security, and network settings.
* Migrates that data, security, and network settings to a new, modern target by using the SMB protocol.
* Takes over the identity of the old server completely, while decommissioning the original source, in such a way that users and applications are unaffected and unaware that migration has taken place. 

SMS provides orchestrated workflow with a Honolulu-based graphical management system, allowing scalable migrations of many servers simultaneously to new targets running on premises or in Azure.

![Scalable migrations](media/scalable-migrations.png "Scalable migrations")

SMS handles common problems and subtleties of a migration, including in-use files, share settings, security settings, network addresses and names, local security principals, encrypted data, and more. All of this is available from an intuitive graphical interface, which is backed by robust PowerShell automation.

SMS is under active development, and you will see many changes and improvements with each preview. Furthermore, the use of the Honolulu management system enables out-of-band changes through its extension manager system, allowing us to act on your feedback more frequently than the Windows Server preview mechanism allows.

For more information on deploying and using the Storage Migration Service, please visit [https://aka.ms/stormigser](https://aka.ms/stormigser)

### Storage Replica

__Storage Replica (SR)__ was first released as a technology for Windows Server 2016 Datacenter Edition. SR enables synchronous and asynchronous block replication of volumes between servers or clusters for disaster recovery. SR also enables you to create stretch failover clusters that span two sites, with all nodes staying in sync. 
Beginning with Windows Server 2019, responding to customer requests, we've added the following improvement to SR: 
 
Storage Replica Standard. SR is available on Windows Server 2019 Standard Edition, not just on Datacenter Edition. When installed on servers running Standard Edition, SR has the following limitations: 
 
*  SR replicates a single volume instead of an unlimited number of volumes.  
*  Volumes can have one partnership instead of an unlimited number of partners.  
*  Volumes can have a size of up to 2 TB instead of an unlimited size. 
 
We will continue to listen to your feedback and evaluate these settings through our telemetry during Insider previews of Windows Server 2019. These limitations may change several times during the preview phase and at RTM. 
For more information about Storage Replica, visit [http://aka.ms/StorageReplica](http://aka.ms/StorageReplica).  


### Shielded virtual machines – Offline mode, VMConnect and Linux support

You can now run [shielded virtual
machines](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms)
on machines with intermittent connectivity to the Host Guardian Service by leveraging the new fallback HGS and offline mode features. Fallback HGS allows you to configure a second set of URLs for Hyper-V to try if it can't reach your primary HGS server. To see how this can be used in a branch-office scenario, see [Improved branch office support for shielded VMs in Windows Server, version 1709](https://blogs.technet.microsoft.com/datacentersecurity/2017/11/15/improved-branch-office-support-for-shielded-vms-in-windows-server-version-1709/)
on our blog. [Offline mode](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-manage-branch-office#offline-mode)
allows you to continue to start up your shielded VMs, even if HGS can't be reached, as long as the VM has started successfully once, and the
host's security configuration has not changed. (To enable offline mode, run the following command on the Host Guardian Service:
**Set-HgsKeyProtectionConfiguration –AllowKeyMaterialCaching**.)

We've also made it easier to troubleshoot your shielded virtual machines by enabling support for VMConnect Enhanced Session Mode and PowerShell Direct. These tools are particularly useful if you've lost network connectivity to your VM and need to update its configuration to restore access. These features do not need to be configured, and they will automatically become available when a shielded VM is placed on a Hyper-V host running build 17040 or later.

For customers who run mixed-OS environments, we now support running Ubuntu, Red Hat Enterprise Linux, and SUSE Linux Enterprise Server
inside shielded virtual machines. Try it out—[Create a Linux shielded VM template disk](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-create-a-linux-shielded-vm-template)—and send us your feedback in the Feedback Hub.

### Microsoft Hyper-V 2019 Preview

Microsoft Hyper-V Server is a stand-alone product that contains only the Windows hypervisor, a Windows Server driver model, and virtualization components. It provides a simple and reliable virtualization solution to help you improve your server utilization and reduce costs.

The Windows hypervisor technology in Microsoft Hyper-V Server is the same as what's in the Hyper-V role on Windows Server. So, much of the content available for the Hyper-V role on Windows Server 2016 also applies to Microsoft Hyper-V Server.