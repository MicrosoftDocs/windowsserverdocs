---
description: "Learn more about: AD Forest Recovery - Resetting the computer account on the recovered DC"
title: AD Forest Recovery - Resetting the computer account on the recovered DC
ms.author: roharwoo
author: robinharwood
ms.date: 05/12/2025
ms.topic: how-to
---

# Active Directory Forest Recovery - Reset the computer account on the recovered DC

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
