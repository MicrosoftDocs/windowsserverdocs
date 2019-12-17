---
title: Create Windows 10 Enterprise virtual desktops for stations
description: Learn how to create Windows Server 2016 desktops for station
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 63f08b5b-c735-41f4-b6c8-411eff85a4ab
author: evaseydl
ms.author: evas
manager: scottman
---
# Create Windows 10 Enterprise virtual desktops for stations
This optional configuration in MultiPoint Services is primarily intended for situations where an essential application requires its own instance of a client operating system for each user. Examples include applications that cannot be installed on Windows Server and applications that will not run multiple instances on the same host computer.  
  
> [!NOTE]  
> These Virtual Desktops, also known as VDI, are much more resource intensive than the default MultiPoint Services desktop sessions, so we recommend that you use default MultiPoint Services sessions when possible.  
  
## Prerequisites  
To prepare to create station virtual desktops, ensure that your MultiPoint Services system meets the following requirements:      
  
|Hardware|Requirements|         |
|------------|----------------|----------------| 
|CPU (multimedia)|1 core or thread per virtual machine|  
|Solid State Drive (SSD)|Capacity >= 20GB per station + 40GB for the MultiPoint Services host operating system<br /><br />Random Read\/Write IOPS >= 3K per station|  
|RAM|2GB per station + 2GB for the Windows MultiPoint Server host operating system|  
|Graphics|DX11|  
|BIOS|BIOS CPU setting configured to enable virtualization – Second Level Address Translation (SLAT)|  
  
-   **Stations** - Set up the stations for your MultiPoint Services system. For more information, see [Attach additional stations to MultiPoint Services](Attach-additional-stations-to-your-MultiPoint-services-computer.md).  
  
-   **Domain** - In a domain environment, the Windows MultiPoint Server computer has been added to the domain, and a domain user has been added to the local Administrators group on the MultiPoint Services host operating system.  
  
## Procedures  
Use the following procedures to:  
  
