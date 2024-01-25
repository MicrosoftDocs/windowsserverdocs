---
description: "Learn more about: Securing Domain Controllers Against Attack"
ms.assetid: ba28bd05-16e6-465f-982b-df49633cfde4
title: Securing Domain Controllers Against Attack
ms.author: joflore
author: MicrosoftGuyJFlo
ms.date: 04/10/2023
ms.topic: article
ms.reviewer: rickys
---
# Securing Domain Controllers Against Attack

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

*Law Number Three: If a bad guy has unrestricted physical access to your computer, it's not your computer anymore.* - [Ten Immutable Laws of Security (Version 2.0)](/security/zero-trust/ten-laws-of-security#immutable-laws-of-security-v2).

Domain controllers provide the physical storage for the Active Directory Domain Services (AD DS) database, in addition to providing the services and data that allow enterprises to effectively manage their servers, workstations, users, and applications. If privileged access to a domain controller is obtained by a malicious user, they can modify, corrupt, or destroy the AD DS database and, by extension, all of the systems and accounts that are managed by Active Directory.

Because domain controllers can read from and write to anything in the AD DS database, compromise of a domain controller means that your Active Directory forest can never be considered trustworthy again, unless you can recover using a known good backup and to close the gaps that allowed the compromise.

Depending on an attacker's preparation, tooling, and skill, irreparable damage can be completed in minutes to hours, not days or weeks. What matters isn't how long an attacker has privileged access to Active Directory, but how much the attacker has planned for the moment when privileged access is obtained. Compromising a domain controller can provide the most direct path to destruction of member servers, workstations, and Active Directory. Because of this threat, domain controllers should be secured separately and more stringently than the general infrastructure.

## Physical Security for Domain Controllers

This section provides information about physically securing domain controllers. Domain controllers may be physical or virtual machines, in datacenters, branch offices, or remote locations.

### Datacenter Domain Controllers

#### Physical Domain Controllers

In datacenters, physical domain controllers should be installed in dedicated secure racks or cages that are separate from the general server population. When possible, domain controllers should be configured with Trusted Platform Module (TPM) chips and all volumes in the domain controller servers should be protected via BitLocker Drive Encryption. BitLocker adds a small performance overhead in single-digit percentages, but protects the directory against compromise even if disks are removed from the server. BitLocker can also help protect systems against attacks such as rootkits because the modification of boot files will cause the server to boot into recovery mode so that the original binaries can be loaded. If a domain controller is configured to use software RAID, serial-attached SCSI, SAN/NAS storage, or dynamic volumes, BitLocker can’t be implemented, so locally attached storage (with or without hardware RAID) should be used in domain controllers whenever possible.

#### Virtual Domain Controllers

If you implement virtual domain controllers, you should ensure that domain controllers also run on separate physical hosts than other virtual machines in the environment. Even if you use a third-party virtualization platform, consider deploying virtual domain controllers on Hyper-V in Windows Server, which provides a minimal attack surface and can be managed with the domain controllers it hosts rather than being managed with the rest of the virtualization hosts. If you implement System Center Virtual Machine Manager (SCVMM) for management of your virtualization infrastructure, you can delegate administration for the physical hosts on which domain controller virtual machines reside and the domain controllers themselves to authorized administrators. You should also consider separating the storage of virtual domain controllers to prevent storage administrators from accessing the virtual machine files.

> [!NOTE]
> If you intend to co-locate virtualized domain controllers with other, less sensitive virtual machines on the same physical virtualization servers (hosts), consider implementing a solution which enforces role-based separation of duties, such as [Shielded VMs](../../../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) in Hyper-V. This technology provides comprehensive protection against malicious or clueless fabric administrators (including virtualization, network, storage and backup administrators.) It leverages physical root of trust with remote attestation and secure VM provisioning, and effectively ensures level of security which is on par with a dedicated physical server.

### Branch Locations

#### Physical Domain Controllers in branches

In locations where multiple servers reside but aren't physically secured to the degree that datacenter servers are secured, physical domain controllers should be configured with TPM chips and BitLocker Drive Encryption for all server volumes. If a domain controller can’t be stored in a locked room in branch locations, you should consider deploying Read-Only Domain Controllers (RODCs) in those locations.

#### Virtual Domain Controllers in branches

Whenever possible, you should run virtual domain controllers in branch offices on separate physical hosts than the other virtual machines in the site. In branch offices where virtual domain controllers can’t run on separate physical hosts from the rest of the virtual server population, you should implement TPM chips and BitLocker Drive Encryption on hosts on which virtual domain controllers run at minimum, and all hosts if possible. Depending on the size of the branch office and the security of the physical hosts, you should consider deploying RODCs in branch locations.

### Remote Locations with Limited Space and Security

If your infrastructure includes locations where only a single physical server can be installed, a server capable of running virtualization workloads should be installed, and BitLocker Drive Encryption should be configured to protect all volumes in the server. One virtual machine on the server should run as a RODC, with other servers running as separate virtual machines on the host. Information about planning for deployment of RODCs is provided in the [Read-Only Domain Controller Planning and Deployment Guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771744(v=ws.10)). For more information about deploying and securing virtualized domain controllers, see [Running Domain Controllers in Hyper-V](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd363553(v=ws.10)). For more detailed guidance for hardening the security of Hyper-V, delegating virtual machine management, and protecting virtual machines, see the [Hyper-V Security Guide](/windows-server/virtualization/hyper-v/plan/plan-hyper-v-security-in-windows-server) Solution Accelerator on the Microsoft website.

