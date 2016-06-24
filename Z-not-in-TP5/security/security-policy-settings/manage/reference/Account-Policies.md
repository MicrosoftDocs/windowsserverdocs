---
title: Account Policies
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 829059d3-41c5-45e2-901e-30496e7bf1ce
---
# Account Policies
This security policy setting reference provides an overview of account policies in Windows and provides links to policy descriptions.  
  
The account policies settings include the following:  
  
-   [Password Policy](Password-Policy.md)  
  
-   [Account Lockout Policy](Account-Lockout-Policy.md)  
  
-   [Kerberos Policy](Kerberos-Policy.md)  
  
For information about setting security policies, see [How to Configure Security Policy Settings](https://technet.microsoft.com/library/dn135243.aspx).  
  
All account policies settings applied by using Group Policy are applied at the domain level. Default values are present in the built-in default domain controller policy for Password Policy settings, Account Lockout Policy settings, and Kerberos Policy settings. The domain account policy becomes the default local account policy of any Windows-based computer that is a member of the domain. If these policies are set at any level below the domain level in Active Directory Domain Services (AD DS), they affect only local accounts on member servers.  
  
> [!NOTE]  
> Each domain can have only one account policy. The account policy must be defined in the default domain policy or in a new policy that is linked to the root of the domain and given precedence over the default domain policy, which is enforced by the domain controllers in the domain. These domain-wide account policy settings (Password Policy, Account Lockout Policy, and Kerberos Policy) are enforced by the domain controllers in the domain; therefore, domain controllers always retrieve the values of these account policy settings from the default domain policy Group Policy Object (GPO).  
  
The only exception is when another account policy is defined for an organizational unit (OU). The account policy settings for the OU affect the local policy on any computers that are contained in the OU. For example, if an OU policy defines a maximum password age that differs from the domain-level account policy, the OU policy will be applied and enforced only when users log on to the local computer. The default local computer policies apply only to computers that are in a workgroup or in a domain where neither an OU account policy nor a domain policy applies.  
  

