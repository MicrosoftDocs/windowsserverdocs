---
title: "Create a Server Recovery DVD for Remotely Administered Servers"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6141fa69-5952-4e3c-a868-40ef3f4badd2
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create a Server Recovery DVD for Remotely Administered Servers

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_HeadlessRecovery"></a> Create a server recovery DVD for remotely administered servers  
 There are two models for factory reset and server recovery, and they differ based on the hardware that the customer received.  
  
 **Remotely administered server**  
  
 This server recovery option requires that the process is run from a client computer on the same network. Because factory reset requires that a hardware-specific image be shipped with the server, the partner must author the server recovery DVD.  
  
 **Locally administered server**  
  
 This is the classic model where the server is administered at the server console. The server installation media is used to run a recovery. This requires that the server ships with the ability to view video output in addition to including a DVD reader. The customer boots from that server installation media, and then chooses the appropriate recovery method. You do not need to create a server recovery DVD for servers that are locally administered.  
  
> [!NOTE]
>  For the locally administered server model, the customer may accomplish a factory reset by performing a new installation. However, they will lose the partner customizations.  
  
 There are two types of server recovery.  
  
 **Factory reset**  
  
 This recovery returns the server to the original state that existed when the server was shipped from the factory. Following a factory reset, you are asked to perform the initial configuration of the server just as you were the first time you turned it on, and all settings and customizations are lost. This is also referred to as Day 0.? Because factory reset requires that a hardware-specific image be shipped with the server, the partner must author the server recovery DVD.  
  
 **Bare-metal restore**  
  
 This recovery assumes that you configured a server backup and that the server backup completed successfully at least one time prior to the server failure. Bare-metal restore (BMR) supports recovery of the system and boot drives only from a previous server backup.  
  
 Following a BMR, the server is returned to the state that existed at the time of the backup that is used for the restore. This is typically the most recent backup, but in some cases, it may be an earlier backup. Data recovery is done after the system is restored by using the Restore Files and Folders Wizard. BMR is the preferred server recovery method because all settings and configuration are returned, whereas a factory reset returns the server to a Day 0 state.  
  
### Remotely administered server recovery  
 This section describes the required customizations that the partner must perform and the final media that must be shipped with each server. Before delving into the details, let us look at the customer experience.  
  
 In this scenario, the customer „¢s server is no longer working. This could be caused by a virus, a hard disk failure, or some other cause. The customer inserts the server recovery DVD into a client computer that is located on the same network as the server. The server recovery application walks them through three steps to recover their server:  
  
1.  Creates a bootable USB flash drive that is used to restart the server in recovery mode. The USB flash drive must be 8 GB or larger.  
  
2.  Detects the server that is now in recovery mode.  
  
3.  Allows the customer to choose a factory reset or a bare-metal restore, and then returns their server to a working state.  
  
### Steps for creating a server recovery DVD for multiple language support  
 There are six major steps to create a server recovery DVD  
  
1.  [(Optional) Update WinPE](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_Updating)  
  
2.  [Collect the factory reset images and XML files](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_Collecting)  
  
3.  [Create the server recovery DVD](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_Creating)  
  
4.  [Customize the wizard](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_Customizing)  
  
5.  [Create the ISO file](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_CreatingISO)  
  
