---
ms.assetid: 0abe0976-4b49-45d6-a7b3-81d28bdb8210
title: Audit Policy Recommendations
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Audit Policy Recommendations

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1, Windows 7

This section addresses the Windows default audit policy settings, baseline recommended audit policy settings, and the more aggressive recommendations from Microsoft, for workstation and server products.  

The SCM baseline recommendations shown here, along with the settings we recommend to help detect compromise, are intended only to be a starting baseline guide to administrators. Each organization must make its own decisions regarding the threats they face, their acceptable risk tolerances, and what audit policy categories or subcategories they should enable. For further information about threats, refer to the [Threats and Countermeasures Guide](https://technet.microsoft.com/library/hh125921(v=ws.10).aspx). Administrators without a thoughtful audit policy in place are encouraged to start with the settings recommended here, and then to modify and test, prior to implementing in their production environment.  

The recommendations are for enterprise-class computers, which Microsoft defines as computers that have average security requirements and require a high level of operational functionality. Entities needing higher security requirements should consider more aggressive audit policies.  

> [!NOTE]  
> Microsoft Windows defaults and baseline recommendations were taken from the [Microsoft Security Compliance Manager tool](https://technet.microsoft.com/library/cc677002.aspx).  

The following baseline audit policy settings are recommended for normal security computers that are not known to be under active, successful attack by determined adversaries or malware.  

## Recommended Audit Policies by Operating System  
This section contains tables that list the audit setting recommendations that apply to the following operating systems:  

-   Windows Server 2016 

-   Windows Server 2012  

-   Windows Server 2012 R2  

-   Windows Server 2008  

-   Windows 10

-   Windows 8.1  

-   Windows 7  

These tables contain the Windows default setting, the baseline recommendations, and the stronger recommendations for these operating systems.  

**Audit Policy Tables Legend**  

|||  
|-|-|  
|**Notation**|**Recommendation**|  
|YES|Enable in general scenarios|  
|NO|Do **not** enable in general scenarios|  
|IF|Enable if needed for a specific scenario, or if a role or feature for which auditing is desired is installed on the machine|  
|DC|Enable on domain controllers|  
|[Blank]|No recommendation|  

**Windows 10, Windows 8, and Windows 7 Audit Settings Recommendations**  

**Audit Policy**  

|Audit Policy Category or Subcategory|Windows Default<br /><br />Success    Failure|Baseline Recommendation<br /><br />Success    Failure|Stronger Recommendation<br /><br />Success    Failure|  
|----------------------------------------|------------------------------------------|--------------------------------------------------|--------------------------------------------------|  
|**Account Logon**||||  
|Audit Credential Validation|No    No|Yes    No|Yes    Yes|  
|Audit Kerberos Authentication Service|||Yes    Yes|  
|Audit Kerberos Service Ticket Operations|||Yes    Yes|  
|Audit Other Account Logon Events|||Yes    Yes|  
|**Account Management**||||  
|Audit Application Group Management||||  
|Audit Computer Account Management||Yes    No|Yes    Yes|  
|Audit Distribution Group Management||||  
|Audit Other Account Management Events||Yes    No|Yes    Yes|  
|Audit Security Group Management||Yes    No|Yes    Yes|  
|Audit User Account Management|Yes    No|Yes    No|Yes    Yes|  
|**Detailed Tracking**||||  
|Audit DPAPI Activity|||Yes    Yes|  
|Audit Process Creation||Yes    No|Yes    Yes|  
|Audit Process Termination||||  
|Audit RPC Events||||  
|**DS Access**||||  
|Audit Detailed Directory Service Replication||||  
|Audit Directory Service Access||||  
|Audit Directory Service Changes||||  
|Audit Directory Service Replication||||  
|**Logon and Logoff**||||  
|Audit Account Lockout|Yes    No||Yes    No|  
|Audit User/Device Claims||||  
|Audit IPsec Extended Mode||||  
|Audit IPsec Main Mode|||IF     IF|  
|Audit IPsec Quick Mode||||  
|Audit Logoff|Yes   No|Yes    No|Yes    No|  
|Audit Logon <sup>1</sup>|Yes    Yes|Yes    Yes|Yes    Yes|  
|Audit Network Policy Server|Yes    Yes|||  
|Audit Other Logon/Logoff Events||||  
|Audit Special Logon|Yes    No|Yes    No|Yes    Yes|  
|**Object Access**||||  
|Audit Application Generated||||  
|Audit Certification Services||||  
|Audit Detailed File Share||||  
|Audit File Share||||  
|Audit File System||||  
|Audit Filtering Platform Connection||||  
|Audit Filtering Platform Packet Drop||||  
|Audit Handle Manipulation||||  
|Audit Kernel Object||||  
|Audit Other Object Access Events||||  
|Audit Registry||||  
|Audit Removable Storage||||  
|Audit SAM||||  
|Audit Central Access Policy Staging||||  
|**Policy Change**||||  
|Audit Audit Policy Change|Yes    No|Yes    Yes|Yes    Yes|  
|Audit Authentication Policy Change|Yes    No|Yes    No|Yes    Yes|  
|Audit Authorization Policy Change||||  
|Audit Filtering Platform Policy Change||||  
|Audit MPSSVC Rule-Level Policy Change|||Yes  |  
|Audit Other Policy Change Events||||  
|**Privilege Use**||||  
|Audit Non Sensitive Privilege Use||||  
|Audit Other Privilege Use Events||||  
|Audit Sensitive Privilege Use||||  
|**System**||||  
|Audit IPsec Driver||Yes    Yes|Yes    Yes|  
|Audit Other System Events|Yes    Yes|||  
|Audit Security State Change|Yes    No|Yes    Yes|Yes    Yes|  
|Audit Security System Extension||Yes    Yes|Yes    Yes|  
|Audit System Integrity|Yes    Yes|Yes    Yes|Yes    Yes|  
|**Global Object Access Auditing**||||  
|Audit IPsec Driver||||  
|Audit Other System Events||||  
|Audit Security State Change||||  
|Audit Security System Extension||||  
|Audit System Integrity||||  

<sup>1</sup> Beginning with Windows 10 version 1809, Audit Logon is enabled by default for both Success and Failure. In previous versions of Windows, only Success is enabled by default.

**Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 Audit Settings Recommendations**  

|Audit Policy Category or Subcategory|Windows Default<br /><br />Success    Failure|Baseline Recommendation<br /><br />Success    Failure|Stronger Recommendation<br /><br />Success    Failure|  
|----------------------------------------|------------------------------------------|--------------------------------------------------|--------------------------------------------------|  
|**Account Logon**||||  
|Audit Credential Validation|No    No|Yes    Yes|Yes    Yes|  
|Audit Kerberos Authentication Service|||Yes    Yes|  
|Audit Kerberos Service Ticket Operations|||Yes    Yes|  
|Audit Other Account Logon Events|||Yes    Yes|  
|**Account Management**||||  
|Audit Application Group Management||||  
|Audit Computer Account Management||Yes    DC|Yes    Yes|  
|Audit Distribution Group Management||||  
|Audit Other Account Management Events||Yes    Yes|Yes    Yes|  
|Audit Security Group Management||Yes    Yes|Yes    Yes|  
|Audit User Account Management|Yes    No|Yes    Yes|Yes    Yes|  
|**Detailed Tracking**||||  
|Audit DPAPI Activity|||Yes    Yes|  
|Audit Process Creation||Yes    No|Yes    Yes|  
|Audit Process Termination||||  
|Audit RPC Events||||  
|**DS Access**||||  
|Audit Detailed Directory Service Replication||||  
|Audit Directory Service Access||DC    DC|DC    DC|  
|Audit Directory Service Changes||DC    DC|DC    DC|  
|Audit Directory Service Replication||||  
|**Logon and Logoff**||||  
|Audit Account Lockout|Yes    No||Yes    No|  
|Audit User/Device Claims||||  
|Audit IPsec Extended Mode||||  
|Audit IPsec Main Mode|||IF     IF|  
|Audit IPsec Quick Mode||||  
|Audit Logoff|Yes    No|Yes    No|Yes    No|  
|Audit Logon|Yes    Yes|Yes    Yes|Yes    Yes|  
|Audit Network Policy Server|Yes    Yes|||  
|Audit Other Logon/Logoff Events|||Yes    Yes|  
|Audit Special Logon|Yes    No|Yes    No|Yes    Yes|  
|**Object Access**||||  
|Audit Application Generated||||  
|Audit Certification Services||||  
|Audit Detailed File Share||||  
|Audit File Share||||  
|Audit File System||||  
|Audit Filtering Platform Connection||||  
|Audit Filtering Platform Packet Drop||||  
|Audit Handle Manipulation||||  
|Audit Kernel Object||||  
|Audit Other Object Access Events||||  
|Audit Registry||||  
|Audit Removable Storage||||  
|Audit SAM||||  
|Audit Central Access Policy Staging||||  
|**Policy Change**||||  
|Audit Audit Policy Change|Yes    No|Yes    Yes|Yes    Yes|  
|Audit Authentication Policy Change|Yes    No|Yes    No|Yes    Yes|  
|Audit Authorization Policy Change||||  
|Audit Filtering Platform Policy Change||||  
|Audit MPSSVC Rule-Level Policy Change|||Yes  |  
|Audit Other Policy Change Events||||  
|**Privilege Use**||||  
|Audit Non Sensitive Privilege Use||||  
|Audit Other Privilege Use Events||||  
|Audit Sensitive Privilege Use||||  
|**System**||||  
|Audit IPsec Driver||Yes    Yes|Yes    Yes|  
|Audit Other System Events|Yes    Yes|||  
|Audit Security State Change|Yes    No|Yes    Yes|Yes    Yes|  
|Audit Security System Extension||Yes    Yes|Yes    Yes|  
|Audit System Integrity|Yes    Yes|Yes    Yes|Yes    Yes|  
|**Global Object Access Auditing**||||  
|Audit IPsec Driver||||  
|Audit Other System Events||||  
|Audit Security State Change||||  
|Audit Security System Extension||||  
|Audit System Integrity||||  

## Set Audit Policy on Workstations and Servers  
All event log management plans should monitor workstations and servers. A common mistake is to only monitor servers or domain controllers. Because malicious hacking often initially occurs on workstations, not monitoring workstations is ignoring the best and earliest source of information.  

Administrators should thoughtfully review and test any audit policy prior to implementation in their production environment.  

## Events to Monitor  
A perfect event ID to generate a security alert should contain the following attributes:  

-   High likelihood that occurrence indicates unauthorized activity  

-   Low number of false positives  

-   Occurrence should result in an investigative/forensics response  

Two types of events should be monitored and alerted:  

1.  Those events in which even a single occurrence indicates unauthorized activity  

2.  An accumulation of events above an expected and accepted baseline  

An example of the first event is:  

If Domain Admins (DAs) are forbidden from logging on to computers that are not domain controllers, a single occurrence of a DA member logging on to an end-user workstation should generate an alert and be investigated. This type of alert is easy to generate by using the Audit Special Logon event 4964 (Special groups have been assigned to a new logon). Other examples of single instance alerts include:  

-   If Server A should never connect to Server B, alert when they connect to each other.  

-   Alert if a normal end-user account is unexpectedly added to a sensitive security group.  

-   If employees in factory location A never work at night, alert when a user logs on at midnight.  

-   Alert if an unauthorized service is installed on a domain controller.  

-   Investigate if a regular end-user attempts to directly log on to a SQL Server for which they have no clear reason for doing so.  

-   If you have no members in your DA group, and someone adds themselves there, check it immediately.  

An example of the second event is:  

An aberrant number of failed logons could indicate a password guessing attack. For an enterprise to provide an alert for an unusually high number of failed logons, they must first understand the normal levels of failed logons within their environment prior to a malicious security event.  

For a comprehensive list of events that you should include when you monitor for signs of compromise, please see [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md).  

## Active Directory Objects and Attributes to Monitor  
The following are the accounts, groups, and attributes that you should monitor to help you detect attempts to compromise your Active Directory Domain Services installation.  

-   Systems for disabling or removal of antivirus and antimalware software (automatically restart protection when it is manually disabled)  

-   Administrator accounts for unauthorized changes  

-   Activities that are performed by using privileged accounts (automatically remove account when suspicious activities are completed or allotted time has expired)  

-   Privileged and VIP accounts in AD DS. Monitor for changes, particularly changes to attributes on the Account tab (for example, cn, name, sAMAccountName, userPrincipalName, or userAccountControl). In addition to monitoring the accounts, restrict who can modify the accounts to as small a set of administrative users as possible.  

Refer to [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md) for a list of recommended events to monitor, their criticality ratings, and an event message summary.  

-   Group servers by the classification of their workloads, which allows you to quickly identify the servers that should be the most closely monitored and most stringently configured  

-   Changes to the properties and membership of following AD DS groups: Enterprise Admins (EA), Domain Admins (DA), Administrators (BA), and Schema Admins (SA)  

-   Disabled privileged accounts (such as built-in Administrator accounts in Active Directory and on member systems) for enabling the accounts  

-   Management accounts to log all writes to the account  

-   Built-in Security Configuration Wizard to configure service, registry, audit, and firewall settings to reduce the server's attack surface. Use this wizard if you implement jump servers as part of your administrative host strategy.  

## Additional Information for Monitoring Active Directory Domain Services  
Review the following links for additional information about monitoring AD DS:  
  
-   [Global Object Access Auditing is Magic](https://blogs.technet.com/b/askds/archive/2011/03/10/global-object-access-auditing-is-magic.aspx) - Provides information about configuring and using Advanced Audit Policy Configuration that was added to Windows 7 and Windows Server 2008 R2.  

-   [Introducing Auditing Changes in Windows 2008](https://blogs.technet.com/b/askds/archive/2007/10/19/introducing-auditing-changes-in-windows-2008.aspx) - Introduces the auditing changes made in Windows 2008.  

-   [Cool Auditing Tricks in Vista and 2008](https://blogs.technet.com/b/askds/archive/2007/11/16/cool-auditing-tricks-in-vista-and-2008.aspx) - Explains interesting new features of auditing in Windows Vista and Windows Server 2008 that can be used for troubleshooting problems or seeing what's happening in your environment.  

-   [One-Stop Shop for Auditing in Windows Server 2008 and Windows Vista](https://blogs.technet.com/b/askds/archive/2008/03/27/one-stop-shop-for-auditing-in-windows-server-2008-and-windows-vista.aspx) - Contains a compilation of auditing features and information contained in Windows Server 2008 and Windows Vista.  

-   [AD DS Auditing Step-by-Step Guide](https://technet.microsoft.com/library/a9c25483-89e2-4202-881c-ea8e02b4b2a5.aspx) - Describes the new Active Directory Domain Services (AD DS) auditing feature in Windows Server 2008. It also provides procedures to implement this new feature.  

## General List of Security Event ID Recommendation Criticalities  
All Event ID recommendations are accompanied by a criticality rating as follows:  

**High:** Event IDs with a high criticality rating should always and immediately be alerted and investigated.  

**Medium:** An Event ID with a medium criticality rating could indicate malicious activity, but it must be accompanied by some other abnormality (for example, an unusual number occurring in a particular time period, unexpected occurrences, or occurrences on a computer that normally would not be expected to log the event.). A medium-criticality event may also r be collected as a metric and compared over time.  

**Low:** And Event ID with a low criticality events should not garner attention or cause alerts, unless correlated with medium or high criticality events.  

These recommendations are meant to provide a baseline guide for the administrator. All recommendations should be thoroughly reviewed prior to implementation in a production environment.  

Refer to [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md) for a list of the recommended events to monitor, their criticality ratings, and an event message summary.  
