---
title: License your RDS deployment with client access licenses (CALs)
description: Learn about client licensing in Remote Desktop Services, the RDS CAL model, and RDS CAL version compatibility.
ms.topic: article
ms.assetid: 5be6546b-df16-4475-bcba-aa75aabef3e3
author: lizap
ms.author: elizapo
ms.date: 09/22/2023
manager: dongill
---
# License your RDS deployment with client access licenses (CALs)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Each user and device that connects to a Remote Desktop Session host needs a client access license (CAL). You use RD Licensing to install, issue, and track RDS CALs.

When a user or a device connects to an RD Session Host server, the RD Session Host server determines if an RDS CAL is needed. If needed, the RD Session Host server then requests an RDS CAL from the Remote Desktop license server. If an appropriate RDS CAL is available from a license server, the RDS CAL is issued to the client, and the client is able to connect to the RD Session Host server and from there to the desktop or apps they're trying to use.

There's a licensing grace period of 120 Days during which no license server is required. Once the grace period ends, clients must have a valid RDS CAL issued by a license server before they can log on to an RD Session Host server.

Use the following information to learn about how client access licensing works in Remote Desktop Services and how to deploy and manage your licenses:

  - [Understand the RDS CAL model](#understand-the-rds-cal-model)
  - [RDS CAL version compatibility](#rds-cal-version-compatibility)

## Understand the RDS CAL model

There are two types of RDS CALs:

- RDS Per Device CALs
- RDS Per User CALs

The following table outlines the similarities and differences between the two types of CALs:

| Per Device                                                     | Per User                                                                         |
|----------------------------------------------------------------|----------------------------------------------------------------------------------|
| RDS CALs are physically assigned to each device.                   | RDS CALs are assigned to a user in Active Directory.                                 |
| RDS CALs are tracked by the license server.                        | RDS CALs are tracked by the license server.                                          |
| RDS CALs can be tracked regardless of Active Directory membership. | RDS CALs can't be tracked within a workgroup.                                       |
| You can revoke up to 20% of RDS CALs.                              | You can't revoke any RDS CALs.                                                      |
| Temporary RDS CALs assigned on first logon are valid for 90 days. | Temporary RDS CALs aren't available.                                                |
| Permanent CALs are valid for a random period of 52–89 days before renewal. | CALs are valid for 60 days before renewal or 90 days before reassignment.  |
| RDS CALs can't be overallocated.                                  | RDS CALs can be overallocated, in breach of the Remote Desktop licensing agreement. |

For example, the Per Device model would be appropriate in an environment where there are two or more shifts using the same computers to access the RD Session Hosts. The Per User model would be best for environments where each user has their own dedicated Windows devices to access the RD Session Hosts.

### Per Device CALs

When you use the Per Device model, a temporary license is issued the first time a device connects to the RD Session Host. After a user signs in to the session, the RDS server instructs the license server to mark the issued temporary RDS CAL token as being validated.

The next time that device connects, as long as the license server is activated and there are available RDS CALs, the license server upgrades the temporary RDS CAL token to a full RDS CAL token and issues a permanent RDS Per Device CAL. If no license tokens are available, the temporary RDS CAL token continues to function for 90 days.

Every time the client device connects to the RDS Host, it presents its RDS CAL certificate to the server. The server checks not only whether the client device has a valid certificate, but also the expiration date of that certificate. If the expiration date of the certificate is within seven days of the current date, the RDS Host connects to the license server to renew the license for another random period of 52 to 89 days.

### Per User CALs

When you use the Per User model, licensing isn't enforced, and each user is granted a license to connect to an RD Session Host from any number of devices. The license server issues licenses from the available RDS CAL pool or the OverUsed RDS CAL pool. It's the administrator's responsibility to ensure that all users have valid licenses and no OverUsed CALs, to avoid violating the Remote Desktop Services license terms.

Per User RDS CALs show as expiring 60 days after they're issued. Shortly before their expiration date, when the user signs in, the date is extended another 60 days. If a user doesn't sign in before the expiration date, they drop off the list, but the next time they sign in they show up again with a new expiration date.

For most license agreements, 90 days is the more relevant time period, because it's the minimum time required before a license can be reassigned to a different user, except under special circumstances.

You can use the Remote Desktop Licensing Manager to track and generate reports on RDS Per User CALs. To ensure you're in compliance with the Remote Desktop Services license terms, track the number of RDS Per User CALs used in your organization. Be sure to have enough RDS Per User CALs installed on the license server for all of your users.

## RDS CAL version compatibility

The RDS CAL for your users or devices must be compatible with the version of Windows Server that the user or device is connecting to. You can't use RDS CALs for earlier versions to access later versions of Windows Server, but you can use later versions of RDS CALs to access earlier versions of Windows Server. For example, an RDS 2016 CAL or higher is required to connect to a Windows Server 2016 RD Session Host, while an RDS 2012 CAL or higher is required to connect to a Windows Server 2012 R2 RD Session Host.

The following table shows which RDS CAL and RD Session Host versions are compatible with each other.

|                  | RDS 2008 R2 and earlier CAL | RDS 2012 CAL | RDS 2016 CAL | RDS 2019 CAL | RDS 2022 CAL |
|---------------------------------|--------|--------|--------|--------|--------|
| **2008, 2008 R2 session host** | Yes    | Yes    | Yes    | Yes     | Yes     |
| **2012 session host**         | No     | Yes    | Yes    | Yes    | Yes     |
| **2012 R2 session host**      | No     | Yes    | Yes    | Yes    | Yes     |
| **2016 session host**         | No     | No     | Yes    | Yes    | Yes     |
| **2019 session host**         | No     | No     | No     | Yes    | Yes     |
| **2022 session host**         | No     | No     | No     | No     | Yes     |

You must install your RDS CAL on a compatible RD license server. Any RDS license server can host licenses from all previous versions of Remote Desktop Services and the current version of Remote Desktop Services. For example, a Windows Server 2016 RDS license server can host licenses from all previous versions of RDS, while a Windows Server 2012 R2 RDS license server can only host licenses up to Windows Server 2012 R2.

The following table shows which RDS CAL and license server versions are compatible with each other.

|                  | RDS 2008 R2 and earlier CAL | RDS 2012 CAL | RDS 2016 CAL | RDS 2019 CAL | RDS 2022 CAL |
|---------------------------------|--------|--------|--------|--------|--------|
| **2008, 2008 R2 license server** | Yes    | No   | No   | No    | No    |
| **2012 license server**         | Yes     | Yes    | No   | No    | No    |
| **2012 R2 license server**      | Yes     | Yes    | No   | No    | No    |
| **2016 license server**         | Yes     | Yes    | Yes   | No    | No    |
| **2019 license server**         | Yes     | Yes    | Yes  | Yes   | No    |
| **2022 license server**         | Yes     | Yes    | Yes  | Yes   | Yes   |
