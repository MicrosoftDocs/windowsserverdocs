---
title: Domain membership is recommended for servers running Hyper-V
description: Learn what to do when the server is a member of a workgroup.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 2f4578e5-0848-46b4-a50b-7dbd480b80bf
ms.date: 8/16/2016
---
# Domain membership is recommended for servers running Hyper-V

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016



*For more information about best practices and scans, see* [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*This server is a member of a workgroup.*

## Impact

*There is no central management for this server.*

Joining this computer to the domain allows centralized management through policies for identity, security, and auditing.

## Resolution

*If you have a domain environment available, join this server to that domain.*

> [!IMPORTANT]
> We recommend that you review the workloads running in the virtual machines on this computer to determine whether there are security implications of joining this computer to a domain. If any of the virtual machines are virtualized domain controllers, see [Planning Considerations for Virtualized Domain Controllers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd348476(v=ws.10)) (https://go.microsoft.com/fwlink/?LinkId=190192).

Joining a computer to a domain requires permissions on the computer and the domain:
- On the computer, you'll need a user account that's a member of the Administrators group. Either log on with this type of account, or provide the user name and password for the account when you're prompted.
- On the domain, you'll need a user account that's authorized to join the computer to the domain. You'll be prompted for the user name and password.

For instructions, see [Join the Computer to the Domain](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd894430(v=ws.10)) (https://go.microsoft.com/fwlink/?LinkId=190193).
