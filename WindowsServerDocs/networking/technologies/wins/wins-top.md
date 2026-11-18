---
title: Windows Internet Name Service (WINS)
description: Microsoft plans to remove Windows Internet Name Service (WINS) in Windows Server 2028, though plans can change. Learn how to replace WINS with Domain Name System (DNS).
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ai-usage: ai-assisted
ms.date: 08/07/2020
---

# Windows Internet Name Service (WINS)

Windows Internet Name Service (WINS) is a legacy service that maps Network Basic Input/Output System (NetBIOS) computer names to Internet Protocol (IP) addresses. Microsoft plans to remove WINS. If your organization still uses it, plan a transition.

This article explains WINS availability and removal plans and provides guidance for migrating name resolution to Domain Name System (DNS).

## WINS availability in Windows Server 2025 and planned removal in Windows Server 2028

WINS is available in Windows Server 2025, the final Long-Term Servicing Channel (LTSC) release to include and support it. Microsoft continues to support WINS as part of Windows Server 2025 throughout the [Windows Server 2025 lifecycle](/lifecycle/products/windows-server-2025).

WINS has been removed in Windows Server 2028 Preview. To learn more, see the [Windows Server 2028 Preview removal notice](../../../get-started/removed-deprecated-features-windows-server.md?tabs=ws28-preview#features-removed). For removal details, see [WINS removal: Moving forward with modern name resolution](https://support.microsoft.com/servicing/os/windows/docs/2025/11/wins-removal-moving-forward-with-modern-name-resolution).

If your network doesn't already have a WINS deployment, don't deploy WINS. Instead, deploy Domain Name System \(DNS\). DNS also provides computer name registration and resolution services, and includes many additional benefits over WINS, such as integration with Active Directory Domain Services.

For more information, see [Domain Name System (DNS)](../../dns/dns-top.md)

If your network already has a WINS deployment, we recommend deploying DNS and then decommissioning WINS.


