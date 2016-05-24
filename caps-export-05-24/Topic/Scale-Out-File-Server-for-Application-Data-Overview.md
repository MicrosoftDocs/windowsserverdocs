---
title: Scale-Out File Server for Application Data Overview
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ff59aea7-e0d0-4cad-9c4f-44f6db1c4573
---
# Scale-Out File Server for Application Data Overview
When you deploy a highly available file server, you can select either of the following file server types:  
  
-   **Scale\-Out File Server for application data \(Scale\-Out File Server\)** This type of clustered file server enables you to store server application data, such as Hyper\-V virtual machine files, on file shares, and obtain a similar level of reliability, availability, manageability, and high performance that you would expect from a storage area network. All file shares are online on all nodes simultaneously. File shares associated with this type of clustered file server are called scale\-out file shares. This is sometimes referred to as active\-active.  
  
-   **File Server for general use** This is the continuation of the clustered file server that has been supported in Windows Server since the introduction of Failover Clustering. This type of clustered file server, and thus all the shares associated with the clustered file server, is online on one node at a time. This is sometimes referred to as active\-passive or dual\-active. File shares associated with this type of clustered file server are called clustered file shares.  
  
## When to use Scale\-Out File Server  
You should use a Scale\-Out File Server if you are interested in the scalability and simplicity that it offers and you only require technologies that are supported with Scale\-Out File Server. Scale\-Out File Servers are ideal for server applications that keep files open for a long amount of time, doing mostly data operations with infrequent metadata operations on the file system. Hyper\-V virtual hard disks and SQL Server database files can be stored on a scale\-out file share.  
  
You should not use a Scale\-Out File Server if your workload generates a high number of metadata operations, such as opening files, closing files, creating new files, or renaming existing files. A typical information worker would generate a lot of metadata operations.  
  
## See also  
  
-   [Scale\-Out File Server for Application Data Overview \[ScaleOut\_FS\]](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
