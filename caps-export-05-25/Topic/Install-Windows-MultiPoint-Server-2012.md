---
title: Install Windows MultiPoint Server 2012
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6f8970b-de3f-4255-b2a1-5472a16ed02f
author: cfreemanwa
---
# Install Windows MultiPoint Server 2012
Use the first procedure if you are installing a [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] operating system from scratch. If you purchased a preinstalled MultiPoint Server computer from an OEM, use the second procedure to complete the system installation.  
  
> [!IMPORTANT]  
> During the [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] installation, the computer will restart several times to complete configurations and update the Registry. It is important that you not turn off the computer during this process.  
  
## Install MultiPoint Server from a DVD  
Use the following procedure if you are installing [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] on your own computer.  
  
#### To install [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] \(DVD installation\)  
  
1.  Turn on your computer, and insert the MultiPoint Server installation DVD in the DVD drive.  
  
2.  Restart your computer. When the message **Press any key to boot from CD or DVD** appears, press any key.  
  
    > [!NOTE]  
    > If your computer does not start from the DVD, ensure that the DVD\-ROM drive is listed first in the BIOS boot sequence. For more information about the BIOS boot sequence, see the documentation from the computer manufacturer.  
  
3.  Select the **Language** that you want to install, **Time and currency format**, and **Keyboard or input method**, and then click **Next**.  
  
4.  Click **Install now**.  
  
5.  When prompted, enter the product key that came with the product. \(The product key format is XXXXX\-XXXXX\-XXXXX\-XXXXX\-XXXXX, where “X” is a letter or number.\)  
  
6.  Read the license terms. If you accept them, select the **I accept the license terms** check box, and then click **Next**.  
  
    > [!NOTE]  
    > If you do not accept the license terms, the installation does not continue.  
  
7.  Click **Custom \(advanced\)**.  
  
8.  Select the hard drive and partition that you want to install the operating system on, and then click **Next**.  
  
    This process takes about 30 minutes and the computer will restart several times.  
  
9. Type a new password into the **New password** and **Confirm password** text boxes, and then press ENTER. Then click **OK** to confirm that the password was changed.  
  
10. On the **Personalize** page, type a name for the computer, and then click **Next**.  
  
11. On the **Settings** page, make your choices for the following services or programs, and then click **Submit**:  
  
    -   Install updates automatically \(recommended\)  
  
    -   Participate in the Customer Experience Improvement Program \(CEIP\)  
  
    -   Enable Windows Error Reporting \(WER\)  
  
    The computer restarts again.  
  
12. Log on as Administrator.  
  
13. Install drivers for your video cards:  
  
    1.  When you receive notification that you need to install graphics \(video\) drivers, press any key. The computer restarts in console mode.  
  
        > [!NOTE]  
        > MutliPoint Server operates in two modes. *Console mode* is used to install, update, and configure software. In console mode, all monitors are treated as a single extended desktop for the console session of the computer system. In contrast, in *station mode*, each station attached to the MultiPoint Server computer behaves as if it were a separate computer, which allows users to have their own sessions. You can change modes by using commands in MultiPoint Manager.  
  
    2.  Log on as Administrator, and follow the instructions in the wizard to install the video drivers.  
  
        After the drivers are installed, the computer restarts in *station mode*.  
  
    3.  Log on as Administrator.  
  
    > [!IMPORTANT]  
    > If the correct display adapter drivers \(video drivers\) are not installed on the computer, you will not be able to map each station to the computer.  
  
14. Configure your primary station:  
  
    1.  On the **Create a MultiPoint Server Station** page, type the specified letter from the keyboard for that monitor. The correct key entry associates the keyboard and mouse for that station.  
  
    2.  Log on as Administrator.  
  
## Complete an OEM installation  
If you purchased a preinstalled computer from an OEM, use the following procedure to complete the installation.  
  
> [!IMPORTANT]  
> If the OEM provided installation instructions with your MultiPoint Server, follow the OEM’s installation instructions instead of this procedure. The OEM might have made customizations that will change the steps below.  
  
#### To complete the [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] installation on your OEM\-preinstalled computer  
  
1.  Turn on your computer.  
  
2.  Select the **Language** that you want to install, **Time and currency format**, and **Keyboard or input method**, and then click **Next**.  
  
3.  Read the license terms. If you accept them, select the **I accept the license terms** check box, and then click **Next**.  
  
    > [!NOTE]  
    > If you do not accept the license terms, the installation does not continue.  
  
4.  If you are not prompted to change your password, log on as Administrator with a blank password.  
  
5.  Type a new password into the **New password** and **Confirm password** text boxes, and press **Enter**. Click **OK** to acknowledge the message that the password has been changed.  
  
6.  On the **Personalize** page, type a name for the computer, and then click **Next**.  
  
7.  On the **Settings** page, make your choices for the following services or programs, and then click **Submit**:  
  
    -   Install updates automatically \(recommended\)  
  
    -   Participate in the Customer Experience Improvement Program \(CEIP\)  
  
    -   Enable Windows Error Reporting \(WER\)  
  
    The computer restarts again.  
  
8.  Log on as Administrator.  
  
9. Configure your primary station:  
  
    1.  On the **Create a MultiPoint Server Station** page, type the specified letter from the keyboard for that monitor. The correct key entry associates the keyboard and mouse for that station.  
  
    2.  Log on as Administrator.  
  
