---
title: Remote Access Always On VPN migration planning
description: Migrating from DirectAccess to Always On VPN requires proper planning to determine your migration phases, which helps identify any issues before they affect the entire organization. 
manager: brianlic
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: pashort
author: shortpatti
ms.date: 2/15/2018
---

# STEP 2: Plan your migration 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

Migrating from DirectAccess to Always On VPN requires proper planning to determine your migration phases, which helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process.

>[!IMPORTANT] 
>If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources. Therefore, Microsoft recommends performing a planned, side-by-side migration from DirectAccess to Always On VPN.

## STEP 2.1: Build migration rings

As in most other system migrations, target client migrations in phases to help identify any issues before they affect the entire organization. The first part of Always On VPN migration is no different.

>[!NOTE] 
>Microsoft recommends that you test this process before performing it on any of your user migration rings.

This section provides one approach for separating users into migration phases, and then managing those phases. Regardless of the user phase separation method you choose, maintain a single VPN Users group for easier management when the migration is complete.

### Benefits of dividing the migration effort into multiple phases

-   **Mass outage protection.** By dividing a migration into phases, the number of people a migration-generated issue can affect is much smaller.

-   **Improvement in process or communication from feedback.** Ideally, users did not even notice that the migration occurred. However, if their experience was less than optimal, feedback from those uses gives you an opportunity to improve your planning and avoid issues in the future.

### Tips for building your migration ring

-   **Identify remote users.** Start by separating users into two buckets: those who frequently come into the office and those who do not. The migration process is the same for both groups, but it is likely to take longer for the remote clients to receive the update than for those who connect more frequently. Each migration phase, ideally, should include members from each bucket.

-   **Prioritize users.** Leadership and other high-impact users are typically among the last users migrated. When prioritizing users, however, consider their business productivity impact if migration of their client computer were to fail. For example, if you had a rating of 1 to 3, with 1 meaning that the employee would not be able to work and 3 meaning no immediate work interruption, a business analyst using only internal line-of-business (LOB) applications remotely would be a 1, whereas a salesperson using a cloud app would be a 3.

-   **Migrate each department or business unit in multiple phases.** Microsoft strongly recommends that you do not migrate an entire department at the same time. If an issue should arise, you do not want it to hinder remote work for the whole department. Instead, migrate each department or business unit in at least two phases.

-   **Gradually increase user counts.** Most typical migration scenarios start with members of the IT organization and then move to business users followed by leadership and other high-impact users. Each migration phase typically involves progressively more people. For example, the first phase may include ten users, and the final group may include 5,000 users. To simplify the deployment, create a single VPN Users security group, and add users to it as their phase arrives. In this way, you end up with a single VPN Users group to which you can add members in the future.

## STEP 2.2: Compare standard configuration considerations

Always ON VPN has many configuration options. When migrating from DirectAccess to Always On VPN, however, consider starting with configuration options that are  comparable to what you have, and then expand from there. However you choose your VPN configuration, though, include the following information:

-   **Connection type.** Connection protocol selection is important and ultimately goes hand in hand with the type of authentication you will use. For details about the tunneling protocols available, see [VPN connection types](https://docs.microsoft.com/windows/access-protection/vpn/vpn-connection-type).

-   **Routing.** In this context, routing rules determine whether users can use other network routes while connected to the VPN.

    -   _Split tunneling_ allows simultaneous access to other networks, such as the Internet.

    -   _Force tunneling_ requires all traffic to go exclusively through the VPN and does not allow simultaneous access to other networks.

-   **Triggering.** *Triggering* determines how and when a VPN connection is initiated (for example, when an app opens, when the device is turned on, manually by the user). For triggering options, see the [VPN connectivity](#vpn-connectivity).

-   **Device or user authentication.** DirectAccess uses machine certificates to enable devices to initiate the remote connection. This approach results in     persistent remote network connectivity, with no user action required. Always On VPN can also use device certificates and device-initiated connection through a feature called [Device Tunnel](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config). That connection can be initiated  automatically and is persistent, resembling a DirectAccess infrastructure tunnel connection.

By using user certificates, the Always On VPN client connects automatically, but it does so at the user level (after user sign-in) instead of at the device level
(before user sign-in). The experience is still seamless to the user, but it supports more advanced authentication mechanisms, like Windows Hello for Business.

## Next steps

[STEP 4: Configure the Remote Access Server for Always On VPN](../always-on-vpn/vpn-deploy-ras.md). Install and configure the Remote Access server role on the computer or virtual machine (VM) that you want to use as your VPN server.