---
title: Refresh Group Policy
description: Learn how to manually refresh Group Policy on the local computer.
manager: brianlic
ms.topic: article
ms.assetid: 65b36794-bb09-4c1b-a2e7-8fc780893d97
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Refresh Group Policy

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use this procedure to manually refresh Group Policy on the local computer. When Group Policy is refreshed, if certificate autoenrollment is configured and functioning correctly, the local computer is autoenrolled a certificate by the certification authority (CA).

> [!NOTE]
> Group Policy is automatically refreshed when you restart the domain member computer, or when a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

## To refresh Group Policy on the local computer

1. On the computer where [Network Policy Server (NPS)](/windows-server/networking/technologies/nps/nps-top) is installed, open PowerShell by using the icon on the taskbar.

2. At the PowerShell prompt, type `gpupdate`, and then press `Enter`.
