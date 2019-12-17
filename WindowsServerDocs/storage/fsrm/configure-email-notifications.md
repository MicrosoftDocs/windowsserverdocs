---
title: Configure E-Mail Notifications
description: This article describes how to configure e-mail notifications
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Configure E-Mail Notifications

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

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


## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)