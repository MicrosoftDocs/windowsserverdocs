---
title: What's new in Remote Desktop Services
description: Provides description of new features RDS in Windows Server 2016.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: chrimo
ms.date: 10/11/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04d52dff-e61b-4633-9908-be8600abc2ba
author: ChristianMontoya
manager: scottman
---
# What's new in Remote Desktop Services

Remote Desktop Services (RDS) built on Windows Server 2016 is a virtualization platform enabling a wide range of customer scenarios. Improvements in the overall RDS solution incorporates the work done by both the Remote Desktop team and other technology partners at Microsoft. The following scenarios and technologies are new or improved in Windows Server 2016.

Also be sure to check out our session from Ignite 2016: [Harness RDS improvements in Windows Server 2016](https://channel9.msdn.com/Events/Ignite/2016/BRK3098). In this video, the product team reviews all of the new and improved features in Remote Desktop Services, including vGPU support. 

## App Compatibility - Windows Server 2016 and Windows 10
Built on the same foundation of Windows 10, Windows Server 2016 not only has the same look and feel you expect out of a desktop but can also run many of the same applications. Pairing Windows Server 2016 with the graphics capabilities (below) gives you an environment for all users to be productive. 

## Azure SQL Database - the new database for your highly available environment
The RD Connection Broker is able to store all of the deployment information (like connection states and user/host mappings) in a shared SQL database, such as an Azure SQL database. Ditch the SQL Server Always On Availability Group deployment manual, grab the connection string to the Azure SQL database, and start using your highly available environment.

Additional information: [Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](https://blogs.technet.microsoft.com/enterprisemobility/2016/05/03/new-windows-server-2016-capability-use-azure-sql-db-for-your-remote-desktop-connection-broker-high-availability-environment/)

## Graphics - solving graphics needs across various scenarios
Thanks to Hyper-V's Discrete Device Assignment, you can now map GPUs on a host machine directly to a VM to be consumed by its GPU-requiring applications. Improvements have also been made in RemoteFX vGPU, including support for OpenGL 4.4, OpenCL 1.1, 4k resolution, and Windows Server virtual machines.

Additional information: [Discrete Device Assignment](https://blogs.technet.microsoft.com/virtualization/2015/11/)

## RD Connection Broker - improved connection handling during logon storms
With improved connection handling, the RD Connection Broker is now able to handle over 10,000 concurrent logon requests, sometimes seen during "logon storms". The improved RD Connection Broker also makes maintenance of the deployment simpler by being able to more quickly add servers back into the environment.

Additional information: [Improved Remote Desktop Connection Broker Performance](https://blogs.technet.microsoft.com/enterprisemobility/2015/12/15/improved-remote-desktop-connection-broker-performance-with-windows-server-2016-and-windows-server-2012-r2-hotfix-kb3091411/)

## RDP 10 - new capabilities built into the protocol
RDP 10 now uses the H.264/AVC 444 codec, appropriately optimizing across both video and text. With this release, pen remoting is also supported. With these capabilities, your remote sessions start to feel even more like a local session.  

Additional information: [RDP 10 AVC/H.264 improvements in Windows 10 and Windows Server 2016](https://blogs.technet.microsoft.com/enterprisemobility/2016/01/11/remote-desktop-protocol-rdp-10-avch-264-improvements-in-windows-10-and-windows-server-2016-technical-preview/)

## Personal session desktops - providing individual desktops to any end-user
Personal session desktops is a new way to have your own personal desktop hosted for you in the cloud. Administrative privileges and dedicated session hosts removes the complexity of hosting environments where users want to manage the desktop like it's their own.

Additional information: [Personal Session Desktops](rds-personal-session-desktops.md)
