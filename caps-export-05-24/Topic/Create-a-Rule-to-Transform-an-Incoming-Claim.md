---
title: Create a Rule to Transform an Incoming Claim
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b146d04-7efd-4b59-a966-cb3e7ed44f1b
author: billmath
---
# Create a Rule to Transform an Incoming Claim
Using the Transform an Incoming Claim rule template in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can select an incoming claim, change its claim type, and change its claim value. For example, you can use this rule template to create a rule that will send a role claim with the same claim value of an incoming group claim. You can also use this rule to send a group claim with a claim value of Purchasers when there is an incoming group claim with a value of Admins, or you can send only User Principal Name \(UPN\) claims that end with @fabrikam.  
  
You can use the following procedure to create a claim rule with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a rule to transform an incoming claim  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **Incoming claim type** select a claim type in the list, in **Outgoing claim type** select a claim type in the list, and then select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
  
    > [!NOTE]  
    > If you are setting up the Dynamic Access Control scenario that uses AD DS\-issued claims, first create a transform rule on the claims provider trust and in **Incoming claim type**, type the name for the incoming claim or if a claim description was previously created select it from the list. Second, in **Outgoing claim type**, select the desired claim URL, and then create a transform rule on the relying party trust to issue the device claim.  
    >   
    > For more information about Dynamic Access Control scenarios, see [Dynamic Access Control Content Roadmap](../Topic/Dynamic-Access-Control--Scenario-Overview.md#BKMK_APP) or [Using AD DS Claims with AD FS](../Topic/Using-AD-DS-Claims-with-AD-FS.md).  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## Additional references  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
[Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md)  
  
[When to Use a Transform Claim Rule](../Topic/When-to-Use-a-Transform-Claim-Rule.md)  
  
[The Role of Claims](../Topic/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../Topic/The-Role-of-Claim-Rules.md)  
  
