---
title: Configure Disk Protection in MultiPoint Services
description: Learn how to set up disk protection for MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bd9bf5b9-e481-499b-9c15-7ee5a4f470c4
author: evaseydl
manager: scottman
ms.author: evas
ms.date: 08/04/2016
---
# Configure Disk Protection
You can use Disk Protection in Multipoint Services to protect your system volume from unintended updates, to schedule Windows Updates to be retained while Disk Protection is active, to temporarily disable Disk Protection, and to uninstall Disk Protection.  
  
By enabling Disk Protection in MultiPoint Services, you can protect the system volume (the drive where Windows is installed, usually C:) from unwanted changes. When Disk Protection is enabled, changes made to the system volume are stored in a temporary location so that simply restarting the computer discards them and automatically returns the system to the previous known-good state.  
  
The administrator can easily install software or make configuration changes by temporarily disabling disk protection. In order to keep the system current with Windows Updates and anti-malware definitions, Disk Protection schedules a maintenance window to download and install updates. The administrator can also provide a custom script to run during the maintenance window to accommodate any maintenance needs beyond Windows Update.  
  
## Enable Disk Protection  
Before you enable Disk Protection, make sure all applications and drivers are installed and up to date, and move your user profiles to a volume that will not be protected. If you need to make manual updates after you enable Disk Protection, you can temporarily disable Disk Protection. However, it's easiest to get the system into an ideal state before Disk Protection is turned on.  
  
 
1.  Log on to the server running MultiPoint Services as an administrator.  
  
2.  Before you enable Disk Protection:  
  
    -   Ensure the MultiPoint Services system is in exactly the state in which you want it to remain. For example, ensure that installed software, system settings, and updates are correct.  
  
    -   Move user profiles to a volume that is not protected, or set up a shared file location off the system volume as described in [Enable file sharing in MultiPoint Services](Enable-file-sharing-in-MultiPoint-services.md).  
  
3.  From the **Start** screen, open **MultiPoint Manager**.  
  
4.  Click the **Home** tab, click **Enable disk protection**, and then click **OK**.  
  
When Disk Protection is enabled for the first time, the system is prepared by installing a driver and creating a cache file on the system volume. The cache file will temporarily store any changes made to the system volume while Disk Protection is active. Because system updates are stored in the cache file, they do not alter the protected contents of the volume outside the cache file. Each time the system starts, the cache file is reset, which discards any changes stored there since the previous system start. Thus, the system always starts in the same state as when Disk Protection was enabled.  
  
Windows needs to update a few system files – including the system pagefile, crash dump location, and event logs. Those files are not discarded when Disk Protection is enabled. To accomplish this, a new volume named DpReserved is created when Disk Protection is enabled for the first time, and those files are moved to that volume. The DpReserved partition is not protected, so writes to those files persist through restarts, even when Disk Protection is enabled.  
  
## Schedule software updates  
If Windows is configured to automatically install Windows Updates, Disk Protection allows these updates at the configured time, and does not discard the updates. For example, if Windows updates are scheduled for 3:00 a.m., Disk Protection checks for updates each day at 3:00 a.m. If any updates are found, MultiPoint Services temporarily disables Disk Protection, applies the updates, and then re-enables Disk Protection.  
   
1.  In MultiPoint Manager, display the **Home** tab, and then click **Schedule software updates**.  
  
2.  In the Schedule Software Updates dialog box, click **Update at**, and select a time for updates - for example, **3:00 AM**.  
  
3.  Select the **Run Windows Update** check box.  
  
4.  If your organization runs its own update script, select the **Run the following program** check box, and specify the location of your organization's update script.  
  
5.  Select a maximum time to allow updates to run.  
  
6.  Under **When finished**, choose whether to have the system return to its previous power state or shut down after applying updates.  
  
7.  Click **OK**.  
  
## Temporarily disable Disk Protection  
If an administrator needs to install software, change system settings, or perform other maintenance tasks that involve system updates, they can temporarily disable Disk Protection. After the changes are made, re-enable Disk Protection. During system restarts, the system will retain its state when Disk Protection was enabled.  
    
1.  In MultiPoint Manager, click the **Home** tab.  
  
2.  On the Home tab, click **Disable disk protection**, and then click **OK**.  
  
> [!NOTE]  
> Remember to re-enable Disk Protection after maintenance is complete. The system will not be protected again until the administrator explicitly re-enables Disk Protection.  
  
## Uninstall Disk Protection  
Uninstalling Disk Protection removes the driver and the cache file, so you should only do this if you want to stop using Disk Protection long-term. If you simply want to perform maintenance or stop protection temporarily, use the Disable disk protection task instead.  
  
You can uninstall Disk Protection whether it is enabled or disabled.  
   
1.  In MultiPoint Manager, click the **Home** tab.  
  
2.  On the Home tab, and click **Uninstall disk protection**, and then click **OK**.  
  
    After you click **OK**, the computer restarts. The uninstallation process requires several restarts, during which the driver and cache file are removed. The DpReserved partition remains, and the pagefile, crash dump location, and event log files remain configured to use the DpReserved partition.