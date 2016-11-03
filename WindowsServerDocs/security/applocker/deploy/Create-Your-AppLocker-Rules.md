---
title: Create Your AppLocker Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 72cd1356-1e25-499b-93d9-1e3e5b204cbc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Create Your AppLocker Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes what you need to know about AppLocker rules and the methods that you can to create rules.

## Creating AppLocker rules
AppLocker rules apply to the targeted application, and they are the components that make up the AppLocker policy. Depending on your IT environment and the business group that requires application control policies, setting these access rules for each application can be time-consuming and prone to error. With AppLocker, you can generate rules automatically or create rules individually. Creating rules that are derived from your planning document can help you avoid unintended results. For information about this planning document and other planning activities, see [AppLocker Policies Design Guide](../design/applocker-policies-design-guide.md).

### Automatically generate your rules
You can use a reference computer to automatically create a set of default rules for each of the installed applications, test and modify each rule as necessary, and deploy the policies. Creating most of the rules for all the installed applications gives you a starting point to build and test your policies. For information about performing this task, see the following topics:

-   [Run the Automatically Generate Rules Wizard](../manage/rules/run-the-automatically-generate-rules-wizard.md)

-   [Create AppLocker Default Rules](../manage/rules/create-applocker-default-rules.md)

-   [Edit AppLocker Rules](../manage/rules/edit-applocker-rules.md)

-   [Configure Exceptions for an AppLocker Rule](../manage/rules/configure-exceptions-for-an-applocker-rule.md)

### Create your rules individually
You can create rules and set the mode to **Audit only** for each installed application, test and update each rule as necessary, and then deploy the policies. Creating rules individually might be best when you are targeting a small number of applications within a business group.

> [!NOTE]
> AppLocker includes default rules for each rule collection. These rules are intended to help ensure that the files that are required for Windows to operate properly are allowed in an AppLocker rule collection. You can also edit the default rules. For information about creating the default rules for the Windows operating system, see [Create AppLocker Default Rules](../manage/rules/create-applocker-default-rules.md).

For information about performing this task, see:

1.  [Create a Rule That Uses a Publisher Condition](../manage/rules/create-a-rule-that-uses-a-publisher-condition.md)

2.  [Create a Rule That Uses a Path Condition](../manage/rules/create-a-rule-that-uses-a-path-condition.md)

3.  [Create a Rule That Uses a File Hash Condition](../manage/rules/create-a-rule-that-uses-a-file-hash-condition.md)

4.  [Edit AppLocker Rules](../manage/rules/edit-applocker-rules.md)

5.  [Enforce AppLocker Rules](../manage/rules/enforce-applocker-rules.md)

6.  [Configure an AppLocker Policy for Audit Only](../manage/policies/configure-an-applocker-policy-for-audit-only.md)

## About selecting rules
AppLocker policies are composed of distinct rules for specific applications. These rules are grouped by collection, and they are implemented through an AppLocker policy definition. AppLocker policies are managed by using Group Policy or by using the Local Security Policy snap-in for a single computer.

When you determine what types of rules to create for each of your business groups or organizational units (OUs), you should also determine what enforcement setting to use for each group. Certain rule types are more applicable for some applications, depending on how the applications are deployed in a specific business group.

For information about how to determine and document your AppLocker rules, see [AppLocker Policies Design Guide](../design/applocker-policies-design-guide.md).

For information about AppLocker rules and AppLocker policies, see the following topics:

-   [Understanding AppLocker Rule Behavior](../get-started/how-applocker-works/understanding-applocker-rule-behavior.md)

-   [Understanding AppLocker Rule Exceptions](../get-started/how-applocker-works/understanding-applocker-rule-exceptions.md)

-   [Understanding AppLocker Rule Collections](../get-started/how-applocker-works/understanding-applocker-rule-collections.md)

-   [Understanding AppLocker Allow and Deny Actions on Rules](../get-started/how-applocker-works/understanding-applocker-allow-and-deny-actions-on-rules.md)

-   [Understanding AppLocker Rule Condition Types](../get-started/how-applocker-works/understanding-applocker-rule-condition-types.md)

-   [Understanding AppLocker Default Rules](../get-started/how-applocker-works/understanding-applocker-default-rules.md)

## Next steps

1.  [Import an AppLocker Policy into a GPO](../manage/policies/import-an-applocker-policy-into-a-gpo.md)

2.  [Import an AppLocker Policy from Another Computer](../manage/policies/import-an-applocker-policy-from-another-computer.md)

3.  [Test and Update an AppLocker Policy](../manage/test-and-update-an-applocker-policy.md)

4.  [Deploy the AppLocker Policy into Production](deploy-the-applocker-policy-into-production.md)

## See Also
[Create Your AppLocker Policies](create-your-applocker-policies.md)


