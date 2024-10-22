---
description: "Learn more about: AD Forest Recovery - Resetting the computer account on the DC legacy"
title: AD Forest Recovery - Resetting the computer account on the DC legacy
ms.author: justinha
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.assetid: 4e1a6070-df0a-4dfe-8773-899a010bfabd
---

# Active Directory Forest Recovery - Reset the computer account on the DC legacy

>

 Use the following procedure to reset the computer account password of the DC.

## Reset the computer account password of the domain controller

1. At a command prompt, type the following command, and then press ENTER:

   ```cli
   netdom help resetpwd
   ```

2. Use the syntax that this command provides for using the Netdom command-line tool to reset the computer account password, for example:

   ```cli
   netdom resetpwd /server:domain controller name /userD:administrator /passwordd:*
   ```

    Where *domain controller name* is the local DC that you're recovering.

   > [!NOTE]
   > You should run this command twice.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