6.  [Test the recovery DVD](Create-a-Server-Recovery-DVD-for-Remotely-Administered-Servers.md#BKMK_Testing)  
  
####  <a name="BKMK_Updating"></a> Step 1: (Optional) Update WinPE  
 The ADK includes a copy of Windows PE that is customized. When this image is booted, it automatically launches the beacon that is used by the client recovery application to connect to a server in recovery mode.  
  
 Windows PE needs to be further customized by adding any hardware-specific drivers, such as network or disk controller drivers. After booting from WinPE, the hard disks on the system need to be recognizable and the network must be working.  
  
####  <a name="BKMK_Collecting"></a> Step 2: Collect the factory reset images and XML files  
 To reset a server to factory defaults, the following two images need to be captured:  
  
- The system drive image  
  
- The system reserved partition  
  
  To capture these images, the GenDiskXML.exe tool is provided. GenDiskXML.exe also collects a file named disk.xml that is used by the recovery process to recreate the disk configuration.  
  
1.  Following Sysprep, reboot the system by using any 64-bit version of Windows PE.  
  
2.  To output the .xml and .wim files to an external source, run `GenDiskXML /outputdir:<path>` to output the .xml and .wim files to any external source. The files are added to the DVD in the next step.  
  
    > [!NOTE]
    >  The system .wim file will be split to meet the FAT32 requirement of no file larger than 4 GB. During the process, the required capacity of the target that is used to capture the .wim files needs to be larger than 8 GB to accommodate the splitting process.  
  
####  <a name="BKMK_Creating"></a> Step 3: Create the server recovery DVD  
 Each server shipped from the factory must be accompanied by a server recovery DVD. Your ADK tools DVD includes the files necessary to create the DVD.  
  
###### To create the server recovery DVD  
  
1.  Create a working folder to use as the location for storing the final ISO.  
  
2.  From the partner CD, copy the contents of the **Server Recovery** folder to the working folder that you created in Step 1.  
  
3.  Copy the disk.xml file that was created when you ran GenDiskXML.exe to the **Reset** folder.  
  
4.  Copy the image files that were created when you ran **GenDiskXML.exe** to the **Reset** folder. The files are the .wim and .swm files, and the number of files may vary.  
  
5.  Remove GenDiskXML.exe from the folder. It is used only for factory purposes, and it should not be included on the DVD that is shipped to the customer.  
  
####  <a name="BKMK_Customizing"></a> Step 4: Customize the wizard  
 The server recovery application must be customized with an image of the device and text that describes how to start the specific device into recovery mode. Because this page of the Restore Files and Folders Wizard is hardware specific, the steps to start the server into recovery mode will vary.  
  
> [!NOTE]
>  The file names that are listed must match exactly.  
  
1. The wizard page has a link for additional help. If this .chm file exists, it will override the FWLink for web Help. The Help file is located at:  
  
    <DVD Root\>\\$OEM$\Customization\\<culture name\>\RestartHelp.chm  
  
2. This file contains the text that the customer sees on the wizard page. The text should explain how to boot the server into recovery mode. The control is scrollable, which places a practical limit on the amount of text that can be added.  
  
    The following file is used to replace the sample picture in the wizard, and it is primarily about branding. It must be a .png file. The file size must be 256 pixels x 256 pixels, or it will be cropped when it is displayed in the wizard.  
  
    <DVD Root\>\\$OEM$\Customization\\<culture name\>\RestartInstructions.rtf  
  
3. <DVD Root\>\\$OEM$\Customization\\<culture name\>\ServerImage.png  
  
   When you are converting your server recovery DVD to support multiple languages, ensure that you do the following:  
  
4. You must always have the en-us folder. If the server recovery application does not find the culture-specific files that match the client computer it is running on, it falls back to en-us.  
  
5. In each culture folder that you create, add the three customization files (.png, .chm, and .rtf).  
  
6. Copy both of the culture folders from Language Packs\\<CultureName\>\Server Recovery to the root of the server recovery DVD. For example: Both the ES and ES-ES folders would be copied to the root of the DVD to support Spanish.  
  
7. Finalize the ISO file.  
  
   Supported culture names include:  

|-|-|  
|- cs-CZ<br /><br /> - de-DE<br /><br /> - en-US<br /><br /> - es-ES<br /><br /> - fr-FR<br /><br /> - hu-HU<br /><br /> - it-IT<br /><br /> - ja-JP<br /><br /> - ko-KR<br /><br /> - nl-NL|- pl-PL<br /><br /> - pt-BR<br /><br /> - pt-PT<br /><br /> - ru-RU<br /><br /> - sv-SE<br /><br /> - tr-TR<br /><br /> - zh-CN<br /><br /> - zh-HK<br /><br /> - zh-TW
  
####  <a name="BKMK_CreatingISO"></a> Step 5: Create the ISO file  
 The folder that was created and all the contents can be burned to a DVD. This is the DVD that will be provided to customers with their new server.  
  
####  <a name="BKMK_Testing"></a> Step 6: Test the recovery DVD  
 After completing the server installation, configure the server backup, run a server backup, and then test the recovery DVD.  
  
###### To configure and run a server backup  
  
1.  Open the Dashboard, click the **Devices** tab, and then click **Set up backup for the server** in the **Tasks** pane.  
  
2.  Follow the instructions in the wizard to configure a backup server backup. You need an external hard disk for the backup.  
  
3.  Click **Start a backup for the server** in the **Tasks** pane, and then follow the instructions in the wizard.  
  
4.  When the backup finishes, verify that it was successful.  
  
###### To restore a server  
  
1.  Insert the recovery DVD that you created into a client computer that is connected to the same network as the server through a hub or a switch.  
  
2.  Double-click **setup.exe**. The Server Recovery Wizard prompts you through the same process that the customer will follow.  
  
3.  Click **Restore the server from a backup**, and then follow the instructions in the wizard.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)