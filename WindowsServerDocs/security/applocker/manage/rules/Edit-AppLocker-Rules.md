---
title: Edit applocker Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cca03e9e-7e50-4c09-9c00-0aa878fb782b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Edit applocker Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to edit a publisher rule, path rule, and file hash rule in applocker in  Windows Server 2012  and Windows 8.

For more information about these rule types, see [Understanding applocker Rule Condition Types](../../get-started/how-applocker-works/understanding-applocker-rule-condition-types.md).

You can perform this task by using the Group Policy Management Console for an applocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an applocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer applocker, see [Using the MMC snap-ins to administer applocker](../administer-applocker.md#BKMK_Using_Snapins).

### <a name="BKMK_EditPubRule"></a>To edit a publisher rule

1.  In the console tree of the snap-in, double-click **Application Control Policies**, and then double-click **applocker**.

2.  Click the appropriate rule collection.

3.  In the **Action** pane, right-click the publisher rule, and then click **Properties**.

4.  Click the appropriate tab to edit the rule properties.

    -   Click the **General** tab to change the rule name, add a rule description, configure whether the rule is used to allow or deny applications, and set the security group for which this rule should apply.

    -   Click the **Publisher** tab to configure the certificate's common name, the product name, the file name, or file version of the publisher.

    -   Click the **Exceptions** tab to create or edit exceptions.

    -   When you finish updating the rule, click **OK**.

### <a name="BKMK_EditHashRule"></a>To edit a file hash rule

1.  In the console tree of the snap-in, double-click **Application Control Policies**, and then double-click **applocker**.

2.  Choose the appropriate rule collection.

3.  In the **Action** pane, right-click the file hash rule, and then click **Properties**.

4.  Click the appropriate tab to edit the rule properties.

    -   Click the **General** tab to change the rule name, add a rule description, configure whether the rule is used to allow or deny applications, and set the security group in which this rule should apply.

    -   Click the **File Hash** tab to configure the files that should be used to enforce the rule. You can click **Browse Files** to add a specific file or click **Browse Folders** to add all files in a specified folder. To remove hashes individually, click **Remove**.

    -   When you finish updating the rule, click **OK**.

### <a name="BKMK_EditPathRule"></a>To edit a path rule

1.  In the console tree in the snap-in, double-click **Application Control Policies**, and then double-click **applocker**.

2.  Choose the appropriate rule collection.

3.  In the **Action** pane, right-click the path rule, and then click **Properties**.

4.  Click the appropriate tab to edit the rule properties.

    -   Click the **General** tab to change the rule name, add a rule description, configure whether the rule is used to allow or deny applications, and set the security group in which this rule should apply.

    -   Click the **Path** tab to configure the path on the computer in which the rule should be enforced.

    -   Click the **Exceptions** tab to create exceptions for specific files in a folder.

    -   When you finish updating the rule, click **OK**.


