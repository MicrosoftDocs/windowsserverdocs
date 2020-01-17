---
ms.assetid: 3ea48a72-20a2-4da4-84e4-26b5728513ce
title: Plan for File Access Auditing
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Plan for File Access Auditing

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The information in this topic explains the security auditing enhancements that are introduced in  Windows Server 2012  and new audit settings that you should consider as you deploy Dynamic Access Control in your enterprise. The actual audit policy settings that you deploy will depend on your goals, which can include regulatory compliance, monitoring, forensic analysis, and troubleshooting.  
  
> [!NOTE]  
> Detailed information about how to plan and deploy an overall security auditing strategy for your enterprise is explained in [Planning and Deploying Advanced Security Audit Policies](https://go.microsoft.com/fwlink/?LinkID=191139). For more information about configuring and deploying a security audit policy, see the [Advanced Security Audit Policy Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkID=191141).  
  
The following security auditing capabilities in  Windows Server 2012  can be used with Dynamic Access Control to extend your overall security auditing strategy.  
  
-   **Expression-based audit policies**. Dynamic Access Control enables you to create targeted audit policies by using expressions based on user, computer, and resource claims. For example, you could create an audit policy to track all Read and Write operations on files classified as high-business impact by employees who do not have a high-security clearance. Expression-based audit policies can be authored directly for a file or folder or centrally through Group Policy. For more information, see [Group Policy using Global Object Access Auditing](https://go.microsoft.com/fwlink/?LinkId=241498).  
  
-   **Additional information from object access auditing**. File access auditing is not new to  Windows Server 2012 . With the right audit policy in place, the Windows and Windows Server operating systems generate an audit event each time a user accesses a file. Existing File Access events (4656, 4663) contain information about the attributes of the file that was accessed. This information can be used by event log filtering tools to help you identify the most relevant audit events. For more information, see [Audit Handle Manipulation](https://technet.microsoft.com//library/dd772626(WS.10).aspx) and [Audit Security Accounts Manager](https://go.microsoft.com/fwlink/?LinkId=241501).  
  
-   **More information from user logon events**. With the right audit policy in place, Windows  operating systems generate an audit event every time a user signs in to a computer locally or remotely. In  Windows Server 2012  or Windows 8, you can also monitor user and device claims associated with a user's security token. Examples can include Department, Company, Project, and Security clearances.Event 4626 contains information about these user claims and device claims, which can be leveraged by audit log management tools to correlate user logon events with object access events to enable event filtering based on file attributes and user attributes. For more information about user logon auditing, see [Audit Logon](https://go.microsoft.com/fwlink/?LinkId=241502).  
  
-   **Change tracking for new types of securable objects**. Tracking changes to securable objects can be important in the following scenarios:  
  
    -   **Change tracking for central access policies and central access rules**. Central access policies and central access rules define the central policy that can be used to control access to critical resources. Any change to these can directly impact the file access permissions that are granted to users on multiple computers. Therefore, tracking changes to central access policies and central access rules can be important for your organization. Because central access policies and central access rules are stored in Active Directory Domain Services (AD DS), you can audit attempts to modify them, like auditing changes to any other securable object in AD DS. For more information, see [Audit Directory Service Access](https://technet.microsoft.com/library/dd941618(WS.10).aspx).  
  
    -   **Change tracking for definitions in the claim dictionary**. Claim definitions include the claim name, description, and possible values. Any change to the claim definition can impact the access permissions on critical resources. Therefore, tracking changes to claim definitions can be important to your organization. Like central access policies and central access rules, claim definitions are stored in AD DS; therefore, they can be audited like any another securable object in AD DS. For more information, see [Audit Directory Service Access](https://technet.microsoft.com/library/dd941618(WS.10).aspx).  
  
    -   **Change tracking for file attributes**. File attributes determine which central access rule applies to the file. A change to the file attributes can potentially impact the access restrictions on the file. Therefore, it can be important to track changes to file attributes. You can track changes to file attributes on any computer by configuring the authorization policy change auditing policy. For more information, see [Authorization Policy Change auditing](https://go.microsoft.com/fwlink/?LinkId=241504) and [Object Access auditing for File Systems](https://go.microsoft.com/fwlink/?LinkId=241505). In  Windows Server 2012 , Event 4911 differentiates file attribute policy changes from other authorization policy change events.  
  
    -   **Chang tracking for the central access policy associated with a file.** Event 4913 displays the security identifiers (SIDs) of the old and new central access policies. Each central access policy also has a user friendly name that can be looked up using this security identifier. For more information, see [Authorization Policy Change auditing](https://go.microsoft.com/fwlink/?LinkId=241504).  
  
    -   **Change tracking for user and computer attributes**. Like files, user and computer objects can have attributes, and changes to these attributes can impact the user's ability to access files. Therefore, it can be valuable to track changes to user or computer attributes. User and computer objects are stored in AD DS; therefore, changes to their attributes can be audited. For more information, see [DS Access](https://go.microsoft.com/fwlink/?LinkId=241508).  
  
-   **Policy change staging**. Changes to central access policies can impact the access control decisions on all computers where the policies are enforced. A loose policy could grant more access than desired, and an overly restrictive policy could generate an excessive number of Help Desk calls. As a result, it can be extremely valuable to verify changes to a central access policy before enforcing the change. For that purpose,  Windows Server 2012  introduces the concept of "staging." Staging enables users to verify their proposed policy changes before enforcing them. To use policy staging, proposed policies are deployed with the enforced policies, but staged policies do not actually grant or deny permissions. Instead,  Windows Server 2012  logs an audit event (4818) any time the result of the access check that uses the staged policy is different from the result of an access check that uses the enforced policy.  
  


