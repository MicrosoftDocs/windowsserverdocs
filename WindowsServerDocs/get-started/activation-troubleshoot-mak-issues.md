---
title: MAK activation known issues
description: Describes common issues that may occur during the MAK activation process, and provides resolutions and guidance
ms.topic: troubleshooting
ms.date: 09/18/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
---

# MAK activation&mdash;known issues

The following list describes common issues that can occur during Multiple Activation Key (MAK) activations, linked to guidance for addressing the issue.

<a id="list"></a>

- [How can I tell whether my computer is activated?](#how-can-i-tell-whether-my-computer-is-activated)
- [The computer does not activate over the internet](#the-computer-does-not-activate-over-the-internet).
- [Internet and telephone activation fail](#internet-and-telephone-activation-fail).
- [**Slmgr.vbs /ato** returns an error code](#slmgrvbs-ato-returns-an-error-code).

## How can I tell whether my computer is activated?

On the computer, open the **System** control panel and look for **Windows is activated**. Alternatively, run Slmgr.vbs and use the **/dli** command-line option.

[Back to list](#list)

## The computer does not activate over the internet

Make sure that the required ports are open in the firewall. For a list of ports, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083).

[Back to list](#list)

## Internet and telephone activation fail

Contact a local Microsoft Activation Center. For the telephone numbers of Microsoft Activation Centers worldwide, go to [Microsoft Licensing Activation Centers worldwide telephone numbers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers). Make sure to provide the Volume License agreement information and proof of purchase when you call.

[Back to list](#list)

## Slmgr.vbs /ato returns an error code

If Slmgr.vbs returns a hexadecimal error code, determine the corresponding error message by running the following script:

```cmd
slui.exe 0x2a 0x <ErrorCode>
```

For more information about specific error codes and how to address them, see [Resolving common activation error codes](activation-error-codes.md).

[Back to list](#list)
