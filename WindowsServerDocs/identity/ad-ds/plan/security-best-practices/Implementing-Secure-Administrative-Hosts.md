---
ms.assetid: eafdddc3-40d7-4a75-8f4f-a45294aabfc8
title: Implementing Secure Administrative Hosts
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Implementing Secure Administrative Hosts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Secure administrative hosts are workstations or servers that have been configured specifically for the purposes of creating secure platforms from which privileged accounts can perform administrative tasks in Active Directory or on domain controllers, domain-joined systems, and applications running on domain-joined systems. In this case, "privileged accounts" refers not only to accounts that are members of the most privileged groups in Active Directory, but to any accounts that have been delegated rights and permissions that allow administrative tasks to be performed.  
  
These accounts may be Help Desk accounts that have the ability to reset passwords for most of the users in a domain, accounts that are used to administer DNS records and zones, or accounts that are used for configuration management. Secure administrative hosts are dedicated to administrative functionality, and they do not run software such as email applications, web browsers, or productivity software such as Microsoft Office.  
  
Although the "most privileged" accounts and groups should accordingly be the most stringently protected, this does not eliminate the need to protect any accounts and groups to which privileges above those of standard user accounts have been granted.  
  
A secure administrative host can be a dedicated workstation that is used only for administrative tasks, a member server that runs the Remote Desktop Gateway server role and to which IT users connect to perform administration of destination hosts, or a server that runs the Hyper-V role and provides a unique virtual machine for each IT user to use for their administrative tasks. In many environments, combinations of all three approaches may be implemented.  
  
Implementing secure administrative hosts requires planning and configuration that is consistent with your organization's size, administrative practices, risk appetite, and budget. Considerations and options for implementing secure administrative hosts are provided here for you to use in developing an administrative strategy suitable for your organization.  
  
## Principles for Creating Secure Administrative Hosts  
To effectively secure systems against attacks, a few general principles should be kept in mind:  
  
1.  You should never administer a trusted system (that is, a secure server such as a domain controller) from a less-trusted host (that is, a workstation that is not secured to the same degree as the systems it manages).  
  
2.  You should not rely on a single authentication factor when performing privileged activities; that is, user name and password combinations should not be considered acceptable authentication because only a single factor (something you know) is represented. You should consider where credentials are generated and cached or stored in administrative scenarios.  
  
3.  Although most attacks in the current threat landscape leverage malware and malicious hacking, do not omit physical security when designing and implementing secure administrative hosts.  
  
### Account Configuration  
Even if your organization does not currently use smart cards, you should consider implementing them for privileged accounts and secure administrative hosts. Administrative hosts should be configured to require smart card logon for all accounts by modifying the following setting in a GPO that is linked to the OUs containing administrative hosts:  
  
**Computer Configuration\Policies\Windows Settings\Local Policies\Security Options\Interactive logon: Require smart card**  
  
This setting will require all interactive logons to use a smart card, regardless of the configuration on an individual account in Active Directory.  
  
You should also configure secure administrative hosts to permit logons only by authorized accounts, which can be configured in:  
  
**Computer Configuration\Policies\Windows Settings\Local Policies\Security Settings\Local Policies\User Rights Assignment**  
  
This grants interactive (and, where appropriate, Remote Desktop Services) logon rights only to authorized users of the secure administrative host.  
  
### Physical Security  
For administrative hosts to be considered trustworthy, they must be configured and protected to the same degree as the systems they manage. Most of the recommendations provided in [Securing Domain Controllers Against Attack](../../../ad-ds/plan/security-best-practices/Securing-Domain-Controllers-Against-Attack.md) are also applicable to the hosts that are used to administer domain controllers and the AD DS database. One of the challenges of implementing secure administrative systems in most environments is that physical security can be more difficult to implement because these computers often reside in areas that are not as secure as servers hosted in datacenters, such as administrative users' desktops.  
  
Physical security includes controlling physical access to administrative hosts. In a small organization, this may mean that you maintain a dedicated administrative workstation that is kept locked in an office or a desk drawer when not in use. Or it may mean that when you need to perform administration of Active Directory or your domain controllers, you log on to the domain controller directly.  
  
