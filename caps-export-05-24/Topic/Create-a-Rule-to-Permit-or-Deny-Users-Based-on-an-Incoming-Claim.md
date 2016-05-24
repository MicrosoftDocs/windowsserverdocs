---
title: Create a Rule to Permit or Deny Users Based on an Incoming Claim
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ccd636f9-fc56-495a-9bd5-376f5a64bf22
author: billmath
---
# Create a Rule to Permit or Deny Users Based on an Incoming Claim
By using the **Permit or Deny Users Based on an Incoming Claim** rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can create an authorization rule that grants or denies user’s access permission to the relying party, which is based on the type and value of an incoming claim. For example, you can use this rule template to create a rule that grants only users that have a group claim with a value of Domain Admins access the relying party. If you want to grant all users access the relying party, use the **Permit All Users** rule template. Users who are granted access the relying party from the Federation Service might still be denied service by the relying party.  
  
You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to permit or deny users based on an incoming claim  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] snap\-in, in the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab, which is based on the type of authorization rule that you require, and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit or Deny Users Based on an Incoming Claim** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. In **Incoming claim type**, select a claim type in the list, under **Incoming claim value**, type a value or click **Browse**, if it is available, and select a value, and then select one of the following options, which depends on the requirements of your organization:  
  
    -   **Permit access to users with this incoming claim**  
  
    -   **Deny access to users with this incoming claim**  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
