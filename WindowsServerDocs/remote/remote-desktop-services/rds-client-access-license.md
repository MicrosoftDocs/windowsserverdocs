---
title: License Remote Desktop Services with Client Access Licenses (CALs)
description: Learn about Remote Desktop Services Client Access Licenses (CALs). Understand CAL types, compatibility, and ensure compliance.
ms.topic: concept-article
ai-usage: ai-assisted 
author: dknappettmsft
ms.author: daknappe
ms.date: 06/16/2025
---

# License Remote Desktop Services with Client Access Licenses (CALs)

Each user and device that connects to a Remote Desktop Services session host or Azure Virtual Desktop session host running Windows Server needs a Remote Desktop Services (RDS) client access license (CAL).

This article explains RDS CAL licensing to help you deploy and manage licenses effectively.

## Understand the RDS CAL model

You use a Remote Desktop Licensing server to install, issue, and track RDS CALs. When a user or a device connects to a session host, the session host determines if an RDS CAL is needed. If an RDS CAL is needed, the session host then requests an RDS CAL from a Remote Desktop Licensing server. If an appropriate RDS CAL is available from a license server, the RDS CAL is issued to the client, and the user is able to connect to a remote session for the desktop or apps they're trying to use.

There are two types of RDS CALs: **per device** and **per user**. The type of RDS CAL you need depends on how your users or devices access the session host.

The following table provides a summary comparison of the two types of RDS CAL:

| Per device RDS CAL | Per user RDS CAL |
|--|--|
| Physically assigned to each device. | Assigned to a user in Active Directory. |
| Tracked by the license server. | Tracked by the license server. |
| Can be tracked regardless of Active Directory membership. | Can't be tracked within a workgroup. |
| You can revoke up to 20% of RDS CALs. | You can't revoke any RDS CALs. |
| Temporary RDS CALs are assigned on first sign-in per device and are valid for 90 days. | Temporary RDS CALs aren't available. |
| Permanent RDS CALs are valid for a random period of 52–89 days before renewal. | Permanent RDS CALs are valid for 60 days before renewal or 90 days before reassignment. |
| Can't be over-allocated. | Can be over-allocated, in breach of the Remote Desktop licensing agreement. |

Here's an example of when you could use each of the RDS CAL types:

- The per device model would be appropriate in an environment where there are two or more shifts of workers using the same computers to access the session hosts.
- The per user model would be best for environments where each user has their own dedicated Windows devices to access the session hosts.

There's a licensing grace period of 120 days during which no license server is required. Once the grace period ends, clients must have a valid RDS CAL issued by a license server before they can sign in a remote session.

A license server can issue RDS CALs across different Active Directory domains or forests, or in a workgroup environment. However, there are some limitations to consider. For more information, see [Best practices for setting up Remote Desktop licensing across Active Directory domains/forests or workgroups](/troubleshoot/windows-server/remote/set-up-remote-desktop-licensing-across-domains-forests-workgroups).

### Per device RDS CALs

When you use the per device model, a temporary RDS CAL is issued the first time a device connects to a session host. After a user signs in to the session, the session host instructs the license server to mark the issued temporary RDS CAL as validated.

The next time that device connects, as long as the license server is activated and there are available RDS CALs, the license server upgrades the temporary RDS CAL to a full RDS CAL and issues a permanent per device RDS CAL. If no RDS CALs are available, the temporary RDS CAL continues to function for 90 days.

Every time the client device connects to the session host, the server checks whether the client device has a valid RDS CAL and also its expiration date. If the expiration date of the RDS CAL is within seven days of the current date, the session host connects to the license server to renew the RDS CAL for another random period of 52 to 89 days.

### Per user RDS CALs

When you use the per user model, licensing isn't enforced, and each user is granted a license to connect to a session host from any number of devices. The license server issues an RDS CAL from the available pool or the overused RDS CAL pool. It's the administrator's responsibility to ensure that all users have valid licenses and not using overused RDS CALs, to avoid violating the Remote Desktop Services license terms.

Per user RDS CALs show as expiring 60 days after they're issued. Shortly before their expiration date, when the user signs in, the date is extended another 60 days. If a user doesn't sign in before the expiration date, they drop off the list, but the next time they sign in they show up again with a new expiration date.

For most license agreements, 90 days is the more relevant time period, because it's the minimum time required before a license can be reassigned to a different user, except under special circumstances.

You can use the Remote Desktop Licensing Manager to track and generate reports on per user RDS CALs. To ensure you're in compliance with the Remote Desktop Services license terms, track the number of per user RDS CALs used in your organization. Be sure to have enough per user RDS CALs installed on the license server for all of your users.

## RDS CAL version compatibility

The RDS CAL for your users or devices must be compatible with the version of Windows Server that the user or device is connecting to. You can't use RDS CALs for earlier versions to access later versions of Windows Server, but you can use later versions of RDS CALs to access earlier versions of Windows Server. For example, if you have RDS CALs for Windows Server 2022, you can connect to a session host running Windows Server 2022 or earlier, but you can't use it to connect to a session host running Windows Server 2025.

The following table shows which version of Windows Server for RDS CALs and session hosts are compatible with each other.

| Session host Window Server version | Windows Server 2025 RDS CAL | Windows Server 2022 RDS CAL | Windows Server 2019 RDS CAL | Windows Server 2016 RDS CAL |
|--|--|--|--|--|
| Windows Server 2025 | Yes | No | No | No |
| Windows Server 2022 | Yes | Yes | No | No |
| Windows Server 2019 | Yes | Yes | Yes | No |
| Windows Server 2016 | Yes | Yes | Yes | Yes |

You must also install your RDS CALs on a Remote Desktop Licensing server running a compatible version of Windows Server. You can install RDS CALs on a license server running the same version of Windows Server as the RDS CALs or earlier. For example, if you have RDS CALs for Windows Server 2022, you can install them on a license server running Windows Server 2022 or earlier, but you can't use it to install RDS CALs for Windows Server 2025.

The following table shows which RDS CAL and license server versions are compatible with each other.

| License server Window Server version | Windows Server 2025 RDS CAL | Windows Server 2022 RDS CAL | Windows Server 2019 RDS CAL | Windows Server 2016 RDS CAL |
|--|--|--|--|--|
| Windows Server 2025 | Yes | Yes | Yes | Yes |
| Windows Server 2022 | No | Yes | Yes | Yes |
| Windows Server 2019 | No | No | Yes | Yes |
| Windows Server 2016 | No | No | No | Yes |

## Next step

[Install Remote Desktop Services client access licenses](rds-install-cals.md).