In medium-sized organizations, you may consider implementing secure administrative "jump servers" that are located in a secured location in an office and are used when management of Active Directory or domain controllers is required. You may also implement administrative workstations that are locked in secure locations when not in use, with or without jump servers.  
  
In large organizations, you can deploy datacenter-housed jump servers that provide strictly controlled access to Active Directory; domain controllers; and file, print, or application servers. Implementation of a jump server architecture is most likely to include a combination of secure workstations and servers in large environments.  
  
Regardless of the size of your organization and the design of your administrative hosts, you should secure physical computers against unauthorized access or theft, and should use BitLocker Drive Encryption to encrypt and protect the drives on administrative hosts. By implementing BitLocker on administrative hosts, even if a host is stolen or its disks are removed, you can ensure that the data on the drive is inaccessible to unauthorized users.  
  
### Operating System Versions and Configuration  
All administrative hosts, whether servers or workstations, should run the newest operating system in use in your organization for the reasons described earlier in this document. By running current operating systems, your administrative staff benefits from new security features, full vendor support, and additional functionality introduced in the operating system. Moreover, when you are evaluating a new operating system, by deploying it first to administrative hosts, you will need to familiarize yourself with the new features, settings and management mechanisms it offers, which can subsequently be leveraged in planning broader deployment of the operating system. By then, the most sophisticated users in your organization will also be the users who are familiar with the new operating system and best positioned to support it.  
  
### Microsoft Security Configuration Wizard  
If you implement jump servers as part of your administrative host strategy, you should use the built-in Security Configuration Wizard to configure service, registry, audit, and firewall settings to reduce the server's attack surface. When the Security Configuration Wizard configuration settings have been collected and configured, the settings can be converted to a GPO that is used to enforce a consistent baseline configuration on all jump servers. You can further edit the GPO to implement security settings specific to jump servers, and can combine all of the settings with additional baseline settings extracted from the Microsoft Security Compliance Manager.  
  
