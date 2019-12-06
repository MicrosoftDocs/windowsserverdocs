---
title: "Install and Configure Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 06/17/2013
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e95cf219-46a4-4041-bd81-0c4c2a0622cf
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install and Configure Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_InstallConfigure"></a>   

 This document provides step-by-step instructions for installing and configuring  Windows Server Essentials. Before you begin the installation, review and complete the tasks that are described in [Before You Install Windows Server Essentials](Before-You-Install-Windows-Server-Essentials.md).  

 This document provides step-by-step instructions for installing and configuring  Windows Server Essentials. Before you begin the installation, review and complete the tasks that are described in [Before You Install Windows Server Essentials](../install/Before-You-Install-Windows-Server-Essentials.md).  
  
 You install and configure  Windows Server Essentials in two steps:  
  

1.  [Step 1: Install the Windows Server Essentials operating system](Install-and-Configure-Windows-Server-Essentials.md#BKMK_ManualInstallation) In this step, you install the operating system on your server.  
  
2.  [Step 2: Configure the Windows Server Essentials operating system](Install-and-Configure-Windows-Server-Essentials.md#BKMK_Step2Configure) In this step, you complete the installation by providing information about your company, domain settings, and network administrator. This information is used to get the server ready for you to use.  

1.  [Step 1: Install the Windows Server Essentials operating system](../install/Install-and-Configure-Windows-Server-Essentials.md#BKMK_ManualInstallation) In this step, you install the operating system on your server.  
  
2.  [Step 2: Configure the Windows Server Essentials operating system](../install/Install-and-Configure-Windows-Server-Essentials.md#BKMK_Step2Configure) In this step, you complete the installation by providing information about your company, domain settings, and network administrator. This information is used to get the server ready for you to use.  

  
###  <a name="BKMK_ManualInstallation"></a> Step 1: Install the Windows Server Essentials operating system  
  
> [!IMPORTANT]
>  After the operating system is installed, do not customize your server until you finish [Step 2: Configure the Windows Server Essentials operating system](#BKMK_Step2Configure).  
  
 **Estimated completion time:** Approximately 30 minutes.  
  
> [!NOTE]
>  The estimated completion times throughout this procedure are based on minimum hardware requirements.  
  
##### To install the operating system  
  
1. Connect your computer to your network with a network cable.  
  
   > [!IMPORTANT]
   >  Do not disconnect your computer from the network during installation. Doing so may cause the installation to fail.  
  
2. Turn on your computer, and then insert the  Windows Server Essentials DVD into the DVD drive.  
  
    If you are performing an unattended installation, connect the removable media (such as a floppy disk or a USB flash drive) that contains your answer files. Depending on the contents of your answer files, you may not see some or any of the following installation screens.  
  
3. Restart your computer. When the message **Press any key to boot from CD or DVD** appears, press any key.  
  
   > [!NOTE]
   >  If your computer does not start from the DVD, ensure that the CD-ROM drive is listed first in the BIOS boot sequence. For more information about the BIOS boot sequence, see the documentation from the computer manufacturer.  
  
4. Select the **Language** that you want to install, **Time and currency format**, and **Keyboard or input method**, and then click **Next**.  
  
5. Click **Install now**.  
  
6. In **Enter the product key**, type the product key.  
  
7. Read the **License terms**. If you accept them, select the **I accept the license terms** check box, and then click **Next**.  
  
   > [!NOTE]
   >  If you do not choose to accept the license terms, the installation does not continue.  
  
8. In **Which type of installation do you want?**, click **Custom: Install Windows only (advanced)**  
  
9. In **Where do you want to install Windows?**, select the hard drive where you want to install the Windows operating system. Verify that all of your internal hard drives are available for installation.  
  
    > [!IMPORTANT]
    >   Windows Server Essentials must be installed as C: volume, and the volume size must be at least 60 GB. It is recommended that you create two partitions on your operating system disk, and not use the C: (system partition) to store any business data.  
  
    > [!NOTE]
    >  If a hard drive is not listed (for example, a Serial Advanced Technology Attachment (SATA) hard disk), you must load the device drivers for that hard disk. Obtain the device driver from the manufacturer and save it to removable media (such as a floppy disk or a USB flash drive). Attach the removable media to your computer, and then click **Load Driver**.  
  
     If you need to delete and/or create partitions, refer to the following steps:  
  
    1.  To delete a partition, select the partition, click **Drive options (advanced)**, and then click **Delete**. After you delete the system partition, create a new partition by using the instructions in either step **b** or step **c**.  
  
        > [!NOTE]
        >  After you click **Drive options (advanced)**, that option will not appear again. In that case, skip the part of the step that refers to drive options.  
  
    2.  To create a partition from an unpartitioned space, click the hard disk that you want to partition, click **Drive options (advanced)**, click **New**, and then in the **Size** text box, type the partition size you want to create. For example, if you use the recommended partition size of 120 gigabytes (GB), type **122880**, and then click **Apply**. After the partition is created, click **Next**. The partition is formatted before the installation continues.  
  
    3.  To create a partition that uses all of the unpartitioned space, click the hard disk that you want to partition, click **Drive options (advanced)**, click **New**, and then click **Apply** to accept the default partition size. After the partition is created, click **Next**. The partition is formatted before the installation continues.  
  
        > [!IMPORTANT]
        >  You cannot move the operating system to a different partition after you finish this step.  
  
   During the installation, temporary files are copied to an installation folder on your computer, which takes about 30 minutes. After the  Windows Server Essentials operating system is installed, your computer restarts. Now, you are ready to configure the  Windows Server Essentials operating system.  
  
###  <a name="BKMK_Step2Configure"></a> Step 2: Configure the Windows Server Essentials operating system  
  
> [!IMPORTANT]
>  If you are migrating from a previous version of Windows Small Business Server to  Windows Server Essentials, you must follow a different process. For information about migration installations, see the following:  
> 
> - [Migrate from Windows SBS 2003](../migrate/Migrate-Windows-Small-Business-Server-2003-to-Windows-Server-Essentials.md)  
>   -   [Migrate from Windows SBS 2008](../migrate/Migrate-Windows-Small-Business-Server-2008-to-Windows-Server-Essentials.md)  
  
 During this phase of the installation, you are prompted to answer a few questions about your organization. This information is used to configure the operating system.  
  
> [!IMPORTANT]
>  Before beginning this step, ensure that the local network adapter is connected to a router or a switch that is turned on and functioning properly.  
  
 **Estimated completion time:** Approximately 30 minutes  
  
##### To configure the operating system  
  
1.  On the **Verify the date and time settings** page, click **Change system date and time settings** to select the date, time, and time zone settings for your server. When you are finished, click **Next**.  
  
    > [!IMPORTANT]
    >  If you are installing  Windows Server Essentials on a virtual machine, make sure that you choose the same time zone settings that are being used by the host operating system. If the time zone settings differ, the server installation might not succeed.  
  
2.  On the **Choose server installation mode** page, do one of the following:  
  
    1.  Choose **Clean install** to set up a full new installation of the  Windows Server Essentials server software.  
  
    2.  Choose **Server migration** to install  Windows Server Essentials and join this server to an existing Windows domain.  
  
3.  On the **Personalize your server** page, enter the name of your organization, an internal domain name, and the server name.  
  
    > [!IMPORTANT]
    >  The server name must be a unique name on your network. You cannot change the server name or the internal domain name after you finish this step.  
  
4.  Click **Next**.  
  
5.  On the **Provide your administrator account information** page, type the information for a new administrator account.  
  
    > [!CAUTION]
    >  Do not name the network administrator account Administrator or Network Administrator. These account names are reserved for use by the system.  
  
6.  On the **Provide your standard user account information** page, type the information for a new standard user account, and then click **Next**.  
  
7.  On the **Keep your server up-to-date automatically** page, select how you want to receive Windows Updates for your server, and then click **Next**.  
  
8.  The **Updating and preparing your server** page displays the progress of the final installation process. This takes time to complete, and your computer will restart a couple of times.  
  
9. After the last server restart, the **Your server is ready to be used** page appears. Click **Close**.  
  
10. Click the Dashboard tile on the **Start** screen, and then on the Dashboard, complete the **Set Up My Server** tasks on the **Home** page. You should complete these tasks immediately after your  Windows Server Essentials installation finishes.  
  
> [!NOTE]
>  After the installation finishes, you are automatically logged on to the server with the new administrator account that you added during installation. The built-in Administrator account password is set to the same password as the new administrator account, and then the built-in Administrator account is disabled.  
  
 You can use your newly installed server for a limited amount of time (known as the evaluation period) without entering a product key. After the evaluation period, you must enter a product key to activate the server or extend the evaluation period. You can extend the evaluation period a maximum of two times. When you reach the maximum number of days allowed for the evaluation period, you must activate your server with a product key.  
  
### Customize Windows Server Essentials  
 The **Home** page of the  Windows Server Essentials Dashboard links to **SETUP** tasks that you should complete immediately after you install your server. By performing these tasks, you can help protect information that is stored on the server and enable the features that are available in  Windows Server Essentials.  
  
 If you choose not to perform the tasks, users might not have access to some network features. To return to these tasks later, return to the  Windows Server Essentials Dashboard **Home** page.  
  
 The following table defines items that can appear in the list of setup tasks.  
  
|Task|Description
|----------|-----------------|  
|Get updates for other Microsoft products|Click this task to access a link that runs a tool that allows you to specify if you want to use Microsoft Update to automatically obtain updates for  Windows Server Essentials and other Microsoft products such as Office.  
|Add user accounts|Click this task to view brief information about adding user accounts. A link to run the **Add a User Account Wizard** is provided. For more information, see [Add a user account](../manage/Manage-User-Accounts-in-Windows-Server-Essentials.md#BKMK_Manage1).  
|Add server folders|Click this task to view brief information about adding server folders. A link to run the **Add a Folder Wizard** is provided. Also provided is a link to an online help topic about using Server Folders. For more information, see [Add or move a server folder](../manage/Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_5). 
|Set up Server Backup|Click this task to view brief information about using Server Backup to protect your data. A link to run the **Set Up Server Backup Wizard** is provided. For more information, see [Set up or customize server backup](../manage/Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_1). 
|Set up Anywhere Access|Click this task to view brief information about the Anywhere Access feature in  Windows Server Essentials. A link to the **Anywhere Access Settings** page is provided. For more information, see [Manage Anywhere Access](../manage/Manage-Anywhere-Access-in-Windows-Server-Essentials.md). 
|Set up email alert notification|Click this task to view brief information about email alert notification. A link to run the **Set up email notification for alerts** tool is provided. For more information, see [Set up email notifications for alerts](../manage/Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Email).  
|Set up Media Server|Click this task to view brief information about using Media Server to share music, video, and image files. A link to the  **Media Settings** page is provided. Also provided is a link to an online help topic to learn more about Media Server. For more information, see [Manage Digital Media](../manage/Manage-Digital-Media-in-Windows-Server-Essentials.md). 
|Connect computers|Click this task to view brief information about how to connect a network computer to the server. For more information, see [Connect computers to the server](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_9).
  
## See also  
  
-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)

