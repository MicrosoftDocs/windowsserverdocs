---
title: Create a Quota Template
description: This article describes how to create a quota template to define a storage space limit
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a Quota Template

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

A *quota template* defines a space limit, the type of quota (hard or soft) and optionally, a set of notifications that will be generated automatically when quota usage reaches defined threshold levels.

By creating quotas exclusively from templates, you can centrally manage your quotas by updating the templates instead of replicating changes in each quota. This feature simplifies the implementation of storage policy changes by providing one central point where you can make all updates.

## To create a Quota Template

1.  In **Quota Management**, click the **Quota Templates** node.

2.  Right-click **Quota Templates**, and then click **Create Quota Template** (or select **Create Quota Template** from the **Actions** pane). This opens the **Create Quota Template** dialog box.

3.  If you want to copy the properties of an existing template to use as a base for your new template, select a template from the **Copy properties from quota template** drop-down list. Then click **Copy**.

    Whether you have chosen to use the properties of an existing template or you are creating a new template, modify or set the following values on the **Settings** tab:

4.  In the **Template Name** text box, enter a name for the new template.

5.  In the **Label** text box, enter an optional descriptive label that will appear next to any quotas derived from the template.

6.  Under **Space Limit**:

    -   In the **Limit** text box, enter a number and choose a unit (KB, MB, GB, or TB) to specify the space limit for the quota.
    -   Click the **Hard quota** or **Soft quota** option. (A hard quota prevents users from saving files after the space limit is reached and generates notifications when the volume of data reaches each configured threshold. A soft quota does not enforce the quota limit, but it generates all configured notifications.)

7.  You can configure one or more optional threshold notifications for your quota template, as described in the procedure that follows. After you have selected all the quota template properties that you want to use, click **OK** to save the template.

## Setting optional notification thresholds

When storage in a volume or folder reaches a threshold level that you define, File Server Resource Manager can send e-mail messages to administrators or specific users, log an event, execute a command or a script, or generate reports. You can configure more than one type of notification for each threshold, and you can define multiple thresholds for any quota (or quota template). By default, no notifications are generated.

For example, you could configure thresholds to send an e-mail message to the administrator and the users who would be interested to know when a folder reaches 85 percent of its quota limit, and then send another notification when the quota limit is reached. Additionally, you might want to run a script that uses the **dirquota.exe** command to raise the quota limit automatically when a threshold is reached.

> [!Important]
> To send e-mail notifications and configure the storage reports with parameters that are appropriate for your server environment, you must first set the general File Server Resource Manager options. For more information, see [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)

**To configure notifications that File Server Resource Manager will generate at a quota threshold**

1. In the **Create Quota Template** dialog box, under **Notification thresholds**, click **Add**. The **Add Threshold** dialog box appears.

2. To set a quota limit percentage that will generate a notification:

   In the **Generate notifications when usage reaches (%)** text box, enter a percentage of the quota limit for the notification threshold. (The default percentage for the first notification threshold is 85 percent.)

3. To configure e-mail notifications:

   On the **E-mail Message** tab, set the following options:

   - To notify administrators when a threshold is reached, select the **Send e-mail to the following administrators** check box, and then enter the names of the administrative accounts that will receive the notifications. Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.
   - To send e-mail to the person who saved the file that reached the quota threshold, select the **Send e-mail to the user who exceeded the threshold** check box.
   - To configure the message, edit the default subject line and message body that are provided. The text that is in brackets inserts variable information about the quota event that caused the notification. For example, the **\[Source Io Owner\]** variable inserts the name of the user who saved the file that reached the quota threshold. To insert additional variables in the text, click **Insert Variable**.
   - To configure additional headers (including From, Cc, Bcc, and Reply-to), click **Additional E-mail Headers**.

4. To log an event:

   On the **Event Log** tab, select the **Send warning to event log** check box, and edit the default log entry.

5. To run a command or script:

   On the **Command** tab, select the **Run this command or script** check box. Then type the command, or click **Browse** to search for the location where the script is stored. You can also enter command arguments, select a working directory for the command or script, or modify the command security setting.

6. To generate one or more storage reports:

   On the **Report** tab, select the **Generate reports** check box, and then select which reports to generate. (You can choose one or more administrative e-mail recipients for the report or e-mail the report to the user who reached the threshold.)

   The report is saved in the default location for incident reports, which you can modify in the **File Server Resource Manager Options** dialog box.

7. Click **OK** to save your notification threshold.

8. Repeat these steps if you want to configure additional notification thresholds for the quota template.

## See also

-   [Quota Management](quota-management.md)
-    [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
-   [Edit Quota Template Properties](edit-quota-template-properties.md)
-   [Command-Line Tools](command-line-tools.md)


