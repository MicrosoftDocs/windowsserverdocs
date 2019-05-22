---
ms.assetid: 38eb3726-e97b-484e-9926-67e8a046b0c5
title: Create a Rule to Send Claims Using a Custom Rule
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Create a Rule to Send Claims Using a Custom Rule


By using the **Send Claims Using a Custom Rule** template in Active Directory Federation Services (AD FS), you can create custom claim rules for situation in which a standard rule template does not satisfy the requirements of your organization. Custom claim rules are written in the claim rule language and must then be copied into the **Custom rule** text box before they can be used in a rule set. For information about constructing the syntax for an advanced rule, see [The Role of the Claim Rule Language](../../ad-fs/technical-reference/The-Role-of-the-Claim-Rule-Language.md).  
  
You can use the following procedure to create a claim rule by using the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).



## To create a rule to pass through or filter an incoming claim on a Relying Party Trust in Windows Server 2016 

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Issuance Policy**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule10.PNG)   
  
4.  In the **Edit Claim Issuance Policy** dialog box, under **Issuance Transform Rules** click **Add Rule** to start the rule wizard. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule11.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Claims Using a Custom Rule** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom3.PNG)   
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. Under **Custom rule**, type or paste the claim rule language syntax that you want for this rule.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom4.PNG)     

7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.   
  
## To create a rule to pass through or filter an incoming claim on a Claims Provider Trust in Windows Server 2016 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)   
  
4.  In the **Edit Claim Rules** dialog box, under **Acceptance Transform Rules** click **Add Rule** to start the rule wizard.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Claims Using a Custom Rule** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom3.PNG)   
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. Under **Custom rule**, type or paste the claim rule language syntax that you want for this rule.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom4.PNG)     

7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.   

















   
  
## To create a rule to send claims by using a custom claim in Windows Server 2012 R2 
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule6.PNG) 
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Claims Using a Custom Rule** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom1.PNG)   
  
6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. Under **Custom rule**, type or paste the claim rule language syntax that you want for this rule.  
![create rule](media/Create-a-Rule-to-Send-Claims-Using-a-Custom-Rule/custom2.PNG)     

7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  

## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  

[Checklist: Creating Claim Rules for a Claims Provider Trust](https://technet.microsoft.com/library/ee913564.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md) 
