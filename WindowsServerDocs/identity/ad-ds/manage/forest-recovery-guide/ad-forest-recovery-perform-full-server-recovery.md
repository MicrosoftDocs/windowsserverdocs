---
title: AD Forest Recovery - Performing a full server recovery
description: A full server recovery is necessary if you're restoring to different hardware or a different operating system instance. Bare-Metal recovery is a supported method of backup.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery -  Perform a full server recovery

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

## Active Directory Full Server Recovery

A full server recovery is necessary if you're restoring to different hardware or a different operating system instance. Bare-Metal recovery is a supported method of backup.

Keep in mind the following:

- The number drives on the target server needs to be equal to the number in the backup and they need to be the same size or greater.
- The target server needs to be started from the operating system DVD in order to access Windows PE Environment, and using the **Repair your computer** option.
- If you're using disk volume encryption solutions like BitLocker, make sure you test and apply the steps necessary to the server recovery plan for getting the server OS restored and started properly.
- If the target DC is running in a VM on Hyper-V and the backup is stored on a network location, you must install a legacy network adapter, with all isolation precautions needed depending on your recovery scenario.
- After you perform a full server recovery, you need to separately perform an authoritative restore of SYSVOL, as described in [AD Forest Recovery - Performing an authoritative synchronization of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-SYSVOL.md).

Depending on your scenario, use one of the following procedures to perform a
full restore.

**Perform a full server restore with a healthy local backup using the latest
image**

1. Start Windows Setup, specify the Language, Time and currency format, and
    keyboard options and select **Next**.
1. Select **Repair your computer**.
    :::image type="content" source="media/553721c65252ea0a039ff206a8bf43bb.png" alt-text="Screenshot that shows where to select Repair your computer.":::
1. Select **Troubleshoot**.  
    :::image type="content" source="media/1cb2ace61dcdf29fb39fceb5309c5376.png" alt-text="Screenshot that shows the Troubleshoot option.":::
1. Select **System Image Recovery**.  
    :::image type="content" source="media/dbc1f945041dca0edb7967de8907d726.png" alt-text="Screenshot that shows the System Image Recovery option.":::
1. Select **Windows Server 2016**.
    :::image type="content" source="media/799b14685522d334e3bba855a025e94a.png" alt-text="Screenshot that shows the Windows Server 2016 option.":::
1. If you're restoring the most recent local backup, select **Use the latest
    available system image (recommended)** and select **Next**.
    >[!NOTE]
    > If you need to select a backup from another time as the problem was introduced was introduced some time ago, select "Select a system image"
    and chose the known good backup.
    :::image type="content" source="media/6fed751a5b8ca6c0b343cbb3fc8679c5.png" alt-text="Screenshot that shows the Use the latest available system image (recommended) option.":::
1. You'll now be given an option to:
    - Format and repartition disks.
    - Install drivers.
    - Deselecting the **Advanced** features of automatically restarting and checking for disk errors. These are enabled by default.
    :::image type="content" source="media/66a6821db9ede980c7c1ae615a9d3128.png" alt-text="Screenshot that highlights the Advanced... button.":::
1. Select **Next**.
1. Select **Finish**. You'll be prompted if you're sure you want to continue. Select **Yes**.
    :::image type="content" source="media/379d865f820f6d2fa20f0d78c283bc87.png" alt-text="Screenshot that shows the progress of the image restoration.":::
1. Once this completes, perform an authoritative restore of SYSVOL, as described in [AD Forest Recovery - Performing an authoritative synchronization of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-SYSVOL.md).

## Perform a full server restore with any image local or remote

1. Start Windows Setup, specify the Language, Time and currency format, and keyboard options and select **Next**.
1. Select **Repair your computer**.
1. Select **Troubleshoot**, select **System Image Recovery**, and select **Windows Server 2016**.
1. If you're restoring the most recent local backup, select **Select a system image** and select **Next**.
1. Now you can select the location of the backup that you want to restore. If the image is local, you can select it from the list.
1. If the image is on a network share, select **Advanced**. You can also select **Advanced** if you need to install a driver.
    :::image type="content" source="media/dffb0ae6bfebd201e0c2b6b947df034d.png" alt-text="Screenshot that highlights the Advanced button in the Re-image your computer dialog box.":::
1. If you're restoring from the network after clicking **Advanced** select **Search for a system image on the network**. You may be prompted to restore network connectivity. Select Ok.  
    :::image type="content" source="media/e07bdbc646362ef4642b9994e96c5e69.png" alt-text="Screenshot that highlights the Search for a system image on the network option.":::
1. Type the UNC path to the backup share location (for example,
    `\\\\server1\\backups`) and select **OK**. You can also type the IP address of the target server, such as `\\\\192.168.1.3\\backups`.
    :::image type="content" source="media/e08571ed9738be2cac0b352213c80353.png" alt-text="Server Restore":::
1. Type credentials necessary to access the share and select OK.
1. Now **Select the date and time of system image to restore** and select **Next**.
1. You'll now be given an option to:
    - Format and repartition disks.
    - Install drivers.
    - Deselecting the **Advanced** features of automatically restarting and checking for disk errors. These are enabled by default.
1. Select **Next**.
1. Select **Finish**. You'll be prompted asking if you're sure you want to
    continue. Select **Yes**.
1. Once this completes, perform an authoritative restore of SYSVOL, as described in [AD Forest Recovery - Performing an authoritative synchronization of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-SYSVOL.md).

## Enable the network adapter for a network backup

If you need to enable a network adapter from the command prompt to restore from
a network share, use the following steps.

1. Start Windows Setup, specify the Language, Time and currency format, and keyboard options and select **Next**.
1. Select **Repair your computer**. I
1. Select **Troubleshoot**, select **Command Prompt**.
1. Type the following command and press ENTER:
    `wpeinit`
1. To confirm the name of the network adapter, type:
    `show interfaces`
1. Type the following commands and press ENTER after each command:
    `netsh`
    `interface`
    `tcp`
    `ipv4`
    `set address "Name of Network Adapter" static IPv4 Address SubnetMask IPv4 Gateway Address 1`

    For example:

    `set address "Local Area Connection" static 192.168.1.2 255.0.0.0 192.168.1.1 1`

1. Type `quit` to return to a command prompt. 

1. Type `ipconfig /all` to verify the network adapter has an IP address and try to ping the IP address of the server that hosts the backup share to confirm connectivity.
1. Close the command prompt when you're done.
1. Now that the network adapter is working, repeat the steps above to complete the restore.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
