---
title: The Server cleanup Wizard
description: "Windows Server Update Service (WSUS) topic - How to use the Server cleanup Wizard to manage disk space"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c351797-2716-4442-a668-60d5b4e77751
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# The Server cleanup Wizard

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Server cleanup Wizard is integrated into the user interface and can be used to help you manage your disk space. This wizard can do the following operations:

- Remove unused updates and update revisions remove all older updates and update revisions that have not been approved.

- Delete computers not contacting the server delete all client computers that have not contacted the server in thirty days or more.

- Delete unneeded update files delete all update files that are not needed by updates or by downstream servers.

- Decline expired updates decline all updates that have been expired by Microsoft.

- Decline superseded updates decline all updates that meet all the following criteria:

  -   The superseded update is not mandatory

  -   The superseded update has been on the server for thirty days or more

  -   The superseded update is not currently reported as needed by any client

  -   The superseded update has not been explicitly deployed to a computer group for ninety days or more

  -   The superseding update must be approved for install to a computer group

  > [!WARNING]
  >  In a WSUS hierarchy, it is strongly recommended that you run the cleanup process on the lower-most, downstream/replica WSUS server first, and then move up the hierarchy. Incorrectly running cleanup on any upstream server prior to running cleanup on every downstream server can cause a mismatch between the data that is present in upstream databases and downstream databases. The data mismatch can lead to synchronization failures between the upstream and downstream servers. 
  > 
  > [!IMPORTANT]
  >  If you remove unnecessary content by using the Server Cleanup Wizard, all the private update files that you have downloaded from the Microsoft Update Catalog site are also removed. You must reimport these files after you run the Server Cleanup Wizard. 

If updates are approved using an auto-approval rule, they might still be in the "Approved" state, and will not be removed by The Server cleanup Wizard. To remove auto-approved updates that are in an "approved" state , the WSUS Admin must - at minimum - manually set the approval status of superseded updates to "Not Approved" so they will be eligible for declination by the Server cleanup Wizard. The Server cleanup Wizard will ensure a newer update is approved and that no client system is still reporting that update as needed before marking the update as "Declined."




