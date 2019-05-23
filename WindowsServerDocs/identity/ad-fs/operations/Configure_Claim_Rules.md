---
ms.assetid: 20d48afc-2623-43e9-8ed9-aeb9a0505630
title: Configure Claims Rules
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Configure Claim Rules

In a claims\-based identity model, the function of Active Directory Federation Services (AD FS) as federation services is to issue a token that contains a set of claims. Claims rules govern the decisions with regard to claims that AD FS issues. Claim rules and all server configuration data are stored in the AD FS configuration database.  
  
AD FS makes issuance decisions that are based on identity information that is provided to it in the form of claims and other contextual information. At a high level, AD FS operates as a rules processor by taking one set of claims as input, performs a number of transformations, and then returns a different set of claims as output. 

The following topics will assist you in creating the rules that AD FS will process: 
  
-   [Create a Rule to Pass Through or Filter an Incoming Claim](../../ad-fs/operations/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim.md)  
  
-   [Create a Rule to Permit All Users](../../ad-fs/operations/Create-a-Rule-to-Permit-All-Users.md)  
  
-   [Create a Rule to Permit or Deny Users Based on an Incoming Claim](../../ad-fs/operations/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim.md)  
  
-   [Create a Rule to Send LDAP Attributes as Claims](../../ad-fs/operations/Create-a-Rule-to-Send-LDAP-Attributes-as-Claims.md)  
  
-   [Create a Rule to Send Group Membership as a Claim](../../ad-fs/operations/Create-a-Rule-to-Send-Group-Membership-as-a-Claim.md)  
  
-   [Create a Rule to Transform an Incoming Claim](../../ad-fs/operations/Create-a-Rule-to-Transform-an-Incoming-Claim.md)  
  
-   [Create a Rule to Send an Authentication Method Claim](../../ad-fs/operations/Create-a-Rule-to-Send-an-Authentication-Method-Claim.md)  
  
-   [Create a Rule to Send Claims Using a Custom Rule](../../ad-fs/operations/Create-a-Rule-to-Send-Claims-Using-a-Custom-rule.md)  

## See Also  
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md) 
