---
title: Securing Privileged Access Reference Material
description: Operational security controls for Windows Server Active Directory Domains 

ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 22ee9a77-4872-4c54-82d9-98fc73a378c0
ms.date: 02/14/2019

ms.author: joflore
author: MicrosoftGuyJFlo
manager: daveba
ms.reviewer: mas
---
# Active Directory administrative tier model

>Applies To: Windows Server

The purpose of this tier model is to protect identity systems using a set of buffer zones between full control of the Environment (Tier 0) and the high risk workstation assets that attackers frequently compromise.

![Diagram showing the three layers of the Tier model](../media/securing-privileged-access-reference-material/PAW_RM_Fig1.JPG)

The Tier model is composed of three levels and only includes administrative accounts, not standard user accounts:

- **Tier 0** - Direct Control of enterprise identities in the environment. Tier 0 includes accounts, groups, and other assets that have direct or indirect administrative control of the Active Directory forest, domains, or domain controllers, and all the assets in it. The security sensitivity of all Tier 0 assets is equivalent as they are all effectively in control of each other.
- **Tier 1** - Control of enterprise servers and applications. Tier 1 assets include server operating systems, cloud services, and enterprise applications. Tier 1 administrator accounts have administrative control of a significant amount of business value that is hosted on these assets. A common example role is server administrators who maintain these operating systems with the ability to impact all enterprise services.
- **Tier 2** - Control of user workstations and devices. Tier 2 administrator accounts have administrative control of a significant amount of business value that is hosted on user workstations and devices. Examples include Help Desk and computer support administrators because they can impact the integrity of almost any user data.

> [!NOTE]
> The tiers also serve as a basic prioritization mechanism for protecting administrative assets, but it is important to consider that an attacker with control of all assets at any tier can access most or all business assets. The reason it is useful as a basic prioritization mechanism is attacker difficulty/cost. It is easier for an attacker to operate with full control of all identities (Tier 0) or servers and cloud services (Tier 1) than it is if they must access each individual workstation or user device (Tier 2) to get your organization's data.

## Containment and security zones

The tiers are relative to a specific security zone. While they have gone by many names, security zones are a well-established approach that provide containment of security threats through network layer isolation between them. The tier model complements the isolation by providing containment of adversaries within a security zone where network isolation isn't effective. Security zones can span both on-premises and cloud infrastructure, such as in the example where Domain Controllers and domain members in the same domain are hosted on-premises and in Azure.

![Diagram showing how Security zones can span both on-premises and cloud infrastructure](../media/securing-privileged-access-reference-material/PAW_RM_Fig2.JPG)

The Tier model prevents escalation of privilege by restricting what administrators can control and where they can log on (because logging on to a computer grants control of those credentials and all assets managed by those credentials).

### Control restrictions

Control restrictions are shown in the figure below:

![Diagram of Control restrictions](../media/securing-privileged-access-reference-material/PAW_RM_Fig3.JPG)

### Primary responsibilities and critical restrictions

**Tier 0 administrator** -  manage the identity store and a small number of systems that are in effective control of it, and:

- Can manage and control assets at any level as required
- Can only log on interactively or access assets trusted at the Tier 0 level

**Tier 1 administrator** -  manage enterprise servers, services, and applications, and:

- Can only manage and control assets at the Tier 1 or Tier 2 level
- Can only access assets (via network logon type) that are trusted at the Tier 1 or Tier 0 levels
- Can only interactively log on to assets trusted at the Tier 1 level

**Tier 2 administrator** - manage enterprise desktops, laptops, printers, and other user devices, and:

- Can only manage and control assets at the Tier 2 level
- Can access assets (via network logon type) at any level as required
- Can only interactively log on to assets trusted at Tier 2 level

### Logon restrictions

Logon restrictions are shown in the figure below:

![Diagram of logon restrictions](../media/securing-privileged-access-reference-material/PAW_RM_Fig4.JPG)

> [!NOTE]
> Note that some assets can have Tier 0 impact to availability of the environment, but do not directly impact the confidentiality or integrity of the assets. These include the DNS Server service and critical network devices like Internet proxies.

## Clean source principle

The clean source principle requires all security dependencies to be as trustworthy as the object being secured.

![Diagram showing how a subject in control of an object is a security dependency of that object](../media/securing-privileged-access-reference-material/PAW_RM_Fig5.JPG)

Any subject in control of an object is a security dependency of that object. If an adversary can control anything in effective control of a target object, they can control that target object. Because of this, you must ensure that the assurances for all security dependencies are at or above the desired security level of the object itself.

While simple in principle, applying this requires understanding the control relationships of an asset of interest (Object) and performing a dependency analysis of it to discover all security dependencies (Subject(s)).

Because control is transitive, this principle has to be repeated recursively. For example if A controls B and B controls C, then A also indirectly controls C.

![Diagram showing how if A controls B, and B controls C, then A also indirectly controls C](../media/securing-privileged-access-reference-material/PAW_RM_Fig6.JPG)

