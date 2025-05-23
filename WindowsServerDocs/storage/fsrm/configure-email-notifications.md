---
title: Configure E-Mail Notifications
description: This article describes how to configure e-mail notifications
ms.date: 7/7/2017
ms.topic: how-to
author: robinharwood
manager: brianlic
ms.author: roharwoo
---
# Configure E-Mail Notifications

When you create quotas and file screens, you have the option of sending e-mail notifications to users when their quota limit is approaching or after they have attempted to save files that have been blocked. When you generate storage reports, you have the option of sending the reports to specific recipients by e-mail. If you want to routinely notify certain administrators about quota and file screening events, or send storage reports, you can configure one or more default recipients.

To send these notifications and storage reports, you must specify the SMTP server to be used for forwarding the e-mail messages.

## To configure e-mail options

1. In the console tree, right-click **File Server Resource Manager**, and then click **Configure Options**. The **File Server Resource Manager Options** dialog box opens.

2. On the **E-mail Notifications** tab, under **SMTP server name or IP address**, type the host name or the IP address of the SMTP server that will forward e-mail notifications and storage reports.

3. If you want to routinely notify certain administrators about quota or file screening events or e-mail storage reports, under **Default administrator recipients**, type each e-mail address.

   Use the format <em>account@domain</em>. Use semicolons to separate multiple accounts.

4. To specify a different "From" address for e-mail notifications and storage reports sent from File Server Resource Manager, under the **Default "From" e-mail address**, type the e-mail address that you want to appear in your message.

5. To test your settings, click **Send Test E-mail**.

6. Click **OK**.

## To configure e-mail options using PowerShell

You can use the `Set-FsrmSetting` cmdlet to set the e-mail configuration and the `Send-FsrmTestEmail` cmdlet to send a test email as shown in the following example:

```powershell
#   Setting FSRM email options
$MHT = @{
  SmtpServer        = 'SMTP.Contoso.Com'  
  FromEmailAddress  = 'FSRM@RContoso.Com'
  AdminEmailAddress = 'FSAdmin@Contoso.com'
}
Set-FsrmSetting @MHT

#   Sending a test email to check the setup
$MHT = @{
  ToEmailAddress = 'JerryG@Contoso.Com'
  Confirm        = $false
}
Send-FsrmTestEmail @MHT
```

## Additional References

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
