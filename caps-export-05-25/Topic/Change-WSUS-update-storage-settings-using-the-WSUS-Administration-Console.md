---
title: Change WSUS update storage settings using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5ee49469-e6ab-4499-ae95-6f9d6dbaf66c
author: britw
---
# Change WSUS update storage settings using the WSUS Administration Console
You can store update files on a local WSUS server or on Microsoft Update. If you store the update files on Microsoft Update, the root WSUS server downloads update metadata only, and client computers must obtain approved updates directly from Microsoft Update.  
  
You initially select the storage location for update files when you install the WSUS server software. You can change this setting at any time by using the following procedure:  
  
### To change the update storage settings  
  
1.  Open the WSUS Administration Console by following the instructions in [Open the WSUS Administration Console](../Topic/Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).  
  
2.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.  
  
3.  In the **Options** pane, click **Update Files and Languages**.  
  
4.  On the **Update Files** tab, specify the location from which client computers will obtain updates. If you store update files on the local WSUS server, you can also choose to download update files only after they are approved, or to download express installation files. For more information about these options, see [Design for Optimized Performance](../Topic/Design-for-Optimized-Performance.md).  
  
> [!NOTE]  
> You cannot configure this setting on a WSUS replica server.  
  
If you are changing the setting to start storing the update files on the local WSUS server, you must identify the languages of the updates that you want to download. For more information about selecting language updates, see the following topics:  
  
-   [Plan for WSUS update languages](assetId:///358e5660-ce8a-483a-aa60-e74fcee7b19c)  
  
-   [Select update languages](assetId:///ea86ec38-ddaa-4d97-a14b-714d18063ccb#lang)  
  
-   [Select WSUS update languages using the WSUS Administration Console](../Topic/Select-WSUS-update-languages-using-the-WSUS-Administration-Console.md)  
  
-   [Move the Local Update Storage Location](../Topic/Move-the-Local-Update-Storage-Location.md)  
  
For more information and recommendations about update storage locations, see [Design a WSUS Storage Strategy](../Topic/Design-a-WSUS-Storage-Strategy.md).  
  
