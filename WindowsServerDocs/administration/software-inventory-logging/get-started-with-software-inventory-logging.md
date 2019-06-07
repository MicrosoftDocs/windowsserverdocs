---
title: Get Started with Software Inventory Logging
description: Describes how to install and start using Software Inventory Logging
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: manage-software-inventory-logging
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed51c13c-7cbf-4144-a675-011fd29379d4
author: brentfor
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Get Started with Software Inventory Logging

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

 Software Inventory Logging collects Microsoft software inventory data on a per server basis. Before using Software Inventory Logging with Windows Server 2012 R2, make sure that Windows Update [KB 3000850](https://support.microsoft.com/kb/3000850) and [KB 3060681](https://support.microsoft.com/kb/3060681) are installed on each system that will be inventoried. No Windows Update is required for Windows Server 2016. Also, if you want to use SIL’s capability to forward data to an aggregation server, be sure you have SSL certificates valid for your network.

## <a name="BKMK_OVER"></a>Feature description
Software Inventory Logging in Windows Server is a feature with a simple set of PowerShell cmdlets that help server administrators retrieve a list of the Microsoft software that is installed on their servers. It also provides the capability to collect and forward this data periodically over the network to a target web server, using the HTTPS protocol, for aggregation. Managing the feature, primarily for hourly collection and forwarding, is also done with PowerShell commands.

> [!NOTE]
> An aggregation server running a web service can be separately configured. Learn more about [Software Inventory Logging Aggregator](software-inventory-logging-aggregator.md).

> [!IMPORTANT]
> None of the data collected by Software Inventory Logging is sent to Microsoft as part of the feature’s functionality.

## <a name="BKMK_APP"></a>Practical applications
Software Inventory Logging is intended to reduce the operational costs of retrieving accurate information regarding the Microsoft software deployed locally on a server, but especially across many servers in an IT environment (assuming it is deployed and enabled across the IT environment). The ability to forward this data to an aggregation server (if set up separately by an IT administrator), allows the data to be collected in one place by a uniform, automatic process. While this can also be achieved by querying the interfaces directly, Software Inventory Logging, by employing a forwarding (over the network) architecture initiated by each server, can overcome machine discovery challenges typical for many software inventory and asset management scenarios. SSL is used to secure data forwarded over HTTPS to an administrator’s aggregation server. Having the data in one place (on one server) makes the data easier to analyze, manipulate and report on. It is important to note that none of this data is sent to Microsoft as part of the feature functionality. Software Inventory Logging data and functionality is meant for the sole use of the server software’s licensed owner and administrators.

Software Inventory Logging can assist server administrators in performing the following tasks:

-   Retrieving software and server inventory information from Windows Servers, remotely and on-demand.

-   Aggregating software and server inventory information for a wide variety of software asset management scenarios by enabling each server’s Software Inventory Logging feature and choosing a web server target URI, and certificate thumbprint for authentication.

## See Also
[Software Inventory Logging Aggregator](https://technet.microsoft.com/library/mt572043.aspx)<br>
[Manage Software Inventory Logging](manage-software-inventory-logging.md)<br>
[Software Inventory Logging Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn283390.aspx)<br>
[Microsoft Assessment and Planning Toolkit](https://www.microsoft.com/download/en/details.aspx?id=7826)
[Volume Activation Management Tool](http://blogs.technet.com/b/volume-licensing/)

