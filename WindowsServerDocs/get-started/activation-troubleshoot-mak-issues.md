---
title: MAK activation known issues
description: Describes common issues that may occur during the MAK activation process, and provides resolutions and guidance
ms.topic: troubleshooting
ms.date: 10/3/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
---

# MAK activation: known issues

This article describes common issues that can occur during Multiple Activation Key (MAK) activations, and provides guidance for addressing those issues.

## How can I tell whether my computer is activated?

On the computer, open the **System** control panel and look for **Windows is activated**. Alternatively, run Slmgr.vbs and use the **/dli** command-line option.

## The computer does not activate over the internet

Make sure that the required ports are open in the firewall. For a list of ports, see the [Volume Activation Deployment Guide](https://go.microsoft.com/fwlink/?linkid=150083).

## Internet and telephone activation fail

Contact a local Microsoft Activation Center. For the telephone numbers of Microsoft Activation Centers worldwide, go to [Microsoft Licensing Activation Centers worldwide telephone numbers](https://www.microsoft.com/Licensing/existing-customer/activation-centers). Make sure to provide the Volume License agreement information and proof of purchase when you call.

## Slmgr.vbs /ato returns an error code

If Slmgr.vbs returns a hexadecimal error code, determine the corresponding error message by running the following script:

```cmd
slui.exe 0x2a 0x <ErrorCode>
```

For more information about specific error codes and how to address them, see [Resolving common activation error codes](activation-error-codes.md).
