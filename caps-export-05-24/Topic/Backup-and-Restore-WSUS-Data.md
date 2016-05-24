---
title: Backup and Restore WSUS Data
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df778948-c8eb-4b09-8db3-94a496340713
author: britw
---
# Backup and Restore WSUS Data
You should regularly back up the WSUS database to safeguard the state of the WSUS network. The WSUS configuration information \(administrative settings, computer groups, group membership, and the installation status of updates\) is stored in the WSUS database.  
  
You might also want to back up locally stored update files, but this is a less important maintenance task. You can always recover lost update content by synchronizing to Microsoft Update, although this process can take some time.  
  
To back up locally stored update files, you must back up the **WSUS\\WSUSContent** folder on the largest partition of your WSUS server. You should also back up the **\\WSUS\\UpdateServicesPackage** folder on the largest partition of your WSUS server. This folder contains .msi files that are used to repair locally published packages.  
  
To back up and restore content folders, use the backup and restore utility that is used by your organization to back up other server content.  
  
To back up and restore the WSUS database, see [How to: Back Up a Database \(SQL Server Management Studio\)](http://go.microsoft.com/fwlink/?LinkID=206259) and [How to: Restore a Backup from a Device \(SQL Server Management Studio\)](http://go.microsoft.com/fwlink/?LinkID=206260)  
  
