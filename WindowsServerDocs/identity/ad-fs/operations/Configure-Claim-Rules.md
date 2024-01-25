---
description: "Learn more about: Configure Claim Rules in AD FS for Windows Server"
ms.assetid: 9cafa3e1-8118-4a75-a7c2-1dbe40b1a444
title: Configure Claims Rules
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# Configure Claim Rules in AD FS for Windows Server

In a claims\-based identity model, the function of Active Directory Federation Services \(AD FS\) as federation services is to issue a token that contains a set of claims. Claims rules govern the decisions with regard to claims that AD FS issues. Claim rules and all server configuration data are stored in the AD FS configuration database.

AD FS makes issuance decisions that are based on identity information that is provided to it in the form of claims and other contextual information. At a high level, AD FS operates as a rules processor by taking one set of claims as input, performs a number of transformations, and then returns a different set of claims as output.

The following topics will assist you in creating the rules that AD FS will process:

-   [Create a Rule to Pass Through or Filter an Incoming Claim](Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim.md)

-   [Create a Rule to Permit All Users](Create-a-Rule-to-Permit-All-Users.md)

-   [Create a Rule to Permit or Deny Users Based on an Incoming Claim](Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim.md)

-   [Create a Rule to Send LDAP Attributes as Claims](Create-a-Rule-to-Send-LDAP-Attributes-as-Claims.md)

-   [Create a Rule to Send Group Membership as a Claim](Create-a-Rule-to-Send-Group-Membership-as-a-Claim.md)

-   [Create a Rule to Transform an Incoming Claim](Create-a-Rule-to-Transform-an-Incoming-Claim.md)

-   [Create a Rule to Send an Authentication Method Claim](Create-a-Rule-to-Send-an-Authentication-Method-Claim.md)
-   [Create a Rule to Send an AD FS 1.x Compatible Claim](Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim.md)

-   [Create a Rule to Send Claims Using a Custom Rule](Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule.md)

## See Also
[AD FS Operations](../ad-fs-operations.md)
