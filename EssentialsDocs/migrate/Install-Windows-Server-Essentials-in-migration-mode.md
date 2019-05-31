---
title: "Install Windows Server Essentials in migration mode1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fd7196ac-cfa6-46a5-ba77-6962b47a825e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install Windows Server Essentials in migration mode1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can have only one server on your network that is running  Windows Server Essentials, and that server must be a domain controller for the network.  
  
 When you install  Windows Server Essentials in migration mode, the installation wizard performs the following tasks:  
  
1.  Installs and configures the  Windows Server Essentials server software on the Destination Server.  
  
2.  Updates the domain schema to the most recent version.  
  
3.  Joins the Destination Server to the existing domain. The Source Server and the Destination Server can both be members of the same domain until the migration process is finished. After the migration is finished, you must remove the Source Server from the network within 21 days.  
  
    > [!WARNING]
    >  An error message is added to the event log each day during the 21-day grace period until you remove the Source Server from your network. The text of the message reads, "The FSMO Role Check detected a condition in your environment that is out of compliance with the licensing policy. The Management Server must hold the primary domain controller and domain naming master Active Directory roles. Please move the Active Directory roles to the Management Server now. This server will be automatically shut down if the issue is not corrected in 21 days from the time this condition was first detected." After the 21-day grace period, the Source Server will shut down.  
  
4.  Transfers the operations master (also called flexible single master operations or FSMO) roles from the Source Server to the Destination Server. Operations master roles are specialized domain-controller tasks, which are used when standard data-transfer and update methods are inadequate. When the Destination Server becomes a domain controller, it must hold the operations master roles.  
  
5.  Configures the Destination Server as a global catalog server. The global catalog server is a domain controller that manages a distributed data repository. It contains a searchable, partial representation of every object in every domain in the Active Directory forest.  
  
6.  Configures the Destination Server as the site-licensing server.  
  
##  <a name="BKMK_Install"></a> Install Windows Server Essentials on the Destination Server  
 To install and configure  Windows Server Essentials on the Destination Server in migration mode, perform the following procedure.  
  
#### To install Windows Server Essentials on the Destination Server  
  
1. Turn on the Destination Server and insert  Windows Server Essentials DVD1 into the DVD drive. If you see a message that asks if you want to boot from a CD or DVD, press any key to do so.  
  
   > [!NOTE]
   >  If the Destination Server supports booting from a USB flash drive, you can use the **Windows 7 USB/DVD Download Tool** to create a bootable USB Flash drive from the  Windows Server Essentials ISO file. Using a USB flash drive can significantly speed up the installation process because flash drives read data much faster than DVD-ROM drives do. After you create a bootable USB flash drive, you can add an answer file to the flash drive. You can [download the Windows 7 USB/DVD Download Tool](https://go.microsoft.com/fwlink/p/?LinkId=248282) free at Microsoft Store website.  
  
   > [!NOTE]
   >  If the Destination Server does not boot from the DVD, restart the computer and check the BIOS Setup to ensure that **DVD-ROM** is listed first in the boot sequence. For more information about how to change the BIOS Setup boot sequence, see your hardware manufacturer's documentation.  
  
2. Click **New Installation**.  
  
3. If you have an internal hard drive that is not displayed in the list, click **Load Drivers** and install the necessary driver before continuing.  
  
4. Select the check box that verifies all files and folders on your primary hard drive will be deleted, and then click **Install**.  
  
5. On the **Choose server installation mode** page, click **Server migration**, and then provide the required migration information.  
  
6. When the **Your server is successfully migrated** message appears, click **Close**.  
  
   After the installation finishes, you are automatically logged on with the administrator user account and password that you provided in the migration answer file.  
  
> [!NOTE]
>  To unlock the desktop while  Windows Server Essentials is installing, use the built-in administrator account and leave the password blank.  
  
##  <a name="BKMK_VerifyTheHealthOfDC"></a> Verify the health of the domain controller  
 Before proceeding with the migration, you should ensure that the domain controller and  Windows Server Essentials network are healthy.  
  
 The following table lists the tools that you can use to diagnose issues on your Destination Server and network, and in the domain:  
  
|Tool|Description|  
|----------|-----------------|  
|Netdiag|Helps isolate networking and connectivity issues. For more information and to download, see [Netdiag](https://go.microsoft.com/fwlink/?LinkId=217388).|  
|Dcdiag.exe|Analyzes the state of domain controllers in a forest or enterprise, and reports issues to assist you in troubleshooting. For more information and to download, see [Dcdiag](https://go.microsoft.com/fwlink/?LinkId=217389).|  
|Repadmin.exe|Assists you in diagnosing replication issues between domain controllers. This tool requires command-line parameters to run. For more information and to download, see [Repadmin](https://go.microsoft.com/fwlink/?LinkId=217387).|  
  
 You should correct all the issues that these tools report before you proceed with the migration.  
  
> [!NOTE]
>  If you plan to migrate email to another on-premises Exchange server, see [Integrate an On-Premises Exchange Server with Windows Server Essentials](../manage/Integrate-an-On-Premises-Exchange-Server-with-Windows-Server-Essentials.md) for information about how to set up your on-premises Exchange server.
