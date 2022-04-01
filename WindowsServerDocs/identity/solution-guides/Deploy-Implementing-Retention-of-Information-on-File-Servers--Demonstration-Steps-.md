---
description: "Learn more about: Deploy Implementing Retention of Information on File Servers (Demonstration Steps)"
title: Deploy Implementing Retention of Information on File Servers (Demonstration Steps)
author: robinharwood
ms.author: roharwoo
manager: femila
ms.date: 04/01/2022
ms.topic: how-to
---

# Deploy Implementing Retention of Information on File Servers (Demonstration Steps)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can set retention periods for folders and put files on legal hold by using File Classification Infrastructure and File Server Resource Manager.

## Prerequisites

The steps in this article assume you have an SMTP server configured for file expiration notifications.

## Step 1: Create resource property definitions

In this step, you enable the Retention Period and Discoverability resource properties so that File Classification Infrastructure can use these resource properties to tag the files that are scanned in a network shared folder.

To create resource property definitions:

# [GUI](#tab/gui)

1. On the domain controller, sign in to the server as a member of the Domain Admins security group.

2. Open Active Directory Administrative Center. In Server Manager, select **Tools**, and then select **Active Directory Administrative Center**.

3. Expand **Dynamic Access Control**, and then select **Resource Properties**.

4. Right-click **Retention Period**, and then select **Enable**.

5. Right-click **Discoverability**, and then select **Enable**.

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-ADResourceProperty -Enabled:$true -Identity:'CN=RetentionPeriod_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'
Set-ADResourceProperty -Enabled:$true -Identity:'CN=Discoverability_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'
```

---

## Step 2: Configure notifications

In this step, you use the File Server Resource Manager console to configure the SMTP server, the default administrator email address, and the default email address that the reports are sent from.

To configure notifications:

# [GUI](#tab/gui)

1. Sign in to the file server as a member of the Administrators security group.

2. From the Windows PowerShell command prompt, type **Update-FsrmClassificationPropertyDefinition**, and then press ENTER. This will synchronize the property definitions that are created on the domain controller to the file server.

3. Open File Server Resource Manager. In Server Manager, select **Tools**, and then select **File Server Resource Manager**.

4. Right-click **File Server Resource Manager (local)**, and then select **Configure Options**.

5. On the **Email Notifications** tab, configure the following parameters:

    - In the **SMTP server name or IP address** box, type the name of the SMTP server on your network.

    - In the **Default administrator recipients** box, type the email address of the administrator who should get the notification.

    - In the **Default "From" e-mail address** box, type the email address that should be used to send the notifications.

6. Select **OK**.

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-FsrmSetting -SmtpServer <IP address of SMTP server> -FromEmailAddress "<FromEmailAddress>" -AdminEmailAddress "<AdministratorEmailAddress>"
```

---

## Step 3: Create a file management task

In this step, you use the File Server Resource Manager console to create a file management task that expires files with the following criteria:

- The file isn't classified as being on legal hold.
- The file is classified as having a long-term retention period.
- The file hasn't been modified in the last 10 years.
- The task will run on the last day of the month.

To create the file management task:

# [GUI](#tab/gui)

1. Sign in to the file server as a member of the Administrators security group.

2. Open File Server Resource Manager. In Server Manager, select **Tools**, and then select **File Server Resource Manager**.

3. Right-click **File Management Tasks**, and then select **Create File Management Task**.

4. On the **General** tab, in the **Task name** box, type a name for the file management task, such as Retention Task.

5. On the **Scope** tab, select **Add**, and choose the folders that should be included in this rule, such as *D:\Finance Documents*.

6. On the **Action** tab, in the **Type** box, select **File expiration**. In the **Expiration directory** box, type a path to a folder on the local file server where the expired files will be moved. This folder should have an access control list that grants only file server administrators access.

7. On the **Notification** tab, select **Add**.

    - Select the **Send e-mail to the following administrators** check box.

    - Select the **Send an email to users with affected files** check box, and then select **OK**.

8. On the **Condition** tab, select **Add**, and add the following properties:

    - In the **Property** list, select **Discoverability**. In the **Operator** list, select **Not equal**. In the **Value** list, select **Hold**.

    - In the **Property** list, select **Retention Period**. In the **Operator** list, select **Equal**. In the **Value** list, select **Long-Term**.

9. On the **Condition** tab, select the **Days since file was last modified** check box, and then set the value to **3650**.

10. On the **Schedule** tab, select the **Monthly** option, and then select the **Last** check box.

11. Select **OK**.

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
$fmjexpiration = New-FsrmFmjAction -Type 'Expiration' -ExpirationFolder folder
$fmjNotificationAction = New-FsrmFmjNotificationAction -Type Email -MailTo "<FileOwner>,<AdminEmail>"
$fmjNotification = New-FsrmFmjNotification -Days 10 -Action @($fmjNotificationAction)
$fmjCondition1 = New-FsrmFmjCondition -Property 'Discoverability_MS' -Condition 'NotEqual' -Value "Hold"
$fmjCondition2 = New-FsrmFmjCondition -Property 'RetentionPeriod_MS' -Condition 'Equal' -Value "Long-term"
$fmjCondition3 = New-FsrmFmjCondition -Property 'File.DateLastAccessed' -Condition 'Equal' -Value 3650
$date = Get-Date
$schedule = New-FsrmScheduledTask -Time $date -Monthly @(-1)
$fmj1 = New-FsrmFileManagementJob -Name "Retention Task" -Namespace @('<folder>') -Action $fmjexpiration -Schedule $schedule -Notification @($fmjNotification) -Condition @( $fmjCondition1, $fmjCondition2, $fmjCondition3)
```

---

## Step 4: Classify a file manually

In this step, you manually classify a file to be on legal hold. The parent folder of this file will be classified with a long-term retention period.

To manually classify a file:

1. Sign in to the file server as a member of the Administrators security group.

2. Navigate to the folder that was configured in the scope of the file management task created in Step 3.

3. Right-click the folder, and then select **Properties**.

4. On the **Classification** tab, select **Retention Period**, select **Long-Term**, and then select **OK**.

5. Right-click a file within that folder, and then select **Properties**.

6. On the **Classification** tab, select **Discoverability**, select **Hold**, select **Apply**, and then select **OK**.

7. On the file server, run the file management task by using the File Server Resource Manager console. After the file management task completes, check the folder and ensure the file wasn't moved to the expiration directory.

8. Right-click the same  file within that folder, and then select **Properties**.

9. On the **Classification** tab, select **Discoverability**, select **Not Applicable**, select **Apply**, and then select **OK**.

10. On the file server, run the file management task again by using the File Server Resource Manager console. After the file management task completes, check the folder and ensure that file was moved to the expiration directory.

## See also

- [Scenario: Implement Retention of Information on File Servers](Scenario--Implement-Retention-of-Information-on-File-Servers.md)

- [Plan for Retention of Information on File Servers](plan-retention-information-file-servers.md)

- [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)
