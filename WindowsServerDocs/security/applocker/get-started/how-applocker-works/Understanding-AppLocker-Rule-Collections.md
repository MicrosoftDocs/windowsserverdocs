---
title: Understanding applocker Rule Collections
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b980d33-eea9-4699-b4ca-62fb8e9309da
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Understanding applocker Rule Collections

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic explains the five different types of applocker rules used to enforce applocker policies.

An applocker rule collection is a set of rules that apply to one of five types:

-   Executable files: .exe and .com

-   Windows Installer files: .msi, mst and .msp

-   Scripts: .ps1, .bat, .cmd, .vbs, and .js

-   DLLs: .dll and .ocx

-   Packaged apps and Packaged app installers: .appx

If you use DLL rules, a DLL allow rule has to be created for each DLL that is used by all of the allowed applications.

> [!IMPORTANT]
> Each application can load several DLLs, and applocker must check each DLL before it is allowed to run. Therefore, creating DLL rules might cause performance problems on some computers. Denying some DLLs from running can also create application compatibility problems. As a result, the DLL rule collection is not enabled by default.

For information about how to enable the DLL rule collection, see [Enable the DLL Rule Collection](http://go.microsoft.com/fwlink/?LinkId=163405).

## See Also
[How applocker Works](../how-applocker-works.md)