An attacker that compromises A gets access to everything A controls (including B), and everything B controls (including C). Using the language of security dependencies on this same example, both B and A are security dependencies of C and have to be secured at the desired assurance level of C in order for C to have that assurance level.

For IT infrastructure and identity systems, this principle should be applied to the most common means of control including the hardware where systems are installed, the installation media for the systems, the architecture and configuration of the system, and daily operations.

## Clean Source for installation media

![Diagram showing a clean source for installation media](../media/securing-privileged-access-reference-material/PAW_RM_CSIM.JPG)

Applying the clean source principle to installation media requires you to ensure that the installation media has not been tampered with since being released by the manufacturer (as best you are able to determine). This figure depicts an attacker using this path to compromise a computer:

![Figure showing an attacker using a path to compromise a computer](../media/securing-privileged-access-reference-material/PAW_RM_Fig8.JPG)

Applying the clean source principle to installation media requires validating the software integrity throughout the cycle you possess it including during acquisition, storage, and transfer up until it is used.

### Software acquisition

The source of the software should be validated through one of the following means:

- Software is obtained from physical media that is known to come from the manufacturer or a reputable source, typically manufactured media shipped from a vendor.
- Software is obtained from the Internet and validated with vendor-provided file hashes.
- Software is obtained from the Internet and validated by downloading and comparing two independent copies:
   - Download to two hosts with no security relationship (not in the same domain and not managed by the same tools), preferably from separate Internet connections.
   - Compare the downloaded files using a utility like certutil:
      `certutil -hashfile <filename>`

