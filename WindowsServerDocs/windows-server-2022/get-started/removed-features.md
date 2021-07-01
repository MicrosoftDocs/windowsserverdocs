---
title: Features removed or no longer developed starting with Windows Server 2022
description: Learn about the features and functionalities removed or no longer developed starting with Windows Server 2022.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 6/24/2021
ms.prod: windows-server
---

# Features removed or no longer developed starting with Windows Server 2022

>Applies to: Windows Server 2022

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server 2022.

> [!TIP]
> - You can get early access to Windows Server builds by joining the [Windows Insider Program for Business](https://insider.windows.com/for-business) - this is a great way to test feature changes.
> - Have questions about other releases? Check out [Features removed or planned for replacement in Windows Server](../../get-started-19/removed-features.md).

**The list is subject to change and might not include every affected feature or functionality.**

## Semi-Annual Channel

With Windows Server 2022 there is one primary release channel available, the Long-Term Servicing Channel. The Semi-Annual Channel in previous versions of Windows Server 2019 focused on containers and microservices, and that innovation will continue with [Azure Stack HCI](/azure-stack/hci/).

With the Long-Term Servicing Channel, a new major version of Windows Server is released every 2-3 years. Users are entitled to 5 years of mainstream support and 5 years of extended support. This channel provides systems with a long servicing option and functional stability, and can be installed with Server Core or Server with Desktop Experience installation options. The Long-Term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.

## Features we're no longer developing

| Feature | Explanation |
|--|--|
| Guarded Fabric and Shielded Virtual Machines (VMs) | Windows Server and Azure Stack HCI are aligning with Azure to take advantage of continuing enhancements to [Azure Confidential Computing](/azure/confidential-computing/) and [Azure Security Center](/azure/security-center/). Having this alignment translates to more cloud security offerings being extended to customer data centers (on-premises).<br><br>Microsoft will continue to provide support for these features, but there will be no further development. On client versions of Windows the Remote Server Administration Tools (RSAT): Shielded VM Tools feature will be removed. |
