---
title: Create a Rule to Pass Through or Filter an Incoming Claim
description:
author: billmath
manager: femila
ms.date: 08/23/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
---

# Create a Rule to Pass Through or Filter an Incoming Claim

>Applies To: Windows Server 2016, Windows Server 2012 R2

Using the Pass Through or Filter an Incoming Claim rule template in Active Directory Federation Services \(AD FS\), you can pass through all incoming claims with a selected claim type. You can also filter the values of incoming claims with a selected claim type. For example, you can use this rule template to create a rule that will send all incoming group claims. You can also use this rule to send only user principal name \(UPN\) claims that end with @fabrikam.  
  
You can use the following procedure to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To create a rule to pass through or filter an incoming claim  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**. 
![](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)   
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
![](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)    
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Pass Through or Filter an Incoming Claim** from the list, and then click **Next**.  
![](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule4.PNG)    

6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **Incoming claim type** select a claim type in the list, and then select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
![](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule5.PNG)    

7.  Click the **Finish** button.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  
  
## Additional references  
[Configure Claim Rules](Configure-Claim-Rules.md)  
  
[When to Use a Pass Through or Filter Claim Rule](../../ad-fs/technical-reference/When-to-Use-a-Pass-Through-or-Filter-Claim-Rule.md)  
  
[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)  
  