## Domain Controller Operating Systems

You should run all domain controllers on the newest version of Windows Server that is supported within your organization. Organizations should prioritize decommissioning legacy operating systems in the domain controller population. Keeping domain controllers current and eliminating legacy domain controllers, allows you to take advantage of new functionality and security. This functionality may not be available in domains or forests with domain controllers running legacy operating system.

> [!NOTE]
> As for any security-sensitive and single-purpose configuration, we recommend that you deploy the operating system in [Server Core](../../../../administration/server-core/what-is-server-core.md) installation option. It provides multiple benefits, such as minimizing attack surface, improving performance and reducing the likelihood of human error. It is recommended that all operations and management are performed **remotely,** from dedicated highly secured endpoints such as [Privileged access workstations (PAW)](/security/compass/privileged-access-devices) or [Secure administrative hosts](./implementing-secure-administrative-hosts.md).

## Secure Configuration of Domain Controllers

Tools can be used to create an initial security configuration baseline for domain controllers that can later be enforced by GPOs. These tools are described in [Administer security policy settings](/windows/security/threat-protection/security-policy-settings/administer-security-policy-settings) section of Microsoft operating systems documentation or [Desired State Configuration (DSC) for Windows](/powershell/dsc/overview).

### RDP Restrictions

Group Policy Objects that link to all domain controllers OUs in a forest should be configured to allow RDP connections only from authorized users and systems like jump servers. Control can be achieved through a combination of user rights settings and WFAS configuration implemented with GPOs so that the policy is consistently applied. If policy is bypassed, the next Group Policy refresh returns the system to its proper configuration.

### Patch and Configuration Management for Domain Controllers

Although it may seem counterintuitive, you should consider patching domain controllers and other critical infrastructure components separately from your general Windows infrastructure. If you use enterprise configuration management software for all computers in your infrastructure, compromise of the systems management software can be used to compromise or destroy all infrastructure components managed by that software. By separating patch and systems management for domain controllers from the general population, you can reduce the amount of software installed on domain controllers, in addition to tightly controlling their management.

### Blocking Internet Access for Domain Controllers

One of the checks that is performed as part of an Active Directory Security Assessment is the use and configuration of Internet Explorer on domain controllers. No web browser should be used on domain controllers. An analysis of thousands of domain controllers has revealed numerous cases where privileged users used Internet Explorer to browse the organization's intranet or the Internet.

As previously described in the "Misconfiguration" section of [Avenues to Compromise](../../../ad-ds/plan/security-best-practices/Avenues-to-Compromise.md), browsing the Internet or an infected intranet from one of the most powerful computers in a Windows infrastructure using a highly privileged account presents an extraordinary risk to an organization's security. Whether via a drive by download or by download of malware-infected "utilities," attackers can gain access to everything they need to completely compromise or destroy the Active Directory environment.

Although Windows Server and current versions of Internet Explorer offer many protections against malicious downloads, in most cases where domain controllers and privileged accounts had been used to browse the Internet, the domain controllers were running Windows Server 2003, or protections offered by newer operating systems and browsers had been intentionally disabled.

Launching web browsers on domain controllers should be restricted by policy and technical controls. Further to this, general Internet access to and from domain controllers should also be strictly controlled.

Microsoft encourages all organizations to move to a cloud-based approach to identity and access management and migrate from Active Directory to Microsoft Entra ID. Microsoft Entra ID is a complete cloud identity and access management solution for managing directories, enabling access to on-premises and cloud apps, and protecting identities from security threats. Microsoft Entra ID also offers a robust and granular set of security controls to help protect identities, such as multi-factor authentication, Conditional Access policies, Identity Protection, identity governance, and Privileged Identity Management.

Most organizations will operate in a hybrid identity model during their transition to the cloud, where some element of their on-premises Active Directory will be synchronized using Microsoft Entra Connect. Whilst this hybrid model exists in any organization, Microsoft recommends cloud powered protection of those on-premises identities using Microsoft Defender for Identity. The configuration of the Defender for Identity sensor on domain controllers and AD FS servers allows for a highly secured, one-way connection to the cloud service through a proxy and to specific endpoints. A complete explanation on how to configure this proxy connection can be found in the technical documentation for Defender for Identity. This tightly controlled configuration ensures that the risk of connecting these servers to the cloud service is mitigated, and organizations benefit from the increase in protection capabilities Defender for Identity offers. Microsoft also recommends that these servers are protected with cloud powered endpoint detection like Microsoft Defender for Servers.

For those organizations that have regulatory or other policy driven requirements to maintain an on-premises only implementation of Active Directory, Microsoft recommends entirely restricting internet access to and from domain controllers.

### Perimeter Firewall Restrictions

Perimeter firewalls should be configured to block outbound connections from domain controllers to the Internet. Although domain controllers may need to communicate across site boundaries, perimeter firewalls can be configured to allow intersite communication by following the guidelines provided in [How to configure a firewall for Active Directory domains and trusts](https://support.microsoft.com/kb/179442).

### Preventing Web Browsing from Domain Controllers

You can use a combination of AppLocker configuration, "black hole" proxy configuration, and WFAS configuration to prevent domain controllers from accessing the Internet and to prevent the use of web browsers on domain controllers.
