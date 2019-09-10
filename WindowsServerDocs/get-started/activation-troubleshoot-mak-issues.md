---
title: Troubleshooting common MAK activation issues
description: 
ms.topic: troubleshooting
ms.date: 09/03/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
manager: kausika
ms.localizationpriority: medium
---

# Troubleshooting common MAK activation issues

The following list describes common issues that can occur during MAK activations, linked to guidance for addressing the issue.

<a id="list"></a>

- [How can I tell if my computer is activated?](#how-can-i-tell-if-my-computer-is-activated)
- [The computer will not activate over the internet](#the-computer-will-not-activate-over-the-internet).
- [Internet and telephone activation fail](#internet-and-telephone-activation-fail).
- [**Slmgr.vbs /ato** returns an error code](#slmgrvbs-ato-returns-an-error-code).

## How can I tell if my computer is activated?

Look for “Windows is activated” in the Control Panel System item. Alternatively, run Slmgr.vbs with the **/dli** command-line option.

[Back to list](#list)

## The computer will not activate over the internet

Ensure that the required ports are open in the firewall. For a list of ports, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083).

[Back to list](#list)

## Internet and telephone activation fail

Contact a local Microsoft Activation Center. For phone numbers of Microsoft Activation Centers worldwide, go to <http://go.microsoft.com/fwlink/?LinkID=107418>. Be sure to provide the Volume License agreement information and proof of purchase when calling.

[Back to list](#list)

## Slmgr.vbs /ato returns an error code

If Slmgr.vbs returns a hexadecimal error code, determine the corresponding error message by running the following script:

```cmd
slui.exe 0x2a 0x <ErrorCode>
```

For more information about specific error codes and how to address them, see [Solutions to common activation errors](activation-error-codes.md).

[Back to list](#list)
