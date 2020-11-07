---
title: AD Forest Recovery - Resetting the computer account on the DC
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 08/09/2018
ms.topic: article
ms.assetid: 4e1a6070-df0a-4dfe-8773-899a010bfabd
---
# AD Forest Recovery - Resetting the computer account on the DC

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

 Use the following procedure to reset the computer account password of the DC.

## To reset the computer account password of the domain controller

1. At a command prompt, type the following command, and then press ENTER:

   ```
   netdom help resetpwd
   ```

2. Use the syntax that this command provides for using the Netdom command-line tool to reset the computer account password, for example:

   ```
   netdom resetpwd /server:domain controller name /userD:administrator /passwordd:*
   ```

    Where *domain controller name* is the local DC that you are recovering.

   > [!NOTE]
   > You should run this command twice.

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
