---
title: "Troubleshoot Windows Server Essentials installation"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ecf19216-7aac-4aca-839a-342ac28f5329
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot Windows Server Essentials installation

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This topic provides troubleshooting for issues that occur when installing  Windows Server Essentials. Guidance is provided in the following areas:  
  

-   [General troubleshooting steps](Troubleshoot-Windows-Server-Essentials-installation.md#BKMK_GeneralTroubleshootingSteps)  
  
-   [Troubleshoot driver issues](Troubleshoot-Windows-Server-Essentials-installation.md#BKMK_TroubleshootDrivers)  

-   [General troubleshooting steps](Troubleshoot-Windows-Server-Essentials-installation.md#BKMK_GeneralTroubleshootingSteps)  
  
-   [Troubleshoot driver issues](Troubleshoot-Windows-Server-Essentials-installation.md#BKMK_TroubleshootDrivers)  

  
> [!NOTE]
>  For the most current troubleshooting information from the  Windows Server Essentials community, we suggest that you visit the [Windows Server Essentials Forum](https://social.technet.microsoft.com/Forums/winserveressentials/threads). The Windows Server Essentials Forum is a great place to search for help, or to ask a question.  
  
##  <a name="BKMK_GeneralTroubleshootingSteps"></a> General troubleshooting steps  
 If the installation of  Windows Server Essentials fails, take these steps to help identify the issue that caused the failure.  
  
> [!IMPORTANT]
>  It is important that you do not manually restart your server while installing  Windows Server Essentials. The server restarts automatically several times during setup and initial configuration. If you restarted the server manually before you saw the **Server installation successful** message, that might have interrupted the installation and caused it to fail.  
  
#### To identify issues in a failed installation of Windows Server Essentials  
  
1.  Verify that your server hardware meets the minimum requirements. For information about hardware requirements, see [System Requirements for Windows Server Essentials](../get-started/system-requirements.md).  
  
2.  If you received the  Windows Server Essentials installation DVD from MSDN, verify that the DVD is valid by checking the SHA1 sum. For more information, see [Availability and description of the File Checksum Integrity Verifier utility](https://go.microsoft.com/fwlink/?LinkId=220495) (https://go.microsoft.com/fwlink/?LinkId=220495).  
  
3.  Verify that the network adapter on the server is connected to a router by a network cable.  
  
4.  If the server has more than one network adapter, verify that only one network adapter is enabled.  
  
    > [!IMPORTANT]
    >  Do not disconnect the network cable or restart the router while installing  Windows Server Essentials.  
  
5.  Review "Server installation and deployment" in [Release Documentation for Windows Server Essentials](../get-started/release-notes.md)  
  
6.  If you receive the error message An error occurred while setting up your server during installation, use the Server Recovery DVD and the instructions provided by the manufacturer of your hardware to restore the server to factory default settings.  
  
##  <a name="BKMK_TroubleshootDrivers"></a> Troubleshoot driver issues  
 The most common issue when installing  Windows Server Essentials is storage controllers that need to have drivers manually installed. Windows includes drivers for many storage controllers, but it might not include drivers for your specific hardware.  
  
 You might also need to manually install network-card drivers for your specific hardware.  
  
###  <a name="BKMK_StorageDrivers"></a> Adding drivers for storage controllers  
 If your hardware requires storage drivers that are not included with  Windows Server Essentials, use the following information to complete Setup.  
  
 If you see the following message during Setup, you need to manually add drivers for your storage controller:  
  
 **Windows Server Setup Error**  
  
 Hard disk drive capable of hosting  Windows Server Essentials was not found. Would you like to load additional storage drivers?  
  
 Use the following procedure to install a storage controller driver.  
  
##### To manually install a storage controller driver  
  
1. Find the drivers for your storage controller. These are provided by the hardware manufacturer, and they might also be available on the manufacturer's Web site.  
  
2. Create a folder called DRIVERS on a floppy disk or a USB flash drive, and then copy the drivers into the folder.  
  
3. Attach the floppy drive or USB flash drive with the drivers to the computer  
  
4. Boot the computer from the  Windows Server Essentials DVD.  
  
    If any storage controller drivers are missing, the  Windows Server Essentials Setup Error dialog box is displayed.  
  
5. In the  Windows Server Essentials Setup Error dialog box, click **Yes** to load the additional storage drivers.  
  
6. At the **Please select your driver's inf file** prompt, navigate to the .inf file in the DRIVERS folder on your floppy disk or USB flash drive, select the file, right-click the file name, and then click **Open**. This loads the driver.  
  
   > [!NOTE]
   >  Before you attempt to load the file, verify that the file name extension (.inf) is in lowercase letters. This operation is case sensitive, and a driver file will not load if the file name extension has uppercase letters.  
  
7. At the prompt, click **Yes** to make the storage driver available during the text-mode phase of Setup.  
  
   Setup should now continue normally.  
  
###  <a name="BKMK_AddingNICdrivers"></a> Adding drivers for network adapters  
 If a network adapter on the computer is not supported by  Windows Server Essentials, your server will not have network connectivity after Setup completes, and you will not be able to connect computers to your server.  
  
 At the end of the  Windows Server Essentials installation, you are informed if a network adapter driver was not automatically installed. You can also use **Network connections** in Control Panel to check for a missing network adapter driver. If you do not see a network connection associated with the network adapter on your server, you need to install a driver.  
  
 If the computer is missing a supported driver for any network adapter, you need to manually install the right network adapter driver and then restart the server. Use the following procedure.  
  
##### To install a network adapter driver  
  
1.  Obtain the missing driver from the manufacturer of the network adapter.  
  
2.  Follow the manufacturer's installation instructions to install the driver.  
  
3.  Restart the computer.  
  
    > [!IMPORTANT]
    >  If you do not restart the server after you install the missing network adapter driver, installation of the  Windows Server Essentials connector software on your client computers might fail.
