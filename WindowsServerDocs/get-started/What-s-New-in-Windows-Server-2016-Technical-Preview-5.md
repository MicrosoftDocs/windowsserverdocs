---
title: What's New in Windows Server 2016
description: "What are the new features in compute, identity, management, automation, networking, security, storage."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 10/10/2016
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2827f332-44d4-4785-8b13-98429087dcc7
author: jaimeo
ms.author: jaimeo
manager: dongill
---
# What's New in Windows Server 2016
>Applies To: Windows Server 2016

The content in this section describes what's new and changed in Windows Server&reg; 2016. The new features and changes listed here are the ones most likely to have the greatest impact as you work with this release. There are several new additions in each of these areas: [Compute](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_Compute), [Identity](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_Identity), [Management and Automation](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_ManagAuto), [Networking](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_Networking), [Security](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_Security), and [Storage](What-s-New-in-Windows-Server-2016-Technical-Preview-5.md#BKMK_Storage).  
   
  
## <a name="BKMK_Compute"></a>Compute  
The Compute area includes virtualization products and features for the IT professional to design, deploy, and maintain Windows Server.  
  
### General  
Physical and virtual machines benefit from greater time accuracy due to improvements in the Win32 Time and Hyper-V Time Synchronization Services. Windows Server can now host services that are compliant with upcoming regulations which require a 1ms accuracy with regards to UTC.  
  
