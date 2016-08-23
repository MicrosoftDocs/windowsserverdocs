---
title: Create a Rule to Send Group Membership as a Claim
description:
author: billmath
manager: femila
ms.date: 08/23/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
ms.author: billmath
---
# Create a Rule to Send Group Membership as a Claim

>Applies To: Windows Server 2016, Windows Server 2012 R2

Using the Send Group Membership as a Claim rule template in Active Directory Federation Services \(AD FS\), you can create a rule that will make it possible for you to select an Active Directory security group to send as a claim. Only a single claim will be emitted from this rule, based on the group that you select. For example, you can use this rule template to create a rule that will send a group claim with a value of Admin if the user is a member of the Domain Admins security group. This rule should be used only for users in the local Active Directory domain.  
  
You can use the following procedure to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To create a rule to send group membership as a claim  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as a Claim** from the list, and then click **Next**.  
  
6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **User’s group** click **Browse** and select a group, under **Outgoing claim type** select the desired claim type, and then under **Outgoing Claim Type** type a value.  
  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  



## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  

[Checklist: Creating Claim Rules for a Claims Provider Trust](https://technet.microsoft.com/library/ee913564.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md) 