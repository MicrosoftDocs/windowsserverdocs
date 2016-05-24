---
title: Issues with Backup and Restore
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2254217c-9c85-4d6f-a3c1-c8ece1a8eb66
author: britw
---
# Issues with Backup and Restore
Use the information in this section to troubleshoot issues related to backing up and restoring WSUS.  
  
## Troubleshooting backup and restore issues  
  
#### Cannot access WSUS data after you restore the database  
If you restore a WSUS database, but you cannot access it from the WSUS administration console, check for the following:  
  
-   If you have changed the WSUS server name since the backup, you must add the server to the WSUS administration console.  
  
-   If you restore the backup to a WSUS server other than the one from which you backed up the database, you must add the server to the WSUS administration console.  
  
-   Verify that your user permissions are still valid for the database.  
  
#### Client computers have download failures after you restore the database  
If you are storing content locally, and the metadata in the database does not match the update files in the content directory, client computers could suffer download failures when they attempt to install an update that is listed in the database but not found in the content directory. You can resolve this problem, or prevent it from occurring, by making sure to run **wsusutil reset** after every restore procedure. For details, see the "wsusutil reset" section in [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
