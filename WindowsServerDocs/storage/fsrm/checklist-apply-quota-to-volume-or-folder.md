---
title: Apply a quota to a volume or folder
description: This article describes how to apply a storage quota to a volume or folder 
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Checklist: Apply a Quota to a volume or folder

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server (Semi-Annual Channel)

1. Configure e-mail settings if you plan to send threshold notifications or storage reports by e-mail. [Configure E-Mail Notifications](configure-email-notifications.md)

2. Assess storage requirements on the volume or folder. You can use reports on the **Storage Reports Management** node to provide data. (For example, run a Files by Owner report on demand to identify users who use large amounts of disk space.) [Generate Reports on Demand](generate-reports-on-demand.md)

3. Review available pre-configured quota templates. (In **Quota Management**, click the **Quota Templates** node.) [Edit Quota Template Properties](edit-quota-template-properties.md) 
<br />-Or- <br /> Create a new quota template to enforce a storage policy in your organization. [Create a Quota Template](create-quota-template.md)

4. Create a quota based on the template on the volume or folder.  
 [Create a Quota](create-quota.md) <br /> -Or- <br /> Create an auto apply quota to automatically generate quotas for subfolders on the volume or folder. [Create an Auto Apply Quota](create-auto-apply-quota.md)

6. Schedule a report task that contains a Quota Usage report to monitor quota usage periodically. [Schedule a Set of Reports](schedule-set-of-reports.md)

> [!Note]
> If you want to screen files on a volume or folder, see [Checklist: Apply a File Screen to a Volume or Folder](checklist-apply-file-screen-to-volume-or-folder.md).











