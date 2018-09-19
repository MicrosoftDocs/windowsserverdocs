---
title: Storage Migration Service frequently asked questions (FAQ)
description: Frequently asked questions about Storage Migration Service, such as what files are excluded from transfers when migrating from one server to another.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 09/24/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service frequently asked questions (FAQ)

This topic contains answers to frequently asked questions (FAQs) about using [Storage Migration Service](overview.md) to migrate servers.

## What files and folders are excluded from transfers?

Storage Migration Service won't transfer files or folders that we know could interfere with Windows operation. Specifically, here's what we won't transfer or move into the PreExistingData folder on the destination:

- Windows, Program Files, Program Files (x86), Program Data, Users
- $Recycle.bin, Recycler, Recycled, System Volume Information, $UpgDrv$, $SysReset, $Windows.~BT, $Windows.~LS, Windows.old, boot, Recovery, Documents and Settings
- pagefile.sys, hiberfil.sys, swapfile.sys, winpepge.sys, config.sys, bootsect.bak, bootmgr, bootnxt
- Any files or folders on the source server that conflicts with excluded folders on the destination. <br>For example, if there's a N:\Windows folder on the source and it gets mapped to the C:\ volume on the destination, it won't get transferred—regardless of what it contains—because it would interfere with the C:\Windows system folder on the destination.

## See also

- [Storage Migration Service overview](overview.md)