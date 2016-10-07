---
title: Configure an AppLocker Policy for Audit Only
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5f25ca9-d21b-4900-852e-cb10fea6cbbd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Configure an AppLocker Policy for Audit Only

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to set AppLocker policies to **Audit only** within your IT environment by using AppLocker in  Windows Server 2012  and Windows 8.

After AppLocker rules are created within the rule collection, you can configure the enforcement setting to **Enforce rules** or **Audit only**.

When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

> [!NOTE]
> There is no audit mode for the DLL rule collection. DLL rules affect specific applications. Therefore, test the impact of these rules first before deploying them to production. To enable the DLL rule collection, see [Enable the DLL Rule Collection](../rules/Enable-the-DLL-Rule-Collection.md).

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object (GPO) or by using the Local Security Policy snap-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap-ins to administer AppLocker, see [Using the MMC snap-ins to administer AppLocker](../Administer-AppLocker.md#BKMK_Using_Snapins).

#### To audit rule collections

1.  In the console tree of the snap-in, double-click **Application Control Policies**, right-click **AppLocker**, and then click **Properties**.

2.  On the **Enforcement** tab, select the **Configured** check box for the rule collection that you want to enforce, and then verify that **Audit only** is selected in the list for that rule collection.

3.  Repeat the above step to configure the enforcement setting to **Audit only** for additional rule collections.

4.  Click **OK**.


