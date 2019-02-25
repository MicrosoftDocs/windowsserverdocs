---
title: Securing privileged access
description: 

ms.prod: windows-server-threshold
ms.topic: conceptual
ms.assetid: f5dec0c2-06fe-4c91-9bdc-67cc6a3ede60
ms.date: 02/14/2019

ms.author: joflore
author: MicrosoftGuyJFlo
manager: daveba
ms.reviewer: mas
---
# Securing privileged access

>Applies To: Windows Server

Securing privileged access is a critical first step to establishing security assurances for business assets in a modern organization. The security of most or all business assets in an IT organization depends on the integrity of the privileged accounts used to administer, manage, and develop. Cyber-attackers often target these accounts and other elements of privileged access to gain access to data and systems using credential theft attacks like [Pass-the-Hash and Pass-the-Ticket](https://www.microsoft.com/pth).

Protecting privileged access against determined adversaries requires you to take a complete and thoughtful approach to isolate these systems from risks.

## What are privileged accounts?

Before we talk about how to secure them lets define privileged accounts.

Today a privileged account could include things you may think of today like an Active Directory Domain Administrator, Azure Active Directory Global Administrator, a security or management tool administrator, or even your organization's social media account.

If compromised these accounts could potentially cause significant impact to your organization.

## Why securing privileged access is important?

In most organizations, the security of most or all business assets depends on the integrity of the privileged accounts that administer, manage, and develop information systems. Cyber-attackers focus on privileged access to systems like Active Directory (AD) to rapidly gain access to all of an organizations targeted data.

Traditional security approaches have focused on the network and firewalls as the primary security perimeter, but the effectiveness of network security has been significantly diminished by two trends:

* Organizations are hosting data and resources outside the traditional network boundary on mobile enterprise PCs, devices like mobile phones and tablets, cloud services, and bring your own devices (BYOD)
* Adversaries have demonstrated a consistent and ongoing ability to obtain access on workstations inside the network boundary through phishing and other web and email attacks.

These necessitate building a modern security perimeter out of authentication and authorization identity controls to supplement the traditional network perimeter strategy. A security perimeter here is defined as a consistent set of controls between assets and the threats to them. Privileged accounts are effectively in control of this new security perimeter so it's critical to protect privileged access.

![Diagram showing an organization's identity layer](../media/securing-privileged-access/PAW_LP_Fig2.JPG)

An attacker that gains control of an administrative account can use those privileges to increase their impact in the target organization as depicted below:

![Diagram showing how an adversary that gains control of an administrative account can use those privileges to pursue their gain at the expense of the target organization](../media/securing-privileged-access/PAW_LP_Fig3.JPG)

The illustration below depicts two paths:

* A "blue" path where a standard user account is used for non-privileged access to resources like email and web browsing and day to day work are completed.
* A "red" path where privileged access occurs on a hardened device to reduce the risk of phishing and other web and email attacks.

![Diagram showing the separate "path" for administration that the roadmap establishes to isolate privileged access tasks from high risk standard user tasks like web browsing and accessing email](../media/securing-privileged-access/PAW_LP_Fig4.JPG)

An attacker can gain control of privileged access using a variety of methods, mitigating the risk requires a holistic and detailed technical approach as outlined in this roadmap. The roadmap will help isolate and harden the elements in your environment that enable privileged access. by building mitigations in each area of the defense column in this figure:

![Table showing attack and defense columns](../media/securing-privileged-access/PAW_LP_Fig5.JPG)

## Securing privileged access roadmap

The roadmap is designed to maximize the use of technologies that you already have deployed, take advantage of key current and upcoming security technologies, and integrate any 3rd party security tools you may already have deployed.

The roadmap of Microsoft recommendations is broken into 3 phases:

* [Phase 1: First 30 days](#phase-1-mitigate-frequently-used-attack-techniques)
   * Quickly mitigate the most frequently used attack techniques.
* [Phase 2: 90 days](#phase-2-enhance-visibility-and-control-of-privileged-access)
   * Enhance visibility and control of privileged access.
* [Phase 3: Ongoing](#phase-3-continue-to-build-defenses)
   * Continue to build defenses to enable proactive security posture.

Each phase of the roadmap is designed to raise the cost and difficulty for adversaries to attack privileged access for your on-premises and cloud assets. The roadmap is prioritized to schedule the most effective and the quickest implementations first based on our experiences with these attacks and solution implementation.

Microsoft recommends you follow this roadmap to secure privileged access against determined adversaries. You may adjust this roadmap to accommodate your existing capabilities and specific requirements in your organizations.

> [!NOTE]
> Securing privileged access requires a broad range of elements including technical components (host defenses, account protections, identity management, etc.) as well as changes to process, and administrative practices and knowledge. The timelines for the roadmap are approximate and are based on our experience with customer implementations. The duration will vary in your organization depending on the complexity of your environment and your change management processes.

## Phase 1: Mitigate frequently used attack techniques

Phase 1 of the roadmap is focused on quickly mitigating the most frequently used attack techniques of credential theft and abuse. Phase 1 is designed to be implemented in approximately 30 days and is depicted in this diagram:

![Figure showing that stage 1 is designed to be implemented in approximately 2-4 weeks](../media/securing-privileged-access/PAW_LP_Fig6.JPG)

### 1. Separate accounts

To help separate internet risks (phishing attacks, web browsing) from privileged access accounts, create a dedicated account for all personnel with privileged access. Administrators should not be browsing the web, checking their email, and doing day to day productivity tasks with highly privileged accounts. More information on this can be found in the section [Separate administrative accounts](securing-privileged-access-reference-material.md#separate-administrative-accounts) of the reference document.

Follow the guidance in the article [Manage emergency access accounts in Azure AD](/azure/active-directory/users-groups-roles/directory-emergency-access) to create at least two emergency access accounts, with permanently assigned administrator rights, in both your on-premises AD and Azure AD environments. These accounts are only for use when traditional administrator accounts are unable to perform a required task such as in a the case of a disaster.

### 2. Just in time local admin passwords

To mitigate the risk of an adversary stealing a local administrator account password hash from the local SAM database and abusing it to attack other computers, organizations should ensure every machine has a unique local administrator password. The Local Administrator Password Solution (LAPS) tool can configure unique random passwords on each workstation and server store them in Active Directory (AD) protected by an ACL. Only eligible authorized users can read or request the reset of these local administrator account passwords. You can obtain the Local Administrator Password Solution for use on workstations and servers from [the Microsoft Download Center](http://Aka.ms/LAPS).

Additional guidance for operating an environment with LAPS and PAWs can be found [here](http://aka.ms/securitystandards).

### 3. Administrative workstations

As an initial security measure for those users with Azure Active Directory and traditional on-premises Active Directory administrative privileges, ensure they are using Windows 10 devices configured with the [Standards for a highly secure Windows 10 device](/windows-hardware/design/device-experiences/oem-highly-secure). This maps to [Phase 1: Immediate deployment for Active Directory administrators](privileged-access-workstations.md#phase-1-immediate-deployment-for-active-directory-administrators) of a privileged admin workstation rollout.

### 4. Identity attack detection

[Azure Advanced Threat Protection (ATP)](/azure-advanced-threat-protection/what-is-atp) is a cloud-based security solution that identifies, detects, and helps you investigate advanced threats, compromised identities, and malicious insider actions directed at your on-premises Active Directory environment.

## Phase 2: Enhance visibility and control of privileged access

Phase 2 builds on the work done in phase 1 and is designed to be completed in approximately 90 days. The steps of this stage are depicted in this diagram:

![Diagram showing the steps of stage 2](../media/securing-privileged-access/PAW_LP_Fig7.JPG)

### 1. Require Windows Hello for Business and MFA

Administrators can benefit from the ease of use associated with Windows Hello for Business. Admins can replace their complex passwords with strong two-factor authentication on their PCs. An attacker must have both the device and the biometric info or PIN, it’s much more difficult to gain access without the employee’s knowledge. More details about Windows Hello for Business and the path to roll out can be found in the article [Windows Hello for Business Overview](/windows/security/identity-protection/hello-for-business/hello-overview)

Enable multi-factor authentication (MFA) for your administrator accounts in Azure AD using Azure MFA. At minimum enable the [baseline protection conditional access policy](/azure/active-directory/conditional-access/baseline-protection#require-mfa-for-admins) more information about Azure Multi-Factor Authentication can be found in the article [Deploy cloud-based Azure Multi-Factor Authentication](/azure/active-directory/authentication/howto-mfa-getstarted)

### 2. Deploy PAW to all privileged identity access account holders

Continuing the process of separating privileged accounts from threats found in email, web browsing, and other non-administrative tasks, implement dedicated Privileged Access Workstations (PAW) for all personnel with privileged access to your organization's information systems. Additional guidance for PAW deployment can be found in the article [Privileged Access Workstations](privileged-access-workstations.md#paw-phased-implementation).

### 3. Just in time privileges

To lower the exposure time of privileges and increase visibility into their use, provide privileges just in time (JIT) using an appropriate solution such as the ones below:

* For Active Directory Domain Services (AD DS), use Microsoft Identity Manager (MIM)'s [Privileged Access Manager (PAM)](/microsoft-identity-manager/pam/privileged-identity-management-for-active-directory-domain-services) capability.
* For Azure Active Directory, use [Azure AD Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-deployment-plan) capability.

### 4. Enable Windows Defender Credential Guard

Enabling Credential Guard helps to protect NTLM password hashes, Kerberos Ticket Granting Tickets, and credentials stored by applications as domain credentials. This capability helps to prevent credential theft attacks, such as Pass-the-Hash or Pass-The-Ticket. Information on how Credential Guard works and how to deploy can be found in the article [Protect derived domain credentials with Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard)

### 5. Leaked credentials reporting

"Every day, Microsoft analyzes over 6.5 trillion signals in order to identify emerging threats and protect customers" - [Microsoft By the Numbers](https://news.microsoft.com/bythenumbers/cyber-attacks)

Put Microsoft Azure AD Identity Protection to work for your organization to report on and allow you to manually take action on users with leaked credentials. [Azure AD Identity Protection](/azure/active-directory/identity-protection/index) can be leveraged to help your organization protect cloud and hybrid environments from threats.

### 6. Azure ATP Lateral Movement Paths

Ensure privileged access account holders are using their PAW for administration only so that a compromised non-privileged accounts cannot gain access to a privileged account via credential theft attacks, such as Pass-the-Hash or Pass-The-Ticket. [Azure ATP Lateral Movement Paths (LMPs)](/azure-advanced-threat-protection/use-case-lateral-movement-path) provides easy to understand reporting to identify where privileged accounts may be open to compromise.

## Phase 3: Continue to build defenses

Phase 3 of the roadmap builds on the steps taken in Phases 1 and 2 to strengthen your security posture. Phase 3 is depicted visually in this diagram:

![Diagram showing stage 3](../media/securing-privileged-access/PAW_LP_Fig8.JPG)

These capabilities will build on the steps from previous phases and move your defenses into a more proactive posture. This phase has no specific timeline and may take longer to implement based on your individual organization.

### 1. Review role-based access control

Using the three tiered model outlined in the article [Active Directory administrative tier model](securing-privileged-access-reference-material.md), review and curtail the access given to administrators to reduce the threat of compromise.

### 2. Reduce attack surfaces

Harden your identity workloads including Domains, Domain Controllers, ADFS, and Azure AD Connect since compromising one of these systems could result in compromise of other systems in your organization. The articles [Reducing the Active Directory Attack Surface](../ad-ds/plan/security-best-practices/reducing-the-active-directory-attack-surface.md) and [Five steps to securing your identity infrastructure](/azure/security/azure-ad-secure-steps) provide guidance for securing your on-premises and hybrid identity environments.

### 3. Integrate logs with SEIM

The articles [Monitoring Active Directory for Signs of Compromise](../ad-ds/plan/security-best-practices/monitoring-active-directory-for-signs-of-compromise.md) and [Appendix L: Events to Monitor](../ad-ds/plan/appendix-l--events-to-monitor#appendix-l-events-to-monitor.md) provide guidance on events that should be monitored in your environment. Integrating this logging into a centralized security information and event management (SEIM) tool can help your organization to analyze, detect, and respond to security events.

### 4. Leaked credentials - Force password reset

Continue to enhance your security posture by enabling Azure AD Identity Protection to automatically force password resets when passwords are suspected of compromise. The guidance found in the article [Use risk events to trigger Multi-Factor Authentication and password changes](/azure/active-directory/authentication/tutorial-risk-based-sspr-mfa) explains how to enable this using a conditional access policy.

## Am I done?

The short answer is no.

The bad guys never stop, so neither can you. This roadmap can only help your organization protect against currently known threats as security threats will constantly evolve and shift. We recommend you view security as an ongoing process focused on raising the cost and reducing the success rate of adversaries targeting your environment.

Securing privileged access is a critical first step to establishing security assurances for business assets in a modern organization, but it is not the only part of a complete security program that would include elements like policy, operations, information security, servers, applications, PCs, devices, cloud fabric, and other components provide the security assurances you require.

For more information on building a complete security roadmap, see the "Customer responsibilities and roadmap" section of the Microsoft Cloud Security for Enterprise Architects document available [here](http://aka.ms/securecustomer).

For more information on engaging Microsoft services to assist with any of these topics, contact your Microsoft representative or visit [this page](https://www.microsoft.com/en-us/microsoftservices/campaigns/cybersecurity-protection.aspx).

### Next steps

[Privileged Access Workstations](privileged-access-workstations.md)

[Active Directory administrative tier model](securing-privileged-access-reference-material.md)