---
title: Security Policy Settings Reference
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a64bede2-5b4e-45a8-befe-080f299b7d71
---
# Security Policy Settings Reference
This reference of security settings provides information about how to implement and manage security policies, including setting options and security considerations. Applicable operating system versions are listed on each policy setting description.  
  
## Overview  
This reference focuses on those settings that are considered security settings. This reference examines only the settings and features in the Windows operating systems that can help organizations secure their enterprises against malicious software threats. Management features and those security features that are not configurable by administrators are not described in this reference.  
  
Each policy setting described contains referential content such as a detailed explanation of the settings, best practices, default settings, differences between operating system versions, policy management considerations, and security considerations that include a discussion of vulnerability, countermeasures, and potential impact of those countermeasures.  
  
For each grouping of policies, an overview topic describes the general use and implementation of those policies and provides links to the related topics.  
  
The information that is provided within this reference should help you and members of your organization understand the implementation and countermeasures for security policies that are available in the named versions of the Windows operating system.  
  
## Contents of this guide  
This guide consists of the following sections that contain descriptions of the settings that you should consider while planning the security policy for your organization.  
  
|||  
|-|-|  
|[Account Policies](Account-Policies.md)|This section discusses the settings that are applied at the domain level: password policies, account lockout policies, and Kerberos authentication protocol policies.|  
|[Audit Policy](Audit-Policy.md)|This section provides information about the security audit policy settings under **Security Settings\\Local Policies\\Audit Policy** that provide broad security audit capabilities for client computers and servers that cannot use advanced security audit policy settings.|  
|[Security Options](Security-Options.md)|This section provides guidance about how to configure the variety of settings specific to security on the local computer:<br /><br />-   Accounts<br />-   Audit<br />-   DCOM<br />-   Devices<br />-   Domain controller<br />-   Domain member<br />-   Interactive logon<br />-   Microsoft network client<br />-   Microsoft network server<br />-   Network access<br />-   Network security<br />-   Recovery console<br />-   Shutdown<br />-   System cryptography<br />-   System objects<br />-   System settings<br />-   User Account Control|  
|[Advanced Audit Policy Configuration](Advanced-Audit-Policy-Configuration.md)|This section provides information about advanced security audit policy settings, which allow administrators to use audit policies to help monitor and enforce business rules.|  
|[User Rights Assignment](User-Rights-Assignment.md)|This section provides information about the User Rights Assignment security policy settings that are available in the Windows operating system.|  
  
## Additional resources  
  
-   [Security Audit Policy Reference](http://technet.microsoft.com/library/dd772623(v=ws.10).aspx)  
  
    This reference for the IT professional provides information about the auditing settings available in the Windows operating system beginning with Windows Server 2003 and the audit events that they generate.  
  
-   [Threats and Countermeasures Guide: Security Settings in Windows Server 2008 and Windows Vista](http://technet.microsoft.com/library/dd349791(v=ws.10).aspx)Threats and Countermeasures Guide: Security Settings in Windows Server 2008 and Windows Vista  
  
    This guide focuses on the security settings available in Windows Server 2008 and Windows Vista that can help you address specific computer security risks in an enterprise environment.  
  
-   [Threats and Countermeasures Guide: Security Settings in Windows Server 2008 R2 and Windows 7](http://technet.microsoft.com/library/hh125921(v=ws.10).aspx)  
  
    This guide focuses on the security settings available in Windows Server 2008 R2 and Windows 7 that can help you address specific computer security risks in an enterprise environment.  
  
-   [Security Policy Settings](http://technet.microsoft.com/library/cc722034(v=ws.10).aspx)  
  
    This reference documents security policy settings in Windows Server 2003.  
  
-   [Security Compliance Manager](http://technet.microsoft.com/solutionaccelerators/cc835245.aspx)  
  
    The Security Baselines are part of the Microsoft Security Compliance Manager available as a downloadable tool that can help you plan, deploy, and monitor the security baselines of computers running the supported operating system versions designated in the **Applies To** list at the beginning of this topic.  
  

