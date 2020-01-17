---
ms.assetid: 0039fbbb-b981-4526-a550-f3456ff27635
title: Create a Rule to Transform an Incoming Claim
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Create a Rule to Send an AD FS 1.x Compatible Claim

In situations in which you are using Active Directory Federation Services \(AD FS\) to issue claims that will be received by federation servers running AD FS 1.0 \(Windows Server 2003 R2\) or AD FS 1.1 \(Windows Server 2008 or Windows Server 2008 R2\), you must do the following:  
  
-   Create a rule that will send a Name ID claim type with a format of UPN, Email, or Common Name.  
  
-   All other claims that are sent must have one of the following claim types:  
  
    -   AD FS 1.*x* Email Address  
  
    -   AD FS 1.*x* UPN  
  
    -   Common Name  
  
    -   Group  
  
    -   Any other claim type that begins with https://schemas.xmlsoap.org/claims/, such as https://schemas.xmlsoap.org/claims/EmployeeID  
  
Depending on the needs of your organization, use one of the following procedures to create an AD FS 1.*x* compatible NameID claim:  
  
-   Create this rule to issue an AD FS 1.x Name ID claim using the **Pass Through or Filter an Incoming Claim rule template**  
  
-   Create this rule to issue an AD FS 1.x Name ID claim using the **Transform an Incoming Claim rule template**. You can use this rule template in situations in which you want to change the existing claim type to a new claim type that will work with AD FS 1. *x* claims.  
  
> [!NOTE]  
> For this rule to work as expected, make sure that the relying party trust or claims provider trust where you are creating this rule has been configured to use the **AD FS 1.0 and 1.1 profile**. 

## To create a rule to issue an AD FS 1.*x* Name ID claim using the Pass Through or Filter an Incoming Claim rule template on a Relying Party Trust in Windows Server 2016 

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Issuance Policy**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule10.PNG)   
  
4.  In the **Edit Claim Issuance Policy** dialog box, under **Issuance Transform Rules** click **Add Rule** to start the rule wizard. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule11.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Pass Through or Filter an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule4.PNG)    

6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Name ID** in the list.  
  
8.  In **Incoming name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
9. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs3.PNG)   

10. Click **Finish**, and then click **OK** to save the rule.  

  
## To create a rule to issue an AD FS 1.*x* Name ID claim using the Pass Through or Filter an Incoming Claim rule template on a Claims Provider Trust in Windows Server 2016 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)   
  
4.  In the **Edit Claim Rules** dialog box, under **Acceptance Transform Rules** click **Add Rule** to start the rule wizard.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Pass Through or Filter an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule4.PNG)    

6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Name ID** in the list.  
  
8.  In **Incoming name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
9. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs3.PNG)

10. Click **Finish**, and then click **OK** to save the rule.  


## To create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016 

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Relying Party Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Issuance Policy**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule10.PNG)
  
4.  In the **Edit Claim Issuance Policy** dialog box, under **Issuance Transform Rules** click **Add Rule** to start the rule wizard. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule11.PNG)

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform3.PNG)

6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select the type of incoming claim that you want to transform in the list.  
  
8.  In **Outgoing claim type**, select **Name ID** in the list.  
  
9. In **Outgoing name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
10. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs4.PNG)

11. Click **Finish**, and then click **OK** to save the rule.  

  


## To create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016 
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**. 
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)   
  
4.  In the **Edit Claim Rules** dialog box, under **Acceptance Transform Rules** click **Add Rule** to start the rule wizard.
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform3.PNG)      

6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select the type of incoming claim that you want to transform in the list.  
  
8.  In **Outgoing claim type**, select **Name ID** in the list.  
  
9. In **Outgoing name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
10. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs4.PNG)    

11. Click **Finish**, and then click **OK** to save the rule.  













  
## To create a rule to issue an AD FS 1.*x* Name ID claim using the Pass Through or Filter an Incoming Claim rule template on Windows Server 2012 R2
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule6.PNG) 
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
![create rule](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)    

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Pass Through or Filter an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule7.PNG)  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Name ID** in the list.  
  
8.  In **Incoming name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
9. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs1.PNG)

10. Click **Finish**, and then click **OK** to save the rule.  

  
## To create a rule to issue an AD FS 1.*x* Name ID claim using the Transform an Incoming Claim rule template in Windows Server 2012 R2  
  
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
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.  
![create rule](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform1.PNG)   
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select the type of incoming claim that you want to transform in the list.  
  
8.  In **Outgoing claim type**, select **Name ID** in the list.  
  
9. In **Outgoing name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
10. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
![create rule](media/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim/adfs2.PNG)    

11. Click **Finish**, and then click **OK** to save the rule.  

## Additional references 
[Configure Claim Rules](Configure-Claim-Rules.md)  
 
[Checklist: Creating Claim Rules for a Relying Party Trust](https://technet.microsoft.com/library/ee913578.aspx)  

[Checklist: Creating Claim Rules for a Claims Provider Trust](https://technet.microsoft.com/library/ee913564.aspx)  
  
[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)  

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)  
  
[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md) 
