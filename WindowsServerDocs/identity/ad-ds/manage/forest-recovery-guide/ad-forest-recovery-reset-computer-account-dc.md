---
description: "Learn more about: AD Forest Recovery - Resetting the computer account on the recovered DC"
title: AD Forest Recovery - Resetting the computer account on the recovered DC
ms.author: justinha
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.assetid: 4e1a6070-df0a-4dfe-8773-899a010bfabd
---

# Active Directory Forest Recovery - Reset the computer account on the recovered DC

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

 Use the following procedure to reset the computer account password of the Domain Controller (DC).

## Reset the computer account password of the domain controller

1. Open PowerShell as an Administrator, type the following command, and then press ENTER:

   ```cli
   Reset-ComputerMachinePassword
   ```

2. Run the same command again to ensure other Domain Controllers from before the Forest Recovery can't replicate from it.

> [!WARNING]
> This should only be carried out on the sole recovered DC during a forest recovery exercise.
> Using this command <i>will</i> break replication with other DCs.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
