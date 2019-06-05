---
ms.assetid: ee008835-7d3b-4977-adcb-7084c40e5918
title: Deploy Implementing Retention of Information on File Servers (Demonstration Steps)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Deploy Implementing Retention of Information on File Servers (Demonstration Steps)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can set retention periods for folders and put files on legal hold by using File Classification Infrastructure and File Server Resource Manager.  
  
**In this document**  
  
-   [Prerequisites](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Prereqs)  
  
-   [Step 1: Create resource property definitions](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step1)  
  
-   [Step 2: Configure notifications](Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-.md#BKMK_Step2)  
  
-   [Step 3: Create a file management task](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step3)  
  
-   [Step 4: Classify a file manually](Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-.md#BKMK_Step4)  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## Prerequisites  
The steps in this topic assume you have a SMTP server configured for file expiration notifications.  
  
## <a name="BKMK_Step1"></a>Step 1: Create resource property definitions  
In this step, we enable the Retention Period and Discoverability resource properties so that File Classification Infrastructure can use these resource properties to tag the files that are scanned in a network shared folder.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep1)  
  
#### To create resource property definitions  
  
1.  On the domain controller, sign in to the server as a member of the Domain Admins security group.  
  
2.  Open Active Directory Administrative Center. In Server Manager, click **Tools**, and then click **Active Directory Administrative Center**.  
  
3.  Expand **Dynamic Access Control**, and then click **Resource Properties**.  
  
4.  Right-click **Retention Period**, and then click **Enable**.  
  
5.  Right-click **Discoverability**, and then click **Enable**.  
  
![solution guides](media/Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Set-ADResourceProperty -Enabled:$true -Identity:'CN=RetentionPeriod_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'  
Set-ADResourceProperty -Enabled:$true -Identity:'CN=Discoverability_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'  
```  
  
## <a name="BKMK_Step2"></a>Step 2: Configure notifications  
In this step, we use the File Server Resource Manager console to configure the SMTP server, the default administrator email address, and the default email address that the reports are sent from.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep2)  
  
#### To configure notifications  
  
1.  Sign in to the file server as a member of the Administrators security group.  
  
2.  From the Windows PowerShell command prompt, type **Update-FsrmClassificationPropertyDefinition**, and then press ENTER. This will synchronize the property definitions that are created on the domain controller to the file server.  
  
3.  Open File Server Resource Manager. In Server Manager, click **Tools**, and then click **File Server Resource Manager**.  
  
4.  Right-click **File Server Resource Manager (local)**, and then click **Configure Options**.  
  
5.  On the **Email Notifications** tab, configure the following:  
  
    -   In the **SMTP server name or IP address** box, type the name of the SMTP server on your network.  
  
    -   In the **Default administrator recipients** box, type the email address of the administrator who should get the notification.  
  
    -   In the **Default "From" e-mail address** box, type the email address that should be used to send the notifications.  
  
6.  Click **OK**.  
  
![solution guides](media/Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Set-FsrmSetting -SmtpServer IP address of SMTP server -FromEmailAddress "FromEmailAddress" -AdminEmailAddress "AdministratorEmailAddress"  
```  
  
## <a name="BKMK_Step3"></a>Step 3: Create a file management task  
In this step, we use the File Server Resource Manager console to create a file management task that will run on the last day of the month and expire any files with the following criteria:  
  
-   The file is not classified as being on legal hold.  
  
-   The file is classified as having a long-term retention period.  
  
-   The file has not been modified in the last 10 years.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep3)  
  
#### To create a file management task  
  
1.  Sign in to the file server as a member of the Administrators security group.  
  
2.  Open File Server Resource Manager. In Server Manager, click **Tools**, and then click **File Server Resource Manager**.  
  
3.  Right-click **File Management Tasks**, and then click **Create File Management Task**.  
  
4.  On the **General** tab, in the **Task name** box, type a name for the file management task, such as Retention Task.  
  
5.  On the **Scope** tab, click **Add**, and choose the folders that should be included in this rule, such as D:\Finance Documents.  
  
6.  On the **Action** tab, in the **Type** box, click **File expiration**. In the **Expiration directory** box, type a path to a folder on the local file server where the expired files will be moved. This folder should have an access control list that grants only file server administrators access.  
  
7.  On the **Notification** tab, click **Add**.  
  
    -   Select the **Send e-mail to the following administrators** check box.  
  
    -   Select the **Send an email to users with affected files** check box, and then click **OK**.  
  
8.  On the **Condition** tab, click **Add**, and add the following properties:  
  
    -   In the **Property** list, click **Discoverability**. In the **Operator** list, click **Not equal**. In the **Value** list, click **Hold**.  
  
    -   In the **Property** list, click **Retention Period**. In the **Operator** list, click **Equal**. In the **Value** list, click **Long-Term**.  
  
9. On the **Condition** tab, select the **Days since file was last modified** check box, and then set the value to **3650**.  
  
10. On the **Schedule** tab, click the **Monthly** option, and then select the **Last** check box.  
  
11. Click **OK**.  
  
![solution guides](media/Deploy-Implementing-Retention-of-Information-on-File-Servers--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
$fmjexpiration = New-FSRMFmjAction -Type 'Expiration' -ExpirationFolder folder  
$fmjNotificationAction = New-FsrmFmjNotificationAction -Type Email -MailTo "[FileOwner],[AdminEmail]"  
$fmjNotification = New-FsrmFMJNotification -Days 10 -Action @($fmjNotificationAction)  
$fmjCondition1 = New-FSRMFmjCondition -Property 'Discoverability_MS' -Condition 'NotEqual' -Value "Hold" 
$fmjCondition2 = New-FSRMFmjCondition -Property 'RetentionPeriod_MS' -Condition 'Equal' -Value "Long-term"  
$fmjCondition3 = New-FSRMFmjCondition -Property 'File.DateLastAccessed' -Condition 'Equal' -Value 3650  
$date = get-date  
$schedule = New-FsrmScheduledTask -Time $date -Monthly @(-1)    
$fmj1=New-FSRMFileManagementJob -Name "Retention Task" -Namespace @('D:\Finance Documents') -Action $fmjexpiration -Schedule $schedule -Notification @($fmjNotification) -Condition @( $fmjCondition1, $fmjCondition2, $fmjCondition3)  
```  
  
## <a name="BKMK_Step4"></a>Step 4: Classify a file manually  
In this step, we manually classify a file to be on legal hold. The parent folder of this file will be classified with a long-term retention period.  
  
#### To manually classify a file  
  
1.  Sign in to the file server as a member of the Administrators security group.  
  
2.  Navigate to the folder that was configured in the scope of the file management task created in Step 3.  
  
3.  Right-click the folder, and then click **Properties**.  
  
4.  On the **Classification** tab, click **Retention Period**, click **Long-Term**, and then click **OK**.  
  
5.  Right-click a file within that folder, and then click **Properties**.  
  
6.  On the **Classification** tab, click **Discoverability**, click **Hold**, click **Apply**, and then click **OK**.  
  
7.  On the file server, run the file management task by using the File Server Resource Manager console. After the file management task completes, check the folder and ensure the file was not moved to the expiration directory.  
  
8.  Right-click the same  file within that folder, and then click **Properties**.  
  
9. On the **Classification** tab, click **Discoverability**, click **Not Applicable**, click **Apply**, and then click **OK**.  
  
10. On the file server, run the file management task again by using the File Server Resource Manager console. After the file management task completes, check the folder and ensure that file was moved to the expiration directory.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Scenario: Implement Retention of Information on File Servers](Scenario--Implement-Retention-of-Information-on-File-Servers.md)  
  
-   [Plan for Retention of Information on File Servers](assetId:///edf13190-7077-455a-ac01-f534064a9e0c)  
  
-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)  
  

