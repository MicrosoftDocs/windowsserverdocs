---
description: "Learn more about: Create a Rule to Transform an Incoming Claim"
ms.assetid: ef83960f-d2cf-441f-b2b6-d97822ec7149
title: Create a Rule to Transform an Incoming Claim
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article

---


# Create a Rule to Transform an Incoming Claim


By using the **Transform an Incoming Claim** rule template in Active Directory Federation Services \(AD FS\), you can select an incoming claim, change its claim type, and change its claim value. For example, you can use this rule template to create a rule that sends a role claim with the same claim value of an incoming group claim. You can also use this rule to send a group claim with a claim value of Purchasers when there is an incoming group claim with a value of Admins, or you can send only user principal name \(UPN\) claims that end with @fabrikam.

You can use the following procedure to create a claim rule with the AD FS Management snap\-in.

Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

## To create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.

2.  In the console tree, under **AD FS**, click **Relying Party Trusts**.
![Screenshot that shows where to select Relying Party Trusts when you create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule9.PNG)

3.  Right\-click the selected trust, and then click **Edit Claim Issuance Policy**.
![Screenshot that shows where to select Edit Claim Issuance Policy when you create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule10.PNG)

4.  In the **Edit Claim Issuance Policy** dialog box, under **Issuance Transform Rules** click **Add Rule** to start the rule wizard.
![Screenshot that shows where to select Add Rule when you create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule11.PNG)

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.
![Screenshot that shows where to select the Transform an Incoming Claim when you create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016.](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform3.PNG)

6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. In **Incoming claim type**, select a claim type in the list. In **Outgoing claim type**, select a claim type in the list, and then select one of the following options, which depends on the requirements of your organization:

    -   **Pass through all claim values**

    -   **Replace an incoming claim value with a different outgoing claim value**

    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**
![Screenshot that shows where to type the claim rule name when you create a rule to transform an incoming claim on a Relying Party Trust in Windows Server 2016.](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform4.PNG)

7.  Click the **Finish** button.

8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.

> [!NOTE]
> If you are setting up the Dynamic Access Control scenario that uses AD FS\-issued claims, first create a transform rule on the claims provider trust, and in **Incoming claim type**, type the name for the incoming claim, or, if a claim description was previously created, select it from the list. Second, in **Outgoing claim type**, select the claim URL that you want, and then create a transform rule on the relying party trust to issue the device claim.
>
> For more information about Dynamic Access Control scenarios, see [Dynamic Access Control Content Roadmap](../../solution-guides/dynamic-access-control--scenario-overview.md) or [Using AD DS Claims with AD FS](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831504(v=ws.11)).

## To create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.

2.  In the console tree, under **AD FS**, click **Claims Provider Trusts**.
![Screenshot that shows where to select Claims Provider Trusts when you create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule1.PNG)

3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![Screenshot that shows where to select Edit Claim Rules when you create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule2.PNG)

4.  In the **Edit Claim Rules** dialog box, under **Acceptance Transform Rules** click **Add Rule** to start the rule wizard.
![Screenshot that shows where to select Add Rule when you create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule3.PNG)

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.
![Screenshot that shows where to select the Transform an Incoming Claim template when you create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016.](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform3.PNG)

6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. In **Incoming claim type**, select a claim type in the list. In **Outgoing claim type**, select a claim type in the list, and then select one of the following options, which depends on the requirements of your organization:

    -   **Pass through all claim values**

    -   **Replace an incoming claim value with a different outgoing claim value**

    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**
![Screenshot that shows where to type the claim rule name when you create a rule to transform an incoming claim on a Claims Provider Trust in Windows Server 2016.](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform4.PNG)

7.  Click the **Finish** button.

8.  In the **Edit Claim Rules** dialog box, click **OK** to save the rule.

> [!NOTE]
> If you are setting up the Dynamic Access Control scenario that uses AD FS\-issued claims, first create a transform rule on the claims provider trust, and in **Incoming claim type**, type the name for the incoming claim, or, if a claim description was previously created, select it from the list. Second, in **Outgoing claim type**, select the claim URL that you want, and then create a transform rule on the relying party trust to issue the device claim.
>
> For more information about Dynamic Access Control scenarios, see [Dynamic Access Control Content Roadmap](../../solution-guides/dynamic-access-control--scenario-overview.md) or [Using AD DS Claims with AD FS](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831504(v=ws.11)).

## To create a rule to transform an incoming claim in Windows Server 2012 R2

1.  In Server Manager, click **Tools**, and then click **AD FS Management**.

2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.

3.  Right\-click the selected trust, and then click **Edit Claim Rules**.
![Screenshot that shows where to select Edit Claim Rules when you create a rule in Windows Server 2012 R2.](media/Create-a-Rule-to-Pass-Through-or-Filter-an-Incoming-Claim/claimrule6.PNG)

4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:

    -   **Acceptance Transform Rules**

    -   **Issuance Transform Rules**

    -   **Issuance Authorization Rules**

    -   **Delegation Authorization Rules**
![Screenshot that shows where to select Edit Claim Rules when you create a rule to transform an incoming claim in Windows Server 2012 R2.](media/Create-a-Rule-to-Permit-All-Users/permitall5.PNG)

5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** from the list, and then click **Next**.
![Screenshot that shows where to select the Transform an Incoming Claim template when you create a rule to transform an incoming claim in Windows Server 2012 R2.](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform1.PNG)

6.  On the **Configure Rule** page, under **Claim rule name**, type the display name for this rule. In **Incoming claim type**, select a claim type in the list. In **Outgoing claim type**, select a claim type in the list, and then select one of the following options, which depends on the requirements of your organization:

    -   **Pass through all claim values**

    -   **Replace an incoming claim value with a different outgoing claim value**

    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**
![create rule](media/Create-a-Rule-to-Transform-an-Incoming-Claim/transform2.PNG)

> [!NOTE]
> If you are setting up the Dynamic Access Control scenario that uses AD FS\-issued claims, first create a transform rule on the claims provider trust, and in **Incoming claim type**, type the name for the incoming claim, or, if a claim description was previously created, select it from the list. Second, in **Outgoing claim type**, select the claim URL that you want, and then create a transform rule on the relying party trust to issue the device claim.
>
> For more information about Dynamic Access Control scenarios, see [Dynamic Access Control Content Roadmap](../../solution-guides/dynamic-access-control--scenario-overview.md) or [Using AD DS Claims with AD FS](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831504(v=ws.11)).

7. Click **Finish**.

8. In the **Edit Claim Rules** dialog box, click **OK** to save the rule.

## Additional references
[Configure Claim Rules](Configure-Claim-Rules.md)

[Checklist: Creating Claim Rules for a Relying Party Trust](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ee913578(v=ws.11))

[Checklist: Creating Claim Rules for a Claims Provider Trust](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ee913564(v=ws.11))

[When to Use an Authorization Claim Rule](../../ad-fs/technical-reference/When-to-Use-an-Authorization-Claim-Rule.md)

[The Role of Claims](../../ad-fs/technical-reference/The-Role-of-Claims.md)

[The Role of Claim Rules](../../ad-fs/technical-reference/The-Role-of-Claim-Rules.md)