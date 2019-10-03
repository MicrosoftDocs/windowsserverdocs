---
ms.assetid: ba28bd05-16e6-465f-982b-df49633cfde4
title: Securing Domain Controllers Against Attack
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 06/18/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Securing Domain Controllers Against Attack

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

*Law Number Three: If a bad guy has unrestricted physical access to your computer, it's not your computer anymore.* - [Ten Immutable Laws of Security (Version 2.0)](https://technet.microsoft.com/security/hh278941.aspx)  
  
Domain controllers provide the physical storage for the AD DS database, in addition to providing the services and data that allow enterprises to effectively manage their servers, workstations, users, and applications. If privileged access to a domain controller is obtained by a malicious user, that user can modify, corrupt, or destroy the AD DS database and, by extension, all of the systems and accounts that are managed by Active Directory.  
  
Because domain controllers can read from and write to anything in the AD DS database, compromise of a domain controller means that your Active Directory forest can never be considered trustworthy again unless you are able to recover using a known good backup and to close the gaps that allowed the compromise in the process.  
  
Depending on an attacker's preparation, tooling, and skill, modification or even irreparable damage to the AD DS database can be completed in minutes to hours, not days or weeks. What matters isn't how long an attacker has privileged access to Active Directory, but how much the attacker has planned for the moment when privileged access is obtained. Compromising a domain controller can provide the most expedient path to wide scale propagation of access, or the most direct path to destruction of member servers, workstations, and Active Directory. Because of this, domain controllers should be secured separately and more stringently than the general Windows infrastructure.  

## Physical Security for Domain Controllers

This section provides information about physically securing domain controllers, whether the domain controllers are physical or virtual machines, in datacenter locations, branch offices, and even remote locations with only basic infrastructure controls.  
  
### Datacenter Domain Controllers  
  
#### Physical Domain Controllers

In datacenters, physical domain controllers should be installed in dedicated secure racks or cages that are separate from the general server population. When possible, domain controllers should be configured with Trusted Platform Module (TPM) chips and all volumes in the domain controller servers should be protected via BitLocker Drive Encryption. BitLocker generally adds performance overhead in single-digit percentages, but protects the directory against compromise even if disks are removed from the server. BitLocker can also help protect systems against attacks such as rootkits because the modification of boot files will cause the server to boot into recovery mode so that the original binaries can be loaded. If a domain controller is configured to use software RAID, serial-attached SCSI, SAN/NAS storage, or dynamic volumes, BitLocker cannot be implemented, so locally attached storage (with or without hardware RAID) should be used in domain controllers whenever possible.  
  
#### Virtual Domain Controllers 

If you implement virtual domain controllers, you should ensure that domain controllers run on separate physical hosts than other virtual machines in the environment. Even if you use a third-party virtualization platform, consider deploying virtual domain controllers on Hyper-V Server in Windows Server 2012 or Windows Server 2008 R2, which provides a minimal attack surface and can be managed with the domain controllers it hosts rather than being managed with the rest of the virtualization hosts. If you implement System Center Virtual Machine Manager (SCVMM) for management of your virtualization infrastructure, you can delegate administration for the physical hosts on which domain controller virtual machines reside and the domain controllers themselves to authorized administrators. You should also consider separating the storage of virtual domain controllers to prevent storage administrators from accessing the virtual machine files.  
  
### Branch Locations  
  
#### Physical Domain Controllers in branches

In locations in which multiple servers reside but are not physically secured to the degree that datacenter servers are secured, physical domain controllers should be configured with TPM chips and BitLocker Drive Encryption for all server volumes. If a domain controller cannot be stored in a locked room in branch locations, you should consider deploying RODCs in those locations.  
  
#### Virtual Domain Controllers in branches

Whenever possible, you should run virtual domain controllers in branch offices on separate physical hosts than the other virtual machines in the site. In branch offices in which virtual domain controllers cannot run on separate physical hosts from the rest of the virtual server population, you should implement TPM chips and BitLocker Drive Encryption on hosts on which virtual domain controllers run at minimum, and all hosts if possible. Depending on the size of the branch office and the security of the physical hosts, you should consider deploying RODCs in branch locations.  
  
### Remote Locations with Limited Space and Security