When possible, all application software, such as application installers and tools should be digitally signed and verified using Windows Authenticode with the [Windows Sysinternal](https://www.microsoft.com/sysinternals)s tool, *sigcheck.exe*, with revocation checking. Some software may be required where the vendor may not provide this type of digital signature.

### Software storage and transfer

After obtaining the software, it should be stored in a location that is protected from modification, especially by internet-connected hosts or personnel trusted at a lower level than the systems where the software or operating system will be installed. This storage can be physical media or a secure electronic location.

### Software usage

Ideally, the software should be validated at the time it is used, such as when it is manually installed, packaged for a configuration management tool, or imported into a configuration management tool.

## Clean source for architecture and design

Applying the clean source principle to the system architecture requires you to ensure that the system is not dependent on lower trust systems. A system can be dependent on a higher trust system, but not on a lower trust system with lower security standards.

As an example, its acceptable for Active Directory to control a standard user desktop but it's a significant escalation of privilege risk for a standard user desktop to be in control of the Active Directory.

![Diagram showing how a system can be dependent on a higher trust system, but not on a lower trust system with lower security standards](../media/securing-privileged-access-reference-material/PAW_RM_Fig09.JPG)

The control relationship can be introduced through many means including security Access Control Lists (ACLs) on objects like filesystems, membership in the local administrators group on a computer, or agents installed on a computer running as System (with the ability to run arbitrary code and scripts).

A frequently overlooked example is exposure through logon, which creates a control relationship by exposing administrative credentials of a system to another system. This is the underlying reason why credential theft attacks like pass the hash are so powerful. When an administrator logs in to a standard user desktop with Tier 0 credentials, they are exposing those credentials to that desktop, putting it in control of AD, and creating an escalation of privilege path to AD. For more information on these attacks, see [this page](https://technet.microsoft.com/security/dn785092).

Because of the large number of assets that depend on identity systems like Active Directory, you should minimize the number of systems your Active Directory and Domain Controllers depend on.

![Diagram showing that you should minimize the number of systems your Active Directory and Domain Controllers depend on](../media/securing-privileged-access-reference-material/PAW_RM_Fig010.JPG)

For more information on hardening the top risks of active directory, see [this page](http://aka.ms/hardenAD).

## Operational standards based on clean source principle

This section describes the operational standards and expectations for administrative personnel. These standards are designed to secure administrative control of an organization's information technology systems against risks that could be created by operational practices and processes.

![Diagram showing how standards are designed to secure administrative control of an organization's information technology systems against risks that could be created by operational practices and processes](../media/securing-privileged-access-reference-material/PAW_RM_Fig11.JPG)

### Integrating the standards

You can integrate these standards into your organization's overall standards and practices. You can adapt these to the specific requirements, available tools, and risk appetite of your organization, but we recommend only minimum modifications to reduce risk. We recommend you use the defaults in this guidance as the benchmark for your ideal end state and manage any deltas as exceptions to be addressed in priority order.

The standards guidance is organized into these sections:

- Assumptions
- Change Advisory Board
- Operational Practices
   - Summary
   - Standards Details

### Assumptions

The standards in this section assume that the organization has the following attributes:

- Most or all servers and workstations in scope are joined to Active Directory.
- All servers to be managed are running Windows Server 2008 R2 or later and have RDP RestrictedAdmin mode enabled.
- All workstations to be managed are running Windows 7 or later and have RDP RestrictedAdmin mode enabled.

   > [!NOTE]
   > To enable RDP RestrictedAdmin mode, see [this page](http://aka.ms/RDPRA).

- Smart cards are available and issued to all administrative accounts.
- The *Builtin\Administrator* for each domain has been designated as an emergency access account
- An enterprise identity management solution is deployed.
- [LAPS](http://aka.ms/laps) has been deployed to servers and workstations to manage the local administrator account password
- There is a privileged access management solution, such as Microsoft Identity Manager, in place, or there is a plan to adopt one.
- Personnel are assigned to monitor security alerts and respond to them.
- The technical capability to rapidly apply Microsoft security updates is available.
- Baseboard management controllers on servers will not be used, or will adhere to strict security controls.
- Administrator accounts and groups for servers (Tier 1 admins) and workstations (Tier 2 admins) will be managed by domain admins (Tier 0).
- There is a Change Advisory Board (CAB) or another designated authority in place for approving Active Directory changes.

### Change advisory board

A Change Advisory Board (CAB) is the discussion forum and approval authority for changes that could impact the security profile of the organization. Any exceptions to these standards should be submitted to the CAB with a risk assessment and justification.

Each standard in this document is broken out by the criticality of meeting the standard for a given Tier level.

![Diagram showing the standard for given Tier levels](../media/securing-privileged-access-reference-material/PAW_RM_Fig12.JPG)

All exceptions for Mandatory items (marked with red octagon or an orange triangle in this document) are considered temporary, and they need to be approved by the CAB. Guidelines include:

- The initial request requires justification risk acceptance signed by personnel's immediate supervisor, and it expires after six months.
- Renewals require justification and risk acceptance signed by a business unit director, and they expire after six months.

All exceptions for Recommended items (marked with a yellow circle in this document) are considered temporary, and need to be approved by the CAB. Guidelines include:

- The initial request requires justification risk acceptance signed by personnel's immediate supervisor, and it expires after 12 months.
- Renewals require justification and risk acceptance signed by a business unit director, and they expire after 12 months.

### Operational practices standards summary

The Tier columns in this table refer to the Tier level of the administrative account, the control of which typically impacts all assets in that tier.

![Table showing Tier levels of the admninistrative account](../media/securing-privileged-access-reference-material/PAW_RM_Fig13.JPG)

Operational decisions that are made on a regular basis are critical to maintaining the security posture of the environment. These standards for processes and practices help ensure that an operational error does not lead to an exploitable operational vulnerability in the environment.

#### Administrator enablement and accountability

Administrators must be informed, empowered, trained, and held accountable to operate the environment as securely as possible.

##### Administrative personnel standards

Assigned administrative personnel must be vetted to ensure they are trustworthy and have a need for administrative privileges:

- Perform background checks on personnel prior to assigning administrative privileges.
- Review administrative privileges each quarter to determine which personnel still have a legitimate business need for administrative access.

##### Administrative security briefing and accountability

Administrators must be informed and accountable for the risks to the organization and their role in managing that risk. Administrators should be trained yearly on:

- General threat environment
   - Determined adversaries
   - Attack techniques including pass-the-hash and credential theft
- Organization-specific threats and incidents
- Administrator's roles in protecting against attacks
   - Managing credential exposure with the Tier model
   - Use of administrative workstations
   - Use of Remote Desktop Protocol RestrictedAdmin mode
- Organization-specific administrative practices
   - Review all operational guidelines in this standard
   - Implement the following key rules:
      - Do not use administrative accounts on anything but administrative workstations
      - Do not disable or dismantle security controls on your account or workstations (for example, logon restrictions or attributes required for smart cards)
      - Report issues or unusual activity

To provide accountability, all personnel with administrative accounts should sign an Administrative Privilege Code of Conduct document that says they intend to follow organization-specific administrative policy practices.

##### Provisioning and deprovisioning processes for administrative accounts

The following standards must be met for meeting lifecycle requirements.

- All administrative accounts must be approved by the Approving Authority outlined in the following table.
   - Approval must only be granted if the personnel have a legitimate business need for administrative privileges.
   - Approval for administrative privileges should not exceed six months.
- Access to administrative privileges must be immediately deprovisioned when:
   - Personnel change positions.
   - Personnel leave the organization.
- Accounts must be immediately disabled following personnel leaving the organization.
- Disabled accounts must be deleted within six months and the record of their deletion must be entered into change approval board records.
- Review all privileged account memberships monthly to ensure that no unauthorized permissions have been granted. This can be replaced by an automated tool that alerts changes.

|Account Privilege Level|Approving Authority|Membership Review Frequency|
|--------------|------------|----------------|
|Tier 0 Administrator|Change approval board|Monthly or automated|
|Tier 1 Administrator|Tier 0 administrators or security|Monthly or automated|
|Tier 2 Administrator|Tier 0 administrators or security|Monthly or automated|

#### Operationalize least privilege

These standards help achieve least privilege by reducing the number of administrators in role and the amount of time that they have privileges.

> [!NOTE]
> Achieving least privilege in your organization will require understanding the organizational roles, their requirements, and their designing mechanisms to ensure that they are able to accomplish their job by using least privilege. Achieving a state of least privilege in an administrative model frequently requires the use of multiple approaches:
>
> - Limit the count of administrators or members of privileged groups
> - Delegate fewer privileges to accounts
> - Provide time-bound privileges on demand
> - Provide ability for other personnel to perform tasks (a concierge approach)
> - Provide processes for emergency access and rare-use scenarios

##### Limit count of administrators

A minimum of two qualified personnel should be assigned to each administrative role to ensure business continuity.

If the number of personnel assigned to any role exceeds two, the change approval board must approve the specific reasons for assigning privileges to each individual member (including the original two). The justification for the approval must include:

- What technical tasks are performed by the administrators that require the administrative privileges
- How often are the tasks performed
- Specific reason why the tasks cannot be performed by another administrator on their behalf
- Document all other known alternative approaches to granting the privilege and why each isn't acceptable

##### Dynamically assign privileges

Administrators are required to obtain permissions "just-in-time" to use them as they perform tasks. No permissions will be permanently assigned to administrative accounts.

> [!NOTE]
> Permanently assigned administrative privileges naturally create a "most privilege" strategy because administrative personnel require rapid access to permissions to maintain operational availability if there is an issue. Just-in-time permissions provide the ability to:
>
> - Assign permissions more granularly, getting closer to least privilege.
> - Reduce the exposure time of privileges
> - Tracking permissions use to detect abuse or attacks.

#### Manage Risk of Credential Exposure

Use the following practices to proper manage risk of credential exposure.

##### Separate administrative accounts

All personnel that are authorized to possess administrative privileges must have separate accounts for administrative functions that are distinct from user accounts.

- **Standard user accounts** - Granted standard user privileges for standard user tasks, such as email, web browsing, and using line-of-business applications. These accounts should not be granted administrative privileges.
- **Administrative accounts** - Separate accounts created for personnel who are assigned the appropriate administrative privileges. An administrator who is required to manage assets in each Tier should have a separate account for each Tier. These accounts should have no access to email or the public Internet.

##### Administrator logon practices

Before an administrator can log on to a host interactively (locally over standard RDP, by using RunAs, or by using the virtualization console), that host must meet or exceed the standard for the admin account Tier (or a higher Tier).

Administrators can only sign in to admin workstations with their administrative accounts. Administrators only log on to managed resources by using the approved support technology described in the next section.

> [!NOTE]
> This is required because logging onto a host interactively grants control of the credentials to that host.
>
> See the [Administrative Tools and Logon Types](http://aka.ms/admintoolsecurity) for details about logon types, common management tools, and credential exposure.

##### Use of approved support technology and methods

Administrators who support remote systems and users must follow these guidelines to prevent an adversary in control of the remote computer from stealing their administrative credentials.

- The primary support options should be used if they are available.
- The secondary support options should only be used if the primary support option is not available.
- Forbidden support methods may never be used.
- No internet browsing or email access may be performed by any administrative account at any time.

###### Tier 0 forest, domain, and DC administration

Ensure that the following practices are applied for this scenario:

- **Remote server support** - When remotely accessing a server, Tier 0 administrators must follow these guidelines:
  - **Primary (tool)** - Remote tools that use network logons (type 3). For more information, see [Administrative Tools and Logon Types](http://aka.ms/admintoolsecurity).
  - **Primary (interactive)** - Use RDP RestrictedAdmin or a Standard RDP Session from an admin workstation with a domain account

    > [!NOTE]
    > If you have a Tier 0 privilege management solution, add "that uses permissions obtained just-in-time from a privileged access management solution."

- **Physical server support** - When physically present at a server console or at a virtual machine console (Hyper-V or VMWare tools), these accounts have no specific administrative tool usage restrictions, only the general restrictions from standard user tasks like email and browsing the open internet.

   > [!NOTE]
   > Tier 0 administration is different from administration of other tiers because all Tier 0 assets already have direct or indirect control of all assets. As an example, an attacker in control of a DC has no need to steal credentials from logged on administrators as they already have access to all domain credentials in the database.

###### Tier 1 server and enterprise application support

Ensure that the following practices are applied for this scenario:

- **Remote server support** - When remotely accessing a server, Tier 1 administrators must follow these guidelines:
   - **Primary (tool)** - Remote tools that use network logons (type 3). For more information, see [Mitigating Pass-the-Hash and Other Credential Theft](https://www.microsoft.com/pth) v1 (pp 42-47).
   - **Primary (interactive)** - Use RDP RestrictedAdmin from an admin workstation with a domain account that uses permissions obtained just-in-time from a privileged access management solution.
   - **Secondary** - Log on to the server by using a local account password that is set by LAPS from an admin workstation.
   - **Forbidden** - Standard RDP may not be used with a domain account.
   - **Forbidden** - Using the domain account credentials while in the session (for example, using *RunAs* or authenticating to a share). This exposes the logon credentials to the risk of theft.
- **Physical server support** - When physically present at a server console or at a virtual machine console (Hyper-V or VMWare tools), Tier 1 administrators must retrieve the local account password from LAPS prior to accessing the server.
   - **Primary** - Retrieve the local account password set by LAPS from an admin workstation before logging on to the server.
   - **Forbidden** - Logging on with a domain account is not allowed in this scenario.
   - **Forbidden** - Using the domain account credentials while in the session (for example, RunAs or authenticating to a share). This exposes the logon credentials to the risk of theft.

###### Tier 2 help desk and user support

Help Desk and user support organizations perform support for end users (which doesn't require administrative privileges) and the user workstations (which does require administrative privileges).

**User support** - Tasks include assisting users with performing tasks that require no modification to the workstation, frequently showing them how to use an application feature or operating system feature.

- **Desk-side user support** - The Tier 2 support personnel is physically at the user's workspace.
   - **Primary** - "Over the shoulder" support can be provided with no tools.
   - **Forbidden** - Logging on with domain account administrative credentials is not allowed in this scenario. Switch to desk-side workstation support if administrative privileges are required.
- **Remote user support** - The Tier 2 support personnel is physically remote to the user.
   - **Primary** - Remote Assistance, Skype for Business, or similar user-screen sharing may be used. For more information, see [What is Windows Remote Assistance?](https://windows.microsoft.com/en-us/windows/what-is-windows-remote-assistance)
   - **Forbidden** - Logging on with domain account administrative credentials is not allowed in this scenario. Switch to workstation support if administrative privileges are required.
- **Workstation support** - Tasks include performing workstation maintenance or troubleshooting that requires access to a system for viewing logs, installing software, updating drivers, and so on.
   - **Desk-side workstation support** - The Tier 2 support personnel is physically at the user's workstation.
      - **Primary** - Retrieve the local account password set by LAPS from an admin workstation before connecting to user workstation.
      - **Forbidden** - Logging on with domain account administrative credentials is not allowed in this scenario.
   - **Remote workstation support** - The Tier 2 support personnel is physically remote to the workstation.
      - **Primary** - Use RDP RestrictedAdmin from an admin workstation with a domain account that uses permissions obtained just-in-time from a privileged access management solution.
      - **Secondary** - Retrieve a local account password set by LAPS from an admin workstation before connecting to user workstation.
      - **Forbidden** - Use standard RDP with a domain account.

###### No browsing the public Internet with admin accounts or from admin workstations

Administrative personnel cannot browse the open Internet while logged on with an administrative account or while logged on to an administrative workstation. The only authorized exceptions are the use of a web browser to administer a cloud-based service.

###### No accessing email with admin accounts or from admin workstations

Administrative personnel cannot access email while logged on with an administrative account or while logged on to an administrative workstation.

###### Store service and application account passwords in a secure location

The following guidelines should be used for the physical security processes that control access to the password:

- Lock the service account passwords in a physical safe.
- Ensure that only personnel trusted at or above the Tier classification of the account have access to the account password.
- Limit the number of people who access to the passwords to a minimum number to for accountability.
- Ensure that all access to the password is logged, tracked, and monitored by a disinterested party, such as a manager who is not trained to perform IT administration.

##### Strong Authentication

Use the following practices to proper configure strong authentication.

###### Enforce smartcard multi-factor authentication (MFA) for all admin accounts

No administrative account is allowed to use a password for authentication. The only authorized exceptions are the emergency access accounts that are protected by the appropriate processes.

Link all administrative accounts to a smart card and enable the attribute "**Smart Card Required for Interactive Logon**."

A script should be implemented to automatically and periodically reset the random password hash value by disabling and immediately re-enabling the attribute "**Smart Card Required for Interactive Logon**."

Allow no exceptions for accounts used by human personnel beyond the emergency access accounts.

###### Enforce Multi-Factor Authentication for All Cloud Admin Accounts

All accounts with administrative privileges in a cloud service, such as Microsoft Azure and Office 365, must use multi-factor authentication.

##### Rare Use emergency procedures

Operational practices must support the following standards:

- Ensure outages can be resolved quickly.
- Ensure rare high-privilege tasks can be completed as needed.
- Ensure safe procedures are used to protect the credentials and privileges.
- Ensure appropriate tracking and approval processes are followed.

###### Correctly follow appropriate processes for all emergency access accounts

Ensure that each emergency access account has a tracking sheet in the safe.

The procedure documented on the password tracking sheet should be followed for each account, which includes changing the password after each use and logging out of any workstations or servers used after completion.

All use of emergency access accounts should be approved by the change approval board in advanced or after-the-fact as an approved emergency usage.

###### Restrict and monitor usage of emergency access accounts

For all use of emergency access accounts:

- Only authorized domain admins can access the emergency access accounts with domain admin privileges.
- The emergency access accounts can be used only on domain controllers and other Tier 0 hosts.
- This account should be used only to:
  - Perform troubleshooting and correction of technical issues that are preventing the use of the correct administrative accounts.
  - Perform rare tasks, such as:
    - Schema administration
    - Forest-wide tasks that require enterprise administrative privileges

      > [!NOTE]
      > Topology management including Active Directory site and subnet management is delegated to limit the use of these privileges.

- All usage of one of these accounts should have written authorization by the security group lead
- The procedure on the tracking sheet for each emergency access account requires the password to be changed for each use. A security team member should validate that this happened correctly.

###### Temporarily assign enterprise admin and schema admin membership

Privileges should be added as needed and removed after use. The emergency account should have these privileges assigned for only the duration of the task to be completed, and for a maximum of 10 hours. All usage and duration of these privileges should be captured in the change approval board record after the task is completed.

## ESAE Administrative Forest Design Approach

This section contains an approach for an administrative forest based on the Enhanced Security Administrative Environment (ESAE) reference architecture deployed by Microsoft's cybersecurity professional services teams to protect customers against cybersecurity attacks.

Dedicated administrative forests allow organizations to host administrative accounts, workstations, and groups in an environment that has stronger security controls than the production environment.

This architecture enables a number of security controls that aren't possible or easily configured in a single forest architecture, even one managed with Privileged Access Workstations (PAWs). This approach allows the provisioning of accounts as standard non-privileged users in the administrative forest that are highly privileged in the production environment, enabling greater technical enforcement of governance. This architecture also enables the use of the selective authentication feature of a trust as a means to restrict logons (and credential exposure) to only authorized hosts. In situations in which a greater level of assurance is desired for the production forest without incurring the cost and complexity of a complete rebuild, an administrative forest can provide an environment that increases the assurance level of the production environment.

While this approach does add a forest to an Active Directory environment, the cost and complexity are limited by the fixed design, small hardware/software footprint, and small number of users.

> [!NOTE]
> This approach works well for administering Active Directory, but many applications aren't compatible with being administered by accounts from an external forest using a standard trust.

This figure depicts an ESAE forest used for administration of Tier 0 Assets and a PRIV forest configured for use with Microsoft Identity Manager's Privileged Access Management capability. For more information on deploying a MIM PAM instance, see [Privileged Identity Management for Active Directory Domain Services (AD DS)](https://technet.microsoft.com/library/mt150258.aspx) article.

![Figure showing an ESAE forest used for administration of Tier 0 Assets and a PRIV forest configured for use with Microsoft Identity Manager's Privileged Access Management capability](../media/securing-privileged-access-reference-material/PAW_RM_Fig14.JPG)

A dedicated administrative forest is a standard single domain Active Directory forest dedicated to the function of Active Directory management. Administrative forests and domains may be hardened more stringently than production forests because of the limited use cases.

An administrative forest design should include the following considerations:

- **Limited scope** - The primary value of an admin forest is the high level of security assurance and reduced attack surface resulting in lower residual risk. The forest can be used to house additional management functions and applications, but each increase in scope will increase the attack surface of the forest and its resources. The objective is to limit the functions of the forest and admin users inside to keep the attack surface minimal, so each scope increase should be considered carefully.
- **Trust configurations** - Configure trust from managed forests(s) or domain(s) to the administrative forest
   - A one-way trust is required from production environment to the admin forest. This can be a domain trust or a forest trust. The admin forest/domain does not need to trust the managed domains/forests to manage Active Directory, though additional applications may require a two-way trust relationship, security validation, and testing.
   - Selective authentication should be used to restrict accounts in the admin forest to only logging on to the appropriate production hosts. For maintaining domain controllers and delegating rights in Active Directory, this typically requires granting the "Allowed to logon" right for domain controllers to designated Tier 0 admin accounts in the admin forest. See Configuring Selective Authentication Settings for more information.
- **Privileges and domain hardening** - The administrative forest should be configured to least privilege based on the requirements for Active Directory administration.
   - Granting rights to administer domain controllers and delegate permissions requires adding admin forest accounts to the BUILTIN\Administrators domain local group. This is because the Domain Admins global group cannot have members from an external domain.
   - One caveat to using this group to grant rights is that they won't have administrative access to new group policy objects by default. This can be changed by following the procedure in [this knowledge base article](https://support.microsoft.com/kb/321476) to change the schema default permissions.
   - Accounts in the admin forest that are used to administer the production environment should not be granted administrative privileges to the admin forest, domains in it, or workstations in it.
   - Administrative privileges over the admin forest should be tightly controlled by an offline process to reduce the opportunity for an attacker or malicious insider to erase audit logs. This also helps ensure that personnel with production admin accounts cannot relax the restrictions on their accounts and increase risk to the organization.
   - The administrative forest should follow the Microsoft Security Compliance Baseline (SCB) configurations for the domain, including strong configurations for authentication protocols.
   - All admin forest hosts should be automatically updated with security updates. While this may create risk of interrupting domain controller maintenance operations, it provides a significant mitigation of security risk of unpatched vulnerabilities.

      > [!NOTE]
      > A dedicated Windows Server Update Services instance can be configured to automatically approve updates. For more information, see the "Automatically Approve Updates for Installation" section in Approving Updates.

- **Workstation Hardening** - Build the administrative workstations using the [Privileged Access Workstations](../securing-privileged-access/privileged-access-workstations.md) (through Phase 3), but change the domain membership to the administrative forest instead of the production environment.
- **Server and DC hardening** - For all domain controllers and servers in the administrative forest:
   - Ensure all media is validated using the guidance in [Clean Source for installation media](http://aka.ms/cleansource)
   - Ensure the administrative forest servers should have the latest operating systems installed, even if this is not feasible in production.
   - Admin forest hosts should be automatically updated with security updates.

      > [!NOTE]
      > Windows Server Update Services can be configured to automatically approve updates. For more information, see the "Automatically Approve Updates for Installation" section in Approving Updates.

   - Security Baselines should be used as starting configurations.

      > [!NOTE]
      > Customers can use the Microsoft Security Compliance Toolkit (SCT) for configuring the baselines on the administrative hosts.

   - Secure Boot to mitigate against attackers or malware attempting to load unsigned code into the boot process.

      > [!NOTE]
      > This feature was introduced in Windows 8 to leverage the Unified Extensible Firmware Interface (UEFI).

   - Full volume encryption to mitigate against physical loss of computers, such as administrative laptops used remotely.

      > [!NOTE]
      > See [BitLocker](https://technet.microsoft.com/library/dn641993.aspx) for more information.

   - USB restrictions to protect against physical infection vectors.

      > [!NOTE]
      > See [Control Read or Write Access to Removable Devices or Media](https://technet.microsoft.com/library/cc730808(v=ws.10).aspx) for more information.

   - Network isolation to protect against network attacks and inadvertent admin actions. Host firewalls should block all incoming connections except those explicitly required and block all outbound Internet access.

   - Antimalware to protect against known threats and malware.

   - Attack surface analysis to prevent introduction of new attack vectors to Windows during installation of new software.

      > [!NOTE]
      > Use of tools such as the [Attack Surface Analyzer (ASA)](https://www.microsoft.com/en-us/download/details.aspx?id=24487) will help assess configuration settings on a host and identify attack vectors introduced by software or configuration changes.

- Account hardening
   - Multi-factor authentication should be configured for all accounts in the admin forest, except one account. At least one administrative account should be password based to ensure access will work in case the multi-factor authentication process breaks. This account should be protected by a stringent physical control process.
   - Accounts configured for multi-factor authentication should be configured to set a new NTLM hash on accounts regularly. This can be accomplished by disabling and enabling the account attribute Smart card is required for interactive logon.

      > [!NOTE]
      > This can interrupt operations in progress that are using this account, so this process should be initiated only when administrators won't be using the account, such as at night or on weekends.

- Detective controls
   - Detective controls for the administrative forest should be designed to alert on anomalies in the admin forest. The limited number of authorized scenarios and activities can help tune these controls more accurately than the production environment.

For more information engaging about Microsoft services to design and deploy an ESAE for your environment, see [this page](https://www.microsoft.com/services).

## Tier 0 Equivalency

Most organizations control membership to powerful Tier 0 Active Directory groups like Administrators, Domain Admins, and Enterprise Admins.  Many organizations overlook the risk of other groups that are effectively equivalent in privilege in a typical active directory environment. These groups offer a relatively easy escalation path for an attacker to the same explicit Tier 0 privileges using various different attack methods.

As an example, a server operator could gain access to a backup media of a domain controller and extract all the credentials from the files in that media and use them to escalate privileges.

Organizations should control and monitor membership in all of the Tier 0 groups (including nested membership) including:

- Enterprise Admins
- Domain Admins
- Schema Admin
- BUILTIN\Administrators
- Account Operators
- Backup Operators
- Print Operators
- Server Operators
- Domain Controllers
- Read-only Domain Controllers
- Group Policy Creator Owners
- Cryptographic Operators
- Distributed COM Users
- Other Delegated Groups - Custom groups that may be created by your organization to manage directory operations that may also have effective Tier 0 access.

## Administrative Tools and Logon Types

This is reference information to help identify the risk of credential exposure associated with using different administrative tools for remote administration.

In a remote administration scenario, credentials are always exposed on the source computer so a trustworthy privileged access workstation (PAW) is always recommended for sensitive or high impact accounts. Whether credentials are exposed to potential theft on the target (remote) computer depends primarily on the windows logon type used by the connection method.

This table includes guidance for the most common administrative tools and connection methods:

|Connection method|Logon type|Reusable credentials on destination|Comments|
|-----------|-------|--------------------|------|
|Log on at console|Interactive|v|Includes hardware remote access / lights-out cards and network KVMs.|
|RUNAS|Interactive|v||
|RUNAS /NETWORK|NewCredentials|v|Clones current LSA session for local access, but uses new credentials when connecting to network resources.|
|Remote Desktop (success)|RemoteInteractive|v|If the remote desktop client is configured to share local devices and resources, those may be compromised as well.|
|Remote Desktop (failure - logon type was denied)|RemoteInteractive|-|By default, if RDP logon fails credentials are only stored very briefly. This may not be the case if the computer is compromised.|
|Net use * \\\SERVER|Network|-||
|Net use * \\\SERVER /u:user|Network|-||
|MMC snap-ins to remote computer|Network|-|Example: Computer Management, Event Viewer, Device Manager, Services|
|PowerShell WinRM|Network|-|Example: Enter-PSSession server|
|PowerShell WinRM with CredSSP|NetworkClearText|v|New-PSSession server<br />-Authentication Credssp<br />-Credential cred|
|PsExec without explicit creds|Network|-|Example: PsExec \\\server cmd|
|PsExec with explicit creds|Network + Interactive|v|PsExec \\\server -u user -p pwd cmd<br />Creates multiple logon sessions.|
|Remote Registry|Network|-||
|Remote Desktop Gateway|Network|-|Authenticating to Remote Desktop Gateway.|
|Scheduled task|Batch|v|Password will also be saved as LSA secret on disk.|
|Run tools as a service|Service|v|Password will also be saved as LSA secret on disk.|
|Vulnerability scanners|Network|-|Most scanners default to using network logons, though some vendors may implement non-network logons and introduce more credential theft risk.|

For web authentication, use the reference from the table below:

|Connection method|Logon type|Reusable credentials on destination|Comments|
|-----------|-------|--------------------|------|
|IIS "Basic Authentication"|NetworkCleartext<br />(IIS 6.0+)<br /><br />Interactive<br />(prior to IIS 6.0)|v||
|IIS "Integrated Windows Authentication"|Network|-|NTLM and Kerberos Providers.|

Column Definitions:

- **Logon type** identifies the logon type initiated by the connection.
- **Reusable credentials on destination** indicates that the following credential types will be stored in LSASS process memory on the destination computer where the specified account is logged on locally:
   - LM and NT hashes
   - Kerberos TGTs
   - Plaintext password (if applicable).

The symbols in this table defined as follows:

- (-) denotes when credentials are not exposed.
- (v) denotes when credentials are exposed.

For management applications that are not in this table, you can determine the logon type from the logon type field in the audit logon events. For more information, see [Audit logon events](https://technet.microsoft.com/library/cc787567(v=ws.10).aspx).

In Windows-based computers, all authentications are processed as one of several logon types, regardless of which authentication protocol or authenticator is used. This table includes most common logon types and their attributes relative to credential theft:

|Logon type|#|Authenticators accepted|Reusable credentials in LSA session|Examples|
|-------|---|--------------|--------------------|------|
|Interactive (a.k.a., Logon locally)|2|Password, Smartcard,<br />other|Yes|Console logon;<br />RUNAS;<br />Hardware remote control solutions (such as Network KVM or Remote Access / Lights-Out Card in server)<br />IIS Basic Auth (before IIS 6.0)|
|Network|3|Password,<br />NT Hash,<br />Kerberos ticket|No (except if delegation is enabled, then Kerberos tickets present)|NET USE;<br />RPC calls;<br />Remote registry;<br />IIS integrated Windows auth;<br />SQL Windows auth;|
|Batch|4|Password (usually stored as LSA secret)|Yes|Scheduled tasks|
|Service|5|Password (usually stored as LSA secret)|Yes|Windows services|
|NetworkCleartext|8|Password|Yes|IIS Basic Auth (IIS 6.0 and newer);<br />Windows PowerShell with CredSSP|
|NewCredentials|9|Password|Yes|RUNAS /NETWORK|
|RemoteInteractive|10|Password, Smartcard,<br />other|Yes|Remote Desktop (formerly known as "Terminal Services")|

Column definitions:

- **Logon type** is the type of logon requested.
- **#** is the numeric identifier for the logon type that is reported in audit events in the Security event log.
- **Authenticators accepted** indicates which types of authenticators are able to initiate a logon of this type.
- **Reusable credentials** in LSA session indicates whether the logon type results in the LSA session holding credentials, such as plaintext passwords, NT hashes, or Kerberos tickets that could be used to authenticate to other network resources.
- **Examples** list common scenarios in which the logon type is used.

> [!NOTE]
> For more information about Logon Types, see [SECURITY_LOGON_TYPE enumeration](https://technet.microsoft.com/library/aa380129(VS.85).aspx).
