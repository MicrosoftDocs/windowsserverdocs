---
title: Create a Rule That Uses a Publisher Condition
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c78958ff-ed07-4032-a708-ea19bf1f5fa9
---
# Create a Rule That Uses a Publisher Condition
This topic shows how to create an applocker rule with a publisher condition in  Windows Server 2012  and Windows 8.

You can use publisher conditions only for files that are digitally signed; the publisher condition identifies an application based on its digital signature and extended attributes. The digital signature contains information about the company that created the application \(the publisher\). The extended attributes, which are obtained from the binary resource, contain the name of the product that the file is part of and the version number of the application. The publisher may be a software development company, such as Microsoft, or the information technology department of your organization.

Packaged app rules are by definition rules that use publisher conditions. For information about creating a packaged app rule, see [Create a Rule for Packaged Apps](create-rule-packaged-apps.md).

For information about the publisher condition, see [Understanding the Publisher Rule Condition in applocker]().

You can perform this task by using the Group Policy Management Console for an applocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an applocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer applocker, see [Using the MMC snap\-ins to administer applocker](#BKMK_Using_Snapins).

### <a name="BKMK_CreatePubRuleGPO"></a>To create a new rule with a publisher condition

1.  In the console tree of the snap\-in, double\-click **Application Control Policies**, double\-click **applocker**, and then click the rule collection that you want to create the rule for.

2.  On the **Action** menu, click **Create New Rule**.

3.  On the **Before You Begin** page, click **Next**.

4.  On the **Permissions** page, select the action \(allow or deny\) and the user or group that the rule should apply to, and then click **Next**.

5.  On the **Conditions** page, select the **Publisher** rule condition, and then click **Next**.

6.  On the **Publisher** page, click **Browse** to select a signed file, and then use the slider to specify the scope of the rule. To use custom values in any of the fields or to specify a specific file version, select the **Use custom values** check box. For example, you can use the asterisk \(\*\) wildcard character within a publisher rule to specify that any value should be matched.

7.  Click **Next**.

8.  \(Optional\) On the **Exceptions** page, specify conditions by which to exclude files from being affected by the rule. Click **Next**.

9. On the **Name and Description** page, either accept the automatically generated rule name or type a new rule name, and then click **Create**.


