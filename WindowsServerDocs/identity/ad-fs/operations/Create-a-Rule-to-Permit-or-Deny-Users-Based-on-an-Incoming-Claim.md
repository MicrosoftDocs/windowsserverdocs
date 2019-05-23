---
ms.assetid: 3d770385-9834-4ebe-b66c-b684e0245971
title: Create a Rule to Permit or Deny Users Based on an Incoming Claim
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Create a Rule to Permit or Deny Users Based on an Incoming Claim 


In Windows Server 2016, you can use an **Access Control Policy** to create a rule that will permit or deny users based on an incoming claim.  In Windows Server 2012 R2, using the **Permit or Deny Users Based on an Incoming Claim** rule template in Active Directory Federation Services \(AD FS\), you can create an authorization rule that will grant or deny user’s access to the relying party based on the type and value of an incoming claim. 

For example, you can use this to create a rule that will permit only users that have a group claim with a value of Domain Admins to access the relying party. If you want to permit all users to access the relying party, use the **Permit Everyone** Access Control Policy or the **Permit All Users** rule template depending on your version of Windows Server. Users who are permitted to access the relying party from the Federation Service may still be denied service by the relying party.  
  
You can use the following procedure to create a claim rule with the AD FS Management snap\-in.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).  

## To create a rule to permit users based on an incoming claim on Windows Server 2016
 
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Access Control Policies**. 
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny3.PNG)

3. Right-click and select **Add Access Control Policy**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny4.PNG)

4. In the name box, enter a name for your policy, a description and click **Add**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny5.PNG)

5. On the **Rule Editor**, under users, place a check in **with specific claims in the request** and click the underlined **specific** at the bottom.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny6.PNG)

6. On the **Select Claims** screen, click the **Claims** radio button, select the **Claim type**, the **Operator**, and the **Claim Value** then click **Ok**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny7.PNG)

7.  On the **Rule Editor** click **Ok**.  On the **Add Access Control Policy** screen, click **Ok**.

8. In the **AD FS Management** console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)

9.  Right-click the **Relying Party Trust** that you want to permit access to and select **Edit Access Control Policy**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall2.PNG)

10. On the Access control policy select your policy and then click **Apply** and **Ok**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny8.PNG)

## To create a rule to deny users based on an incoming claim on Windows Server 2016
 
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Access Control Policies**. 
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny3.PNG)

3. Right-click and select **Add Access Control Policy**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny4.PNG)

4. In the name box, enter a name for your policy, a description and click **Add**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny9.PNG)

5. On the **Rule Editor**, make sure everyone is selected and under **Except** place a check in **with specific claims in the request** and click the underlined **specific** at the bottom.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny10.PNG)

6. On the **Select Claims** screen, click the **Claims** radio button, select the **Claim type**, the **Operator**, and the **Claim Value** then click **Ok**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny11.PNG)

7.  On the **Rule Editor** click **Ok**.  On the **Add Access Control Policy** screen, click **Ok**.

8. In the **AD FS Management** console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)

9.  Right-click the **Relying Party Trust** that you want to permit access to and select **Edit Access Control Policy**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall2.PNG)

10. On the Access control policy select your policy and then click **Apply** and **Ok**.
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny12.PNG)

  
## To create a rule to permit or deny users based on an incoming claim on Windows Server 2012 R2
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.    
  
2.  In the console tree, under **AD FS\\Trust Relationships\\Relying Party Trusts**, click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule6.PNG)   

4.  In the **Edit Claim Rules** dialog box, click the **Issuance Authorization Rules** tab or the **Delegation Authorization Rules** tab \(based on the type of authorization rule you require\), and then click **Add Rule** to start the **Add Authorization Claim Rule Wizard**.  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Permit or Deny Users Based on an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny1.PNG)

6.  On the **Configure Rule** page under **Claim rule name** type the display name for this rule, in **Incoming claim type** select a claim type in the list, under **Incoming claim value** type a value or click Browse \(if it is available\) and select a value, and then select one of the following options, depending on the needs of your organization:  
  
    -   **Permit access to users with this incoming claim**  
  
    -   **Deny access to users with this incoming claim**  
![create rule](media/Create-a-Rule-to-Permit-or-Deny-Users-Based-on-an-Incoming-Claim/permitdeny2.PNG)  
7.  Click **Finish**.  
  
8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.  

## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)  
