---
title: Create a Rule to Pass Through or Filter an Incoming Claim
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fd09a6d-50af-4578-ac1a-19d9c8495377
author: billmath
---
# Create a Rule to Pass Through or Filter an Incoming Claim
By using the **Pass Through or Filter an Incoming Claim** rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can pass through all incoming claims by using a selected claim type. You can also filter the values of incoming claims by using a selected claim type. For example, you can use this rule template to create a rule that sends all incoming group claims. You can also use this rule to send only user principal name \(UPN\) claims that end with @fabrikam.  
  
You can use the following procedure to create a claim rule by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to pass through or filter an incoming claim  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Pass Through or Filter an Incoming Claim** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. In **Incoming claim type**, select a claim type in the list, and then select one of the following options, which depends on the requirements of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
  
7.  Click the **Finish** button.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
