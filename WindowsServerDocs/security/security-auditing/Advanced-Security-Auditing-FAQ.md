---
title: Advanced Security Auditing FAQ
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0263a4f1-2804-475b-845c-284f3cb4cfb9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Advanced Security Auditing FAQ

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional lists questions and answers about understanding, deploying, and managing security audit policies.

-   [What is Windows security auditing and why might I want to use it?](#BKMK_1)

-   [What is the difference between audit policies located in Local Policies\Audit Policy and audit policies located in Advanced Audit Policy Configuration?](#BKMK_2)

-   [What is the interaction between basic audit policy settings and advanced audit policy settings?](#BKMK_3)

-   [How are audit settings merged by Group Policy?](#BKMK_4)

-   [What is the difference between an object DACL and an object SACL?](#BKMK_14)

-   [Why are audit policies applied on a per-computer basis rather than per user?](#BKMK_13)

-   [What are the differences in auditing functionality between versions of Windows?](#BKMK_12)

-   [Can I use advanced audit policy from a domain controller running Windows Server 2003 or Windows 2000 Server?](#BKMK_15)

-   [What is the difference between success and failure events? Is something wrong if I get a failure audit?](#BKMK_5)

-   [How can I set an audit policy that affects all objects on a computer?](#BKMK_6)

-   [How do I figure out why someone was able to access a resource?](#BKMK_7)

-   [How do I know when changes are made to access control settings, by whom, and what the changes were?](#BKMK_8)

-   [How can I roll back security audit policies from the advanced audit policy to the basic audit policy?](#BKMK_19)

-   [How can I monitor if changes are made to audit policy settings?](#BKMK_10)

-   [How can I minimize the number of events that are generated?](#BKMK_16)

-   [What are the best tools to model and manage audit policy?](#BKMK_17)

-   [Where can I find information about all the possible events that I might receive?](#BKMK_11)

-   [Where can I find more detailed information?](#BKMK_18)

## <a name="BKMK_1"></a>What is Windows security auditing and why might I want to use it?
Security auditing is a methodical examination and review of activities that may affect the security of a system. In the Windows operating systems, security auditing is more narrowly defined as the features and services that enable an administrator to log and review events for specified security-related activities.

Hundreds of events occur as the Windows operating system and the applications that run on it perform their tasks. Monitoring these events can provide valuable information to help administrators troubleshoot and investigate security-related activities.

## <a name="BKMK_2"></a>What is the difference between audit policies located in Local Policies\Audit Policy and audit policies located in Advanced Audit Policy Configuration?
The basic security audit policy settings in **Security Settings\Local Policies\Audit Policy** and the advanced security audit policy settings in **Security Settings\Advanced Audit Policy Configuration\System Audit Policies** appear to overlap, but they are recorded and applied differently. When you apply basic audit policy settings to the local computer by using the Local Security Policy snap-in, you are editing the effective audit policy, so changes made to basic audit policy settings will appear exactly as configured in Auditpol.exe.

There are a number of additional differences between the security audit policy settings in these two locations.

There are nine basic audit policy settings under **Security Settings\Local Policies\Audit Policy** and 53 settings under **Advanced Audit Policy Configuration**. The settings available in **Security Settings\Advanced Audit Policy Configuration** address similar issues as the nine basic settings in **Local Policies\Audit Policy**, but they allow administrators to be more selective in the number and types of events to audit. For example, the basic audit policy provides a single setting for account logon, and the advanced audit policy provides four. Enabling the single basic account logon setting would be the equivalent of setting all four advanced account logon settings. In comparison, setting a single advanced audit policy setting does not generate audit events for activities that you are not interested in tracking.

In addition, if you enable success auditing for the basic **Audit account logon events** setting, only success events will be logged for all account logon???related behaviors. In comparison, depending on the needs of your organization, you can configure success auditing for one advanced account logon setting, failure auditing for a second advanced account logon setting, success and failure auditing for a third advanced account logon setting, or no auditing.

The nine basic settings under **Security Settings\Local Policies\Audit Policy** were introduced in Windows 2000. Therefore, they are available in all versions of Windows released since then. The advanced audit policy settings were introduced in Windows Vista and Windows Server 2008. The advanced settings can only be used on computers running at least  Windows 7 , Windows Vista,  Windows Server 2008 R2 , or Windows Server 2008.

> [!NOTE]
> In Windows Vista and Windows Server 2008, advanced audit event settings were not integrated with Group Policy, and they could be deployed only by using logon scripts that were generated with the Auditpol.exe command-line tool. In  Windows Server 2008 R2  and  Windows 7 , all auditing capabilities were integrated with Group Policy. This allows administrators to configure, deploy, and manage these settings in the Group Policy Management Console (GPMC) or Local Security Policy snap-in for a domain, site, or organizational unit (OU).
> 
> In  Windows Server 2012 , changes to security auditing were introduced to:
> 
> -   **Reduce the volume of audits.** You can target audit policies to specific files and users based on resource attributes and user and device claims.
> -   **Improve the manageability of audit policies.** The introduction of Global Object Access Auditing in Windows Server 2008 R2 provides an effective means for enforcing the application of security audit policy on resources. Combining Global Object Access Auditing with claims and Dynamic Access Control allows you to apply this global enforcement mechanism to a more precise set of activities of potential interest.
> -   **Improve ability to locate critical security audit data.** Existing data access events can log additional information regarding user, computer, and resource claims. This makes it easier for event collection and analysis tools to be configured to get the most relevant event data quickly.
> -   **Enable security auditing of removable storage devices.** The growing popularity of removable storage devices makes their attempted use a significant security concern that needs to be monitored.
> 
> Dynamic claim-based auditing leads to more precise and easier-to-manage audit policies. It enables scenarios that have been impossible or too difficult to configure. In addition to these improvements, new audit events and categories for tracking changes to Dynamic Access Control (DAC) policy elements include or initiated:
> 
> -   Changes to resource attributes on files
> -   Changes to central access policies associated with files
> -   User and device claims
> -   Changes to user and device claims and resource property definitions
> -   Changes to central access policy and central access rule definitions

## <a name="BKMK_3"></a>What is the interaction between basic audit policy settings and advanced audit policy settings?
Basic audit policy settings are not compatible with advanced audit policy settings that are applied by using Group Policy. When advanced audit policy settings are applied by using Group Policy, the current computer's audit policy settings are cleared before the resulting advanced audit policy settings are applied. After you apply advanced audit policy settings by using Group Policy, you can only reliably set system audit policy for the computer by using the advanced audit policy settings.

Editing and applying the advanced audit policy settings in Local Security Policy modifies the local Group Policy Object (GPO), so changes made here may not be exactly reflected in Auditpol.exe if there are policies from other domain GPOs or logon scripts. Both types of policies can be edited and applied by using domain GPOs, and these settings will override any conflicting local audit policy settings. However, because the basic audit policy is recorded in the effective audit policy, that audit policy must be explicitly removed when a change is desired, or it will remain in the effective audit policy. Policy changes that are applied by using local or domain Group Policy settings are reflected as soon as the new policy is applied.

> [!IMPORTANT]
> Whether you apply advanced audit policies by using Group Policy or by using logon scripts, do not use both the basic audit policy settings under **Local Policies\Audit Policy** and the advanced settings under **Security Settings\Advanced Audit Policy Configuration**. Using both advanced and basic audit policy settings can cause unexpected results in audit reporting.
> 
> If you use Advanced Audit Policy Configuration settings or use logon scripts (for computers running Windows Vista or Windows Server 2008) to apply advanced audit policies, be sure to enable the **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings** policy setting under **Local Policies\Security Options**. This will prevent conflicts between similar settings by forcing basic security auditing to be ignored.

## <a name="BKMK_4"></a>How are audit settings merged by Group Policy?
By default, policy options that are set in GPOs and linked to higher levels of Active Directory sites, domains, and OUs are inherited by all OUs at lower levels. However, an inherited policy can be overridden by a GPO that is linked at a lower level.

For example, you might use a domain GPO to assign an organization-wide group of audit settings, but want a certain OU to get a defined group of additional settings. To accomplish this, you can link a second GPO to that specific lower-level OU. Therefore, a logon audit setting that is applied at the OU level will override a conflicting logon audit setting that is applied at the domain level (unless you have taken special steps to apply Group Policy loopback processing).

The rules that govern how Group Policy settings are applied propagate to the subcategory level of audit policy settings. This means that audit policy settings configured in different GPOs will be merged if no policy settings configured at a lower level exist. The following table illustrates this behavior.

|Auditing subcategory|Setting configured in an OU GPO (higher priority)|Setting configured in a domain GPO (lower priority)|Resulting policy for the target computer|
|------------|----------------------------|-----------------------------|----------------------|
|Detailed File Share Auditing|Success|Failure|Success|
|Process Creation Auditing|Disabled|Success|Disabled|
|Logon Auditing|Success|Failure|Failure|

## <a name="BKMK_14"></a>What is the difference between an object DACL and an object SACL?
All objects in Active Directory Domain Services (AD DS), and all securable objects on a local computer or on the network, have security descriptors to help control access to the objects. Security descriptors include information about who owns an object, who can access it and in what way, and what types of access are audited. Security descriptors contain the access control list (ACL) of an object, which includes all of the security permissions that apply to that object. An object's security descriptor can contain two types of ACLs:

-   A discretionary access control list (DACL) that identifies the users and groups who are allowed or denied access

-   A system access control list (SACL) that controls how access is audited

The access control model that is used in Windows is administered at the object level by setting different levels of access, or permissions, to objects. If permissions are configured for an object, its security descriptor contains a DACL with security identifiers (SIDs) for the users and groups that are allowed or denied access.

If auditing is configured for the object, its security descriptor also contains a SACL that controls how the security subsystem audits attempts to access the object. However, auditing is not completely configured unless a SACL has been configured for an object and a corresponding **Object Access** audit policy setting has been configured and applied.

## <a name="BKMK_13"></a>Why are audit policies applied on a per-computer basis rather than per user?
In security auditing in Windows, the computer, objects on the computer, and related resources are the primary recipients of actions by clients including applications, other computers, and users. In a security breach, malicious users can use alternate credentials to hide their identity, or malicious applications can impersonate legitimate users to perform undesired tasks. Therefore, the most consistent way to apply an audit policy is to focus on the computer and the objects and resources on that computer.

In addition, because audit policy capabilities can vary between computers running different versions of Windows, the best way to ensure that the audit policy is applied correctly is to base these settings on the computer instead of the user.

However, in cases where you want audit settings to apply only to specified groups of users, you can accomplish this by configuring SACLs on the relevant objects to enable auditing for a security group that contains only the users you specify. For example, you can configure a SACL for a folder called Payroll Data on Accounting Server 1. This can audit attempts by members of the Payroll Processors OU to delete objects from this folder. The **Object Access\Audit File System** audit policy setting applies to Accounting Server 1, but because it requires a corresponding resource SACL, only actions by members of the Payroll Processors OU on the Payroll Data folder generates audit events.

## <a name="BKMK_12"></a>What are the differences in auditing functionality between versions of Windows?
Basic audit policy settings are available in all versions of Windows since Windows 2000, and they can be applied locally or by using Group Policy. Advanced audit policy settings were introduced in Windows Vista and Windows Server 2008, but the settings can only be applied by using logon scripts in those versions. Advanced audit policy settings, which were introduced in  Windows 7  and  Windows Server 2008 R2 , can be configured and applied by using local and domain Group Policy settings.

## <a name="BKMK_15"></a>Can I use advanced audit policies from a domain controller running Windows Server 2003 or Windows 2000 Server?
To use advanced audit policy settings, your domain controller must be installed on a computer running  Windows Server 2012 R2 ,  Windows Server 2012 ,  Windows Server 2008 R2 , Windows Server 2008, or Windows Server 2003 with Service Pack 2 (SP2). Windows 2000 Server is not supported.

## <a name="BKMK_5"></a>What is the difference between success and failure events? Is something wrong if I get a failure audit?
A success audit event is triggered when a defined action, such as accessing a file share, is completed successfully.

A failure audit event is triggered when a defined action, such as a user logon, is not completed successfully.

The appearance of failure audit events in the event log does not necessarily mean that something is wrong with your system. For example, if you configure Audit Logon events, a failure event may simply mean that a user mistyped his or her password.

## <a name="BKMK_6"></a>How can I set an audit policy that affects all objects on a computer?
System administrators and auditors increasingly want to verify that an auditing policy is applied to all objects on a system. This has been difficult to accomplish because the system access control lists (SACLs) that govern auditing are applied on a per-object basis. Thus, to verify that an audit policy has been applied to all objects, you would have to check every object to be sure that no changes have been made???even temporarily to a single SACL.

Introduced in  Windows Server 2008 R2  and  Windows 7 , security auditing allows administrators to define global object access auditing policies for the entire file system or for the registry on a computer. The specified SACL is then automatically applied to every object of that type. This can be useful for verifying that all critical files, folders, and registry settings on a computer are protected, and for identifying when an issue with a system resource occurs. If a file or folder SACL and a global object access auditing policy (or a single registry setting SACL and a global object access auditing policy) are configured on a computer, the effective SACL is derived from combining the file or folder SACL and the global object access auditing policy. This means that an audit event is generated if an activity matches either the file or folder SACL or the global object access auditing policy.

## <a name="BKMK_7"></a>How do I figure out why someone was able to access a resource?
Often it is not enough to know simply that an object such as a file or folder was accessed. You may also want to know why the user was able to access this resource. You can obtain this forensic data by configuring the **Audit Handle Manipulation** setting with the **Audit File System** or with the **Audit Registry** audit setting. For more information, see "Step 3: Creating and verifying an audit policy that provides the reason for object access" in the [Advanced Security Auditing Walkthrough](advanced-security-auditing-walkthrough.md).

## <a name="BKMK_8"></a>How do I know when changes are made to access control settings, by whom, and what the changes were?
To track access control changes on computers running  Windows Server 2012 R2 ,  Windows Server 2012  Windows 7 ,  Windows Server 2008 R2 , Windows Vista, or Windows Server 2008, you need to enable the following settings, which track changes to DACLs:

-   **Audit File System** subcategory: Enable for success, failure, or success and failure

-   **Audit Authorization Policy Change** setting: Enable for success, failure, or success and failure

-   A SACL with **Write** and **Take ownership** permissions: Apply to the object that you want to monitor

In Windows XP and Windows Server 2003, you need to use the **Audit policy change** subcategory.

## <a name="BKMK_19"></a>How can I roll back security audit policies from the advanced audit policy to the basic audit policy?
Applying advanced audit policy settings replaces any comparable basic security audit policy settings. If you subsequently change the advanced audit policy setting to **Not configured**, you need to complete the following steps to restore the original basic security audit policy settings:

1.  Set all Advanced Audit Policy subcategories to **Not configured**.

2.  Delete all audit.csv files from the %SYSVOL% folder on the domain controller.

3.  Reconfigure and apply the basic audit policy settings.

Unless you complete all of these steps, the basic audit policy settings will not be restored.

## <a name="BKMK_10"></a>How can I monitor if changes are made to audit policy settings?
Changes to security audit policies are critical security events. You can use the **Audit Audit Policy Change** setting to determine if the operating system generates audit events when the following types of activities take place:

-   Permissions and audit settings on the audit policy object are changed

-   The system audit policy is changed

-   Security event sources are registered or unregistered

-   Per-user audit settings are changed

-   The value of **CrashOnAuditFail** is modified

-   Audit settings on a file or registry key are changed

-   A Special Groups list is changed

## <a name="BKMK_16"></a>How can I minimize the number of events that are generated?
Finding the right balance between auditing enough network and computer activity and auditing too little network and computer activity can be challenging. You can achieve this balance by identifying the most important resources, critical activities, and users or groups of users. Then design a security audit policy that targets these resources, activities, and users. Useful guidelines and recommendations for developing an effective security auditing strategy can be found in [Planning and Deploying Advanced Security Audit Policies](planning-and-deploying-advanced-security-audit-policies.md).

## <a name="BKMK_17"></a>What are the best tools to model and manage audit policies?
The integration of advanced audit policy settings with domain Group Policy, introduced in  Windows 7  and  Windows Server 2008 R2 , is designed to simplify the management and implementation of security audit policies in an organization's network. As such, tools used to plan and deploy Group Policy Objects for a domain can also be used to plan and deploy security audit policies.

On an individual computer, the Auditpol command-line tool can be used to complete a number of important audit policy???related management tasks.

In addition, there are a number of computer management products, such as the Audit Collection Services in the Microsoft System Center Operations Manager products, which can be used to collect and filter event data.

## <a name="BKMK_11"></a>Where can I find information about all the possible events that I might receive?
Users who examine the security event log for the first time can be a bit overwhelmed by the number of audit events that are stored there (which can quickly number in the thousands) and by the structured information that is included for each audit event. Additional information about these events, and the settings used to generate them, can be obtained from the following resources:

-   [Windows 8 and Windows Server 2012 Security Event Details](http://www.microsoft.com/download/details.aspx?id=35753)

-   [Security Audit Events for Windows 7 and Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=157780)

-   [Security Audit Events for Windows Server 2008 and Windows Vista](http://go.microsoft.com/fwlink/?LinkID=121868)

-   [Security Audit Policy Reference](http://technet.microsoft.com/library/dd772623(v=ws.10).aspx)

-   [Advanced Security Audit Policy Settings](advanced-security-audit-policy-settings.md)

## <a name="BKMK_18"></a>Where can I find more detailed information?
To learn more about security audit policies, see the following resources:

-   [Planning and Deploying Advanced Security Audit Policies](planning-and-deploying-advanced-security-audit-policies.md)

-   [Security Monitoring and Attack Detection Planning Guide](http://social.technet.microsoft.com/wiki/contents/articles/325.advanced-security-auditing-in-windows-7-and-windows-server-2008-r2.aspx)

-   [Security Audit Policy Reference](https://technet.microsoft.com/library/dd772623(v=ws.10).aspx)

-   [Security Audit Events for Windows 7 and Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkID=157780)

-   [Security Audit Events for Windows Server 2008 and Windows Vista](http://go.microsoft.com/fwlink/?LinkId=121868)

-   [Windows Security Logging and Other Esoterica](http://go.microsoft.com/fwlink/?LinkId=163437)


