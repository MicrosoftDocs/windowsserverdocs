---
title: Storing Files with MultiPoint Server
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9eb0461-3846-4ddc-97ff-de10f03f30cf
---
# Storing Files with MultiPoint Server
[!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] supports storing user files in the following ways:  
  
-   **On the operating system partition of the hard disk drive.** By default, [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] stores user files on the hard disk drive with the operating system.  
  
-   **On a separate partition of the hard disk drive.** When the [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] system is set up for the first time, you can *partition* the hard disk drive. That is, you can configure a section of the drive so that it functions as if it were a separate drive. This makes it easier to restore or upgrade the operating system without affecting user files. For more information, see [Create a partition or logical drive](http://go.microsoft.com/fwlink/?LinkId=182618) in the Windows Server Technical Library.  
  
-   **On an additional internal or external hard disk drive.** You can attach additional internal or external hard disk drives to [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] for saving and backing up data.  
  
-   **In a shared network folder.** To make user files available from any station, you can create a shared folder on the network. This requires another computer or server in addition to the computer running [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)]. This is the recommended method for storing files if there is a file server available.  
  
    For small systems of 2\-3 computers running [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] with no file server available, one of the [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] computers can act as the file server for all of the [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] computers. You would then create user accounts for all users on the [!INCLUDE[win8_server_multipoint_3](../Token/win8_server_multipoint_3_md.md)] that is acting as the file server.  
  
