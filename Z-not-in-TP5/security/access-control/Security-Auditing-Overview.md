---
title: Security Auditing Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2270f84b-7dfa-4597-8f2d-ecbd6ca9fbd7
---
# Security Auditing Overview
This technical overview for the IT professional describes the security auditing features in Windows and how your organization can benefit from using these technologies to enhance the security and manageability of your network.

**Did you mean…**

[Security Policy Settings Reference](Security-Policy-Settings-Reference.md)

[Event Viewer](http://go.microsoft.com/fwlink/?LinkId=234764)

## <a name="BKMK_OVER"></a>Feature description
Security auditing is a powerful tool to help maintain the security of an enterprise. Auditing can be used for a variety of purposes, including forensic analysis, regulatory compliance, monitoring user activity, and troubleshooting. Industry regulations in various countries or regions require enterprises to implement a strict set of rules related to data security and privacy. Security audits can help implement such policies and prove that these policies have been implemented. Also, security auditing can be used for forensic analysis, to help administrators detect anomalous behavior, to identify and mitigate gaps in security policies, and to deter irresponsible behavior by tracking critical user activities.

## <a name="BKMK_APP"></a>Practical applications
You can use Windows security and system logs to create a security events tracking system, to record and store network activities that are associated with potentially harmful behaviors, and to mitigate those risks. You can enable auditing based on categories of security events such as:

-   Changes to user account and resource permissions.

-   Failed attempts by users to log on.

-   Failed attempts to access resources.

-   Changes to system files.

In Windows Server 2008 R2 and Windows 7, the number of security audit policy settings was increased from nine to 53, and all auditing capabilities were integrated with Group Policy. This allows administrators to configure, deploy, and manage a wide range of settings in the Group Policy Management Console (GPMC) or the Local Security Policy snap-in for a domain, site, or organizational unit (OU). This makes it easier for IT professionals to track when precisely defined, significant activities take place on the network. For more information, see [Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md).

## New and changed functionality
There are no new changes in functionality to security auditing in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].

In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], changes to security auditing were introduced for the following purposes:

-   **Reduce the volume of audits.** You can target audit policies to specific files and users based on resource attributes and user and device claims.

-   **Improve the manageability of audit policies.** The introduction of Global Object Access Auditing provides an effective means for enforcing the application of security audit policies on resources. Combining Global Object Access Auditing with claims and Dynamic Access Control allows you to take this global enforcement mechanism and apply it to a more precise set of activities of potential interest.

-   **Improve ability to locate critical security audit data.** Existing data access events can log additional information regarding user, computer, and resource claims. This makes it easier for event collection and analysis tools to be configured to get the most relevant event data quickly.

-   **Enable security auditing of removable storage devices.** The growing popularity of removable storage devices makes their attempted use a significant security concern that needs to be monitored.

Dynamic claim-based auditing leads to more precise and easier-to-manage audit policies. It enables scenarios that have been impossible or too difficult to configure. In addition to these improvements, new audit events and categories for tracking changes to Dynamic Access Control (DAC) policy elements include:

-   Resource attributes on files

-   Central access policies associated with files

-   User and device claims

-   Resource property definitions

-   Central access policy and central access rule definitions

The following are examples of audit policies that administrators can author:

-   Anyone without a “High” security clearance who attempts to access documents classified as High Business Impact (HBI)—for example, Audit | Everyone | All-Access | Resource.BusinessImpact=HBI AND User.SecurityClearance!=High.

-   Audit all vendors when they access documents related to projects that they are not working on—for example, Audit | Everyone | All-Access | User.EmploymentStatus=Vendor AND User.Project Not_AnyOf Resource.Project.

These policies help regulate the volume of audit events and limit them to only the most relevant data or users.

To provide a full view of events across the organization, Microsoft is working with partners to provide event collection and analysis tools, such as Microsoft System Center.

## Managing security auditing
To use security auditing, you need to configure the system access control list (SACL) for an object, and apply the appropriate security audit policy to the user or computer. For more information, see [Managing Security Auditing](http://technet.microsoft.com/library/cc771475.aspx).

For information about managing Advanced Security Auditing, see [Advanced Security Auditing Walkthrough](Advanced-Security-Auditing-Walkthrough.md).

For information about auditing Dynamic Access Control, see [Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](Using-Advanced-Security-Auditing-Options-to-Monitor-Dynamic-Access-Control-Objects.md).

## Related resources

|Content type|Resources|
|----------------|-------------|
|**Product evaluation**|[Advanced Security Auditing FAQ](Advanced-Security-Auditing-FAQ.md)<br /><br />[Advanced Security Auditing Walkthrough](Advanced-Security-Auditing-Walkthrough.md)<br /><br />[What’s New in Security Auditing for Windows Server 2012](http://technet.microsoft.com/library/hh849638.aspx)|
|**Planning and Deployment**|[Planning and Deploying Advanced Security Audit Policies](Planning-and-Deploying-Advanced-Security-Audit-Policies.md)|
|**Operations**|[Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](Using-Advanced-Security-Auditing-Options-to-Monitor-Dynamic-Access-Control-Objects.md)|
|**Troubleshooting**|Not yet available|
|**Tools and settings**|[Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md)|
|**Community resources**|[Advanced Security Auditing in Windows 7 and Windows Server 2008 R2](http://social.technet.microsoft.com/wiki/contents/articles/advanced-security-auditing-in-windows-7-and-windows-server-2008-r2.aspx)|
|**Related technologies**|[Active Directory Domain Services Overview](Active-Directory-Domain-Services-Overview.md)|