### Hyper-V  
-   [What's new in Hyper-V on Windows Server 2016](../compute/hyper-v/What-s-new-in-Hyper-V-on-Windows.md). This topic explains the new and changed functionality of the Hyper-V role in Windows Server 2016, Client Hyper-V running on Windows 10, and Microsoft Hyper-V Server 2016.  
  
-   [Windows Containers](https://msdn.microsoft.com/virtualization/windowscontainers/containers_welcome):  Windows Server 2016 container support adds performance improvements, simplified network management, and support for Windows containers on Windows 10. For some additional information on containers, see [Containers: Docker, Windows and Trends](http://azure.microsoft.com/blog/2015/08/17/containers-docker-windows-and-trends/).  
  
### Nano Server  
What's New in [Nano Server](https://technet.microsoft.com/library/mt126167.aspx). Nano Server now has an updated module for building Nano Server images, including more separation of physical host and guest virtual machine functionality as well as support for different Windows Server editions.   

There are also improvements to the Recovery Console, including separation of inbound and outbound firewall rules as well as the ability to repair configuration of WinRM.  
  
### Remote Desktop Services  
[Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](../compute/remote-desktop-services/Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md). Deploying a highly available RDS deployment lets you leverage Azure SQL Database for your RD Connection Brokers in high availability mode.  
  
## <a name="BKMK_Identity"></a>Identity and Access  
New features in Identity improve the ability for organizations to secure Active Directory environments and help them migrate to cloud-only deployments and hybrid deployments, where some applications and services are hosted in the cloud and others are hosted on premises.  
  
### Active Directory Certificate Services  
What's New in Active Directory Certificate Services. Active Directory Certificate Services (AD CS) in Windows Server 2016 increases support for TPM key attestation: You can now use Smart Card KSP for key attestation, and devices that are not joined to the domain can now use NDES enrollment to get certificates that can be attested for keys being in a TPM.  
  
### Active Directory Domain Services  
Active Directory Domain Services includes improvements to help organizations secure Active Directory environments and provide better identity management experiences for both corporate and personal devices. For more information, see [What's new in Active Directory Domain Services (AD DS) in Windows Server 2016](https://technet.microsoft.com/library/mt163897.aspx).   
  
### Active Directory Federation Services  
What's New in Active Directory Federation Services. Active Directory Federation Services (AD FS) in Windows Server 2016 includes new features that enable you to configure AD FS to authenticate users stored in Lightweight Directory Access Protocol (LDAP) directories. For more information, see   [What's New in AD FS for Windows Server 2016](../identity/ad-fs/overview/whats-new-active-directory-federation-services-windows-server-2016.md).  
  
### Web Application Proxy  
The latest version of Web Application Proxyfocuses on new features that enable publishing and preauthentication for more applications and improved user experience. Check out the full list of new features that includes preauthentication for rich client apps such as Exchange ActiveSync and wildcard domains for easier publishing of SharePoint apps. For more information, see [What's New in Web Application Proxy in Windows Server 2016](https://technet.microsoft.com/library/dn765473.aspx).  
  
##  <a name="BKMK_ManagAuto"></a>Management and Automation  
The Management and Automation area focuses on tool and reference information for IT pros who want to run and manage Windows Server 2016, including Windows PowerShell.  
  
Windows PowerShell 5.0 includes significant new features, including support for developing with classes and new security features that extend its use, improve its usability, and allow you to control and manage Windows-based environments more easily and comprehensively. See [Windows Management Framework (WMF) 5.0 RTM Release Notes Overview](https://msdn.microsoft.com/powershell/wmf/5.0/releasenotes) for details. 

New additions for Windows Server 2016 include: the ability to run PowerShell.exe locally on Nano Server (no longer remote only), new Local Users & Groups cmdlets to replace the GUI, added PowerShell debugging support, and added support in Nano Server for security logging & transcription and JEA.   
  
## <a name="BKMK_Networking"></a>Networking  
This area addresses networking products and features for the IT professional to design, deploy, and maintain Windows Server 2016.  
  
### Software-Defined Networking
You can now both mirror and route traffic to new or existing virtual appliances. Together with a distributed firewall and Network security groups, this enables you to dynamically segment and secure workloads in a manner similar to Azure. Second, you can deploy and manage the entire Software-defined networking (SDN) stack using System Center Virtual Machine Manager. Finally, you can use Docker to manage Windows Server container networking, and associate SDN policies not only with virtual machines but containers as well. For more information, see [Plan Software Defined Networking Deployment](https://technet.microsoft.com/library/mt605207.aspx).

### TCP performance improvements
The default Initial Congestion Window (ICW) has been increased from 4 to 10 and TCP Fast Open (TFO) has been implemented. TFO reduces the amount of time required to establish a TCP connection and the increased ICW allows larger objects to be transferred in the initial burst. This combination can significantly reduce the time required to transfer an Internet object between the client and the cloud.

In order to improve TCP behavior when recovering from packet loss we have implemented TCP Tail Loss Probe (TLP) and Recent Acknowledgement (RACK). TLP helps convert Retransmit TimeOuts (RTOs) to Fast Recoveries and RACK reduces the time required for Fast Recovery to retransmit a lost packet.  
  
## <a name="BKMK_Security"></a>Security  
Includes security solutions and features for the IT professional to deploy in your datacenter and cloud environment. For information about security in Windows Server 2016 generally, see [Security and Assurance](https://technet.microsoft.com/library/mt130644.aspx).  
  
### Just Enough Administration  
Just Enough Administration in Windows Server 2016 is security technology that enables delegated administration for anything that can be managed with Windows PowerShell. Capabilities include support for running under a network identity, connecting over PowerShell Direct, securely copying files to or from JEA endpoints, and configuring the PowerShell console to launch in a JEA context by default For more details, see [JEA on GitHub](http://aka.ms/JEA).

### Credential Guard
Credential Guard uses virtualization-based security to isolate secrets so that only privileged system software can access them. See [Protect derived domain credentials with Credential Guard] (https://technet.microsoft.com/itpro/windows/keep-secure/credential-guard).

###  Remote Credential Guard
Credential Guard includes support for RDP sessions so that the user credentials remain on the client side and are not exposed on the server side. This also provides Single Sign On for Remote Desktop. See [Protect Remote Desktop credentials with Remote Credential Guard] (https://technet.microsoft.com/itpro/windows/keep-secure/remote-credential-guard).   
  
### Device Guard (Code Integrity)
Device Guard provides kernel mode code integrity (KMCI) and user mode code integrity (UMCI) by creating policies that specify what code can run on the server. See [Introduction to Device Guard: virtualization-based security and code integrity policies] (https://technet.microsoft.com/itpro/windows/keep-secure/introduction-to-device-guard-virtualization-based-security-and-code-integrity-policies).

### Shielded Virtual Machines  
Windows Server 2016 provides a new Hyper-V-based Shielded Virtual Machine to protect any Generation 2 virtual machine from a compromised fabric. Among the features introduced in Windows Server 2016 are the following:  
  
- New "Encryption Supported" mode that offers more protections than for an ordinary virtual machine, but less than "Shielded" mode, while still supporting vTPM, disk encryption, Live Migration traffic encryption, and other features, including direct fabric administration conveniences such as virtual machine console connections and Powershell Direct.  
  
- Full support for converting existing non-shielded Generation 2 virtual machines to shielded virtual machines, including automated disk encryption.

- Hyper-V Virtual Machine Manager can now view the fabrics upon which a shielded virtual is authorized to run, providing a way for the fabric administrator to open a shielded virtual machine's key protector (KP) and view the fabrics it is permitted to run on.  
  
- You can switch Attestation modes on a running Host Guardian Service. Now you can switch on the fly between the less secure but simpler Active Directory-based attestation and TPM-based attestation.  
  
- End-to-end diagnostics tooling based on Windows PowerShell that is able to detect misconfigurations or errors in both guarded Hyper-V hosts and the Host Guardian Service.  
  
- A recovery environment that offers a means to securely troubleshoot and repair shielded virtual machines within the fabric in which they normally run while offering the same level of protection as the shielded virtual machine itself.

- Host Guardian Service support for existing safe Active Directory – you can direct the Host Guardian Service to use an existing Active Directory forest as its Active Directory instead of creating its own Active Directory instance 
  
For more details and instructions for working with shielded virtual machines, see [Shielded VMs and Guarded Fabric Validation Guide for Windows Server 2016 (TPM)](http://aka.ms/shieldedvms).  
  
### Windows Defender  
[Windows Defender Overview for Windows Server 2016](../security/windows-defender/windows-defender-overview-windows-server.md). Windows Server Antimalware is installed and enabled by default in Windows Server 2016, but the user interface for Windows Server Antimalware is not installed. However, Windows Server Antimalware will update antimalware definitions and protect the computer without the user interface. If you need the user interface for Windows Server Antimalware, you can install it after the operating system installation by using the Add Roles and Features Wizard.

### Control Flow Guard
Control Flow Guard (CFG) is a platform security feature that was created to combat memory corruption vulnerabilities. See [Control Flow Guard] (https://msdn.microsoft.com/library/windows/desktop/mt637065(v=vs.85).aspx) for more information. 
  
  
## <a name="BKMK_Storage"></a>Storage  
This area covers storage products and features for the IT professional to design, deploy, and maintain Windows Server 2016.  
  
-   [What's New in Storage in Windows Server 2016](../storage/whats-new-in-storage.md). In Windows Server 2016, enhancements include simplification, manageability, and smaller scale Storage Spaces Direct. The new Health Service continues to improve the day-to-day monitoring, operations, and maintenance experience of Storage Spaces Direct. Storage Replica brings flexibility by expanding stretch clusters to asynchronous support, delegation of administration, and improved efficiency with support for thinly provisioned storage.

- Windows Server 2016 enables the use of persistent memory devices in the form of NVDIMM-N. NVDIMMs provide a persistent storage medium with near-DRAM speeds and reside on the memory bus, significantly reducing I/O latencies.

    Through enhancements in NTFS, Windows Server 2016 is able to grant applications direct access (DAX) to the byte-ranges of an NVDIMM and fully unlock the potential of this technology.

    These videos provide more information:

- [Using Non-volatile Memory (NVDIMM-N) as Block Storage in Windows Server 2016](https://channel9.msdn.com/Events/Build/2016/P466)
- [Using Non-volatile Memory (NVDIMM-N) as Byte-Addressable Storage in Windows Server 2016](https://channel9.msdn.com/Events/Build/2016/P470)
- [Accelerating SQL Server 2016 peformance with Persistent Memory in Windows Server 2016](https://channel9.msdn.com/Shows/Data-Exposed/SQL-Server-2016-and-Windows-Server-2016-SCM--FAST)

    To learn more about health management of NVDIMM-N devices in Windows, see [Storage-class Memory (NVDIMM-N) Health Management in Windows](https://technet.microsoft.com/windows-server-docs/storage/storage-spaces/storage-class-memory-health).  
  
-   [What's New in Failover Clustering in Windows Server 2016](../failover-clustering/whats-new-in-failover-clustering.md). In Windows Server 2016, new additions include VM Node Fairness to seamless load balancing of Virtual Machines (VMs) across the nodes in a cluster, VM Start Order introduces start order orchestration for virtual machines (and all groups) in a cluster, and Simplified SMB Multi-channel and Multi-NIC Cluster Networks to make it easier to set up high speed networks on Scale-out File Servers.  
  
## See Also  
-   [Release Notes: Important Issues in Windows Server 2016](Windows-Server-2016-GA-Release-Notes.md)  
  

