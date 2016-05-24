---
title: Create a Rule to Send LDAP Attributes as Claims_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b8f06200-ed64-41ec-959b-521d9af351ba
author: billmath
---
# Create a Rule to Send LDAP Attributes as Claims_1
Using the Send LDAP Attributes as Claims rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create a rule that will select attributes from a Lightweight Directory Access Protocol \(LDAP\) attribute store, such as Active Directory, to send as claims to the relying party. For example, you can use this rule template to create a Send LDAP Attributes as Claims rule that will extract attribute values for authenticated users from the **displayName** and **telephoneNumber** Active Directory attributes and then send those values as two different outgoing claims.  
  
You can also use this rule to send all the user’s group memberships. If you want to send only individual group memberships, use the Send Group Membership as a Claim rule template. You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to send LDAP attributes as claims  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send LDAP Attributes as Claims** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, under **Attribute store** select **Active Directory**, and under **Mapping of LDAP attributes to outgoing claim types** select the desired **LDAP Attribute** and corresponding **Outgoing Claim Type** types from the drop\-down lists.  
  
    You have to select a new LDAP attribute and outgoing claim type pair on a different row for each Active Directory attribute that you want to issue a claim for as part of this rule.  
  
7.  Click the **Finish** button.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## Additional references  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
[Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md)  
  
[The Role of Claims](../Topic/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../Topic/The-Role-of-Claim-Rules.md)  
  
