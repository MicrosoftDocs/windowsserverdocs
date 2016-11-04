---
title: Administer Security Policy Settings
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c51bf360-aed2-47a3-be53-19f2d6c7a94c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Administer Security Policy Settings

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional discusses different methods to administer security policy settings on the local computer or throughout a small- or medium-sized IT organization by using Windows Server 2012 and Windows 8.

## Introduction
Security policy settings should be used as part of your overall security implementation to help secure domain controllers, servers, client computers, and other resources in your organization.

Security settings policies are rules that you can configure on a computer, or multiple computers, for the purpose of protecting resources on a computer or network. The Security Settings extension of the Local Group Policy Editor snap-in (Gpedit.msc) allows you to define security configurations as part of a Group Policy Object (GPO). The GPOs are linked to Active Directory containers such as sites, domains, and organizational units, and they enable administrators to manage security settings for multiple computers from any computer joined to the domain.

Security settings can control:

-   User authentication to a network or computer.

-   The resources that users are permitted to access.

-   Whether to record a user???s or group???s actions in the Event log.

-   Membership in a group.

For information about each setting, including descriptions, default settings, and management and security considerations, see the [Security Policy Settings Reference](http://www.microsoft.com/downloads/details.aspx?FamilyID=18C90C80-8B0A-4906-A4F5-FF24CC2030FB&amp;displaylang=e&displaylang=en) in the Microsoft Download Center.

For information about how the security settings snap-ins work, see the [Security Policy Settings Technical Overview](../group-managed-service-accounts/security-policy-settings-technical-overview.md).

To manage security configurations for multiple computers, you can use one of the following options:

-   Edit specific security settings in a GPO.

-   Use the Security Templates snap-in to create a security template that contains the security policies you want to apply, and then import the security template into a Group Policy Object. A security template is a file that represents a security configuration, and it can be imported to a GPO, or applied to a local computer, or it can be used to analyze security.


## <a name="BKMK_SecPol"></a>Using the Local Security Policy snap-in
The Local Security Policy snap-in (Secpol.msc) restricts the view of local policy objects to the following policies and features:

-   Account Policies

-   Local Policies

-   Windows Firewall with Advanced Security

-   Network List Manager Policies

-   Public Key Policies

-   Software Restriction Policies

-   Application Control Policies

-   IP Security Policies on Local Computer

-   Advanced Audit Policy Configuration

Policies set locally might be overwritten if the computer is joined to the domain.


## <a name="BKMK_Secedit"></a>Using the Secedit command-line tool
The Secedit command-line tool works with security templates and provides six primary functions:

-   The **Configure** parameter helps you resolve security discrepancies between servers by applying the correct security template to the errant server.

-   The **Analyze** parameter compares the server???s security configuration with the selected template.

-   The **Import** parameter allows you to create a database from an existing template. The Security Configuration and Analysis tool does this also.

-   The **Export** parameter allows you to export the settings from a database into a security settings template.

-   The **Validate** parameter allows you to validate the syntax of each or any lines of text that you created or added to a security template. This ensures that if the template fails to apply syntax, the template will not be the issue.

-   The **Generate Rollback** parameter saves the server???s current security settings into a security template so it can be used to restore most of the server???s security settings to a known state. The exceptions are that, when applied, the rollback template will not change access control list entries on files or registry entries that were changed by the most recently applied template.

For more information about the Secedit.exe tool, see [Secedit](../../management/windows-commands/Secedit.md).

## <a name="BKMK_SCM"></a>Using the Security Compliance Manager
The Security Compliance Manager is a downloadable tool that helps you plan, deploy, operate, and manage your security baselines for Windows client and server operating systems, and for Microsoft applications. It contains a complete database of recommended security settings, methods to customize your baselines, and the option to implement those settings in multiple formats???including XLS, GPOs, Desired Configuration Management (DCM) packs, or Security Content Automation Protocol (SCAP). The Security Compliance Manager is used to export the baselines to your environment to automate the security baseline deployment and compliance verification process.

#### To administer security policies by using the Security Compliance Manager

1.  Download the most recent version of the [Security Compliance Manager](http://www.microsoft.com/download/details.aspx?DisplayLang=en&id=16776) in the Microsoft Download Center.

2.  Read the relevant security baseline documentation that is included in this tool.

3.  Download and import the relevant security baselines. The installation process steps you through baseline selection.

4.  Open the Help and follow instructions how to customize, compare, or merge your security baselines before deploying those baselines.

## <a name="BKMK_SCW"></a>Using the Security Configuration Wizard
The Security Configuration Wizard (SCW) guides you through the process of creating, editing, applying, or rolling back a security policy. A security policy that you create with SCW is an .xml file that, when applied, configures services, network security, specific registry values, and audit policy. SCW is a role-based tool: You can use it to create a policy that enables services, firewall rules, and settings that are required for a selected server to perform specific roles. For example, a server might be a file server, a print server, or a domain controller.

The following are considerations for using SCW:

-   SCW disables unnecessary services and provides Windows Firewall with Advanced Security support.

-   Security policies that are created with SCW are not the same as security templates, which are files with an .inf extension. Security templates contain more security settings than those that can be set with SCW. However, it is possible to include a security template in an SCW security policy file.

-   You can deploy security policies that you create with SCW by using Group Policy.

-   SCW does not install or uninstall the features necessary for the server to perform a role. You can install role-specific features through Server Manager.

-   SCW detects role dependencies. If you select a role, it automatically selects dependent roles.

-   All applications that use the IP protocol and ports must be running on the server when you run SCW.

-   In some cases, you must be connected to the Internet to use the links in the SCW Help.

> [!NOTE]
> The SCW is available only on Windows Server and only applicable to server installations.

The SCW can be accessed through Server Manager or by running Scw.exe. The wizard steps you through server security configuration to:

-   Create a security policy that can be applied to any server on your network.

-   Edit an existing security policy.

-   Apply an existing security policy.

-   Roll back the last applied security policy.

The Security Policy Wizard configures services and network security based on the server???s role, as well as configures auditing and registry settings.

For more information about SCW, including procedures, see the [Security Configuration Wizard](http://technet.microsoft.com/library/cc754997.aspx).

## <a name="BKMK_SCMtool"></a>Working with the Security Configuration Manager
The Security Configuration Manager tool set allows you to create, apply, and edit the security for your local computer, organizational unit, or domain.

For procedures on how to use the Security Configuration Manager, see [Security Configuration Manager](http://technet.microsoft.com/library/cc758219(WS.10).aspx).


### <a name="BKMK_SecCfgAna"></a>Security Configuration and Analysis
Security Configuration and Analysis is an MMC snap-in for analyzing and configuring local system security.

#### <a name="H2_359808543"></a>Security analysis
The state of the operating system and applications on a computer is dynamic. For example, you may need to temporarily change security levels so that you can immediately resolve an administration or network issue. However, this change can often go unreversed. This means that a computer may no longer meet the requirements for enterprise security.

Regular analysis enables an administrator to track and ensure an adequate level of security on each computer as part of an enterprise risk management program. An administrator can tune the security levels and, most importantly, detect any security flaws that may occur in the system over time.

Security Configuration and Analysis enables you to quickly review security analysis results. It presents recommendations alongside of current system settings and uses visual flags or remarks to highlight any areas where the current settings do not match the proposed level of security. Security Configuration and Analysis also offers the ability to resolve any discrepancies that analysis reveals.

#### <a name="H2_359810173"></a>Security configuration
Security Configuration and Analysis can also be used to directly configure local system security. Through its use of personal databases, you can import security templates that have been created with Security Templates and apply these templates to the local computer. This immediately configures the system security with the levels specified in the template.

### <a name="BKMK_SecTmpl"></a>Security templates
With the Security Templates snap-in for Microsoft Management Console, you can create a security policy for your computer or for your network. It is a single point of entry where the full range of system security can be taken into account. The Security Templates snap-in does not introduce new security parameters, it simply organizes all existing security attributes into one place to ease security administration.

Importing a security template to a Group Policy Object eases domain administration by configuring security for a domain or organizational unit at once.

To apply a security template to your local computer, you can use Security Configuration and Analysis or the Secedit command-line tool.

Security templates can be used to define:

-   Account Policies

    -   Password Policy

    -   Account Lockout Policy

    -   Kerberos Policy

-   Local Policies

    -   Audit Policy

    -   User Rights Assignment

    -   Security Options

-   Event Log: Application, system, and security Event Log settings

-   Restricted Groups: Membership of security-sensitive groups

-   System Services: Startup and permissions for system services

-   Registry: Permissions for registry keys

-   File System: Permissions for folders and files

Each template is saved as a text-based .inf file. This enables you to copy, paste, import, or export some or all of the template attributes. With the exceptions of Internet Protocol security and public key policies, all security attributes can be contained in a security template.

### <a name="BKMK_SecExtensions"></a>Security Settings extension to Group Policy
Organizational units, domains, and sites are linked to Group Policy Objects.  The Security Settings tool allows you change the security configuration of the Group Policy Object, in turn, affecting multiple computers. With Security Settings, you can modify the security settings of many computers, depending on the Group Policy Object you modify, from just one computer joined to a domain.

Security settings or security policies are rules that are configured on a computer or multiple computers for protecting resources on a computer or network. Security settings can control:

-   How users are authenticated to a network or computer.

-   What resources users are authorized to use.

-   Whether or not a user's or group's actions are recorded in the event log.

-   Group membership.

You can change the security configuration on multiple computers in two ways:

-   Create a security policy by using a security template with Security Templates, and then import the template through Security Settings to a Group Policy Object.

-   Change a few select settings with Security Settings.

### <a name="BKMK_LocalSecPol"></a>Local Security Policy
A security policy is a combination of security settings that affect the security on a computer. You can use your local security policy to edit account policies and local policies on your local computer.

With the local security policy, you can control:

-   Who accesses your computer.

-   What resources users are authorized to use on your computer.

-   Whether or not a user???s or group's actions are recorded in the event log.

If your local computer is joined to a domain, you are subject to obtaining a security policy from the domain's policy or from the policy of any organizational unit that you are a member of. If you are getting a policy from more than one source, conflicts are resolved in the following order of precedence.

1.  Organizational unit policy

2.  Domain policy

3.  Site policy

4.  Local computer policy

If you modify the security settings on your local computer by using the local security policy, then you are directly modifying the settings on your computer. Therefore, the settings take effect immediately, but this may only be temporary. The settings will actually remain in effect on your local computer until the next refresh of Group Policy security settings, when the security settings that are received from Group Policy will override your local settings wherever there are conflicts.

### Using the Security Configuration Manager
For procedures on how to use the Security Configuration Manager, see [Security Configuration Manager How To](http://technet.microsoft.com/library/cc784762(WS.10).aspx).

#### <a name="BKMK_ApplySecSettings"></a>Applying security settings
Once you have edited the security settings, the settings are refreshed on the computers in the organizational unit linked to your Group Policy Object:

-   When a computer is restarted, the settings on that computer will be refreshed.

-   To force a computer to refresh its security settings as well as all Group Policy settings, see the [Gpupdate](../../management/windows-commands/Gpupdate.md) command-line tool.

**Precedence of a policy when more than one policy is applied to a computer**

For security settings that are defined by more than one policy, the following order of precedence is observed:

1.  Organizational Unit Policy

2.  Domain Policy

3.  Site Policy

4.  Local computer Policy

For example, a workstation that is joined to a domain will have its local security settings overridden by the domain policy wherever there is a conflict. Likewise, if the same workstation is a member of an Organizational Unit, the settings applied from the Organizational Unit's policy will override both the domain and local settings. If the workstation is a member of more than one Organizational Unit, then the Organizational Unit that immediately contains the workstation has the highest order of precedence.

> [!NOTE]
> Use the [Gpresult](../../management/windows-commands/Gpresult.md) command-line tool to find out what policies are applied to a computer and in what order.
> 
> For domain accounts, there can be only one account policy that includes password policies, account lockout policies, and Kerberos policies.

**Persistence in security settings**

Security settings may still persist even if a setting is no longer defined in the policy that originally applied it.

Persistence in security settings occurs when:

-   The setting has not been previously defined for the computer.

-   The setting is for a registry object.

-   The setting is for a file system object.

All settings applied through local policy or a Group Policy Object are stored in a local database on your computer. Whenever a security setting is modified, the computer saves the security setting value to the local database, which retains a history of all the settings that have been applied to the computer. If a policy first defines a security setting and then no longer defines that setting, then the setting takes on the previous value in the database. If a previous value does not exist in the database, then the setting does not revert to anything and remains defined as is. This behavior is sometimes called "tattooing."

Registry and file settings will maintain the values applied through policy until that setting is set to other values.

**Filtering security settings based on group membership**

You can also decide what users or groups will or will not have a Group Policy Object applied to them regardless of what computer they have logged onto by denying them either the Apply Group Policy or Read permission on that Group Policy Object. Both of these permissions are needed to apply Group Policy.

#### <a name="BKMK_ImpExpSecTmpl"></a>Importing and exporting security templates
Security Configuration and Analysis provides the ability to import and export security templates into or from a database.

If you have made any changes to the analysis database, you can save those settings by exporting them into a template. The export feature provides the ability to save the analysis database settings as a new template file. This template file can then be used to analyze or configure a system, or it can be imported to a Group Policy Object.

#### <a name="BKMK_AnaSecViewResults"></a>Analyzing security and viewing results
Security Configuration and Analysis performs security analysis by comparing the current state of system security against an *analysis database*. During creation, the analysis database uses at least one security template. If you choose to import more than one security template, the database will merge the various templates and create one composite template. It resolves conflicts in order of import; the last template that is imported takes precedence.

Security Configuration and Analysis displays the analysis results by security area, using visual flags to indicate problems. It displays the current system and base configuration settings for each security attribute in the security areas. To change the analysis database settings, right-click the entry, and then click **Properties**.

|Visual flag|Meaning|
|--------|------|
|Red X|The entry is defined in the analysis database and on the system, but the security setting values do not match.|
|Green check mark|The entry is defined in the analysis database and on the system and the setting values match.|
|Question mark|The entry is not defined in the analysis database and, therefore, was not analyzed.<br /><br />If an entry is not analyzed, it may be that it was not defined in the analysis database or that the user who is running the analysis may not have sufficient permission to perform analysis on a specific object or area.|
|Exclamation point|This item is defined in the analysis database, but does not exist on the actual system. For example, there may be a restricted group that is defined in the analysis database but does not actually exist on the analyzed system.|
|No highlight|The item is not defined in the analysis database or on the system.|

If you choose to accept the current settings, the corresponding value in the base configuration is modified to match them. If you change the system setting to match the base configuration, the change will be reflected when you configure the system with Security Configuration and Analysis.

To avoid continued flagging of settings that you have investigated and determined to be reasonable, you can modify the base configuration. The changes are made to a copy of the template.

#### <a name="BKMK_ResolveSecDiffs"></a>Resolving security discrepancies
You can resolve discrepancies between analysis database and system settings by:

-   Accepting or changing some or all of the values that are flagged or not included in the configuration, if you determine that the local system security levels are valid due to the context (or role) of that computer. These attribute values are then updated in the database and applied to the system when you click **Configure Computer Now**.

-   Configuring the system to the analysis database values, if you determine the system is not in compliance with valid security levels.

-   Importing a more appropriate template for the role of that computer into the database as the new base configuration and applying it to the system.

Changes to the analysis database are made to the stored template in the database, not to the security template file. The security template file will only be modified if you either return to Security Templates and edit that template or export the stored configuration to the same template file.

You should use **Configure Computer Now** only to modify security areas *not* affected by Group Policy settings, such as security on local files and folders, registry keys, and system services. Otherwise, when the Group Policy settings are applied, it will take precedence over local settings???such as account policies. In general, do not use **Configure Computer Now** when you are analyzing security for domain-based clients, since you will have to configure each client individually. In this case, you should return to Security Templates, modify the template, and reapply it to the appropriate Group Policy Object.

#### <a name="BKMK_AutoSecCfgTasks"></a>Automating security configuration tasks
By calling the Secedit.exe tool at a command prompt from a batch file or automatic task scheduler, you can use it to automatically create and apply templates, and analyze system security. You can also run it dynamically from a command prompt.

Secedit.exe is useful when you have multiple computers on which security must be analyzed or configured, and you need to perform these tasks during off-hours.

## <a name="BKMK_GroupPolicy"></a>Working with Group Policy tools
Group Policy is an infrastructure that allows you to specify managed configurations for users and computers through Group Policy settings and Group Policy Preferences. For Group Policy settings that affect only a local computer or user, you can use the Local Group Policy Editor. You can manage Group Policy settings and Group Policy Preferences in an Active Directory Domain Services (AD DS) environment through the Group Policy Management Console (GPMC). Group Policy management tools also are included in the Remote Server Administration Tools pack to provide a way for you to administer Group Policy settings from your desktop.

To get started with managing security settings with Group Policy, see [Group Policy Overview](../../management/group-policy/get-started/Group-Policy-Overview.md).

To begin using the Group Policy Management Console, see the Help for the [Group Policy Management Console](../../management/group-policy/get-started/group-policy-management-console.md) in the TechNet Library.

To begin using the Local Group Policy Editor, see the Help for the [Local Group Policy Editor](../../management/group-policy/get-started/local-group-policy-editor.md).


