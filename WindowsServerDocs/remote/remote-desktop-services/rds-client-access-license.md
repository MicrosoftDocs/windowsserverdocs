---
title: License your RDS deployment with client access licenses (CALs)
description: Overview of client licensing in Remote Desktop Services.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5be6546b-df16-4475-bcba-aa75aabef3e3
author: lizap
ms.author: elizapo
ms.date: 05/11/2017
manager: dongill
---
# License your RDS deployment with client access licenses (CALs)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Each user and device that connects to a Remote Desktop Session host needs a client access licenses (CAL). You use RD Licensing to install, issue, and track RDS CALs.  

When a user or a device connects to an RD Session Host server, the RD Session Host server determines if an RDS CAL is needed. The RD Session Host server then requests an RDS CAL from the Remote Desktop license server. If an appropriate RDS CAL is available from a license server, the RDS CAL is issued to the client, and the client is able to connect to the RD Session Host server and from there to the desktop or apps they're trying to use. 

Although there is a licensing grace period during which no license server is required, after the grace period ends, clients must have a valid RDS CAL issued by a license server before they can log on to an RD Session Host server.

Use the following information to learn about how client access licensing works in Remote Desktop Services and to deploy and manage your licenses:

- [Understand the CALs model](#understanding-the-cals-model)
- [Activate the license server](rds-activate-license-server.md)
- [Install RDS CALs on the license server](rds-install-cals.md)
- [Track the CALs used in your deployment](rds-track-cals.md)

## Understanding the CALs model

There are two types of CALs:

- RDS Per Device CALs
- RDS Per User CALs

The following table outlines the differences between the two types of CALs:

| Per Device                                                     | Per User                                                                         |
|----------------------------------------------------------------|----------------------------------------------------------------------------------|
| CALs are physically assigned to each device.                   | CALs are assigned to a user in Active Directory.                                 |
| CALs are tracked and enforced by the license server.           | CALs are tracked but not enforced by the license server.                         |
| CALs can be tracked regardless of Active Directory membership. | CALs cannot be tracked within a workgroup.                                       |
| You can revoke up to 20% of CALs.                              | You cannot revoke any CALs.                                                      |
| Temporary CALs are valid for 52-89 days.                          | Temporary CALs are not available.                                                |
| CALs cannot be overallocated.                                  | CALs can be overallocated (in breach of the Remote Desktop licensing agreement). |

When you use the Per Device model, a temporary license is issued the first time a device connects to the RD Session Host. The second time that device connects, as long as the license server is activated and there are available CALs, the license server issues a permanent RDS Per Device CAL.

When you use the Per User model, licensing is not enforced and each user is granted a license to connect to an RD Session Host from any number of devices. The license server issues licenses from the available CAL pool or the Over-Used CAL pool - it’s your responsibility to ensure that all of your users have a valid license and zero Over-Used CALs - otherwise, you're in violiation of the Remote Destkop Services license terms. 

To ensure you are in compliance with the Remote Destkop Services license terms, track the number of RDS Per User CALs used in your organization and be sure to have a enough Per User CALs installed on the license server for all of your users.

You can use the Remote Desktop Licensing Manager to track and generate reports on RDS Per User CALs.   

## Note about CAL versions

The CAL used by users or devices must correspond to the version of Windows Server that the user or device is connecting to. You can't use older CALs to access newer Windows Server versions, but you can use newer CALs to access older Windows Server versions. 

The following table shows the CALs that are compatible on RD Session Hosts and RD Virtualization Hosts.

|      |2000 CAL|2003 CAL|2003 R2 CAL|2008 CAL|2008 R2 CAL|2012 CAL|2016 CAL|
|--------------|------|------|--------|------|--------|------|------|
| 2000 license server | Yes  | No   | No     | No   | No     | No   | No   |
| 2003 license server | Yes  | Yes  | Yes    | No   | No     | No   | No   |
| 2008, 2008 R2 license server| Yes  | Yes  | Yes    | Yes  | Yes    | No   | No   |
| 2012 license server | Yes  | Yes  | Yes    | Yes  | Yes    | Yes  | No   |
| 2012 R2 license server | Yes  | Yes  | Yes    | Yes  | Yes    | Yes  | No   |
| 2016 license server| Yes  | Yes  | Yes    | Yes  | Yes    | Yes  | Yes    | Yes  |

Any RDS license server can host licenses from all previous versions of Remote Desktop Services and the current version of Remote Desktop Services. For example, a Windows Server 2016 RDS license server can host licenses from all previous versions of RDS, while a Windows Server 2012 R2 RDS license server can only host licenses up to Windows Server 2012 R2.
