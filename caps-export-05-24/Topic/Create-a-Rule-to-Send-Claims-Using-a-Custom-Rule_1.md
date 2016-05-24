---
title: Create a Rule to Send Claims Using a Custom Rule_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71183813-3df8-4d3a-8e13-9f25d4437a9a
author: billmath
---
# Create a Rule to Send Claims Using a Custom Rule_1
By using the **Send Claims Using a Custom Rule** template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create custom claim rules for situation in which a standard rule template does not satisfy the requirements of your organization. Custom claim rules are written in the claim rule language and must then be copied into the **Custom rule** text box before they can be used in a rule set. For information about constructing the syntax for an advanced rule, see [The Role of the Claim Rule Language](../Topic/The-Role-of-the-Claim-Rule-Language.md).  
  
You can use the following procedure to create a claim rule by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to send claims by using a custom claim  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Claims Using a Custom Rule** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. Under **Custom rule**, type or paste the claim rule language syntax that you want for this rule.  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
