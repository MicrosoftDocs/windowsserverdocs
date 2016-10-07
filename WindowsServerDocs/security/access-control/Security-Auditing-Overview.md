---
title: Security Auditing Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-access-control
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2270f84b-7dfa-4597-8f2d-ecbd6ca9fbd7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Security Auditing Overview

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This technical overview for the IT professional describes the security auditing features in Windows and how your organization can benefit from using these technologies to enhance the security and manageability of your network.

## Feature description
Security auditing is a powerful tool to help maintain the security of an enterprise. Auditing can be used for a variety of purposes, including forensic analysis, regulatory compliance, monitoring user activity, and troubleshooting. Industry regulations in various countries or regions require enterprises to implement a strict set of rules related to data security and privacy. Security audits can help implement such policies and prove that these policies have been implemented. Also, security auditing can be used for forensic analysis, to help administrators detect anomalous behavior, to identify and mitigate gaps in security policies, and to deter irresponsible behavior by tracking critical user activities.

## <a name="BKMK_APP"></a>Practical applications
You can use Windows security and system logs to create a security events tracking system, to record and store network activities that are associated with potentially harmful behaviors, and to mitigate those risks. You can enable auditing based on categories of security events such as:

-   Changes to user account and resource permissions.

-   Failed attempts by users to log on.

-   Failed attempts to access resources.

-   Changes to system files.

In Windows Server 2008 R2 and Windows 7, the number of security audit policy settings was increased from nine to 53, and all auditing capabilities were integrated with Group Policy. This allows administrators to configure, deploy, and manage a wide range of settings in the Group Policy Management Console (GPMC) or the Local Security Policy snap-in for a domain, site, or organizational unit (OU). This makes it easier for IT professionals to track when precisely defined, significant activities take place on the network. For more information, see [Advanced Security Audit Policy Settings](../security-auditing/Advanced-Security-Audit-Policy-Settings.md).

## Managing security auditing
To use security auditing, you need to configure the system access control list (SACL) for an object, and apply the appropriate security audit policy to the user or computer. For more information, see [Managing Security Auditing](http://technet.microsoft.com/library/cc771475.aspx).

For information about managing Advanced Security Auditing, see [Advanced Security Auditing Walkthrough](../security-auditing/Advanced-Security-Auditing-Walkthrough.md).

For information about auditing Dynamic Access Control, see [Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](../security-auditing/Using-Advanced-Security-Auditing-Options-to-Monitor-Dynamic-Access-Control-Objects.md).

## Related resources

|Content type|Resources|
|----------------|-------------|
|**Product evaluation**|[Advanced Security Auditing FAQ](../security-auditing/Advanced-Security-Auditing-FAQ.md)<br /><br />[Advanced Security Auditing Walkthrough](../security-auditing/Advanced-Security-Auditing-Walkthrough.md)<br /><br/>[What's New in Security Auditing for Windows Server 2012](http://technet.microsoft.com/library/hh849638.aspx)|
|**Planning and Deployment**|[Planning and Deploying Advanced Security Audit Policies](../security-auditing/Planning-and-Deploying-Advanced-Security-Audit-Policies.md)|
|**Operations**|[Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](../security-auditing/Using-Advanced-Security-Auditing-Options-to-Monitor-Dynamic-Access-Control-Objects.md)|
|**Troubleshooting**|Not yet available|
|**Tools and settings**|[Advanced Security Audit Policy Settings](../security-auditing/Advanced-Security-Audit-Policy-Settings.md)|
|**Community resources**|[Advanced Security Auditing in Windows 7 and Windows Server 2008 R2](http://social.technet.microsoft.com/wiki/contents/articles/advanced-security-auditing-in-windows-7-and-windows-server-2008-r2.aspx)|
|**Related technologies**|[Active Directory Domain Services Overview](../group-managed-service-accounts/Active-Directory-Domain-Services-Overview.md)|


