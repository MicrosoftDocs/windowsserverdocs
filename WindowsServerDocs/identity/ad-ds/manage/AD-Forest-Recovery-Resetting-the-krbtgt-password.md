---
title: AD Forest Recovery - Resetting the krbtgt password 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 3bd6c1d0-d316-4b03-b7b4-557d4537635c
ms.technology: identity-adds
---
# AD Forest Recovery - Resetting the krbtgt password

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to reset the krbtgt password for the domain. The following procedure applies writeable DCs, but not read-only domain controllers (RODCs).
  
> [!IMPORTANT]
> If you plan to recover RODCs online during the forest recovery, do not delete the krbtgt accounts for the RODCs. The krbtgt account for an RODC is listed in the format krbtgt_*number*.
>
> If you use a customized password filter (such as passfilt.dll) on a DC, then you might receive an error when you try to reset the krbtgt password. For more information, including a workaround, see Microsoft Knowledge Base [article 2549833](https://support.microsoft.com/kb/2549833) (https://support.microsoft.com/kb/2549833).
  
## To reset the krbtgt password  
  
1. Click **Start**, point to **Control Panel**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Click **View**, and then click **Advanced Features**.
3. In the console tree, double-click the domain container, and then click **Users**.
4. In the details pane, right-click the **krbtgt** user account, and then click **Reset Password**.
   ![Reset Password](media/AD-Forest-Recovery-Resetting-the-krbtgt-password/resetpass1.png)
5. In **New password**, type a new password, retype the password in **Confirm password**, and then click **OK**. The password that you specify is not significant because the system will generate a strong password automatically independent of the password that you specify.
  
> [!NOTE]
> You should perform this operation twice. The password history of the krbtgt account is two, meaning it includes the two most recent passwords. By resetting the password twice you effectively clear any old passwords from the history, so there is no way another DC will replicate with this DC by using an old password.

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md) 
