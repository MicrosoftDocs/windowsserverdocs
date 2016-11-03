---
title: Enable the DLL Rule Collection
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f028364-2f96-45cd-8bf7-c1336bf0b515
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Enable the DLL Rule Collection

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to enable the DLL rule collection feature for AppLocker in Windows Server 2012 and Windows 8.

The DLL rule collection includes the .dll and .ocx file formats.

For information about these rules, see [DLL Rules in AppLocker](http://technet.microsoft.com/library/ee460947(v=ws.10).aspx).

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer AppLocker, see [Using the MMC snap-ins to administer AppLocker](../administer-applocker.md#BKMK_Using_Snapins).

### <a name="BKMK_EnableRuleCollectionGPO"></a>To enable the DLL rule collection

1.  In the console tree in the snap-in, double-click **Application Control Policies**, right-click **AppLocker**, and then click **Properties**.

2.  Click the **Advanced** tab, select the **Enable the DLL rule collection** check box, and then click **OK**.

    > [!IMPORTANT]
    > Before you enforce DLL rules, make sure that there are allow rules for each DLL that is used by any of the allowed applications.


