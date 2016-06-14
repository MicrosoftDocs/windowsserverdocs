---
title: Create a Rule That Uses a Path Condition
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5ac35f27-3181-46e8-9d80-2ab081b61c72
---
# Create a Rule That Uses a Path Condition
This topic shows how to create an AppLocker rule with a path condition in  Windows Server 2012  and Windows 8.

The path condition identifies an application by its location in the file system of the computer or on the network.

> [!IMPORTANT]
> When creating a rule that uses a deny action, path conditions are less secure for preventing access to a file because a user could easily copy the file to a different location than what is specified in the rule. Because path rules correspond to locations within the file system, you should ensure that there are no subdirectories that are writable by non\-administrators. For example, if you create a path rule for C:\\ with the allow action, any file within C:\\ will be allowed to run, including users' profiles.

For information about the path condition, see [Understanding the Path Rule Condition in AppLocker](Understanding-the-Path-Rule-Condition-in-AppLocker.md).

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer AppLocker, see [Using the MMC snap\-ins to administer AppLocker](Administer-AppLocker.md#BKMK_Using_Snapins).

### <a name="BKMK_CreatePathRuleGPO"></a>To create a new rule with a path condition

1.  In the console tree of the snap\-in, double\-click **Application Control Policies**, double\-click **AppLocker**, and then click the rule collection that you want to create the rule for.

2.  On the **Action** menu, click **Create New Rule**.

3.  On the **Before You Begin** page, click **Next**.

4.  On the **Permissions** page, select the action \(allow or deny\) and the user or group that the rule should apply to, and then click **Next**.

5.  On the **Conditions** page, select the **Path** rule condition, and then click **Browse Files** to locate the targeted folder for the application.

    > [!NOTE]
    > When you browse to a file or folder location, the wizard automatically converts absolute file paths to use AppLocker path variables. You may edit the path after browsing to specify an absolute path, or you may type the path directly into the **Path** box. To learn more about AppLocker path variables, see [Understanding the Path Rule Condition in AppLocker](Understanding-the-Path-Rule-Condition-in-AppLocker.md).

6.  Click **Next**.

7.  \(Optional\) On the **Exceptions** page, specify conditions by which to exclude files from being affected by the rule. Click **Next**.

8.  On the **Name and Description** page, either accept the automatically generated rule name or type a new rule name, and then click **Create**.


