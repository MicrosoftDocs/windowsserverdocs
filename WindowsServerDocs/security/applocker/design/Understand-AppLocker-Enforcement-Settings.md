---
title: Understand applocker Enforcement Settings
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8b4cb4fd-fbc3-4ff0-8fe3-e9788f723aac
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Understand applocker Enforcement Settings

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the applocker enforcement settings for rule collections.

Rule enforcement is applied only to a collection of rules, not to individual rules. applocker divides the rules into four collections: executable files, Windows Installer files, scripts, and DLL files. For more information about rule collections, see [Understanding applocker Rule Collections](../get-started/how-applocker-works/understanding-applocker-rule-collections.md). By default, if enforcement is not configured and rules are present in a rule collection, those rules are enforced. The following table details the three applocker rule enforcement settings in Group Policy for each rule collection.

|Enforcement setting|Description|
|------------|--------|
|Not configured|By default, enforcement is not configured in a rule collection. If rules are present in the corresponding rule collection, they are enforced. If rule enforcement is configured in a higher-level linked Group Policy object (GPO), that enforcement value overrides the **Not configured**  value.|
|Enforce rules|Rules are enforced for the rule collection, and all rule events are audited.|
|Audit only|Rule events are audited only. Use this value when planning and testing applocker rules.|

For the applocker policy to be enforced on a computer, the Application Identity service must be running. For more information about the Application Identity service, see [Configure the Application Identity Service](../manage/policies/configure-the-application-identity-service.md).

When applocker policies from various GPOs are merged, the enforcement modes are merged by using the standard Group Policy order of inheritance, which is local, domain, site, and organizational unit (OU). The Group Policy setting that was last written or applied by order of inheritance is used for the enforcement mode, and all rules from linked GPOs are applied.


