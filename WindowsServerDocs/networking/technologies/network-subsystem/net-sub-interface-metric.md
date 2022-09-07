---
title: Configure the Order of Network Interfaces
description: Learn how to use the interface metric to configure the order of network interfaces.
ms.topic: article
ms.assetid: 3266328c-ca82-40d2-90ca-854b7088ccaa
manager: dcscontentpm
ms.author: wscontent
author: Teresa-Motiv
ms.date: 10/27/2021
---

# Configure the Order of Network Interfaces

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

In Windows Server 2016 and Windows 10, you can use the interface metric to configure the order of network interfaces.

This is different than in previous versions of Windows and Windows Server, which allowed you to configure the binding order of network adapters by using either the user interface or the commands **INetCfgComponentBindings::MoveBefore** and **INetCfgComponentBindings::MoveAfter**. These two methods for ordering network interfaces are not available in Windows Server 2016 and Windows 10.

Instead, you can use the new method for setting the enumerated order of network adapters by configuring the interface metric of each adapter. You can configure the interface metric by using the [Set-NetIPInterface](/powershell/module/nettcpip/set-netipinterface) Windows PowerShell command.

When network traffic routes are chosen and you have configured the **InterfaceMetric** parameter of the **Set-NetIPInterface** command, the overall metric that is used to determine the interface preference is the sum of the route metric and the interface metric. Typically, the interface metric gives preference to a particular interface, such as using wired if both wired and wireless are available.

The following Windows PowerShell command example shows use of this parameter.

```powershell
Set-NetIPInterface -InterfaceIndex 12 -InterfaceMetric 15
```

The order in which adapters appear in a list is determined by the IPv4 or IPv6 interface metric.  For more information, see [GetAdaptersAddresses function](/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersaddresses?f=255&MSPPError=-2147217396).

For links to all topics in this guide, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).
