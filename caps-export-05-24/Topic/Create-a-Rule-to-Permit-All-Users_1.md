---
title: Create a Rule to Permit All Users_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75b9d3a6-6ec8-4d02-bab5-62e9010c55a0
author: billmath
---
# Create a Rule to Permit All Users_1
Using the **Permit All Users** rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create an authorization rule that will give all users access to the relying party. You can use additional authorization rules to further restrict access. Users who are permitted to access the relying party from the Federation Service may still be denied service by the relying party.  
  
You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to permit all users  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab \(based on the type of authorization rule you require\), and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit All Users** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, click **Finish**.  
  
7.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## Additional references  
[Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md)  
  
[When to Use an Authorization Claim Rule](../Topic/When-to-Use-an-Authorization-Claim-Rule.md)  
  
[The Role of Claims](../Topic/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../Topic/The-Role-of-Claim-Rules.md)  
  
