---
ms.assetid: 8c179884-f0d9-4c7a-973d-820119cf3c38
title: Create a Rule to Permit All Users
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Create a Rule to Permit All Users

In Windows Server 2016, you can use an **Access Control Policy** to create a rule that will give all users access to a relying party.  In Windows Server 2012 R2, using the **Permit All Users** rule template in Active Directory Federation Services \(AD FS\), you can create an authorization rule that will give all users access to the relying party. 

You can use additional authorization rules to further restrict access. Users who are permitted to access the relying party from the Federation Service may still be denied service by the relying party.  
  
You can use the following procedures to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477). 

## To create a rule to permit all users in Windows Server 2016

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall1.PNG)

3.  Right-click the **Relying Party Trust** that you want to permit access to and select **Edit Access Control Policy**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall2.PNG)

4. On the Access control policy select **Permit everyone** and then click **Apply** and **Ok**.
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall3.PNG)
  
## To create a rule to permit all users in Windows Server 2012 R2 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  

3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall4.PNG)  

4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab \(based on the type of authorization rule you require\), and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit All Users** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall6.PNG)    
6.  On the **Configure Rule** page, click **Finish**.  
  
7.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  

## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)  
