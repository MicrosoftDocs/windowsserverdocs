---
title: AD Forest Recovery - Reset the krbtgt password
description: How to reset the krbtgt password for the domain. 
ms.author: roharwoo
author: robinharwood
ms.date: 05/21/2025
ms.topic: how-to
ms.custom: sfi-image-nochange
---

# Active Directory Forest Recovery - Reset the krbtgt password

Use the following procedure to reset the krbtgt password for the domain. The following procedure applies to writeable DCs, but not read-only domain controllers (RODC).

> [!IMPORTANT]
> If you plan to recover RODC during the forest recovery, don't delete the krbtgt accounts for the RODC. The krbtgt account for an RODC is listed in the format krbtgt_*number*.
>
> If you use a customized password filter (such as passfilt.dll) on a DC, then you might receive an error when you try to reset the krbtgt password. For more information, including a workaround, see Microsoft Knowledge Base [article 2549833](https://support.microsoft.com/kb/2549833).

## Reset the krbtgt password

1. Select **Start**, point to **Control Panel**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.
1. Select **View**, and then select **Advanced Features**.
1. In the console tree, double-click the domain container, and then select **Users**.
1. In the details pane, right-click the **krbtgt** user account, and then select **Reset Password**.
   :::image type="content" source="media/resetpass1.png" alt-text="Reset password":::
1. In **New password**, type a new password, retype the password in **Confirm password**, and then select **OK**. The password that you specify isn't significant because the system generates a strong password automatically independent of the password that you specify.

> [!IMPORTANT]
> You should perform this operation twice. You must wait 10 hours between password resets. 10 hours are the default **Maximum lifetime for user ticket** and **Maximum lifetime for service ticket** policy settings, hence in a case where the Maximum lifetime period changes, the minimum waiting period between resets should be greater than the configured value.
> [!NOTE]
> The password history value for the krbtgt account is 2, meaning it includes the two most recent passwords. By resetting the password twice you effectively clear any old passwords from the history, so there's no way another DC replicates with this DC by using an old password.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]


