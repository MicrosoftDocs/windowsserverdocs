---
title: Export an AppLocker Policy to an XML File
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b29072a4-f614-4cc5-beab-5274685a33f9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Export an AppLocker Policy to an XML File

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to export an AppLocker policy to an XML file for review or testing in  Windows Server 2012  and Windows 8.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.

### To export an AppLocker policy to an XML file

1.  On the **Start** screen, type**secpol.msc**.

2.  In the console tree, expand **Application Control Policies**, right-click **AppLocker**, and then click **Export Policy**.

3.  Browse to the location where you want to save the XML file.

4.  In the **File name** box, type a file name for the XML file, and then click **Save**.


