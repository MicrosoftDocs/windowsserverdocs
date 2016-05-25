---
title: Create a Rule to Permit All Users
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 328830dd-8a9f-4bc5-9811-8cd9014d0867
author: billmath
---
# Create a Rule to Permit All Users
By using the **Permit All Users** rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create an authorization rule that gives all users access to the relying party. You can use additional authorization rules to further restrict access. Users who are permitted to access the relying party from the Federation Service might still be denied service by the relying party.  
  
You can use the following procedure to create a claim rule by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to permit all users  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] snap\-in, in the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab, which is based on the type of authorization rule that you require, and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit All Users** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, click **Finish**.  
  
7.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
