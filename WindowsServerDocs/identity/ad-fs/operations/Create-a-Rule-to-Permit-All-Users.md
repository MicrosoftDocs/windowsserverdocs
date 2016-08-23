---
title: Create a Rule to Permit All Users
description:
author: billmath
manager: femila
ms.date: 08/23/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
---

# Create a Rule to Permit All Users

>Applies To: Windows Server 2016, Windows Server 2012 R2

Using the **Permit All Users** rule template in Active Directory Federation Services \(AD FS\), you can create an authorization rule that will give all users access to the relying party. You can use additional authorization rules to further restrict access. Users who are permitted to access the relying party from the Federation Service may still be denied service by the relying party.  
  
You can use the following procedure to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To create a rule to permit all users  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab \(based on the type of authorization rule you require\), and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit All Users** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, click **Finish**.  
  
7.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  

## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)  