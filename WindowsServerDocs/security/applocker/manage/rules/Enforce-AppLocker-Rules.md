---
title: Enforce AppLocker Rules
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13c2e47a-23ea-49a7-979e-95f1b31c4275
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Enforce AppLocker Rules

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to enforce application control rules by using AppLocker in  Windows Server 2012  and Windows 8.

After AppLocker rules are created within the rule collection, you can configure the enforcement setting to **Enforce rules** or **Audit only** on the rule collection.

When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When AppLocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the AppLocker log.

There is no audit mode for the DLL rule collection. DLL rules affect specific applications. Therefore, test the impact of these rules first before deploying them to production.

To enforce AppLocker rules by configuring an AppLocker policy to **Enforce rules**, see [Configure an AppLocker Policy for Enforce Rules](../policies/configure-an-applocker-policy-for-enforce-rules.md).

> [!CAUTION]
> AppLocker rules will be enforced immediately on the local computer or when the Group Policy object (GPO) is updated by performing this procedure. If you want to see the effect of applying an AppLocker policy before setting the enforcement setting to **Enforce rules**, configure the policy to **Audit only**. For information about how to do this, see [Configure an AppLocker Policy for Audit Only](../policies/configure-an-applocker-policy-for-audit-only.md)or [Test an AppLocker Policy by Using Test-applockerPolicy](../policies/test-an-applocker-policy-by-using-test-applockerpolicy.md).


