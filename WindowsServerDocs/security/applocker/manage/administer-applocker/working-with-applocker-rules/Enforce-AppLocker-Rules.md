---
title: Enforce applocker Rules
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13c2e47a-23ea-49a7-979e-95f1b31c4275
---
# Enforce applocker Rules
This topic describes how to enforce application control rules by using applocker in  Windows Server 2012  and Windows 8.

After applocker rules are created within the rule collection, you can configure the enforcement setting to **Enforce rules** or **Audit only** on the rule collection.

When applocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited. When applocker policy enforcement is set to **Audit only**, rules are only evaluated but all events generated from that evaluation are written to the applocker log.

There is no audit mode for the DLL rule collection. DLL rules affect specific applications. Therefore, test the impact of these rules first before deploying them to production.

To enforce applocker rules by configuring an applocker policy to **Enforce rules**, see [Configure an applocker Policy for Enforce Rules]().

> [!CAUTION]
> applocker rules will be enforced immediately on the local computer or when the Group Policy object \(GPO\) is updated by performing this procedure. If you want to see the effect of applying an applocker policy before setting the enforcement setting to **Enforce rules**, configure the policy to **Audit only**. For information about how to do this, see [Configure an applocker Policy for Audit Only]()or [Test an applocker Policy by Using Test-applockerPolicy]().


