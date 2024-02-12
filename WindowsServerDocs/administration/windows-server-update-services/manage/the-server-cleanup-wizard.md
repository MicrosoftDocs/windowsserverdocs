---
title: Server Cleanup wizard
description: Windows Server Update Service (WSUS) article - How to use the Server Cleanup wizard to manage disk space.
ms.topic: article
ms.author: jgerend
author: JasonGerend
ms.date: 05/10/2023
---
# Server cleanup wizard

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Server Cleanup wizard is integrated into the user interface to help you manage your disk space. The Server Cleanup wizard can do the following operations:

- Remove unused updates and update revisions.

- Remove all older updates and update revisions that haven't been approved.

- Delete all client computers that haven't contacted the server in 30 days or longer.

- Delete all update files that aren't needed by updates or by downstream servers.

- Decline all updates that are expired by Microsoft.

- Decline all updates that meet all the following criteria:

  - The superseded update isn't mandatory.

  - The superseded update has been on the server for 30 days or more.

  - The superseded update isn't currently reported as needed by any client.

  - The superseded update hasn't been explicitly deployed to a computer group for 90 days or longer.

  - The superseding update must be approved for install to a computer group.

  > [!WARNING]
  >  In a WSUS hierarchy, it's strongly recommended that you run the cleanup process on the lower-most, downstream/replica WSUS server first and then move up the hierarchy. Incorrectly running cleanup on any upstream server prior to running cleanup on every downstream server can cause a mismatch between the data that's present in upstream databases and downstream databases. The data mismatch can lead to synchronization failures between the upstream and downstream servers.
  >
  > [!IMPORTANT]
  >  If you remove unnecessary content using the Server Cleanup wizard, all the private update files that you've downloaded from the Microsoft Update Catalog site are also removed. You must reimport these files after you run the Server Cleanup wizard.

If updates are approved using an autoapproval rule, they could remain in an Approved state and won't be removed by The Server Cleanup wizard. To remove autoapproved updates that are in an Approved state, the WSUS Admin must at minimum manually set the approval status of superseded updates to Not Approved. Manually setting approval status of superseded updates to Not Approved make the updates eligible for declination by the Server Cleanup wizard. The Server Cleanup wizard ensures a newer update is approved and that no client system is still reporting these updates as needed before marking the update as Declined.
