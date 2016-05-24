---
title: Create a Rule to Send LDAP Attributes as Claims
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8c499dfd-0761-42af-ae60-170605d7da24
author: billmath
---
# Create a Rule to Send LDAP Attributes as Claims
By using the **Send LDAP Attributes as Claims** rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create a rule that selects attributes from a Lightweight Directory Access Protocol \(LDAP\) attribute store, such as Active Directory, to send as claims to the relying party. For example, you can use this rule template to create a **Send LDAP Attributes as Claims** rule that extracts attribute values for authenticated users from the **displayName** and **telephoneNumber** Active Directory attributes, and then send those values as two different outgoing claims.  
  
You can also use this rule to send all the user’s group memberships. If you want to send only individual group memberships, use the **Send Group Membership as a Claim** rule template. You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to send LDAP attributes as claims  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send LDAP Attributes as Claims** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. Under **Attribute store**, select **Active Directory**, and under **Mapping of LDAP attributes to outgoing claim types**, select the **LDAP Attribute** that you want and the corresponding **Outgoing Claim Type** types from the lists.  
  
    You have to select a new LDAP attribute and outgoing claim type pair on a different row for each Active Directory attribute for which you want to issue a claim as part of this rule.  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