-   [Create a template for virtual desktops](#create-a-template-for-virtual-desktops)  
  
-   [Create virtual desktops from the template](#create-virtual-machine-desktops-from-the-template)  
  
-   [Copy an existing virtual desktop template](#copy-an-existing-virtual-desktop-template)  
  
### Create a template for virtual desktops  
Before you can create a template for your virtual desktops, you must enable the Virtual Desktop feature in MultiPoint Server.  
  
##### To enable the Virtual Desktop feature  
  
1.  Log on to the MultiPoint Server host operating system with a local administrator account or, in a domain, with a domain account that is a member of the local Administrators group.  
  
2.  From the **Start** screen, open MultiPoint Manager.  
  
3.  Click the **Virtual Desktops** tab, click **Enable virtual desktops**, and then click **OK**, and wait for the system to restart.  
  
Your next step is to create a Virtual Desktop template. You are literally creating a virtual hard disk (VHD) file that you can use as a template to create station virtual desktops for MultiPoint Manager. You can either use the physical installation media for Windows or an .ISO image file to as source for the template. You can also use a .VHD of the Windows installation. Note that to use a physical installation disc, you must insert the disc before you start the wizard.  
  
##### To create a Virtual Desktop template  
  
1.  Log on to the MultiPoint Server host operating system with a local Administrator account or, in domain, a domain account that is a member of the local Administrators group.  
  
2.  From the **Start** screen, open MultiPoint Manager.  
  
3.  Click the **Virtual Desktops** tab.  
  
4.   Copy a Windows 10 Enterprise .iso file to the local SSD.  
  
5.  On the Virtual Desktops tab, click **Create virtual desktop template.**   
  
6.  In **Prefix**, enter a prefix to use to identify the template and the virtual desktops created with the template. The default prefix is the host computer name.  
  
    The prefix is used to name the template and the virtual desktop stations. The template will be <*prefix*>-t. The virtual desktop stations will be named <*prefix*>-*n*, where *n* is the station identifier.  
  
7.  Enter a username and password to use for the local Administrator account for the template. In a domain, enter the credentials for a domain account that will be added to the local Administrators group. This account can be used to log on to the template and all virtual desktop stations created from the template.  
  
8. Click **OK**, and wait for template creation to complete.  
  
9. The new template will be listed on the **Virtual Desktops** tab. The template will be turned off.  
  
Your next step is to configure the template with the software and setting that you want on the virtual desktops. You must do this before you create any virtual desktops from the template.  
  
##### To customize a virtual desktop template  
  
1.  Log on to the MultiPoint server host operating system with a local administrator account or, in a domain, with a domain account in the local Administrators group.  
  
2.  From the **Start** screen, open MultiPoint Manager.  
  
3.  Click the **Virtual Desktops** tab.  
  
4.  Select the template that you want to customize, click **Customize template**, and then click **OK**.  
  
    > [!NOTE]  
    > Only the templates that have not been used to create virtual desktop stations are available. If you want to update a template that is already in use, you must make a copy of the template by using the **Import template** task, described later, in [Copy an existing virtual desktop template](#copy-an-existing-virtual-desktop-template).  
  
    The template opens in a Hyper-V **VM Connect** window, and auto-logon is performed using the built-in Administrator account.  
  
5.  At this point you can install applications and software updates, change settings, and update the administrator profile. All changes made to the template's built-in administrator profile will be copied to the default user profile in the virtual desktop stations that are created from the template.  
  
    If you are connecting your stations over a domain, we recommend that you create a local user account and add it to the local Administrators group during customization.  
  
    > [!NOTE]  
    > If the system restarts while a template is being customized, auto-logon using the built-in Administrator account might fail after the system restarts. To get around this problem, manually log on using the local Administrator account that you created, change the password of the built-in Administrator account, log off, and then log back on using the built-in Administrator account and the new password. (You will need to delete the profile that was created when you logged on using the local Administrator account.)  
  
6.  After you finish configuring your system, double-click the **CompleteCustomization** shortcut on the administrator's desktop to run Sysprep and then shut down the template. During customization, the Sysprep tool removes all unique system information to prepare the Windows installation to be imaged.  
  
### Create virtual machine desktops from the template  
With your virtual desktop template configured the way you want your desktops to be, you are ready to begin creating virtual desktops. A virtual desktop will be created for each station that is attached to the MultiPoint Server computer. The next time a user logs on to a station, they will see the virtual desktop instead of the session-based desktop that was displayed before.  
  
> [!NOTE]  
> This procedure only works when MultiPoint Server is in *station mode*. If the system is in *console mode*, you can switch to station mode from MultiPoint Manager. If you are using default MultiPoint settings, you can also start station mode by restarting the computer. By default, the MultiPoint Server computer always starts in station mode  
  
##### To create virtual desktops for your stations  
  
1.  Log on to the Windows MultiPoint server from a remote station (for example, from a Windows computer by using Remote Desktop Connection) using a local administrator account or, in a domain, a domain account in the local Administrators group.  
  
    > [!NOTE]  
    > Alternatively, you can log on to the server using a local station. However, when you create a station virtual desktop, you will have to log off the station that you used to create the virtual desktop in order to connect the other station to the new virtual desktop.  
  
2.  From the **Start** screen, open MultiPoint Manager.  
  
3.  If the computer is in console mode, switch to station mode:  
  
    1.  On the **Home** tab, click **Switch to station mode**.  
  
    2.  When the computer restarts, log on as Administrator.  
  
4.  Click the **Virtual Desktops** tab.  
  
5.  Select the virtual desktop template that you want to use with the stations, click **Create virtual desktop stations**, and then click **OK**.  
  
When the task completes, each local station will connect to a virtual machine-based virtual desktop.  
  
> [!NOTE]  
> If a user account is logged on to any of the local stations, you will need to log out of the session to get the station to connect to one of the newly created station virtual desktops.  
  
### Copy an existing virtual desktop template  
Use the following procedure to create a copy of an existing virtual desktop template that you can customize and use. This can be useful in the following situations:  
  
-   To copy a master template from a network share onto a MultiPoint Server host computer so that virtual desktop stations can be created from the master template.  
  
-   To create a copy of a template that is currently in use so that you can make additional customizations.  
  
##### To import a virtual desktop template  
  
1.  Log on to the MultiPoint server as an administrator.  
  
2.  From the **Start** screen, open MultiPoint Manager.  
  
3.  Click the **Virtual Desktops** tab.  
  
4.  Click **Import virtual desktop template**, and use **Browse** to select the .vhd file (template) that you want to import. When you import a template, a copy is made of the original .vhd. By default, MultiPoint Services stores .vhd files in the C:\\Users\\Public\\Documents\\Hyper\-V\\Virtual hard disks\\ folder.  
  
5.  Enter a prefix for the new template, and then click **OK**.  
  
6.  If you are making further customizations to a local template, you might change the prefix name by incrementing a version number at the end of the prefix. Or, if you are importing a master template, you might want to add the version of the master template to the end of the default prefix name.  
  
7.  When the task completes, you can customize the template or use it as it is to create stations.  
