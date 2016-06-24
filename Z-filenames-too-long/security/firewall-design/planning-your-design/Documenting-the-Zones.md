---
title: Documenting the Zones
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d751d514-b871-4807-9562-4e0a63301785
---
# Documenting the Zones
Generally, the task of determining zone membership is not complex, but it can be time-consuming. Use the information generated during the [Designing a Windows Firewall with Advanced Security Strategy](../Designing-a-Windows-Firewall-with-Advanced-Security-Strategy.md) section of this guide to determine the zone in which to put each host. You can document this zone placement by adding a Group column to the inventory table shown in the [Designing a Windows Firewall with Advanced Security Strategy](../Designing-a-Windows-Firewall-with-Advanced-Security-Strategy.md) section. A sample is shown here:

|Host name|Hardware reqs met|Software reqs met|Configuration required|Details|Projected cost|Group|
|-------------|---------------------|---------------------|--------------------------|-----------|------------------|---------|
|CLIENT001|No|No|Upgrade hardware and software.|Current operating system is Windows XP. Old hardware not compatible with Windows 8.|$??|Isolated domain|
|SERVER002|Yes|No|Join trusted domain, upgrade from  Windows Server 2008  to  Windows Server 2012 |No antivirus software present.|$??|Encryption|
|SENSITIVE001|Yes|Yes|Not required.|Running  Windows Server 2012 . Ready for inclusion.|$0|Isolated server (in zone by itself)|
|PRINTSVR1|Yes|Yes|Not required.|Running  Windows Server 2008 R2 . Ready for inclusion.|$0|Boundary|

**Next:**[Planning Group Policy Deployment for Your Isolation Zones](Planning-Group-Policy-Deployment-for-Your-Isolation-Zones.md)


