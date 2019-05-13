---
title: Checklist - Apply a file screen to a volume or folder
description: This article describes how to apply a file screen to a volume or folder
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Checklist - Apply a file screen to a volume or folder

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

To apply a file screen to a volume or folder, use the following list:
1. Configure e-mail settings if you plan to send file screening notifications or storage reports by e-mail by following the instructions in [Configure E-Mail Notifications](configure-email-notifications.md).

2. Enable recording of file screening events in the auditing database if you plan to generate File Screening Audit reports.
[Configure File Screen Audit](configure-file-screen-audit.md)

3. Assess stored file types that are candidates for screening rules. You can use reports at the **Storage Reports Management** node to provide data. (For example, run a Files by File Group report or a Large Files report on demand to identify files that occupy large amounts of disk space.) [Generate Reports on Demand](generate-reports-on-demand.md) 

4. Review the preconfigured file groups, or create a new file group to enforce a specific screening policy in your organization. [Define File Groups for Screening](define-file-groups-for-screening.md)  

5. Review the properties of available file screen templates. (In **File Screening Management**, click the **File Screen Templates** node.)
[Edit File Screen Template Properties](edit-file-screen-template-properties.md) 
 <br />
 -Or- 
 <br /> Create a new file screen template to enforce a storage policy in your organization.  [Create a File Screen Template](create-file-screen-template.md) 

6. Create a file screen based on the template on a volume or folder. 
 [Create a File Screen](create-file-screen.md)
 
7. Configure file screen exceptions in subfolders of the volume or folder. [Create a File Screen Exception](create-file-screen-exception.md) 

8. Schedule a report task containing a File Screening Audit report to monitor screening activity periodically.
  [Schedule a Set of Reports](schedule-set-of-reports.md)


> [!NOTE]
> To limit storage on a volume or folder, see 
[Checklist: Apply a Quota to a Volume or Folder](checklist-apply-file-screen-to-volume-or-folder.md)