### Microsoft Security Compliance Manager  
The [Microsoft Security Compliance Manager](https://technet.microsoft.com/library/cc677002.aspx) is a freely available tool that integrates security configurations that are recommended by Microsoft, based on operating system version and role configuration, and collects them in a single tool and UI that can be used to create and configure baseline security settings for domain controllers. Microsoft Security Compliance Manager templates can be combined with Security Configuration Wizard settings to produce comprehensive configuration baselines for jump servers that are deployed and enforced by GPOs deployed at the OUs in which jump servers are located in Active Directory.  
  
> [!NOTE]  
> As of this writing, the Microsoft Security Compliance Manager does not include settings specific to jump servers or other secure administrative hosts, but Security Compliance Manager (SCM) can still be used to create initial baselines for your administrative hosts. To properly secure the hosts, however, you should apply additional security settings appropriate to highly secured workstations and servers.  
  
### AppLocker  
Administrative hosts and virtual machinesshould be configured with script, tool, and application whitelists via AppLocker or a third-party application restriction software. Any administrative applications or utilities that do not adhere to secure settings should be upgraded or replaced with tooling that adheres to secure development and administrative practices. When new or additional tooling is needed on an administrative host, applications and utilities should be thoroughly tested, and if the tooling is suitable for deployment on administrative hosts, it can be added to the systems' whitelists.  
  
### RDP Restrictions  
Although the specific configuration will vary depending on the architecture of your administrative systems, you should include restrictions on which accounts and computers can be used to establish Remote Desktop Protocol (RDP) connections to managed systems, such as using Remote Desktop Gateway (RD Gateway) jump servers to control access to domain controllers and other managed systems from authorized users and systems.  
  
You should allow interactive logons by authorized users and should remove or even block other logon types that are not needed for server access.  
  
### Patch and Configuration Management  
Smaller organizations may rely on offerings such as Windows Update or [Windows Server Update Services](https://technet.microsoft.com/windowsserver/bb332157) (WSUS) to manage deployment of updates to Windows systems, while larger organizations may implement enterprise patch and configuration management software such as Microsoft Endpoint Configuration Manager. Regardless of the mechanisms you use to deploy updates to your general server and workstation population, you should consider separate deployments for highly secure systems such as domain controllers, certification authorities, and administrative hosts. By segregating these systems from the general management infrastructure, if your management software or service accounts are compromised, the compromise cannot be easily extended to the most secure systems in your infrastructure.  
  
Although you should not implement manual update processes for secure systems, you should configure a separate infrastructure for updating secure systems. Even in very large organizations, this infrastructure can usually be implemented via dedicated WSUS servers and GPOs for secured systems.  
  
### Blocking Internet Access  
Administrative hosts should not be permitted to access the Internet, nor should they be able to browse an organization's intranet. Web browsers and similar applications should not be permitted on administrative hosts. You can block Internet access for secure hosts via a combination of perimeter firewall settings, WFAS configuration, and "black hole" proxy configuration on secure hosts. You can also use application whitelisting to prevent web browsers from being used on administrative hosts.  
  
### Virtualization  
Where possible, consider implementing virtual machines as administrative hosts. Using virtualization, you can create per-user administrative systems that are centrally stored and managed, and which can be easily shut down when not in use, ensuring that credentials are not left active on the administrative systems. You can also require that virtual administrative hosts are reset to an initial snapshot after each use, ensuring that the virtual machines remain pristine. More information about options for virtualization of administrative hosts is provided in the following section.  
  
## Sample Approaches to Implementing Secure Administrative Hosts  
Regardless of how you design and deploy your administrative host infrastructure, you should keep in mind the guidelines provided in "Principles for Creating Secure Administrative Hosts" earlier in this topic. Each of the approaches described here provides general information about how you can separate "administrative" and "productivity" systems used by your IT staff. Productivity systems are computers that IT administrators employ to check email, browse the Internet, and to use general productivity software such as Microsoft Office. Administrative systems are computers that are hardened and dedicated to use for day-to-day administration of an IT environment.  
  
The simplest way to implement secure administrative hosts is to provide your IT staff with secured workstations from which they can perform administrative tasks. In a workstation-only implementation, each administrative workstation is used to launch management tools and RDP connections to manage servers and other infrastructure. Workstation-only implementations can be effective in smaller organizations, although larger, more complex infrastructures may benefit from a distributed design for administrative hosts in which dedicated administrative servers and workstations are used, as described in "Implementing Secure Administrative Workstations and Jump Servers" later in this topic.  
  
### Implementing Separate Physical Workstations  
One way that you can implement administrative hosts is to issue each IT user two workstations. One workstation is used with a "regular" user account to perform activities such as checking email and using productivity applications, while the second workstation is dedicated strictly to administrative functions.  
  
For the productivity workstation, the IT staff can be given regular user accounts rather than using privileged accounts to log on to unsecured computers. The administrative workstation should be configured with a stringently controlled configuration and the IT staff should use a different account to log on to the administrative workstation.  
  
If you have implemented smart cards, administrative workstations should be configured to require smart card logons, and IT staff should be given separate accounts for administrative use, also configured to require smart cards for interactive logon. The administrative host should be hardened as previously described, and only designated IT users should be allowed to log on locally to the administrative workstation.  
  
#### Pros  
By implementing separate physical systems, you can ensure that each computer is configured appropriately for its role and that IT users cannot inadvertently expose administrative systems to risk.  
  
#### Cons  
  
-   Implementing separate physical computers increases hardware costs.  
  
-   Logging on to a physical computer with credentials that are used to administer remote systems caches the credentials in memory.  
  
-   If administrative workstations are not stored securely, they may be vulnerable to compromise via mechanisms such as physical hardware key loggers or other physical attacks.  
  
### Implementing a Secure Physical Workstation with a Virtualized Productivity Workstation  
In this approach, IT users are given a secured administrative workstation from which they can perform day-to-day administrative functions, using Remote Server Administration Tools (RSAT) or RDP connections to servers within their scope of responsibility. When IT users need to perform productivity tasks, they can connect via RDP to a remote productivity workstation running as a virtual machine. Separate credentials should be used for each workstation, and controls such as smart cards should be implemented.  
  
#### Pros  
  
-   Administrative workstations and productivity workstations are separated.  
  
-   IT staff using secure workstations to connect to productivity workstations can use separate credentials and smart cards, and privileged credentials are not deposited on the less-secure computer.  
  
#### Cons  
  
-   Implementing the solution requires design and implementation work and robust virtualization options.  
  
-   If the physical workstations are not stored securely, they may be vulnerable to physical attacks that compromise the hardware or the operating system and make them susceptible to communications interception.  
  
### Implementing a Single Secure Workstation with Connections to Separate "Productivity" and "Administrative" Virtual Machines  
In this approach, you can issue IT users a single physical workstation that is locked down as previously described, and on which IT users do not have privileged access. You can provide Remote Desktop Services connections to virtual machines hosted on dedicated servers, providing IT staff with one virtual machine that runs email and other productivity applications, and a second virtual machine that is configured as the user's dedicated administrative host.  
  
You should require smart card or other multifactor logon for the virtual machines, using separate accounts other than the account that is used to log on to the physical computer. After an IT user logs on to a physical computer, they can use their productivity smart card to connect to their remote productivity computer and a separate account and smart card to connect to their remote administrative computer.  
  
#### Pros  
  
-   IT users can use a single physical workstation.  
  
-   By requiring separate accounts for the virtual hosts and using Remote Desktop Services connections to the virtual machines, IT users' credentials are not cached in memory on the local computer.  
  
-   The physical host can be secured to the same degree as administrative hosts, reducing the likelihood of compromise of the local computer.  
  
-   In cases in which an IT user's productivity virtual machine or their administrative virtual machine may have been compromised, the virtual machine can easily be reset to a "known good" state.  
  
-   If the physical computer is compromised, no privileged credentials will be cached in memory, and the use of smart cards can prevent compromise of credentials by keystroke loggers.  
  
#### Cons  
  
-   Implementing the solution requires design and implementation work and robust virtualization options.  
  
-   If the physical workstations are not stored securely, they may be vulnerable to physical attacks that compromise the hardware or the operating system and make them susceptible to communications interception.  
  
### Implementing Secure Administrative Workstations and Jump Servers  
As an alternative to secure administrative workstations, or in combination with them, you can implement secure jump servers, and administrative users can connect to the jump servers using RDP and smart cards to perform administrative tasks.  
  
Jump servers should be configured to run the Remote Desktop Gateway role to allow you to implement restrictions on connections to the jump server and to destination servers that will be managed from it. If possible, you should also install the Hyper-V role and create [Personal Virtual Desktops](https://technet.microsoft.com/library/dd759174.aspx) or other per-user virtual machines for administrative users to use for their tasks on the jump servers.  
  
By giving the administrative users per-user virtual machines on the jump server, you provide physical security for the administrative workstations, and administrative users can reset or shut down their virtual machines when not in use. If you prefer not to install the Hyper-V role and the Remote Desktop Gateway role on the same administrative host, you can install them on separate computers.  
  
Wherever possible, remote administration tools should be used to manage servers. The Remote Server Administration Tools (RSAT) feature should be installed on the users' virtual machines (or the jump server if you are not implementing per-user virtual machines for administration), and administrative staff should connect via RDP to their virtual machines to perform administrative tasks.  
  
In cases when an administrative user must connect via RDP to a destination server to manage it directly, RD Gateway should be configured to allow the connection to be made only if the appropriate user and computer are used to establish the connection to the destination server. Execution of RSAT (or similar) tools should be prohibited on systems that are not designated management systems, such as general-use workstations and member servers that are not jump servers.  
  
#### Pros  
  
-   Creating jump servers allows you to map specific servers to "zones" (collections of systems with similar configuration, connection, and security requirements) in your network and to require that the administration of each zone is achieved by administrative staff connecting from secure administrative hosts to a designated "zone" server.  
  
-   By mapping jump servers to zones, you can implement granular controls for connection properties and configuration requirements, and can easily identify attempts to connect from unauthorized systems.  
  
-   By implementing per-administrator virtual machines on jump servers, you enforce shutdown and resetting of the virtual machines to a known clean state when administrative tasks are completed. By enforcing shutdown (or restart) of the virtual machines when administrative tasks are completed, the virtual machines cannot be targeted by attackers, nor are credential theft attacks feasible because memory-cached credentials do not persist beyond a reboot.  
  
#### Cons  
  
-   Dedicated servers are required for jump servers, whether physical or virtual.  
  
-   Implementing designated jump servers and administrative workstations requires careful planning and configuration that maps to any security zones configured in the environment.  
  


