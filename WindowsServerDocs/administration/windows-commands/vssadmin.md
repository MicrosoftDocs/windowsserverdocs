---
title: Vssadmin
description: An overview of the vssadmin commands.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 05/18/2018
ms.localizationpriority: medium
---
# Vssadmin

>Applies to: Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Displays current volume shadow copy backups and all installed shadow copy writers and providers. Select a command name in the following table view its command syntax.

|Command|Description|Availability
|---|---|---
|[Vssadmin add shadowstorage](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788051(v%3dws.11))|Adds a volume shadow copy storage association.| Server only
|[Vssadmin create shadow](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788055(v%3dws.11))|Creates a new volume shadow copy.| Server only
|[Vssadmin delete shadows](vssadmin-delete-shadows.md)|Deletes volume shadow copies.| Client and Server
|[Vssadmin delete shadowstorage](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc785461(v%3dws.11))|Deletes volume shadow copy storage associations.| Server only
|[Vssadmin list providers](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788108(v%3dws.11))|Lists registered volume shadow copy providers.| Client and Server
|[Vssadmin list shadows](vssadmin-list-shadows.md)|Lists existing volume shadow copies.| Client and Server
|[Vssadmin list shadowstorage](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788045(v%3dws.11))|Lists all shadow copy storage associations on the system.| Client and Server
|[Vssadmin list volumes](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc788064(v%3dws.11))|Lists volumes that are eligible for shadow copies.| Client and Server
|[Vssadmin list writers](vssadmin-list-writers.md)|Lists all subscribed volume shadow copy writers on the system.| Client and Server
|[Vssadmin resize shadowstorage](vssadmin-resize-shadowstorage.md)|Resizes the maximum size for a shadow copy storage association.| Client and Server
