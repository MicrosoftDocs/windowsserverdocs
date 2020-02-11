---
title: License your RDS deployment with client access licenses (CALs)
description: Overview of client licensing in Remote Desktop Services.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5be6546b-df16-4475-bcba-aa75aabef3e3
author: lizap
ms.author: elizapo
ms.date: 02/12/2020
manager: dongill
---
# License your RDS deployment with client access licenses (CALs)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Each user and device that connects to a Remote Desktop Session host needs a client access licenses (CAL). You use RD Licensing to install, issue, and track RDS CALs.  

When a user or a device connects to an RD Session Host server, the RD Session Host server determines if an RDS CAL is needed. The RD Session Host server then requests an RDS CAL from the Remote Desktop license server. If an appropriate RDS CAL is available from a license server, the RDS CAL is issued to the client, and the client is able to connect to the RD Session Host server and from there to the desktop or apps they're trying to use.

Although there is a licensing grace period during which no license server is required, after the grace period ends, clients must have a valid RDS CAL issued by a license server before they can log on to an RD Session Host server.

Use the following information to learn about how client access licensing works in Remote Desktop Services and to deploy and manage your licenses:

- [License your RDS deployment with client access licenses (CALs)](#license-your-rds-deployment-with-client-access-licenses-cals)
  - [Understanding the RDS CAL model](#understanding-the-rds-cal-model)
  - [RDS CAL version compatibility](#rds-cal-version-compatibility)

## Understanding the RDS CAL model

There are two types of RDS CALs:

- RDS Per Device CALs
- RDS Per User CALs

The following table outlines the differences between the two types of CALs:

| Per Device                                                     | Per User                                                                         |
|----------------------------------------------------------------|----------------------------------------------------------------------------------|
| RDS CALs are physically assigned to each device.                   | RDS CALs are assigned to a user in Active Directory.                                 |
| RDS CALs are tracked by the license server.                        | RDS CALs are tracked by the license server.                                          |
| RDS CALs can be tracked regardless of Active Directory membership. | RDS CALs cannot be tracked within a workgroup.                                       |
| You can revoke up to 20% of RDS CALs.                              | You cannot revoke any RDS CALs.                                                      |
| Temporary RDS CALs are valid for 52–89 days.                       | Temporary RDS CALs are not available.                                                |
| RDS CALs cannot be overallocated.                                  | RDS CALs can be overallocated (in breach of the Remote Desktop licensing agreement). |

When you use the Per Device model, a temporary license is issued the first time a device connects to the RD Session Host. The second time that device connects, as long as the license server is activated and there are available RDS CALs, the license server issues a permanent RDS Per Device CAL.

When you use the Per User model, licensing is not enforced and each user is granted a license to connect to an RD Session Host from any number of devices. The license server issues licenses from the available RDS CAL pool or the Over-Used RDS CAL pool. It's your responsibility to ensure that all of your users have a valid license and zero Over-Used CALs—otherwise, you're in violation of the Remote Desktop Services license terms.

To ensure you are in compliance with the Remote Desktop Services license terms, track the number of RDS Per User CALs used in your organization and be sure to have a enough RDS Per User CALs installed on the license server for all of your users.

You can use the Remote Desktop Licensing Manager to track and generate reports on RDS Per User CALs.

## RDS CAL version compatibility

The RDS CAL for your users or devices must be compatible with the version of Windows Server that the user or device is connecting to. You can't use RDS CALs for earlier versions to access later versions of Windows Server, but you can use later versions of RDS CALs to access earlier versions of Windows Server. For example, an RDS 2016 CAL or higher is required to connect to a Windows Server 2016 RD Session Host, while an RDS 2012 CAL or higher is required to connect to a Windows Server 2012 R2 RD Session Host.

The following table shows which RDS CAL and RD Session Host versions are compatible with each other.

|                  | RDS 2008 R2 and earlier CAL | RDS 2012 CAL | RDS 2016 CAL | RDS 2019 CAL |
|---------------------------------|--------|--------|--------|--------|
| **2008, 2008 R2 session host** | Yes    | Yes    | Yes    | Yes     |
| **2012 session host**         | No     | Yes    | Yes    | Yes    |
| **2012 R2 session host**      | No     | Yes    | Yes    | Yes    |
| **2016 session host**         | No     | No     | Yes    | Yes    |
| **2019 session host**         | No     | No     | No     | Yes    |

You must install your RDS CAL on a compatible RD license server. Any RDS license server can host licenses from all previous versions of Remote Desktop Services and the current version of Remote Desktop Services. For example, a Windows Server 2016 RDS license server can host licenses from all previous versions of RDS, while a Windows Server 2012 R2 RDS license server can only host licenses up to Windows Server 2012 R2.

The following table shows which RDS CAL and license server versions are compatible with each other.

|                  | RDS 2008 R2 and earlier CAL | RDS 2012 CAL | RDS 2016 CAL | RDS 2019 CAL |
|---------------------------------|--------|--------|--------|--------|
| **2008, 2008 R2 license server** | Yes    | No   | No   | No    |
| **2012 license server**         | Yes     | Yes    | No   | No    |
| **2012 R2 license server**      | Yes     | Yes    | No   | No    |
| **2016 license server**         | Yes     | Yes    | Yes   | No    |
| **2019 license server**         | Yes     | Yes    | Yes  | Yes   |
