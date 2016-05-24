---
title: Issues with Update Approvals
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e02a12a4-53db-4e6f-8335-9dde330de1f4
author: britw
---
# Issues with Update Approvals
If you are having problems with update approvals, use the following suggestions to troubleshoot the problem.  
  
## Troubleshooting update approvals  
  
#### New approvals can take up to one minute to take effect  
If you approve an update on the WSUS console and there are client computers running detection at that exact moment, those computers might not get the approved update until they go through another detection cycle. The WSUS server requires approximately one minute to begin offering newly approved updates to client computers.  
  
#### Remote computers that are accessed by using Remote Desktop Services cannot be restarted by non\-administrators  
Non\-administrators using Remote Desktop Services  will not be able to restart their computers remotely. Therefore, if a remote computer on which an update is installed needs to be restarted for the update to take effect, users without administrative permissions will be unable to complete the updating of their remote computer.  
  
#### The number of updates that are approved on a parent upstream server does not match the number of approved updates on a replica server  
This might occur if you have changed language settings on the parent upstream server after first synchronizing with the old language settings. For more information see "listinactiveapprovals" in [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
