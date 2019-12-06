---
ms.assetid: 475e34f9-9399-43f4-a840-9dd77258e11a
title: Create a Rule to Send Group Membership as a Claim
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---
# Create a Rule to Send Group Membership as a Claim

Using the Send Group Membership as a Claim rule template in Active Directory Federation Services \(AD FS\), you can create a rule that will make it possible for you to select an Active Directory security group to send as a claim. Only a single claim will be emitted from this rule, based on the group that you select. For example, you can use this rule template to create a rule that will send a group claim with a value of Admin if the user is a member of the Domain Admins security group. This rule should be used only for users in the local Active Directory domain.  
  
You can use the following procedure to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   

## To create a rule to send group membership as a claim on a Relying Party Trust in Windows Server 2016 

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Issuance Policy**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule10.PNG)   
  
4.  In the **Edit Claim Issuance Policy** dialog box, under **Issuance Transform Rules** click **Add Rule** to start the rule wizard. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule11.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group3.PNG)      

6.   On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **User's group** click **Browse** and select a group, under **Outgoing claim type** select the desired claim type, and then under **Outgoing Claim Type** type a value.
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group4.PNG)   

7.  Click the **Finish** button.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.
  
## To create a rule to send group membership as a claim on a Claims Provider Trust in Windows Server 2016 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)   
  
4.  In the **Edit Claim Rules** dialog box, under **Acceptance Transform Rules** click **Add Rule** to start the rule wizard.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group3.PNG)     

6.   On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **User's group** click **Browse** and select a group, under **Outgoing claim type** select the desired claim type, and then under **Outgoing Claim Type** type a value. 
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group4.PNG)      

7.  Click the **Finish** button.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  




  
## To create a rule to send group membership as a claim in Windows Server 2012 R2 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule6.PNG)  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)
    
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as a Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group1.PNG)

6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **User's group** click **Browse** and select a group, under **Outgoing claim type** select the desired claim type, and then under **Outgoing Claim Type** type a value.  
![create rule](media/Create-a-Rule-to-Send-Group-Membership-as-a-Claim/group2.PNG)  

7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  



## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  

[Checklist: Creating Claim Rules for a Claims Provider Trust](https://technet.microsoft.com/library/ee913564.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md) 
