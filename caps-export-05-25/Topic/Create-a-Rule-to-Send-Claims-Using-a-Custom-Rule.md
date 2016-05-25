---
title: Create a Rule to Send Claims Using a Custom Rule
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5006abfe-c5dd-4d1b-9b03-30f3d0600dff
author: billmath
---
# Create a Rule to Send Claims Using a Custom Rule
Using the Send Claims Using a Custom Rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create custom claim rules for situation in which a standard rule template is not sufficient for the needs of your organization. Custom claim rules are written in the claim rule language and must then be copied into the **Custom rule** text box before they can be used in a rule set. For information about constructing the syntax for an advanced rule, see [The Role of the Claim Rule Language](../Topic/The-Role-of-the-Claim-Rule-Language.md).  
  
You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to send claims using a custom claim  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Claims Using a Custom Rule** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule. Under **Custom rule**, type or paste the desired claim rule language syntax for this rule.  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## Additional references  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
[Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md)  
  
[The Role of the Claim Rule Language](../Topic/The-Role-of-the-Claim-Rule-Language.md)  
  
[The Role of Claims](../Topic/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../Topic/The-Role-of-Claim-Rules.md)  
  
