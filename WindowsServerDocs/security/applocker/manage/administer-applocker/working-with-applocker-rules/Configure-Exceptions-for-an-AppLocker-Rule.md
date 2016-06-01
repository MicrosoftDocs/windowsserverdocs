---
title: Configure Exceptions for an AppLocker Rule
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b10014f3-2bd3-4743-85d9-59325617d60e
---
# Configure Exceptions for an AppLocker Rule
This topic describes the steps to specify which applications can or cannot run as exceptions to an AppLocker rule in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)].

Rule exceptions allow you to specify files or folders to exclude from the rule. For more information about exceptions, see [Understanding AppLocker Rule Exceptions](Understanding-AppLocker-Rule-Exceptions.md).

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer AppLocker, see [Using the MMC snap\-ins to administer AppLocker](Administer-AppLocker.md#BKMK_Using_Snapins).

### <a name="BKMK_CfgExceptionsAppLockerRuleGPO"></a>To configure exceptions for a rule

1.  In the console tree of the snap\-in, double\-click **Application Control Policies**, and then double\-click **AppLocker**.

2.  Expand the rule collection, right\-click the rule that you want to configure exceptions for, and then click **Properties**.

3.  Click the **Exceptions** tab.

4.  In the **Add exception** box, select the rule type that you want to create, and then click **Add**.

    -   For a publisher exception, click **Browse**, select the file that contains the publisher to exclude, and then click **OK**.

    -   For a path exception, choose the file or folder path to exclude, and then click **OK**.

    -   For a file hash exception, edit the file hash rule, and click **Remove**.

    -   For Packaged apps exception, click **Add** to create the exceptions based on reference app and rule scope.


