---
title: AD Forest Recovery - Resetting the krbtgt password
description: How to reset the krbtgt password for the domain. 
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.custom: 3bd6c1d0-d316-4b03-b7b4-557d4537635c, inhenkel
---

# Active Directory Forest Recovery - Resetting the krbtgt password

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to reset the krbtgt password for the domain. The following procedure applies writeable DCs, but not read-only domain controllers (RODCs).

> [!IMPORTANT]
> If you plan to recover RODCs online during the forest recovery, do not delete the krbtgt accounts for the RODCs. The krbtgt account for an RODC is listed in the format krbtgt_*number*.
>
> If you use a customized password filter (such as passfilt.dll) on a DC, then you might receive an error when you try to reset the krbtgt password. For more information, including a workaround, see Microsoft Knowledge Base [article 2549833](https://support.microsoft.com/kb/2549833) (https://support.microsoft.com/kb/2549833).

## To reset the krbtgt password

1. Select **Start**, point to **Control Panel**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.

2. Select **View**, and then select **Advanced Features**.

3. In the console tree, double-click the domain container, and then select **Users**.

4. In the details pane, right-click the **krbtgt** user account, and then select **Reset Password**.

   ![Reset Password](media/resetpass1.png)

5. In **New password**, type a new password, retype the password in **Confirm password**, and then select **OK**. The password that you specify isn't significant because the system will generate a strong password automatically independent of the password that you specify.

> [!IMPORTANT]
> You should perform this operation twice. When resetting the Key Distribution Center Service Account password twice, a 10 hour waiting period is required between resets. 10 hours are the default **Maximum lifetime for user ticket** and **Maximum lifetime for service ticket** policy settings, hence in a case where the Maximum lifetime period has been altered, the minimum waiting period between resets should be greater than the configured value.  

> [!NOTE]
> The password history value for the krbtgt account is 2, meaning it includes the 2 most recent passwords. By resetting the password twice you effectively clear any old passwords from the history, so there is no way another DC will replicate with this DC by using an old password.

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)

- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
