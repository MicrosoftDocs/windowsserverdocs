---
title: Monitor the Resource Attributes on Files and Folders
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e3ddda21-a051-43d2-86be-c09fe3c30b32
---
# Monitor the Resource Attributes on Files and Folders
This topic for the IT professional describes how to monitor attempts to change settings to the resource attributes on files when you are using Advanced Security Auditing options to monitor dynamic access control objects.

The contents of this topic apply to the list of supported Windows operating systems designated in the **Applies To** list at the beginning of this topic.

If your organization has a carefully thought out authorization configuration for resources, changes to these resource attributes can create potential security risks. Examples include:

-   Changing files that have been marked as high business value to low business value.

-   Changing the Retention attribute of files that have been marked for retention.

-   Changing the Department attribute of files that are marked as belonging to a particular department.

Use the following procedures to configure settings to monitor changes to resource attributes on files and folders. These procedures assume that  have configured and deployed central access policies in your network. For more information about how to configure and deploy central access policies, see [Dynamic Access Control: Scenario Overview](http://technet.microsoft.com/library/hh831717.aspx) .

> [!NOTE]
> Your server might function differently based on the version and edition of the operating system that is installed, your account permissions, and your menu settings.

#### To monitor changes to resource attributes on files

1.  Sign in to your domain controller by using domain administrator credentials.

2.  In Server Manager, point to **Tools**, and then click **Group Policy Management**.

3.  In the console tree, right\-click the flexible access Group Policy Object, and then click **Edit**.

4.  Double\-click **Computer Configuration**, double\-click **Security Settings**, double\-click **Advanced Audit Policy Configuration**, double\-click **Policy Change**, and then double\-click **Audit Authorization Policy Change**.

5.  Select the **Configure the following audit events** check box, select the **Success** and **Failure** check boxes, and then click **OK**.

After you configure settings to monitor resource attributes on files, verify that the changes are being monitored.

##### To verify that changes to resource attributes on files are monitored

1.  Use administrator credentials to sign in to the server that hosts the resource you want to monitor. Press the Windows key \+ R, and then type **cmd** to open a Command Prompt window.

    > [!NOTE]
    > If the User Account Control dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

2.  Type **gpupdate \/force**, and press ENTER.

3.  Attempt to change resource properties on one or more files and folders.

4.  In Server Manager, click **Tools**, and then click **Event Viewer**.

5.  Expand **Windows Logs**, and then click **Security**.

6.  Depending on which resource attributes you attempted to change, you should look for the following events:

    -   Event 4911, which tracks changes to file attributes

    -   Event 4913, which tracks changes to central access policies

    Key information to look for includes the name and account domain of the principal attempting to change the resource attribute, the object that the principal is attempting to modify, and information about the changes that are being attempted.

### Related resource
[Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](../using-advanced-security-auditing-options-monitor-dynamic-access-control-objects.md)


