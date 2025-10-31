---
title: Upgrading your Remote Desktop Session Host
description: Learn how to upgrade your existing Remote Desktop Session Host.
ms.author: daknappe
ms.date: 7/3/2024
ms.topic: upgrade-and-migration-article
author: dknappettmsft
---
# Upgrading your Remote Desktop Session Host

> 

> [!IMPORTANT]
> All applications must be uninstalled before the upgrade and reinstalled after the upgrade to avoid any app compatibility issues that may rise because of the upgrade.

## Upgrading a RDS session-based collection

In order to keep the down-time to a minimum, it's best to follow these steps while upgrading a RDS session-based collection:

1. Identify the servers to be upgraded, say, half the servers in the collection.

1. Prevent new connections to these servers by setting **Allow New Connections** to false.

1. Log off all sessions on these servers.

1. Remove these servers from the collection.

1. Upgrade the servers to the latest Windows Server version.

1. Set **Allow New Connections** to "false" on the remaining servers in the collection.

1. Add the upgraded servers back to their corresponding collections.

1. Remove the remaining set of servers to be upgraded from the collection.

1. Set **Allow New Connections** to "true" on the upgraded servers in the collection.

1. Upgrade the remaining servers in the deployment by following steps 3 through 9.

## Upgrading a standalone RD Session Host server

A standalone RD Session Host server can be upgraded anytime.
