---
title: What's new in Remote Desktop Services
description: Provides description of new features RDS in Windows Server 2016.
ms.author: chrimo
ms.date: 10/11/2016
ms.topic: article
ms.assetid: 04d52dff-e61b-4633-9908-be8600abc2ba
author: ChristianMontoya
manager: scottman
---
# What's new in Remote Desktop Services

Remote Desktop Services (RDS) built on Windows Server 2016 is a virtualization platform enabling a wide range of customer scenarios. Improvements in the overall RDS solution incorporates the work done by both the Remote Desktop team and other technology partners at Microsoft. The following scenarios and technologies are new or improved in Windows Server 2016.

Also be sure to check out our session from Ignite 2016: Harness RDS improvements in Windows Server 2016. In this video, the product team reviews all of the new and improved features in Remote Desktop Services, including vGPU support.

## App Compatibility - Windows Server 2016 and Windows 10
Built on the same foundation of Windows 10, Windows Server 2016 not only has the same look and feel you expect out of a desktop but can also run many of the same applications. Pairing Windows Server 2016 with the graphics capabilities (below) gives you an environment for all users to be productive.

## Azure SQL Database - the new database for your highly available environment
The RD Connection Broker is able to store all of the deployment information (like connection states and user/host mappings) in a shared SQL database, such as an Azure SQL database. Ditch the SQL Server Always On Availability Group deployment manual, grab the connection string to the Azure SQL database, and start using your highly available environment.

Additional information: [Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](https://techcommunity.microsoft.com/t5/microsoft-security-and/new-windows-server-2016-capability-use-azure-sql-db-for-your/ba-p/249787)

## Remote Desktop IP Virtualization on Windows Server 2019
If you want to use IP virtualization on Windows Server 2019, please follow [these steps](/support/windows-server/remote/remote-desktop-ip-virtualization).

## Graphics - solving graphics needs across various scenarios
Thanks to Hyper-V's Discrete Device Assignment, you can now map GPUs on a host machine directly to a VM to be consumed by its GPU-requiring applications. Improvements have also been made in RemoteFX vGPU, including support for OpenGL 4.4, OpenCL 1.1, 4k resolution, and Windows Server virtual machines.

Additional information: [Discrete Device Assignment](https://techcommunity.microsoft.com/t5/virtualization/bg-p/Virtualization)

## RD Connection Broker - improved connection handling during logon storms
With improved connection handling, the RD Connection Broker is now able to handle over 10,000 concurrent logon requests, sometimes seen during "logon storms". The improved RD Connection Broker also makes maintenance of the deployment simpler by being able to more quickly add servers back into the environment.

Additional information: [Improved Remote Desktop Connection Broker Performance](https://techcommunity.microsoft.com/t5/microsoft-security-and/improved-remote-desktop-connection-broker-performance-with/ba-p/249559)

## RDP 10 - new capabilities built into the protocol
RDP 10 now uses the H.264/AVC 444 codec, appropriately optimizing across both video and text. With this release, pen remoting is also supported. With these capabilities, your remote sessions start to feel even more like a local session.

Additional information: [RDP 10 AVC/H.264 improvements in Windows 10 and Windows Server 2016](https://techcommunity.microsoft.com/t5/microsoft-security-and/remote-desktop-protocol-rdp-10-avc-h-264-improvements-in-windows/ba-p/249588)

## Personal session desktops - providing individual desktops to any end-user
Personal session desktops is a new way to have your own personal desktop hosted for you in the cloud. Administrative privileges and dedicated session hosts removes the complexity of hosting environments where users want to manage the desktop like it's their own.

Additional information: [Personal Session Desktops](rds-personal-session-desktops.md)
