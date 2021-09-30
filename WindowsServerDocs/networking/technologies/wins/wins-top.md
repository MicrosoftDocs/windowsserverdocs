---
title: Windows Internet Name Service (WINS)
description: This topic provides information about decommissioning WINS and using DNS for name resolution services on your network.
manager: brianlic
ms.topic: article
ms.assetid: 32eabe7d-1130-4001-a79a-8ddb31993e5b
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---

#  Windows Internet Name Service (WINS)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Windows Internet Name Service (WINS) is a legacy computer name registration and resolution service that maps computer NetBIOS names to IP addresses.

If you do not already have WINS deployed on your network, do not deploy WINS - instead, deploy Domain Name System \(DNS\). DNS also provides computer name registration and resolution services, and includes many additional benefits over WINS, such as integration with Active Directory Domain Services.

For more information, see [Domain Name System (DNS)](../../dns/dns-top.md)

If you have already deployed WINS on your network, it is recommended that you deploy DNS and then decommission WINS.
