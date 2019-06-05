---
ms.assetid: 696a29b2-d627-4c9a-a384-9c8aaf50bd23
title: Determine the Type of Claim Rule Template to Use
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---


# Determine the Type of Claim Rule Template to Use


An important part of designing an Active Directory Federation Services \(AD FS\) infrastructure is determining the complete set of claim rules—and which corresponding claim rule templates you should use to create them—for each partner that will participate in federation with your organization. You create rules by using claim rule templates in the AD FS Management snap\-in.  
  
Each set of claim rules you configure can only be associated with one federated trust. This means that you cannot create a set of rules on one trust and use them for other trusts in your Federation Service. Instead you can easily create rules from claim rule templates to more quickly help produce a desired set of claims that are agreed upon between each federated partner and your organization.  
  
For more information about rules and rule templates, see [The Role of Claim Rules](The-Role-of-Claim-Rules.md).  
  
Before you begin to determine the types of claim rule templates you should use, consider the following questions:  
  
-   What claims will be provided by your trusted claims providers?  
  
-   What claims do you trust from each claims provider?  
  
-   What claims are required by the relying parties that trust this Federation Service?  
  
-   What claims are you willing to divulge to each relying party?  
  
-   Which users should have access to each relying party?  
  
Answering these questions will help you plan a solid claim rule design. It will also assist you in creating a smooth authorization and access control strategy and make your deployment team more efficient during the rollout.  
  
In this next section you can learn about the type of rule templates to select for your environment based on your business needs.  
  
## Claim rule template types  
The following table describes all of the types of claim rule templates that you can use to create rules using the AD FS Management snap\-in, and the benefits of using one template type over another.  
  
|Rule template type|Description|Advantages|Disadvantages|  
|----------------------|---------------|--------------|-----------------|  
|Pass Through or Filter an Incoming Claim|Used to create a rule that will pass through all claim values for a selected claim type or filter claims based on the claim values so that only certain claim values for a selected claim type will pass through.<br /><br />For more information, see [When to Use a Pass Through or Filter Claim Rule](When-to-Use-a-Pass-Through-or-Filter-Claim-Rule.md).|-   Can be used to select particular claims to be accepted or issued unchanged|-   Claim type and value cannot be changed|  
|Transform an Incoming Claim|Used to create a rule that can select an incoming claim and map it to a different claim type or map its claim value to a new claim value.<br /><br />For more information, see [When to Use a Transform Claim Rule](When-to-Use-a-Transform-Claim-Rule.md).|-   Can be used to normalize claim types or values<br />-   Can replace an e\-mail suffix of an incoming claim|-   More complex string replacements require a custom rule|  
|Send LDAP Attributes as Claims|Used to create a rule that will select attributes from an LDAP attribute store to send as claims to the relying party.<br /><br />For more information, see [When to Use a Send LDAP Attributes as Claims Rule](When-to-Use-a-Send-LDAP-Attributes-as-Claims-Rule.md).|-   Can source claims from any AD DS\/AD LDS attribute store<br />-   Multiple claims can be issued using a single rule|-   Performance – slow as a result of account lookup<br />-   Cannot use a custom LDAP filter for querying|  
|Send Group Membership as a Claim|Used to create a rule that can send a specified claim type and value when a user is a member of an Active Directory security group. Only a single claim will be sent using this rule, based on the group that you select.<br /><br />For more information, see [When to Use a Send Group Membership as a Claim Rule](When-to-Use-a-Send-Group-Membership-as-a-Claim-Rule.md).|-   Fast performance for issuing group claims – no account lookup|-   User must be a member of a local Active Directory group|  
|Send Claims Using a Custom Rule|Used to create a custom rule that will provide more advanced options than a standard rule template. You write custom rules with the AD FS claim rule language.<br /><br />For more information, see [When to Use a Custom Claim Rule](When-to-Use-a-Custom-Claim-Rule.md).|-   Can be used to source claims from an SQL attribute store<br />-   Can be used to specify a custom LDAP filter<br />-   Can be used to issue a PPID<br />-   Can be used with a custom attribute store<br />-   Can be used to add claims only to the input claim set<br />-   Can be used to send claims based on more than one incoming claim|-   More difficult to configure \- Some ramp up time may be needed to initially gain knowledge of the claim rule language|  
|Permit or Deny Users Based on an Incoming Claim|Used to create a rule that will permit or deny access by users to the relying party, based on the type and value of an incoming claim.<br /><br />For more information, see [When to Use an Authorization Claim Rule](When-to-Use-an-Authorization-Claim-Rule.md).|-   Simplifies the authorization process|-   Requires that only one claim type and one claim value be specified<br />-   Does not support pattern matching for claim values|  
|Permit All Users|Used to create a rule that will permit all users to access the relying party.<br /><br />For more information, see [When to Use an Authorization Claim Rule](When-to-Use-an-Authorization-Claim-Rule.md).|-   Simple to configure|-   Less secure than using the Permit or Deny Users Based on an Incoming Claim template|  
  