If your infrastructure includes locations in which only a single physical server can be installed, a server capable of running virtualization workloads should be installed in the remote location, and BitLocker Drive Encryption should be configured to protect all volumes in the server. One virtual machine on the server should run an RODC, with other servers running as separate virtual machines on the host. Information about planning for deployment of RODC is provided in the [Read-Only Domain Controller Planning and Deployment Guide](https://go.microsoft.com/fwlink/?LinkID=135993). For more information about deploying and securing virtualized domain controllers, see [Running Domain Controllers in Hyper-V](https://technet.microsoft.com/library/dd363553(v=ws.10).aspx) on the TechNet website. For more detailed guidance for hardening Hyper-V, delegating virtual machine management, and protecting virtual machines, see the [Hyper-V Security Guide](https://www.microsoft.com/download/details.aspx?id=16650) Solution Accelerator on the Microsoft website.  
  
## Domain Controller Operating Systems

You should run all domain controllers on the newest version of Windows Server that is supported within your organization and prioritize decommissioning of legacy operating systems in the domain controller population. By keeping your domain controllers current and eliminating legacy domain controllers, you can often take advantage of new functionality and security that may not be available in domains or forests with domain controllers running legacy operating system. Domain controllers should be freshly installed and promoted rather than upgraded from previous operating systems or server roles; that is, do not perform in-place upgrades of domain controllers or run the AD DS Installation Wizard on servers on which the operating system is not freshly installed. By implementing freshly installed domain controllers, you ensure that legacy files and settings are not inadvertently left on domain controllers, and you simplify the enforcement of consistent, secure domain controller configuration.  
  
## Secure Configuration of Domain Controllers

A number of freely available tools, some of which are installed by default in Windows, can be used to create an initial security configuration baseline for domain controllers that can subsequently be enforced by GPOs. These tools are described here.  
  
### Security Configuration Wizard  

All domain controllers should be locked down upon initial build. This can be achieved using the Security Configuration Wizard that ships natively in Windows Server to configure service, registry, system, and WFAS settings on a "base build" domain controller. Settings can be saved and exported to a GPO that can be linked to the Domain Controllers OU in each domain in the forest to enforce consistent configuration of domain controllers. If your domain contains multiple versions of Windows operating systems, you can configure Windows Management Instrumentation (WMI) filters to apply GPOs only to the domain controllers running the corresponding version of the operating system.  
  
### Microsoft Security Compliance Toolkit

[Microsoft Security Compliance Toolkit](https://www.microsoft.com/download/details.aspx?id=55319) domain controller settings can be combined with Security Configuration Wizard settings to produce comprehensive configuration baselines for domain controllers that are deployed and enforced by GPOs deployed at the Domain Controllers OU in Active Directory.  
  
### RDP Restrictions

Group Policy Objects that link to all domain controllers OUs in a forest should be configured to allow RDP connections only from authorized users and systems (for example, jump servers). This can be achieved through a combination of user rights settings and WFAS configuration and should be implemented in GPOs so that the policy is consistently applied. If it is bypassed, the next Group Policy refresh returns the system to its proper configuration.  
  
### Patch and Configuration Management for Domain Controllers

Although it may seem counterintuitive, you should consider patching domain controllers and other critical infrastructure components separately from your general Windows infrastructure. If you leverage enterprise configuration management software for all computers in your infrastructure, compromise of the systems management software can be used to compromise or destroy all infrastructure components managed by that software. By separating patch and systems management for domain controllers from the general population, you can reduce the amount of software installed on domain controllers, in addition to tightly controlling their management.
  
### Blocking Internet Access for Domain Controllers  

One of the checks that is performed as part of an Active Directory Security Assessment is the use and configuration of Internet Explorer on domain controllers. Internet Explorer (or any other web browser) should not be used on domain controllers, but analysis of thousands of domain controllers has revealed numerous cases in which privileged users used Internet Explorer to browse the organization's intranet or the Internet.  
  
As previously described in the "Misconfiguration" section of [Avenues to Compromise](../../../ad-ds/plan/security-best-practices/Avenues-to-Compromise.md), browsing the Internet (or an infected intranet) from one of the most powerful computers in a Windows infrastructure using a highly privileged account (which are the only accounts permitted to log on locally to domain controllers by default) presents an extraordinary risk to an organization's security. Whether via a drive by download or by download of malware-infected "utilities," attackers can gain access to everything they need to completely compromise or destroy the Active Directory environment.  
  
Although Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, and current versions of Internet Explorer offer a number of protections against malicious downloads, in most cases in which domain controllers and privileged accounts had been used to browse the Internet, the domain controllers were running Windows Server 2003, or protections offered by newer operating systems and browsers had been intentionally disabled.  
  
Launching web browsers on domain controllers should be prohibited not only by policy, but by technical controls, and domain controllers should not be permitted to access the Internet. If your domain controllers need to replicate across sites, you should implement secure connections between the sites. Although detailed configuration instructions are outside the scope of this document, you can implement a number of controls to restrict the ability of domain controllers to be misused or misconfigured and subsequently compromised.  
  
### Perimeter Firewall Restrictions

Perimeter firewalls should be configured to block outbound connections from domain controllers to the Internet. Although domain controllers may need to communicate across site boundaries, perimeter firewalls can be configured to allow intersite communication by following the guidelines provided in [How to configure a firewall for domains and trusts](https://support.microsoft.com/kb/179442) on the Microsoft Support website.  
  
### DC Firewall Configurations  

As described earlier, you should use the Security Configuration Wizard to capture configuration settings for the Windows Firewall with Advanced Security on domain controllers. You should review the output of Security Configuration Wizard to ensure that the firewall configuration settings meet your organization's requirements, and then use GPOs to enforce configuration settings.  
  
### Preventing Web Browsing from Domain Controllers

You can use a combination of AppLocker configuration, "black hole" proxy configuration, and WFAS configuration to prevent domain controllers from accessing the Internet and to prevent the use of web browsers on domain controllers.
