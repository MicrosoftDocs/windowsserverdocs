---
title: Why Privileged Access Workstations can help secure your organization
description: How PAW can increase your organization's security posture

ms.prod: windows-server
ms.topic: article
ms.assetid: 93589778-3907-4410-8ed5-e7b6db406513
ms.date: 03/13/2019

ms.author: joflore
author: MicrosoftGuyJFlo
manager: daveba
ms.reviewer: mas
---
# Privileged Access Workstations

>Applies To: Windows Server

Privileged Access Workstations (PAWs) provide a dedicated operating system for sensitive tasks that is protected from Internet attacks and threat vectors. Separating these sensitive tasks and accounts from the daily use workstations and devices provides very strong protection from phishing attacks, application and OS vulnerabilities, various impersonation attacks, and credential theft attacks such as keystroke logging, [Pass-the-Hash](https://aka.ms/pth), and Pass-The-Ticket.

## What is a Privileged Access Workstation?

In simplest terms, a PAW is a hardened and locked down workstation designed to provide high security assurances for sensitive accounts and tasks.  PAWs are recommended for administration of identity systems, cloud services, and private cloud fabric as well as sensitive business functions.

> [!NOTE]
> The PAW architecture doesn't require a 1:1 mapping of accounts to workstations, though this is a common configuration. PAW creates a trusted workstation environment that can be used by one or more accounts.

In order to provide the greatest security, PAWs should always run the most up-to-date and secure operating system available: Microsoft strongly recommends Windows 10 Enterprise, which includes several additional security features not available in other editions (in particular, [Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx) and [Device Guard](https://technet.microsoft.com/library/dn986865(v=vs.85).aspx)).

> [!NOTE]
> Organizations without access to Windows 10 Enterprise can use Windows 10 Pro, which includes many of the critical foundational technologies for PAWs, including Trusted Boot, BitLocker, and Remote Desktop.  Education customers can use Windows 10 Education.  Windows 10 Home should not be used for a PAW.
>
> For a comparison matrix of the different editions of Windows 10, read [this article](https://www.microsoft.com/WindowsForBusiness/Compare).

The PAW security controls are focused on mitigating high impact and high probability risks of compromise. These include mitigating attacks on the environment and risks that can decrease the effectiveness of PAW controls over time:

* **Internet attacks** - Most attacks originate directly or indirectly from internet sources and use the internet for exfiltration and command and control (C2). Isolating the PAW from the open internet is a key element to ensuring the PAW is not compromised.
* **Usability risk** - If a PAW is too difficult to use for daily tasks, administrators will be motivated to create workarounds to make their jobs easier. Frequently, these workarounds open the administrative workstation and accounts to significant security risks, so it's critical to involve and empower the PAW users to mitigate these usability issues securely. This can be accomplished by listening to their feedback, installing tools and scripts required to perform their jobs, and ensuring all administrative personnel are aware of why they need to use a PAW, what a PAW is, and how to use it correctly and successfully.
* **Environment risks** - Because many other computers and accounts in the environment are exposed to internet risk directly or indirectly, a PAW must be protected against attacks from compromised assets in the production environment. This requires minimizing the use of management tools and accounts that have access to the PAWs to secure and monitor these specialized workstations.
* **Supply chain tampering** - While it's impossible to remove all possible risks of tampering in the supply chain for hardware and software, taking a few key actions can mitigate critical attack vectors that are readily available to attackers. This includes validating the integrity of all installation media ([Clean Source Principle](https://aka.ms/cleansource)) and using a trusted and reputable supplier for hardware and software.
* **Physical attacks** - Because PAWs can be physically mobile and used outside of physically secure facilities, they must be protected against attacks that leverage unauthorized physical access to the computer.

> [!NOTE]
> A PAW will not protect an environment from an adversary that has already gained administrative access over an Active Directory Forest.
> Because many existing implementations of Active Directory Domain Services have been operating for years at risk of credential theft, organizations should assume breach and consider the possibility that they may have an undetected compromise of domain or enterprise administrator credentials. An organization that suspects domain compromise should consider the use of professional incident response services.
>
> For more information on response and recovery guidance, see the "Respond to suspicious activity" and "Recover from a breach" sections of [Mitigating Pass-the-Hash and Other Credential Theft](https://aka.ms/pth), version 2.
>
> Visit [Microsoft's Incident Response and Recovery services](https://www.microsoft.com/microsoftservices/campaigns/cybersecurity-protection.aspx) page for more information.

### PAW hardware profiles

Administrative personnel are standard users too - they need a PAW as well as a standard user workstation to check email, browse the web, and access corporate line of business applications.  Ensuring that administrators can remain both productive and secure is essential to the success of any PAW deployment.  A secure solution that dramatically limits productivity will be abandoned by the users in favor of one that enhances productivity (even if it is done in an insecure manner).

In order to balance the need for security with the need for productivity, Microsoft recommends using one of these PAW hardware profiles:

* **Dedicated hardware** - Separate dedicated devices for user tasks vs. administrative tasks.
* **Simultaneous Use** - Single device that can run user tasks and administrative tasks concurrently by taking advantage of OS or presentation virtualization.

Organizations may use only one profile or both. There are no interoperability concerns between the hardware profiles, and organizations have the flexibility to match the hardware profile to the specific need and situation of a given administrator.

> [!NOTE]
> It is critical that, in all these scenarios, administrative personnel are issued a standard user account that is separate from designated administrative account(s). The administrative account(s) should only be used on the PAW administrative operating system.

This table summarizes the relative advantages and disadvantages of each hardware profile from the perspective of operational ease-of-use and productivity and security.  Both hardware approaches provide strong security for administrative accounts against credential theft and reuse.

|**Scenario**|**Advantages**|**Disadvantages**|
|--------|---------|-----------|
|Dedicated hardware|-   Strong signal for sensitivity of tasks<br />-   Strongest security separation|-   Additional desk space<br />-   Additional weight (for remote work)<br />-   Hardware Cost|
|Simultaneous use|-   Lower hardware cost<br />-   Single device experience|-   Sharing single keyboard/mouse creates risk of inadvertent errors/risks|

This guidance contains the detailed instructions for the PAW configuration for the dedicated hardware approach. If you have requirements for the simultaneous use hardware profiles, you can adapt the instructions based on this guidance yourself or hire a professional services organization like Microsoft to assist with it.

#### Dedicated hardware

In this scenario, a PAW is used for administration that is completely separate from the PC that is used for daily activities like email, document editing, and development work. All administrative tools and applications are installed on the PAW and all productivity applications are installed on the standard user workstation. The step by step instructions in this guidance are based on this hardware profile.

#### Simultaneous use - Adding a local user VM

In this simultaneous use scenario, a single PC is used for both administration tasks and daily activities like email, document editing, and development work. In this configuration, the user operating system is available while disconnected (for editing documents and working on locally cached email), but requires hardware and support processes that can accommodate this disconnected state.

![Diagram showing single PC  in a simultaneous use scenario used for both administration tasks and daily activities like email, document editing, and development work](../media/privileged-access-workstations/PAWFig10.JPG)

The physical hardware runs two operating systems locally:

* **Admin OS** - The physical host runs Windows 10 on the PAW host for Administrative tasks
* **User OS** - A Windows 10 client Hyper-V virtual machine guest runs a corporate image

With Windows 10 Hyper-V, a guest virtual machine (also running Windows 10) can have a rich user experience including sound, video, and Internet communications applications such as  Skype for Business.

In this configuration, daily work that does not require administrative privileges is done in the user OS virtual machine which has a regular corporate Windows 10 image and is not subject to restrictions applied to the PAW host. All administrative work is done on the Admin OS.

To configure this, follow the instructions in this guidance for the PAW host, add Client Hyper-V features, create a User VM, and then install a Windows 10 corporate image on the User VM.

Read [Client Hyper-V](https://docs.microsoft.com/virtualization/hyper-v-on-windows/index) article for more information about this capability. Please note that the operating system in guest virtual machines will need to be licensed per [Microsoft product licensing](https://www.microsoft.com/Licensing/product-licensing/products.aspx), also described [here](https://download.microsoft.com/download/9/8/D/98D6A56C-4D79-40F4-8462-DA3ECBA2DC2C/Licensing_Windows_Desktop_OS_for_Virtual_Machines.pdf).

#### Simultaneous use - Adding RemoteApp, RDP, or a VDI

In this simultaneous use scenario, a single PC is used for both administration tasks and daily activities like email, document editing and development work. In this configuration, the user operating systems are deployed and managed centrally (on the cloud or in your datacenter), but aren't available while disconnected.

![Figure showing a single PC in a simultaneous use scenario used for both administration tasks and daily activities like email, document editing and development work](../media/privileged-access-workstations/PAWFig11.JPG)

The physical hardware runs a single PAW operating system locally for administrative tasks and contacts a Microsoft or 3rd party remote desktop service for user applications such as email, document editing, and line of business applications.

In this configuration, daily work that does not require administrative privileges is done in the Remote OS(es) and applications which are not subject to restrictions applied to the PAW host. All administrative work is done on the Admin OS.

To configure this, follow the instructions in this guidance for the PAW host, allow network connectivity to the Remote Desktop services, and then add shortcuts to the PAW user's desktop to access the applications. The remote desktop services could be hosted in many ways including:

* An existing Remote Desktop or VDI service (on-premises or in the cloud)
* A new service you install on-premises or in the cloud
* Azure RemoteApp using pre-configured Office 365 templates or your own installation images

For more information on Azure RemoteApp, visit [this page](https://www.remoteapp.windowsazure.com).

## How Microsoft is using administrative workstations

Microsoft uses the PAW architectural approach both internally on our systems as well as with our customers. Microsoft uses administrative workstations internally in several capacities including administration of Microsoft IT infrastructure, Microsoft cloud fabric infrastructure development and operations, and other high value assets.

This guidance is directly based on the Privileged Access Workstation (PAW) reference architecture deployed by our cybersecurity professional services teams to protect customers against cybersecurity attacks. The administrative workstations are also a key element of the strongest protection for domain administration tasks, the Enhanced Security Administrative Environment (ESAE) administrative forest reference architecture.

For more details on the ESAE administrative forest, see the *ESAE Administrative Forest Design Approach* section in [Securing Privileged Access Reference Material](../securing-privileged-access/securing-privileged-access-reference-material.md#esae-administrative-forest-design-approach).

## Architecture overview

The diagram below depicts a separate "channel" for administration (a highly sensitive task) that is created by maintaining separate dedicated administrative accounts and workstations.

![Diagram showing a separate "channel" for administration (a highly sensitive task) that is created by maintaining separate dedicated administrative accounts and workstations](../media/privileged-access-workstations/PAWFig1.JPG)

This architectural approach builds on the protections found in the Windows 10 [Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx) and [Device Guard](https://technet.microsoft.com/library/dn986865(v=vs.85).aspx) features and goes beyond those protections for sensitive accounts and tasks.

This methodology is appropriate for accounts with access to high value assets:

* **Administrative Privileges** - PAWs provide increased security for high impact IT administrative roles and tasks. This architecture can be applied to administration of many types of systems including Active Directory Domains and Forests, Microsoft Azure Active Directory tenants, Office 365 tenants, Process Control Networks (PCN), Supervisory Control and Data Acquisition (SCADA) systems, Automated Teller Machines (ATMs), and Point of Sale (PoS) devices.
* **High Sensitivity Information workers** - The approach used in a PAW can also provide protection for highly sensitive information worker tasks and personnel such as those involving pre-announcement Merger and Acquisition activity, pre-release financial reports, organizational social media presence, executive communications, unpatented trade secrets, sensitive research, or other proprietary or sensitive data. This guidance does not discuss the configuration of these information worker scenarios in depth or include this scenario in the technical instructions.

    > [!NOTE]
    > Microsoft IT uses PAWs (internally referred to as "secure admin workstations", or SAWs) to manage secure access to internal high-value systems within Microsoft. This guidance has additional details below on PAW usage at Microsoft in the section "How Microsoft uses admin workstations". For more detailed information on this high value asset environment approach, please refer to the article, [Protecting high-value assets with secure admin workstations](https://msdn.microsoft.com/library/mt186538.aspx).

This document will describe why this practice is recommended for protecting high impact privileged accounts, what these PAW solutions look like for protecting administrative privileges, and how to quickly deploy a PAW solution for domain and cloud services administration.

This document provides detailed guidance for implementing several PAW configurations and includes detailed implementation instructions to get you started on protecting common high impact accounts:

* [**Phase 1 - Immediate Deployment for Active Directory Administrators**](#phase-1-immediate-deployment-for-active-directory-administrators) this provides a PAW quickly that can protect on premises domain and forest administration roles
* [**Phase 2 - Extend PAW to all administrators**](#phase-2-extend-paw-to-all-administrators) this enables protection for administrators of cloud services like Office 365 and Azure, enterprise servers, enterprise applications, and workstations
* [**Phase 3 - Advanced PAW security**](#phase-3-extend-and-enhance-protection) this discusses additional protections and considerations for PAW security

### Why dedicated workstations?

The current threat environment for organizations is rife with sophisticated phishing and other internet attacks that create continuous risk of security compromise for internet exposed accounts and workstations.

This threat environment requires organizations to adopt an "assume breach" security posture when designing protections for high value assets like administrative accounts and sensitive business assets. These high value assets need to be protected against both direct internet threats as well as attacks mounted from other workstations, servers, and devices in the environment.

![Figure showing the risk to managed assets if an attacker gains control of a user workstation where sensitive credentials are used](../media/privileged-access-workstations/PAWFig2.JPG)

This figure depicts risk to managed assets if an attacker gains control of a user workstation where sensitive credentials are used.

An attacker in control of an operating system has numerous ways in which to illicitly gain access to all activity on the workstation and impersonate the legitimate account. A variety of known and unknown attack techniques can be used to gain this level of access. The increasing volume and sophistication of cyberattacks have made it necessary to extend that separation concept to completely separate client operating systems for sensitive accounts. For more information on these types of attacks, please visit the [Pass The Hash web site](https://www.microsoft.com/pth) for informative white papers, videos and more.

The PAW approach is an extension of the well-established recommended practice to use separate admin and user accounts for administrative personnel. This practice uses an individually assigned administrative account that is completely separate from the user's standard user account. PAW builds on that account separation practice by providing a trustworthy workstation for those sensitive accounts.

This PAW guidance is intended to help you implement this capability for protecting high value accounts such as high-privileged IT administrators and high sensitivity business accounts. The guidance helps you:

* Restrict exposure of credentials to only trusted hosts
* Provide a high-security workstation to administrators so they can easily perform administrative tasks.

Restricting the sensitive accounts to using only hardened PAWs is a straightforward protection for these accounts that is both highly usable for administrators and very difficult for an adversary to defeat.

### Alternate approaches

This section contains information on how the security of alternate approaches compares to PAW and how to correctly integrate these approaches within a PAW architecture. all these approaches carry significant risks when implemented in isolation, but can add value to a PAW implementation in some scenarios.

#### Credential Guard and Windows Hello for Business

Introduced in Windows 10, [Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx) uses hardware and virtualization-based security to mitigate common credential theft attacks, such as Pass-the-Hash, by protecting the derived credentials. The private key for credentials used by [Windows Hello for Business](https://aka.ms/passport) can be also be protected by Trusted Platform Module (TPM) hardware.

These are powerful mitigations, but workstations can still be vulnerable to certain attacks even if the credentials are protected by Credential Guard or Windows Hello for Business. Attacks can include abusing privileges and use of credentials directly from a compromised device, reusing previously stolen credentials prior to enabling Credential Guard and abuse of management tools and weak application configurations on the workstation.

The PAW guidance in this section includes the use of many of these technologies for high sensitivity accounts and tasks.

#### Administrative VM

An administrative virtual machine (Admin VM) is a dedicated operating system for administrative tasks hosted on a standard user desktop. While this approach is similar to PAW in providing a dedicated OS for administrative tasks, it has a fatal flaw in that the administrative VM is dependent on the standard user desktop for its security.

The diagram below depicts the ability of attackers to follow the control chain to the target object of interest with an Admin VM on a User Workstation and that it is difficult to create a path on the reverse configuration.

The PAW architecture does not allow for hosting an Admin VM on a User Workstation, but a User VM with a standard corporate image can be hosted on an Admin PAW to provide personnel with a single PC for all responsibilities.

![Diagram of the PAW architecture](../media/privileged-access-workstations/PAWFig9.JPG)

#### Shielded VM-based PAWs

A secure variant of the administrative VM model is to use [shielded virtual machines](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) to host one or more admin VMs alongside a user VM.
Shielded VMs are designed to run secure workloads in an environment where potentially untrusted users or code may be running on the physical machine's standard user desktop.
A shielded VM has a virtual TPM which allows it to encrypt its own data at rest, and several administrative controls such as basic console access, PowerShell Direct, and the ability to debug the VM are disabled to further isolate the VM from the standard user desktop and other VMs.
The keys for a shielded VM are stored on a trusted key management server, which requires the physical device to attest to its identity and health before releasing a key to start the VM.
This ensures that shielded VMs can only start on the intended devices and that those devices are running known and trusted software configurations.

Because the shielded VMs are isolated from each other and the standard user desktop, it is acceptable to run multiple shielded PAW VMs on a single host, even when those admin VMs manage different tiers.

See the [deploy PAWs using a guarded fabric](#deploy-paws-using-a-guarded-fabric) section below for more information.

#### Jump server

Administrative "Jump Server" architectures set up a small number administrative console servers and restrict personnel to using them for administrative tasks. This is typically based on remote desktop services, a 3rd-party presentation virtualization solution, or a Virtual Desktop Infrastructure (VDI) technology.

This approach is frequently proposed to mitigate risk to administration and does provide some security assurances, but the jump server approach by itself is vulnerable to certain attacks because it violates the ["clean source" principle](../securing-privileged-access/securing-privileged-access-reference-material.md#clean-source-principle). The clean source principle requires all security dependencies to be as trustworthy as the object being secured.

![Figure showing a simple control relationship](../media/privileged-access-workstations/PAWFig3.JPG)

This figure depicts a simple control relationship. Any subject in control of an object is a security dependency of that object. If an adversary can control a security dependency of a target object (subject), they can control that object.

The administrative session on the jump server relies on the integrity of the local computer accessing it. If this computer is a user workstation subject to phishing attacks and other internet-based attack vectors, then the administrative session is also subject to those risks.

![Figure showing how attackers can follow an established control chain to the target object of interest](../media/privileged-access-workstations/PAWFig4.JPG)

The figure above depicts how attackers can follow an established control chain to the target object of interest.

While some advanced security controls like multi-factor authentication can increase the difficulty of an attacker taking over this administrative session from the user workstation, no security feature can fully protect against technical attacks when an attacker has administrative access of the source computer (e.g. injecting illicit commands into a legitimate session, hijacking legitimate processes, and so on.)

The default configuration in this PAW guidance installs administrative tools on the PAW, but a jump server architecture can also be added if required.

![Figure showing how reversing the control relationship and accessing user apps from an admin workstation gives the attacker no path to the targeted object](../media/privileged-access-workstations/PAWFig5.JPG)

This figure shows how reversing the control relationship and accessing user apps from an admin workstation gives the attacker no path to the targeted object. The user jump server is still exposed to risk so appropriate protective controls, detective controls, and response processes should still be applied for that internet-facing computer.

This configuration requires administrators to follow operational practices closely to ensure that they don't accidentally enter administrator credentials into the user session on their desktop.

![Figure showing how accessing an administrative jump server from a PAW adds no path for the attacker into the administrative assets](../media/privileged-access-workstations/PAWFig6.JPG)

This figure shows how accessing an administrative jump server from a PAW adds no path for the attacker into the administrative assets. A jump server with a PAW allows in this case you to consolidate the number of locations for monitoring administrative activity and distributing administrative applications and tools. This adds some design complexity, but can simplify security monitoring and software updates if a large number of accounts and workstations are used in your PAW implementation. The jump server would need to be built and configured to similar security standards as the PAW.

#### Privilege management solutions

Privileged Management solutions are applications that provide temporary access to discrete privileges or privileged accounts on demand. Privilege management solutions are an extremely valuable component of a complete strategy to secure privileged access and provide critically important visibility and accountability of administrative activity.

These solutions typically use a flexible workflow to grant access and many have additional security features and capabilities like service account password management and integration with administrative jump servers. There are many solutions on the market that provide privilege management capabilities, one of which is Microsoft Identity Manager (MIM) privileged access management (PAM).

Microsoft recommends using a PAW to access privilege management solutions. Access to these solutions should be granted only to PAWs. Microsoft does not recommend using these solutions as a substitute for a PAW because accessing privileges using these solutions from a potentially compromised user desktop violates the [clean source](https://aka.ms/cleansource) principle as depicted in the diagram below:

![Diagram showing how Microsoft does not recommend using these solutions as a substitute for a PAW because accessing privileges using these solutions from a potentially compromised user desktop violates the clean source principle](../media/privileged-access-workstations/PAWFig7.JPG)

Providing a PAW to access these solutions enables you to gain the security benefits of both PAW and the privilege management solution, as depicted in this diagram:

![Diagram showing how providing a PAW to access these solutions enables you to gain the security benefits of both PAW and the privilege management solution](../media/privileged-access-workstations/PAWFig8.JPG)

> [!NOTE]
> These systems should be classified at the highest tier of the privilege they manage and be protected at or above that level of security. These are commonly configured to manage Tier 0 solutions and Tier 0 assets and should be classified at Tier 0.
> For more information on the tier model, see [https://aka.ms/tiermodel](https://aka.ms/tiermodel) For more information on Tier 0 groups, see Tier 0 equivalency in [Securing Privileged Access Reference Material](../securing-privileged-access/securing-privileged-access-reference-material.md).

For more information on deploying Microsoft Identity Manager (MIM) privileged access management (PAM), see [https://aka.ms/mimpamdeploy](https://aka.ms/mimpamdeploy)

## PAW Scenarios

This section contains guidance on which scenarios this PAW guidance should be applied to. In all scenarios, administrators should be trained to only use PAWs for performing support of remote systems. To encourage successful and secure usage, all PAW users should be also be encouraged to provide feedback to improve the PAW experience and this feedback should be reviewed carefully for integration with your PAW program.

In all scenarios, additional hardening in later phases and different hardware profiles in this guidance may be used to meet the usability or security requirements of the roles.

> [!NOTE]
> This guidance explicitly differentiates between requiring access to specific services on the internet (such as Azure and Office 365 administrative portals) and the "Open Internet" of all hosts and services.

See the [Tier model page](https://aka.ms/tiermodel) for more information on the Tier designations.

|**Scenarios**|**Use PAW?**|**Scope and Security Considerations**|
|---------|--------|---------------------|
|Active Directory Admins - Tier 0|Yes|A PAW built with Phase 1 guidance is sufficient for this role.<br /><br />-   An administrative forest can be added to provide the strongest protection for this scenario. For more information on the ESAE administrative forest, see [ESAE Administrative Forest Design Approach](../securing-privileged-access/securing-privileged-access-reference-material.md#esae-administrative-forest-design-approach)<br />-   A PAW can be used to managed multiple domains or multiple forests.<br />-   If Domain Controllers are hosted on an Infrastructure as a Service (IaaS) or on-premises virtualization solution, you should prioritize implementing PAWs for the administrators of those solutions.|
|Admin of Azure IaaS and PaaS services - Tier 0 or Tier 1 (see Scope and Design Considerations)|Yes|A PAW built using the guidance provided in Phase 2 is sufficient for this role.<br /><br />-   PAWs should be used for at least the Global administrator and Subscription Billing administrator. You should also use PAWs for delegated administrators of critical or sensitive servers.<br />-   PAWs should be used for managing the operating system and applications that provide Directory Synchronization and Identity Federation for cloud services such as [Azure AD Connect](https://azure.microsoft.com/documentation/articles/active-directory-aadconnect/) and Active Directory Federation Services (ADFS).<br />-   The outbound network restrictions must allow connectivity only to authorized cloud services using the guidance in Phase 2. No open internet access should be allowed from PAWs.<br />-   Windows Defender Exploit Guard should be configured on the workstation **Note:**     A subscription is considered to be Tier 0 for a Forest if Domain Controllers or other Tier 0 hosts are in the subscription. A subscription is Tier 1 if no Tier 0 servers are hosted in Azure.|
|Admin Office 365 Tenant <br />- Tier 1|Yes|A PAW built using the guidance provided in Phase 2 is sufficient for this role.<br /><br />-   PAWs should be used for at least the Subscription Billing administrator, Global administrator, Exchange administrator, SharePoint administrator, and User management administrator roles. You should also strongly consider the use of PAWs for delegated administrators of highly critical or sensitive data.<br />-   Windows Defender Exploit Guard should be configured on the workstation.<br />-   The outbound network restrictions must allow connectivity only to Microsoft services using the guidance in Phase 2. No open internet access should be allowed from PAWs.|
|Other IaaS or PaaS cloud service admin<br />- Tier 0 or Tier 1 (see Scope and Design Considerations)|Yes|A PAW built using the guidance provided in Phase 2 is sufficient for this role.<br /><br />-   PAWs should be used for any role that has administrative rights over cloud hosted VMs including the ability to install agents, export hard disk files, or access storage where hard drives with operating systems, sensitive data, or business critical data is stored.<br />-   The outbound network restrictions must allow connectivity only to Microsoft services using the guidance in Phase 2. No open internet access should be allowed from PAWs.<br />-   Windows Defender Exploit Guard should be configured on the workstation. **Note:** A subscription is Tier 0 for a Forest if Domain Controllers or other Tier 0 hosts are in the subscription. A subscription is Tier 1 if no Tier 0 servers are hosted in Azure.|
|Virtualization Administrators<br />- Tier 0 or Tier 1 (see Scope and Design Considerations)|Yes|A PAW built using the guidance provided in Phase 2 is sufficient for this role.<br /><br />-   PAWs should be used for any role that has administrative rights over VMs including the ability to install agents, export virtual hard disk files, or access storage where hard drives with guest operating system information, sensitive data, or business critical data is stored. **Note:** A virtualization system (and its admins) are considered Tier 0 for a Forest if Domain Controllers or other Tier 0 hosts are in the subscription. A subscription is Tier 1 if no Tier 0 servers are hosted in the virtualization system.|
|Server Maintenance Admins<br />- Tier 1|Yes|A PAW built using the guidance provided in Phase 2 is sufficient for this role.<br /><br />-   A PAW should be used for administrators that update, patch, and troubleshoot enterprise servers and apps running Windows server, Linux, and other operating systems.<br />-   Dedicated management tools may need to be added for PAWs to handle the larger scale of these admins.|
|User Workstation Admins <br />- Tier 2|Yes|A PAW built using guidance provided in Phase 2 is sufficient for roles that have administrative rights on end user devices (such as helpdesk and deskside support roles).<br /><br />-   Additional applications may need to be installed on PAWs to enable ticket management and other support functions.<br />-   Windows Defender Exploit Guard should be configured on the workstation.<br />    Dedicated management tools may need to be added for PAWs to handle the larger scale of these admins.|
|SQL, SharePoint, or line of business (LOB) Admin<br />- Tier 1|Yes|A PAW built with Phase 2 guidance is sufficient for this role.<br /><br />-   Additional management tools may need to be installed on PAWs to allow administrators to manage applications without needing to connect to servers using Remote Desktop.|
|Users Managing Social Media Presence|Partially|A PAW built using the guidance provided in Phase 2 can be used as a starting point to provide security for these role.<br /><br />-   Protect and manage social media accounts using Azure Active Directory (AAD) for sharing, protecting, and tracking access to social media accounts.<br />    For more information on this capability read [this blog post](https://blogs.technet.com/b/ad/archive/2015/02/20/azure-ad-automated-password-roll-over-for-facebook-twitter-and-linkedin-now-in-preview.aspx).<br />-   The outbound network restrictions must allow connectivity to these services. This can be done by allowing open internet connections (much higher security risk that negates many PAW assurances) or by allowing only required DNS addresses for the service (may be challenging to obtain).|
|Standard Users|No|While many hardening steps can be used for standard users, PAW is designed to isolate accounts from the open internet access that most users require for job duties.|
|Guest VDI/Kiosk|No|While many hardening steps can be used for a kiosk system for guests, the PAW architecture is designed to provide higher security for high sensitivity accounts, not higher security for lower sensitivity accounts.|
|VIP User (Executive, Researcher, etc.)|Partially|A PAW built using guidance provided in Phase 2 can be used as a starting point to provide security for these roles.<br /><br />-   This scenario is similar to a standard user desktop, but typically has a smaller, simpler, and well-known application profile. This scenario typically requires discovering and protecting sensitive data, services, and applications (which may or may not be installed on the desktops).<br />-   These roles typically require a high degree of security and very high degree of usability, which require design changes to meet user preferences.|
|Industrial control systems (e.g. SCADA, PCN, and DCS)|Partially|A PAW built using guidance provided in Phase 2 can be used as a starting point to provide security for these roles as most ICS consoles (including such common standards as SCADA and PCN) don't require browsing the open Internet and checking email.<br /><br />-   Applications used for controlling physical machinery would have to be integrated and tested for compatibility and protected appropriately.|
|Embedded Operating System|No|While many hardening steps from PAW can be used for embedded operating systems, a custom solution would need to be developed for hardening in this scenario.|

> [!NOTE]
> **Combination scenarios** some personnel may have administrative responsibilities that span multiple scenarios.
> In these cases, the key rules to keep in mind are that the Tier model rules must always be followed. See the Tier model page for more information.

> [!NOTE]
> **Scaling the PAW Program** as your PAW program scales to encompass more admins and roles, you need to continue to ensure that you maintain adherence to the security standards and usability. This may require you to update your IT support structures or create new ones to resolve PAW specific challenges such as PAW onboarding process, incident management, configuration management, and gathering feedback to address usability challenges.  One example may be that your organization decides to enable work-from-home scenarios for administrators, which would necessitate a shift from desktop PAWs to laptop PAWs - a shift which may necessitate additional security considerations.  Another common example is to create or update training for new administrators - training which must now include content on the appropriate use of a PAW (including why its important and what a PAW is and isn't).  For more considerations which must be addressed as you scale your PAW program, see Phase 2 of the instructions.

This guidance contains the detailed instructions for the PAW configuration for the scenarios as noted above. If you have requirements for the other scenarios, you can adapt the instructions based on this guidance yourself or hire a professional services organization like Microsoft to assist with it.

For more information on engaging Microsoft services to design a PAW tailored for your environment, contact your Microsoft representative or visit [this page](https://www.microsoft.com/microsoftservices/campaigns/cybersecurity-protection.aspx).

## PAW Phased implementation

Because the PAW must provide a secure and trusted source for administration, it's essential that the build process is secure and trusted.  This section will provide detailed instructions which will allow you to build your own PAW using general principles and concepts very similar to those used by Microsoft IT and Microsoft cloud engineering and service management organizations.

The instructions are divided into three phases which focus on putting the most critical mitigations in place quickly and then progressively increasing and expanding the usage of PAW for the enterprise.

* [Phase 1 - Immediate Deployment for Active Directory Administrators](#phase-1-immediate-deployment-for-active-directory-administrators)
* [Phase 2 - Extend PAW to all administrators](#phase-2-extend-paw-to-all-administrators)
* [Phase 3 - Advanced PAW security](#phase-3-extend-and-enhance-protection)

It is important to note that the phases should always be performed in order even if they are planned and implemented as part of the same overall project.

### Phase 1: Immediate deployment for Active Directory administrators

Purpose: Provides a PAW quickly that can protect on-premises domain and forest administration roles.

Scope: Tier 0 Administrators including Enterprise Admins, Domain Admins (for all domains), and administrators of other authoritative identity systems.

Phase 1 focuses on the administrators who manage your on-premises Active Directory domain, which are critically important roles frequently targeted by attackers. These identity systems will work effectively for protecting these admins whether your Active Directory Domain Controllers (DCs) are hosted in on-premises datacenters, on Azure Infrastructure as a Service (IaaS), or another IaaS provider.

During this phase, you will create the secure administrative Active Directory organizational unit (OU) structure to host your privileged access workstation (PAW), as well as deploy the PAWs themselves.  This structure also includes the group policies and groups required to support the PAW.  You will create most of the structure using PowerShell scripts which are available at [TechNet Gallery](https://aka.ms/pawmedia).

The scripts will create the following OUs and Security Groups:

* Organizational Units (OU)
   * Six new top-level OUs:  Admin; Groups; Tier 1 Servers; Workstations; User Accounts; and Computer Quarantine.  Each top-level OU will contain several child OUs.
* Groups
   * Six new security-enabled global groups:  Tier 0 Replication Maintenance; Tier 1 Server Maintenance; Service Desk Operators; Workstation Maintenance; PAW Users; PAW Maintenance.

You will also create several group policy objects: PAW Configuration - Computer; PAW Configuration - User; RestrictedAdmin Required - Computer; PAW Outbound Restrictions; Restrict Workstation Logon; Restrict Server Logon.

Phase 1 includes the following steps:

#### Complete the Prerequisites

1. **Ensure that all administrators use separate, individual accounts for administration and end user activities** (including email, Internet browsing, line-of-business applications, and other non-administrative activities).  Assigning an administrative account to each authorized personnel separate from their standard user account is fundamental to the PAW model, as only certain accounts will be permitted to log onto the PAW itself.

   > [!NOTE]
   > Each administrator should use his or her own account for administration.  Do not share an administrative account.

2. **Minimize the number of Tier 0 privileged administrators**.  Because each administrator must use a PAW, reducing the number of administrators reduces the number of PAWs required to support them and the associated costs. The lower count of administrators also results in lower exposure of these privileges and associated risks. While it is possible for administrators in one location to share a PAW, administrators in separate physical locations will require separate PAWs.
3. **Acquire hardware from a trusted supplier that meets all technical requirements**. Microsoft recommends acquiring hardware that meets the technical requirements in the article [Protect domain credentials with Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx).

   > [!NOTE]
   > PAW installed on hardware without these capabilities can provide significant protections, but advanced security features such as Credential Guard and Device Guard will not be available.  Credential Guard and Device Guard are not required for Phase 1 deployment, but are strongly recommended as part of Phase 3 (advanced hardening).
   >
   > Ensure that the hardware used for the PAW is sourced from a manufacturer and supplier whose security practices are trusted by the organization. This is an application of the clean source principle to supply chain security.
   >
   > For more background on the importance of supply chain security, visit [this site](https://www.microsoft.com/security/cybersecurity/).

4. **Acquire and validate the required Windows 10 Enterprise Edition and application software**. Obtain the software required for PAW and validate it using the guidance in [Clean Source for installation media](https://aka.ms/cleansource).

   * Windows 10 Enterprise Edition
   * [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=45520) for Windows 10
   * [Windows 10 Security Baselines](https://aka.ms/win10baselines)

      > [!NOTE]
      > Microsoft publishes MD5 hashes for all operating systems and applications on MSDN, but not all software vendors provide similar documentation.  In those cases, other strategies will be required.  For additional information on validating software, please refer to [Clean Source](https://aka.ms/cleansource) for installation media.

5. **Ensure you have WSUS server available on the intranet**. You will need a WSUS server on the intranet to download and install updates for PAW. This WSUS server should be configured to automatically approve all security updates for Windows 10 or an administrative personnel should have responsibility and accountability to rapidly approve software updates.

   > [!NOTE]
   > For more information, see the "Automatically Approve Updates for Installation" section in the [Approving Updates guidance](https://technet.microsoft.com/library/cc708458(v=ws.10).aspx).

#### Deploy the Admin OU Framework to host the PAWs

1. Download the PAW script library from [TechNet Gallery](https://aka.ms/PAWmedia)

   > [!NOTE]
   > Download all the files and save them to the same directory, and run them in the order specified below.  Create-PAWGroups depends on the OU structure created by Create-PAWOUs, and Set-PAWOUDelegation depends on the groups created by Create-PAWGroups.
   > Do not modify any of the scripts or the comma-separated value (CSV) file.

2. **Run the Create-PAWOUs.ps1 script**.  This script will create the new organizational unit (OU) structure in Active Directory, and block GPO inheritance on the new OUs as appropriate.
3. **Run the Create-PAWGroups.ps1 script**.  This script will create the new global security groups in the appropriate OUs.

   > [!NOTE]
   > While this script will create the new security groups, it will not populate them automatically.

4. **Run the Set-PAWOUDelegation.ps1 script**.  This script will assign permissions to the new OUs to the appropriate groups.

#### Move Tier 0 accounts to the Admin\Tier 0\Accounts OU

Move each account that is a member of the Domain Admin, Enterprise Admin, or Tier 0 equivalent groups (including nested membership) to this OU. If your organization has your own groups that are added to these groups, you should move these to the Admin\Tier 0\Groups OU.

   > [!NOTE]
   > For more information on which groups are Tier 0, see "Tier 0 Equivalency" in [Securing Privileged Access Reference Material](../securing-privileged-access/securing-privileged-access-reference-material.md).

#### Add the appropriate members to the relevant groups

1. **PAW Users** - Add the Tier 0 administrators with Domain or Enterprise Admin groups that you identified in Step 1 of Phase 1.
2. **PAW Maintenance** - Add at least one account that will be used for PAW maintenance and troubleshooting tasks. The PAW Maintenance Account(s) will be used only rarely.

   > [!NOTE]
   > Do not add the same user account or group to both PAW Users and PAW Maintenance.  The PAW security model is based partly on the assumption that the PAW user account has privileged rights on managed systems or over the PAW itself, but not both.
   >
   > * This is important for building good administrative practices and habits in Phase 1.
   > * This is critically important for Phase 2 and beyond to prevent escalation of privilege through PAW as PAWs being to span Tiers.
   >
   > Ideally, no personnel are assigned to duties at multiple tiers to enforce the principle of segregation of duties, but Microsoft recognizes that many organizations may have limited staff (or other organizational requirements) that don't allow for this full segregation. In these cases, the same personnel may be assigned to both roles, but should not use the same account for these functions.

#### Create "PAW Configuration - Computer" group policy object (GPO)

In this section, you will create a new "PAW Configuration - Computer" GPO which provide specific protections for these PAWs and link it to the Tier 0 Devices OU ("Devices" under Tier 0\Admin).

   > [!NOTE]
   > **Do not add these settings to the Default Domain Policy**.  Doing so will potentially impact operations on your entire Active Directory environment.  Only configure these settings in the newly-created GPOs described here, and only apply them to the PAW OU.

1. **PAW Maintenance Access** - this setting will set the membership of specific privileged groups on the PAWs to a specific set of users. Go to *Computer Configuration\Preferences\Control Panel Settings\Local Users* and Groups and follow the steps below:
   1. Click **New** and click **Local Group**
   2. Select the **Update** action, and select "Administrators (built-in)" (do not use the Browse button to select the domain group Administrators).
   3. Select the **Delete all member users** and **Delete all member groups** check boxes
   4. Add PAW Maintenance (pawmaint) and Administrator (again, do not use the Browse button to select Administrator).

      > [!NOTE]
      > Do not add the PAW Users group to the membership list for the local Administrators group.  To ensure that PAW Users cannot accidentally or deliberately modify the security settings of the PAW itself, they should not be members of the local Administrators groups.
      >
      > For more information on using Group Policy Preferences to modify group membership, please refer to the TechNet article [Configure a Local Group Item](https://technet.microsoft.com/library/cc732525.aspx).

2. **Restrict Local Group Membership** - this setting will ensure that the membership of local admin groups on the workstation is always empty
   1. Go to Computer Configuration\Preferences\Control Panel Settings\Local Users and Groups and follow the steps below:
      1. Click **New** and click **Local Group**
      2. Select the **Update** action, and select "Backup Operators (built-in)" (do not use the Browse button to select the domain group Backup Operators).
      3. Select the **Delete all member users** and **Delete all member groups** check boxes.
      4. Do not add any members to the group.  Simply click **OK**.  By assigning an empty list, group policy will automatically remove all members and ensure a blank membership list each time group policy is refreshed.
   2. Complete the above steps for the following additional groups:
      * Cryptographic Operators
      * Hyper-V Administrators
      * Network Configuration Operators
      * Power Users
      * Remote Desktop Users
      * Replicators
   3. **PAW Logon Restrictions** - this setting will limit the accounts which can log onto the PAW. Follow the steps below to configure this setting:
      1. Go to Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Allow log on locally.
      2. Select Define these policy settings and add "PAW Users" and Administrators (again, do not use the Browse button to select Administrators).
   4. **Block Inbound Network Traffic** - This setting will ensure that no unsolicited inbound network traffic is allowed to the PAW. Follow the steps below to configure this setting:
      1. Go to Computer Configuration\Policies\Windows Settings\Security Settings\Windows Firewall with Advanced Security\Windows Firewall with Advanced Security and follow the steps below:
         1. Right click on Windows Firewall with Advanced Security and select **Import policy**.
         2. Click **Yes** to accept that this will overwrite any existing firewall policies.
         3. Browse to PAWFirewall.wfw and select **Open**.
         4. Click **OK**.

            > [!NOTE]
            > You may add addresses or subnets which must reach the PAW with unsolicited traffic at this point (e.g. security scanning or management software.
            > The settings in the WFW file will enable the firewall in "Block - Default" mode for all firewall profiles, turn off rule merging and enable logging of both dropped and successful packets. These settings will block unsolicited traffic while still allowing bidirectional communication on connections initiated from the PAW, prevent users with local administrative access from creating local firewall rules that would override the GPO settings and ensure that traffic in and out of the PAW is logged.
            > **Opening up this firewall will expand the attack surface for the PAW and increase security risk. Before adding any addresses, consult the Managing and Operating PAW section in this guidance**.

   5. **Configure Windows Update for WSUS** - follow the steps below to change the settings to configure Windows Update for the PAWs:
      1. Go to Computer Configuration\Policies\Administrative Templates\Windows Components\Windows Updates and follow the steps below:
         1. Enable the **Configure Automatic Updates policy**.
         2. Select option  **4 - Auto download and schedule the install**.
         3. Change the option **Scheduled install day** to **0 - Every Day** and the option **Scheduled install time** to your organizational preference.
         4. Enable option **Specify intranet Microsoft update service location** policy, and specify in both options the URL of the ESAE WSUS server.
   6. Link the "PAW Configuration - Computer" GPO as follows:

         |Policy|Link Location|
         |-----|---------|
         |PAW Configuration - Computer |Admin\Tier 0\Devices|

#### Create "PAW Configuration - User" group policy object (GPO)

In this section, you will create a new "PAW Configuration - User" GPO which provide specific protections for these PAWs and link to the Tier 0 Accounts OU ("Accounts" under Tier 0\Admin).

   > [!NOTE]
   > Do not add these settings to the Default Domain Policy

1. **Block internet browsing** - To deter inadvertent internet browsing, this will set a proxy address of a loopback address (127.0.0.1).
   1. Go to User Configuration\Preferences\Windows Settings\Registry. Right-click Registry, select **New** > **Registry Item** and configure the following settings:
      1. Action:  Replace
      2. Hive: HKEY_CURRENT_USER
      3. Key Path:  Software\Microsoft\Windows\CurrentVersion\Internet Settings
      4. Value name: ProxyEnable

         > [!NOTE]
         > Do not select the Default box to the left of Value name.

      5. Value type: REG_DWORD
      6. Value data: 1
         1. Click the Common tab and select **Remove this item when it is no longer applied**.
         2. On the Common tab select **Item level targeting** and click **Targeting**.
         3. Click **New Item** and select **Security group**.
         4. Select the "..." button and browse for the PAW Users group.
         5. Click **New Item** and select **Security group**.
         6. Select the "..." button and browse for the **Cloud Services Admins** group.
         7. Click on the **Cloud Services Admins** item and click **Item Options**.
         8. Select **Is not**.
         9. Click **OK** on the targeting window.
      7. Click **OK** to complete the ProxyServer group policy setting
   2. Go to User Configuration\Preferences\Windows Settings\Registry. Right-click Registry, select **New** > **Registry Item** and configure the following settings:

      * Action: Replace
      * Hive: HKEY_CURRENT_USER
      * Key Path: Software\Microsoft\Windows\CurrentVersion\Internet Settings
         * Value name: ProxyServer

            > [!NOTE]
            > Do not select the Default box to the left of Value name.

         * Value type: REG_SZ
         * Value data: 127.0.0.1:80
            1. Click the **Common** tab and select **Remove this item when it is no longer applied**.
            2. On the **Common** tab select **Item level targeting** and click **Targeting**.
            3. Click **New Item** and select security group.
            4. Select the "..." button and add the PAW Users group.
            5. Click **New Item** and select security group.
            6. Select the "..." button and browse for the **Cloud Services Admins** group.
            7. Click on the **Cloud Services Admins** item and click **Item Options**.
            8. Select **Is not**.
            9. Click **OK** on the targeting window.

   3. Click **OK** to complete the ProxyServer group policy setting,
2. Go to User Configuration\Policies\Administrative Templates\Windows Components\Internet Explorer, and enable the options below. These settings will prevent the administrators from manually overriding the proxy settings.
   1. Enable the **Disable changing Automatic Configuration** settings.
   2. Enable the **Prevent changing proxy settings**.

#### Restrict Administrators from logging onto lower tier hosts

In this section, we will configure group policies to prevent privileged administrative accounts from logging onto lower tier hosts.

1. Create the new **Restrict Workstation Logon** GPO - this setting will restrict Tier 0 and Tier 1 administrator accounts from logging onto standard workstations.  This GPO should be linked to the "Workstations" top-level OU and have the following settings:
   * In Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Deny log on as a batch job, select **Define these policy settings** and add the Tier 0 and Tier 1 groups:
     ```
     Enterprise Admins
     Domain Admins
     Schema Admins
     BUILTIN\Administrators
     Account Operators
     Backup Operators
     Print Operators
     Server Operators
     Domain Controllers
     Read-Only Domain Controllers
     Group Policy Creators Owners
     Cryptographic Operators
     ```

     > [!NOTE]
     > Built-in Tier 0 Groups, see Tier 0 equivalency for more details.

         Other Delegated Groups

     > [!NOTE]
     > Any custom created groups with effective Tier 0 access, see Tier 0 equivalency for more details.

         Tier 1 Admins

     > [!NOTE]
     > This Group was created earlier in Phase 1.

   * In Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Deny log on as a service,  select **Define these policy settings** and add the Tier 0 and Tier 1 groups:
     ```
     Enterprise Admins
     Domain Admins
     Schema Admins
     BUILTIN\Administrators
     Account Operators
     Backup Operators
     Print Operators
     Server Operators
     Domain Controllers
     Read-Only Domain Controllers
     Group Policy Creators Owners
     Cryptographic Operators
     ```

     > [!NOTE]
     > Note: Built-in Tier 0 Groups, see Tier 0 equivalency for more details.

         Other Delegated Groups

     > [!NOTE]
     > Note: Any custom created groups with effective Tier 0 access, see Tier 0 equivalency for more details.

         Tier 1 Admins

     > [!NOTE]
     > Note: This Group was created earlier in Phase 1

2. Create the new **Restrict Server Logon** GPO - this setting will restrict Tier 0 administrator accounts from logging onto Tier 1 servers.  This GPO should be linked to the "Tier 1 Servers" top-level OU and have the following settings:
   * In Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Deny log on as a batch job, select **Define these policy settings** and add the Tier 0 groups:
     ```
     Enterprise Admins
     Domain Admins
     Schema Admins
     BUILTIN\Administrators
     Account Operators
     Backup Operators
     Print Operators
     Server Operators
     Domain Controllers
     Read-Only Domain Controllers
     Group Policy Creators Owners
     Cryptographic Operators
     ```

     > [!NOTE]
     > Built-in Tier 0 Groups, see Tier 0 equivalency for more details.

         Other Delegated Groups

     > [!NOTE]
     > Any custom created groups with effective Tier 0 access, see Tier 0 equivalency for more details.

   * In Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Deny log on as a service, select **Define these policy settings** and add the Tier 0 groups:
     ```
     Enterprise Admins
     Domain Admins
     Schema Admins
     BUILTIN\Administrators
     Account Operators
     Backup Operators
     Print Operators
     Server Operators
     Domain Controllers
     Read-Only Domain Controllers
     Group Policy Creators Owners
     Cryptographic Operators
     ```

     > [!NOTE]
     > Built-in Tier 0 Groups, see Tier 0 equivalency for more details.

         Other Delegated Groups

     > [!NOTE]
     > Any custom created groups with effective Tier 0 access, see Tier 0 equivalency for more details.

   * In Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Deny log on locally, select **Define these policy settings** and add the Tier 0 groups:
     ```
     Enterprise Admins
     Domain Admins
     Schema Admins
     BUILTIN\Administrators
     Account Operators
     Backup Operators
     Print Operators
     Server Operators
     Domain Controllers
     Read-Only Domain Controllers
     Group Policy Creators Owners
     Cryptographic Operators
     ```

     > [!NOTE]
     > Note: Built-in Tier 0 Groups, see Tier 0 equivalency for more details.

         Other Delegated Groups

     > [!NOTE]
     > Note: Any custom created groups with effective Tier 0 access, see Tier 0 equivalency for more details.

#### Deploy your PAW(s)

   > [!NOTE]
   > Ensure that the PAW is disconnected from the network during the operating system build process.

1. Install Windows 10 using the clean source installation media that you obtained earlier.

   > [!NOTE]
   > You may use Microsoft Deployment Toolkit (MDT) or another automated image deployment system to automate PAW deployment, but you must ensure the build process is as trustworthy as the PAW. Adversaries specifically seek out corporate images and deployment systems (including ISOs, deployment packages, etc.) as a persistence mechanism so preexisting deployment systems or images should not be used.
   >
   > If you automate deployment of the PAW, you must:
   >
   > * Build the system using installation media validated using the guidance in [Clean Source for installation media](https://aka.ms/cleansource).
   > * Ensure that the automated deployment system is disconnected from the network during the operating system build process.

2. Set a unique complex password for the local Administrator account.  Do not use a password that has been used for any other account in the environment.

   > [!NOTE]
   > Microsoft recommends using [Local Administrator Password Solution (LAPS)](https://www.microsoft.com/download/details.aspx?id=46899) to manage the local Administrator password for all workstations, including PAWs.  If you use LAPS, ensure that you only grant the PAW Maintenance group the right to read LAPS-managed passwords for the PAWs.

3. Install Remote Server Administration Tools for Windows 10 using the clean source installation media.
4. Configure Windows Defender Exploit Guard

   > [!NOTE]
   > Configuration guidance to follow

5. Connect the PAW to the network.  Ensure that the PAW can connect to at least one Domain Controller (DC).
6. Using an account that is a member of the PAW Maintenance group, run the following PowerShell command from the newly-created PAW to join it to the domain in the appropriate OU:

   `Add-Computer -DomainName Fabrikam -OUPath "OU=Devices,OU=Tier 0,OU=Admin,DC=fabrikam,DC=com"`

   Replace the references to *Fabrikam* with your domain name, as appropriate.  If your domain name extends to multiple levels (e.g. child.fabrikam.com), add the additional names with the "DC=" identifier in the order in which they appear in the domain's fully-qualified domain name.

   > [!NOTE]
   > If you have deployed an [ESAE Administrative Forest](https://aka.ms/esae) (for Tier 0 admins in Phase 1) or a [Microsoft Identity Manager (MIM) privileged access management (PAM)](https://aka.ms/mimpamdeploy) (for Tier 1 and 2 admins in Phase 2), you would join the PAW to the domain in that environment here instead of the production domain.

7. Apply all critical and important Windows Updates before installing any other software (including administrative tools, agents, etc.).
8. Force the Group Policy application.
   1. Open an elevated command prompt and enter the following command: `Gpupdate /force /sync`
   2. Restart the computer

9. (Optional) Install additional required tools for Active Directory Admins. Install any other tools or scripts required to perform job duties. Ensure to evaluate the risk of credential exposure on the target computers with any tool before adding it to a PAW. Access [this page](https://aka.ms/logontypes) to obtain more information on evaluating administrative tools and connection methods for credential exposure risk. Ensure to obtain all installation media using the guidance in [Clean Source for installation media](https://aka.ms/cleansource).

   > [!NOTE]
   > Using a jump server for a central location for these tools can reduce complexity, even if it doesn't serve as a security boundary.

10. (Optional) Download and install required remote access software. If administrators will be using the PAW remotely for administration, install the remote access software using security guidance from your remote access solution vendor. Ensure to obtain all installation media using the guidance in Clean Source for installation media.

    > [!NOTE]
    > Carefully consider all the risks involved in allowing remote access via a PAW.  While a mobile PAW enables many important scenarios, including work from home, remote access software can potentially be vulnerable to attack and used to compromise a PAW.

11. Validate the integrity of the PAW system by reviewing and confirming that all appropriate settings are in place using the steps below:
    1. Confirm that only the PAW-specific group policies are applied to the PAW
       1. Open an elevated command prompt and enter the following command: `Gpresult /scope computer /r`
       2. Review the resulting list and ensure that the only group policies that appear are the ones you created above.
    2. Confirm that no additional user accounts are members of privileged groups on the PAW using the steps below:
       1. Open **Edit Local Users and Groups** (lusrmgr.msc), select **Groups**, and confirm that the only members of the local Administrators group are the local Administrator account and the PAW Maintenance global security group.

          > [!NOTE]
          > The PAW Users group should not be a member of the local Administrators group.  The only members should be the local Administrator account and the PAW Maintenance global security group (and PAW Users should not be a member of that global group either).

       2. Also using **Edit Local Users and Groups**, ensure that the following groups have no members:
          Backup Operators
          Cryptographic Operators
          Hyper-V Administrators
          Network Configuration Operators
          Power Users
          Remote Desktop Users
          Replicators

12. (Optional) If your organization uses a security information and event management (SIEM) solution, ensure that the PAW is [configured to forward events to the system using Windows Event Forwarding (WEF)](https://blogs.technet.com/b/jepayne/archive/2015/11/24/monitoring-what-matters-windows-event-forwarding-for-everyone-even-if-you-already-have-a-siem.aspx) or is otherwise registered with the solution so that the SIEM is actively receiving events and information from the PAW.  The details of this operation will vary based on your SIEM solution.

    > [!NOTE]
    > If your SIEM requires an agent which runs as system or a local administrative account on the PAWs, ensure that the SIEMs are managed with the same level of trust as your domain controllers and identity systems.

13. (Optional) If you chose to deploy LAPS to manage the password for the local Administrator account on your PAW, verify that the password is registered successfully.

    * Using an account with permissions to read LAPS-managed passwords, open **Active Directory Users and Computers** (dsa.msc).  Ensure that Advanced Features is enabled, and then right-click the appropriate computer object.  Select the Attribute Editor tab and confirm that the value for msSVSadmPwd is populated with a valid password.

### Phase 2: Extend PAW to all administrators

Scope: All users with administrative rights over mission-critical applications and dependencies.  This should include at least administrators of application servers, operational health and security monitoring solutions, virtualization solutions, storage systems, and network devices.

> [!NOTE]
> The instructions in this phase assume that Phase 1 has been completed in its entirety.  Do not begin Phase 2 until you have completed all the steps in Phase 1.

Once you confirm that all steps were done, perform the steps below to complete Phase 2:

#### (Recommended) Enable **RestrictedAdmin** mode

Enable this feature on your existing servers and workstations, then enforce the use of this feature. This feature will require the target servers to be running Windows Server 2008 R2 or later and target workstations to be running Windows 7 or later.

1. Enable **RestrictedAdmin** mode on your servers and workstations by following the instructions available in this [page](https://aka.ms/rdpra).

   > [!NOTE]
   > Before enabling this feature for internet facing servers, you should consider the risk of adversaries being able to authenticate to these servers with a previously-stolen password hash.

2. Create "RestrictedAdmin Required - Computer" group policy object (GPO). This section creates a GPO which enforces the use of the /RestrictedAdmin switch for outgoing Remote Desktop connections, protecting accounts from credential theft on the target systems
   * Go to Computer Configuration\Policies\Administrative Templates\System\Credentials Delegation\Restrict delegation of credentials to remote servers and set to **Enabled**.
3. Link the **RestrictedAdmin** Required - Computer to the appropriate Tier 1 and/or Tier 2 Devices by using the Policy options below:
   * PAW Configuration - Computer
      * -> Link Location: Admin\Tier 0\Devices (Existing)
   * PAW Configuration - User
      * -> Link Location: Admin\Tier 0\Accounts
   * RestrictedAdmin Required - Computer
      * ->Admin\Tier1\Devices or -> Admin\Tier2\Devices (Both are optional)

   > [!NOTE]
   > This is not necessary for Tier 0 systems as these systems are already in full control of all assets in the environment.

#### Move Tier 1 Objects to the appropriate OUs

1. Move Tier 1 groups To the Admin\Tier 1\Groups OU. Locate all groups that grant the following administrative rights and move them to this OU.
   * Local administrator on more than one server
      * Administrative Access to cloud services
      * Administrative Access to enterprise applications
2. Move Tier 1 accounts to the Admin\Tier 1\Accounts OU. Move each account that is a member of those Tier 1 groups (including nested membership) to this OU.
3. Add the appropriate members to the relevant groups
   * **Tier 1 Admins** - This group will contain the Tier 1 Admins that will be restricted from logging onto Tier 2 hosts. Add all your Tier 1 administrative groups that have administrative privileges over servers or internet services.

      > [!NOTE]
      > If administrative personnel have duties to manage assets at multiple tiers, you will need to create a separate admin account per tier.

4. Enable Credential Guard to reduce risk of credential theft and reuse.  Credential Guard is a new feature of Windows 10 that restricts application access to credentials, preventing credential theft attacks (including Pass-the-Hash).  Credential Guard is completely transparent to the end user and requires minimal setup time and effort.  For further information on Credential Guard, including deployment steps and hardware requirements, please refer to the article, [Protect domain credentials with Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx).

   > [!NOTE]
   > Device Guard must be enabled in order to configure and use Credential Guard.  However, you are not required to configure any other Device Guard protections in order to use Credential Guard.

5. (Optional) Enable Connectivity to Cloud Services. This step allows management of cloud services like Azure and Office 365 with appropriate security assurances. This step is also required for Microsoft Intune to manage the PAWs.

   > [!NOTE]
   > Skip this step if no cloud connectivity is required for administration of cloud services or management by Intune.

   * These steps will restrict communication over the internet to only authorized cloud services (but not the open internet) and add protections to the browsers and other applications that will process content from the internet. These PAWs for administration should never be used for standard user tasks like internet communications and productivity.
   * To enable connectivity to PAW services follow the steps below:

   1. Configure PAW to allow only authorized Internet destinations.  As you extend your PAW deployment to enable cloud administration, you need to allow access to authorized services while filtering out access from the open internet where attacks can more easily be mounted against your admins.

      1. Create **Cloud Services Admins** group and add all the accounts to it that require access to cloud services on the internet.
      2. Download the PAW *proxy.pac* file from [TechNet Gallery](https://aka.ms/pawmedia) and publish it on an internal website.

         > [!NOTE]
         > You will need to update the *proxy.pac* file after downloading to ensure that it is up-to-date and complete.  
         > Microsoft publishes all current Office 365 and Azure URLs in the Office [Support Center](https://support.office.com/article/Office-365-URLs-and-IP-address-ranges-8548a211-3fe7-47cb-abb1-355ea5aa88a2?ui=en-US&rs=en-US&ad=US). These instructions assume that you will be using Internet Explorer (or Microsoft Edge) for administration of Office 365, Azure, and other cloud services. Microsoft recommends configuring similar restrictions for any 3rd party browsers that you require for administration. Web browsers on PAWs should only be used for administration of cloud services, and never for general web browsing.
         >
         > You may need to add other valid Internet destinations to add to this list for other IaaS provider, but do not add productivity, entertainment, news, or search sites to this list.
         >
         > You may also need to adjust the PAC file to accommodate a valid proxy address to use for these addresses.
         >
         > You can also restrict access from the PAW using a web proxy as well for defense in depth. We don't recommend using this by itself without the PAC file as it will only restrict access for PAWs while connected to the corporate network.

      3. Once you have configured the *proxy.pac* file, update the PAW Configuration - User GPO.
         1. Go to User Configuration\Preferences\Windows Settings\Registry. Right-click Registry, select **New** > **Registry Item** and configure the following settings:
            1. Action: Replace
            2. Hive: HKEY_ CURRENT_USER
            3. Key Path: Software\Microsoft\Windows\CurrentVersion\Internet Settings
            4. Value name: AutoConfigUrl

               > [!NOTE]
               > Do not select the **Default** box to the left of Value name.

            5. Value type: REG_SZ
            6. Value data: enter the complete URL to the *proxy.pac* file, including http:// and the file name - for example http://proxy.fabrikam.com/proxy.pac.  The URL can also be a single-label URL - for example, http://proxy/proxy.pac

               > [!NOTE]
               > The PAC file can also be hosted on a file share, with the syntax of file://server.fabrikan.com/share/proxy.pac but this requires allowing the file:// protocol. See the "NOTE: File://-based Proxy Scripts Deprecated" section of this [Understanding Web Proxy Configuration](https://blogs.msdn.com/b/ieinternals/archive/2013/10/11/web-proxy-configuration-and-ie11-changes.aspx) blog for additional detail on configuring the required registry value.

            7. Click the **Common** tab and select **Remove this item when it is no longer applied**.
            8. On the **Common** tab select **Item level targeting** and click **Targeting**.
            9. Click **New Item** and select **security group**.
            10. Select the "..." button and browse for the **Cloud Services Admins** group.
            11. Click **New Item** and select **security group**.
            12. Select the "..." button and browse for the **PAW Users** group.
            13. Click on the **PAW Users** item and click **Item Options**.
            14. Select **Is not**.
            15. Click **OK** on the targeting window.
            16. Click **OK** to complete the **AutoConfigUrl** group policy setting.
   2. Apply Windows 10 Security baselines and Cloud Service Access Link the security baselines for Windows and for cloud service access (if required) to the correct OUs using the steps below:
      1. Extract the contents of the Windows 10 Security Baselines ZIP file.
      2. Create these GPOs, [import the policy](https://technet.microsoft.com/library/cc753786.aspx) settings, and [link](https://technet.microsoft.com/library/cc732979.aspx) per this table. Link each policy to each location and ensure the order follows the table (lower entries in table should be applied later and higher priority):

         **Policies:**

         |||
         |-|-|
         |CM Windows 10 - Domain Security|N/A - Do Not Link Now|
         |SCM Windows 10 TH2 - Computer|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |SCM Windows 10 TH2- BitLocker|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |SCM Windows 10 - Credential Guard|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |SCM Internet Explorer - Computer|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |PAW Configuration - Computer|Admin\Tier 0\Devices (Existing)|
         ||Admin\Tier 1\Devices (New Link)|
         ||Admin\Tier 2\Devices (New Link)|
         |RestrictedAdmin Required - Computer|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |SCM Windows 10 - User|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |SCM Internet Explorer - User|Admin\Tier 0\Devices|
         ||Admin\Tier 1\Devices|
         ||Admin\Tier 2\Devices|
         |PAW Configuration - User|Admin\Tier 0\Devices (Existing)|
         ||Admin\Tier 1\Devices (New Link)|
         ||Admin\Tier 2\Devices (New Link)|

         > [!NOTE]
         > The "SCM Windows 10 - Domain Security" GPO may be linked to the domain independently of PAW, but will affect the entire domain.

6. (Optional) Install additional required tools for Tier 1 Admins. Install any other tools or scripts required to perform job duties. Ensure to evaluate the risk of credential exposure on the target computers with any tool before adding it to a PAW. For more information on evaluating administrative tools and connection methods for credential exposure risk visit [this page](https://aka.ms/logontypes). Ensure to obtain all installation media using the guidance in Clean Source for installation media
7. Identify and safely obtain software and applications required for administration.  This is similar to the work performed in Phase 1, but with a broader scope due to the increased number of applications, services, and systems being secured.

   > [!NOTE]
   > Ensure that you protect these new applications (including web browsers) by opting them into the protections provided by Windows Defender Exploit Guard.

   Examples of additional software and applications include:

      * Microsoft Azure PowerShell
      * Office 365 PowerShell (also known as Microsoft Online Services Module)
      * Application or service management software based on the Microsoft Management Console
      * Proprietary (non-MMC-based) application or service management software

         > [!NOTE]
         > Many applications are now exclusively managed via web browsers, including many cloud services.  While this reduces the number of applications which need to be installed on a PAW, it also introduces the risk of browser interoperability issues.  You may need to deploy a non-Microsoft web browser onto specific PAW instances to enable administration of specific services.  If you do deploy an additional web browser, ensure that you follow all clean source principles and secure the browser according to the vendor's security guidance.

8. (Optional) Download and install any required management agents.

   > [!NOTE]
   > If you choose to install additional management agents (monitoring, security, configuration management, etc.), it is vital that you ensure the management systems are trusted at the same level as domain controllers and identity systems. See the Managing and Updating PAWs for additional guidance.

9. Assess your infrastructure to identify systems which require the additional security protections provided by a PAW.  Ensure that you know exactly which systems must be protected.  Ask critical questions about the resources themselves, such as:

   * Where are the target systems which must be managed?  Are they collected in a single physical location, or connected to a single well-defined subnet?
   * How many systems are there?
   * Do these systems depend on other systems (virtualization, storage, etc.), and if so, how are those systems managed?  How are the critical systems exposed to these dependencies, and what are the additional risks associated with those dependencies?
   * How critical are the services being managed, and what is the expected loss if those services are compromised?

      > [!NOTE]
      > Include your cloud services in this assessment - attackers increasingly target insecure cloud deployments, and it is vital that you administer those services as securely as you would your on-premises mission-critical applications.

        Use this assessment to identify the specific systems which require additional protection, and then extend your PAW program to the administrators of those systems.  Common examples of systems which benefit greatly from PAW-based administration include SQL Server (both on-premises and SQL Azure), human resources applications, and financial software.

        > [!NOTE]
        > If a resource is managed from a Windows system, it can be managed with a PAW, even if the application itself runs on an operating system other than Windows or on a non-Microsoft cloud platform.  For example, the owner of an Amazon Web Services subscription should only use a PAW to administer that account.

10. Develop a request and distribution method for deploying PAWs at scale in your organization.  Depending on the number of PAWs you choose to deploy in Phase 2, you may need to automate the process.

    * Consider developing a formal request and approval process for administrators to use to obtain a PAW.  This process would help standardize the deployment process, ensure accountability for PAW devices, and help identify gaps in PAW deployment.
    * As stated previously, this deployment solution should be separate from existing automation methods (which may have already been compromised) and should follow the principles outlined in Phase 1.

        > [!NOTE]
        > Any system which manages resources should itself managed at the same or higher trust level.

11. Review and if necessary deploy additional PAW hardware profiles.  The hardware profile you chose for Phase 1 deployment may not be suitable for all administrators.  Review the hardware profiles and if appropriate select additional PAW hardware profiles to match the needs of the administrators.  For example, the Dedicated Hardware profile (separate PAW and daily use workstations) may be unsuitable for an administrator who travels often - in this case, you might choose to deploy the Simultaneous Use profile (PAW with user VM) for that administrator.
12. Consider the cultural, operational, communications, and training needs which accompany an extended PAW deployment.   Such a significant change to an administrative model will naturally require change management to some degree, and it is essential to build that into the deployment project itself.  Consider at a minimum the following:

    * How will you communicate the changes to senior leadership to ensure their support?  Any project without senior leadership backing is likely to fail, or at the very least struggle for funding and broad acceptance.
    * How will you document the new process for administrators?  These changes must be documented and communicated not only to existing administrators (who must change their habits and manage resources in a different way), but also for new administrators (those promoted from within or hired from outside the organization).  It is essential that the documentation is clear and fully articulates the importance of the threats, PAW's role in protecting the admins, and how to use PAW correctly.

      > [!NOTE]
      > This is especially important for roles with high turnover, including but not limited to help desk personnel.

    * How will you ensure compliance with the new process?  While the PAW model includes several technical controls to prevent the exposure of privileged credentials, it is impossible to fully prevent all possible exposure purely using technical controls.  For example, although it is possible to prevent an administrator from successfully logging onto a user desktop with privileged credentials, the simple act of attempting the logon can expose the credentials to malware installed on that user desktop.  It is therefore essential that you articulate not only the benefits of the PAW model, but the risks of non-compliance.  This should be complemented by auditing and alerting so that credential exposure can be quickly detected and addressed.

### Phase 3: Extend and enhance protection

Scope: These protections enhance the systems built in Phase 1, bolstering the basic protection with advanced features including multi-factor authentication and network access rules.

> [!NOTE]
> This phase can be performed at any time after Phase 1 has been completed.  It is not dependent on completion of Phase 2, and thus can be performed before, concurrent with, or after Phase 2.

Follow the steps below to configure this phase:

1. **Enable multi-factor authentication for privileged accounts**.  Multi-factor authentication strengthens account security by requiring the user to provide a physical token in addition to credentials.  Multi-factor authentication complements authentication policies extremely well, but it does not depend on authentication policies for deployment (and, similarly, authentication policies do not require multi-factor authentication).  Microsoft recommends using one of these forms of multi-factor authentication:

   * **Smart card**: A smart card is a tamper-resistant and portable physical device which provides a second verification during the Windows logon process.  By requiring an individual to possess a card for logon, you can reduce the risk of stolen credentials being reused remotely.  For details on smart card logon in Windows, please refer to the article [Smart Card Overview](https://technet.microsoft.com/library/hh831433.aspx).
   * **Virtual smart card**:  A virtual smart card provides the same security benefits as physical smart cards, with the added benefit of being linked to specific hardware.  For details on deployment and hardware requirements, please refer to the articles, [Virtual Smart Card Overview](https://technet.microsoft.com/library/dn593708.aspx) and [Get Started with Virtual Smart Cards: Walkthrough Guide](https://technet.microsoft.com/library/dn579260.aspx).
   * **Windows Hello for Business**: Windows Hello for Business lets users authenticate to a Microsoft account, an Active Directory account, a Microsoft Azure Active Directory (Azure AD) account, or non-Microsoft service that supports Fast ID Online (FIDO) authentication. After an initial two-step verification during Windows Hello for Business enrollment, a Windows Hello for Business is set up on the user's device and the user sets a gesture, which can be Windows Hello or a PIN. Windows Hello for Business credentials are an asymmetric key pair, which can be generated within isolated environments of Trusted Platform Modules (TPMs).
      For more information on Windows Hello for Business read [Windows Hello for Business](https://docs.microsoft.com/windows/security/identity-protection/hello-for-business/hello-identity-verification) article.
   * **Azure multi-factor authentication**:  Azure multi-factor authentication (MFA) provides the security of a second verification factor as well as enhanced protection through monitoring and machine-learning-based analysis.  Azure MFA can secure not only Azure administrators but many other solutions as well, including web applications, Azure Active Directory, and on-premises solutions like remote access and Remote Desktop.  For more information on Azure multi-factor authentication, please refer to the article [Multi-Factor Authentication](https://azure.microsoft.com/services/multi-factor-authentication).

2. **Whitelist trusted applications using Windows Defender Application Control and/or AppLocker**.  By limiting the ability of untrusted or unsigned code to run on a PAW, you further reduce the likelihood of malicious activity and compromise.  Windows includes two primary options for application control:

   * **AppLocker**:  AppLocker helps administrators control which applications can run on a given system.  AppLocker can be centrally controlled through group policy, and applied to specific users or groups (for targeted application to users of PAWs).  For more information on AppLocker, please refer to the TechNet article [AppLocker Overview](https://technet.microsoft.com/library/hh831440.aspx).
   * **Windows Defender Application Control**:  the new Windows Defender Application Control feature provides enhanced hardware-based application control which, unlike AppLocker, cannot be overridden on the impacted device.  Like AppLocker, Windows Defender Application Control can be controlled via group policy and targeted to specific users.  For more information on restricting application usage with Windows Defender Application Control, please refer to [Windows Defender Application Control Deployment Guide](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide).

3. **Use Protected Users, Authentication Policies, and Authentication Silos to further protect privileged accounts**.  The members of Protected Users are subject to additional security policies which protect the credentials stored in the local security agent (LSA) and greatly minimize the risk of credential theft and reuse.  Authentication policies and silos control how privileged users can access resources in the domain.  Collectively, these protections dramatically strengthen the account security of these privileged users.  For additional details on these features, please refer to the web article [How to Configure Protected Accounts](https://technet.microsoft.com/library/dn518179.aspx).

   > [!NOTE]
   > These protections are meant to complement, not replace, existing security measures in Phase 1.  Administrators should still use separate accounts for administration and general use.

## Managing and updating

PAWs must have anti-malware capabilities and software updates must be rapidly applied to maintain integrity of these workstations.

Additional configuration management, operational monitoring, and security management can also be used with PAWs, but the integration of these must be considered carefully because each management capability also introduces risk of PAW compromise through that tool. Whether it makes sense to introduce advanced management capabilities depends on several factors including:

* The security state and practices of the management capability (including software update practices for the tool, administrative roles and accounts in those roles, operating systems the tool is hosted on or managed from, and any other hardware or software dependencies of that tool)
* The frequency and quantity of software deployments and updates on your PAWs
* Requirements for detailed inventory and configuration information
* Security monitoring requirements
* Organizational standards and other organizational-specific factors

Per the clean source principle, all tools used to manage or monitor the PAWs must be trusted at or above the level of the PAWs. This typically requires those tools to be managed from a PAW to ensure no security dependency from lower privilege workstations.

This table outlines different approaches that may be used to manage and monitor the PAWs:

|Approach|Considerations|
|------|---------|
|Default in PAW<br /><br />-   Windows Server Update Services<br />-   Windows Defender|-   No additional cost<br />-   Performs basic required security functions<br />-   Instructions included in this guidance|
|Manage with [Intune](https://technet.microsoft.com/library/jj676587.aspx)|<ul><li>Provides cloud based visibility and control<br /><br /><ul><li>Software Deployment</li><li>o   Manage software updates</li><li>Windows Firewall policy management</li><li>Anti-malware protection</li><li>Remote assistance</li><li>Software license management.</li></ul></li><li>No server infrastructure required</li><li>Requires following "Enable Connectivity to Cloud Services" steps in Phase 2</li><li>If the PAW computer is not joined to a domain, this requires applying the SCM baselines to the local images using the tools provided in the security baseline download.</li></ul>|
|New System Center instance(s) for managing PAWs|-   Provides visibility and control of configuration, software deployment, and security updates<br />-   Requires separate server infrastructure, securing it to level of PAWs, and staffing skills for those highly privileged personnel|
|Manage PAWs with existing management tool(s)|-   Creates significant risk to compromise of PAWs unless the existing management infrastructure is brought up to security level of PAWs **Note:**     Microsoft would generally discourage this approach unless your organization has a specific reason to use it. In our experience, there is typically a very high cost of bringing all these tools (and their security dependencies) up to the security level of the PAWs.<br />-   Most of these tools provide visibility and control of configuration, software deployment, and security updates|
|Security Scanning or monitoring tools requiring admin access|Includes any tool that installs an agent or requires an account with local administrative access.<br /><br />-   Requires bringing tool security assurance up to level of PAWs.<br />-   May require lowering security posture of PAWs to support tool functionality (open ports, install Java or other middleware, etc.), creating a security trade-off decision,|
|Security information and event management (SIEM)|<ul><li>If SIEM is agentless<br /><br /><ul><li>Can access events on PAWs without administrative access by using an account in the **Event Log Readers** group</li><li>Will require opening up network ports to allow inbound traffic from the SIEM servers</li></ul></li><li>If SIEM requires an agent, see other row **Security Scanning or monitoring tools requiring admin access**.</li></ul>|
|Windows Event Forwarding|-   Provides an agentless method of forwarding security events from the PAWs to an external collector or SIEM<br />-   Can access events on PAWs without administrative access<br />-   Does not require opening up network ports to allow inbound traffic from the SIEM servers|

## Operating PAWs

The PAW solution should be operated using the standards in [Operational Standards](https://aka.ms/securitystandards) based on Clean Source Principle.

## Deploy PAWs using a Guarded Fabric

A [guarded fabric](https://aka.ms/shieldedvms) can be used to run PAW workloads in a shielded virtual machine on a laptop or jump server.
Adopting this approach requires extra infrastructure and operational steps, but can make it easier to redeploy PAW images at regular intervals and allows you to consolidate multiple different tiered (or classifications) PAWs into virtual machines running side-by-side on a single device.
For a complete explanation of the guarded fabric topology and security promises, consult the [guarded fabric documentation](https://aka.ms/shieldedvms).

### Changes to the PAW GPOs

When using shielded VM-based PAWs, the [recommended GPO settings](#create-paw-configuration---computer-group-policy-object-gpo) defined above will need to be modified to support the use of virtual machines.

1. Create a new OU for the physical PAW hosts. Physical and virtual PAWs have different security requirements, and should be separated in Active Directory accordingly.
2. The PAW Computer GPO should be linked to both the physical and virtual PAW OUs.
3. Create a new GPO for the physical PAW to add the PAW users to the Hyper-V Admins group. This is required to allow the admins to connect to the admin VMs and turn them on/off as necessary. It is important that the user logging into the physical PAW does not have admin rights, access to the internet, or the ability to copy malicious virtual machine data from network shares or external storage devices onto the physical PAW.
4. Create a new GPO for the admin VMs to add PAW users to the Remote Desktop Users group. This will allow the users to use Hyper-V Enhanced Console Sessions, which offer a better user experience and enables smart card passthrough to the VM.

### Set up the Host Guardian Service

The Host Guardian Service is responsible for attesting to the identity and health of a physical PAW device.
Only those machines which are known to HGS and running a trusted [code integrity policy](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control) are allowed to start up shielded VMs.
This helps protect the shielded VMs, which run trusted workloads to manage your tiered resources, from user desktop environment threats.

Since HGS is responsible for determining which devices can run PAW VMs, it is considered a Tier 0 resource.
It should be deployed alongside other Tier 0 resources and protected from unauthorized physical and logical access.
HGS is a clustered role, making it easy to scale out for any size deployment.
The general rule is to plan 1 HGS server for every 1,000 devices you have, with a minimum of 3 nodes.

1. To install your first HGS server, start with the [Install HGS - Bastion Forest](../../security/guarded-fabric-shielded-vm/guarded-fabric-install-hgs-in-a-bastion-forest.md) article and join HGS to your Tier 0 domain.

2. Then, [create certificates for HGS](../../security/guarded-fabric-shielded-vm/guarded-fabric-obtain-certs.md) using your enterprise certificate authority.
Anyone in possession of the HGS encryption and signing certificates can decrypt a shielded VM, so if you have access to a Hardware Security Module to protect private keys, it is recommended that you generate these certificates using an HSM.
For stronger security, select a key size greater than or equal to 4096 bits.

3. Finally, follow the steps to [initialize your HGS server](../../security/guarded-fabric-shielded-vm/guarded-fabric-initialize-hgs-tpm-mode-bastion.md) in **TPM Mode**.
Initialization sets up the attestation and key protection web services used by your PAWs.
HGS should be [configured with a TLS certificate](../../security/guarded-fabric-shielded-vm/guarded-fabric-configure-hgs-https.md) to protect these communications, and only port 443 should be opened from untrusted networks to HGS.

4. Follow the steps to [add additional nodes](../../security/guarded-fabric-shielded-vm/guarded-fabric-configure-additional-hgs-nodes.md) for your second, third, and additional HGS nodes.

5. If your HGS server is running Windows Server 2019 or later, you can enable an optional feature to cache the keys for shielded VMs on PAWs so they can be used offline. The keys are sealed to the current security configuration of the system to prevent someone from using cached keys on another machine or the same machine in an insecure state. This may be a useful solution if your PAW users travel without access to the Internet but still need to be able to log into their PAW VMs. To use this feature, run the following command on any HGS server:

      ```powershell
      Set-HgsKeyProtectionConfiguration -AllowKeyMaterialCaching:$true
      ```

### Set up the physical PAW device

The physical PAW device is considered untrusted by default in the guarded fabric solution.
It can prove it is trustworthy during the attestation process, after which it can obtain the keys needed to start a shielded admin VM.
The device must be able to run Hyper-V and have Secure Boot and a TPM 2.0 enabled to meet the [guarded host prerequisites](../../security/guarded-fabric-shielded-vm/guarded-fabric-guarded-host-prerequisites.md).
The minimum operating system version to support all PAW functionality is **Windows 10 version 1803**.

The physical PAW should be set up like any other, with the exception that any PAW users will need to be Hyper-V Administrators to be able to turn the admin VM on and connect to it.
In your clean room environment, you will need to create a golden configuration for each unique hardware/software combination you are deploying as guarded hosts for admin VMs.
On each golden configuration, complete the following tasks:

1. Install the latest updates for Windows, drivers, and firmware on the machine as well as any third party management or monitoring agents.
2. [Capture the required baseline information](../../security/guarded-fabric-shielded-vm/guarded-fabric-tpm-trusted-attestation-capturing-hardware.md), including the unique TPM identifier (endorsement key), boot measurements (TCG log), and code integrity policy for the machine.
3. Copy these artifacts to an HGS server and run the HGS attestation commands in the previous article to register the host. If all your hosts use the same code integrity policy and/or use the same hardware configuration, you only need to register the code integrity policy/TCG log once.

### Create the signed template disk

Shielded VMs are created using signed template disks.
The signature is verified at deployment time to verify the disk integrity and authenticity before releasing secrets such as the administrator password into the VM.

To create a signed template disk, follow the phase 1 deployment steps on a regular, generation 2 virtual machine.
This machine will become the golden image for an admin VM.
You can create more than one template disk to have specialized tools available in different contexts.

When the VM is configured as desired, run `C:\Windows\System32\sysprep\sysprep.exe` and choose to **Generalize** the disk. **Shut down** the OS when generalization completes.

Finally, run the [Template Disk Wizard](../../security/guarded-fabric-shielded-vm/guarded-fabric-create-a-shielded-vm-template.md) on the VHDX file from the VM to install the BitLocker components and generate the disk signature.

#### Create the shielding data file

The generalized template disk is paired with a shielding data file, which contains the secrets needed to provision a shielded VM.
The shielding data file includes:
   - A list of guardians, which define the fabrics where the VM is allowed to run. Each HGS cluster is a guardian for the PAW devices it protects.
   - A list of disk signatures trusted for deployment. Shielding data files will only release their secrets to VMs created using authorized source media.
   - A security policy that dictates whether extra protections should be put in place to protect the VM from the host and whether the VM is allowed to move to another machine. PAW admin VMs should always be fully shielded.
   - The unattend.xml specialization file, which allows Windows to complete installation automatically and includes secrets like the local administrator's password.
   - Additional files, such as RDP or VPN certificates.

See the [shielding data file article](../../security/guarded-fabric-shielded-vm/guarded-fabric-tenant-creates-shielding-data.md) for steps on how to create a shielding data file.

The owner keys for shielded VMs are extremely sensitive and should be kept in an HSM or stored offline in a safe location.
They can be used in an emergency break glass scenario to boot a shielded VM without the presence of HGS.

It is strongly recommended that shielding data for PAW admin VMs include the setting to lock a VM to the first physical host where it is booted.
This will prevent someone from moving an admin VM from one PAW to another PAW in the same environment.
To use this feature, create the shielding data file with PowerShell and include the **BindToHostTpm** parameter:

```powershell
New-ShieldingDataFile -Policy Shielded -BindToHostTpm [...]
```

#### Deploy an admin VM

Once the template disk and shielding data file are ready, you can deploy an admin VM on any PAW that was registered with HGS.

1. Copy the template disk (.vhdx) and shielding data file (.pdk) to a trusted PAW device.
2. Follow the instructions to [deploy a new shielded VM using PowerShell](../../security/guarded-fabric-shielded-vm/guarded-fabric-create-a-shielded-vm-using-powershell.md)
3. Complete the remaining steps in phase 1 of the deployment process to secure the VM operating system and configure it for its intended role, as appropriate.


## Related topics

[Engaging Microsoft Cybersecurity Services](https://www.microsoft.com/microsoftservices/campaigns/cybersecurity-protection.aspx)

[Taste of Premier: How to Mitigate Pass-the-Hash and Other Forms of Credential Theft](https://channel9.msdn.com/Blogs/Taste-of-Premier/Taste-of-Premier-How-to-Mitigate-Pass-the-Hash-and-Other-Forms-of-Credential-Theft)

[Microsoft Advanced Threat Analytics](https://aka.ms/ata)

[Protect derived domain credentials with Credential Guard](https://technet.microsoft.com/library/mt483740%28v=vs.85%29.aspx)

[Device Guard Overview](https://technet.microsoft.com/library/dn986865(v=vs.85).aspx)

[Protecting high-value assets with secure admin workstations](https://msdn.microsoft.com/library/mt186538.aspx)

[Isolated User Mode in Windows 10 with Dave Probert (Channel 9)](https://channel9.msdn.com/Blogs/Seth-Juarez/Isolated-User-Mode-in-Windows-10-with-Dave-Probert)

[Isolated User Mode Processes and Features in Windows 10 with Logan Gabriel (Channel 9)](https://channel9.msdn.com/Blogs/Seth-Juarez/Isolated-User-Mode-Processes-and-Features-in-Windows-10-with-Logan-Gabriel)

[More on Processes and Features in Windows 10 Isolated User Mode with Dave Probert (Channel 9)](https://channel9.msdn.com/Blogs/Seth-Juarez/More-on-Processes-and-Features-in-Windows-10-Isolated-User-Mode-with-Dave-Probert)

[Mitigating Credential Theft using the Windows 10 Isolated User Mode (Channel 9)](https://channel9.msdn.com/Blogs/Seth-Juarez/Mitigating-Credential-Theft-using-the-Windows-10-Isolated-User-Mode)

[Enabling Strict KDC Validation in Windows Kerberos](https://www.microsoft.com/download/details.aspx?id=6382)

[What's New in Kerberos Authentication for Windows Server 2012](https://technet.microsoft.com/library/hh831747.aspx)

[Authentication Mechanism Assurance for AD DS in Windows Server 2008 R2 Step-by-Step Guide](https://technet.microsoft.com/library/dd378897(v=ws.10).aspx)

[Trusted Platform Module](C:/sd/docs/p_ent_keep_secure/p_ent_keep_secure/trusted_platform_module_technology_overview.xml)
