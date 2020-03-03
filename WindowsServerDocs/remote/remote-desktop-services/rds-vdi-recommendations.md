---
title: Recommended configuration for VDI desktops
description: Recommended settings and configuration to minimize overhead for Windows 10 1607 (10.0.1393) desktops used as VDI images
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 12/18/2018
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a44dc9f-c221-4bf7-89c3-fb4c86a90f8c
author: jaimeo
manager: dougkim
---
# Recommended settings for VDI desktops

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows 10

Microsoft Desktop Virtualization automatically detects device configurations and network conditions to get users up and running sooner by enabling the instant setup of corporate applications and desktops, and it equips IT to provide access to legacy applications during migration to Windows 10.

Although the Windows 10 operating system is very well tuned out of the box, there are opportunities for you to refine it further specifically for the corporate Microsoft Virtual Desktop Infrastructure (VDI) environment. In the VDI environment, many background services and tasks are disabled from the beginning.

This topic is not a blueprint, but rather a guide or starting point. Some recommendations might disable functionality that you would prefer to use, so you should consider the cost versus the benefit of adjusting any particular setting in your scenario.

These instructions and recommended settings are relevant to Windows 10 1607 (version 10.0.1393).

> [!NOTE]
> Any settings not specifically mentioned in this topic can be left at their default values (or set per your requirements and policies) without appreciable impact on VDI functionality.

When you create an image to base the VDI deployment, be sure to use the **Current Branch**. For more information about Current Branch, see [Windows 10 release information](https://technet.microsoft.com/windows/release-info.aspx).

## Creating the Windows 10 image
The first step is to install a reference image of Windows 10 1607 (version 10.0.1393) on either a physical  or virtual machine. Installing to a virtual machine is easy and allows you to save versions of the virtual hard-disk (VHD) file, in case you want to roll back to an earlier version.

During installation, you can choose either **Express Settings** or **Customize**. The settings offered during the **Customize** option are adjustable by using Group Policy, so the method of installing the base OS is not that important.


If you chose **Customize**, you can adjust these settings during installation:

## In "Customize settings"

You can also adjust these after installation with Group Policy Editor; see the "Group Policy settings" section of this topic.

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|**Personalization**| | |
|Personalize your speech, typing, and inking input by sending your input data to Microsoft.|	On|	Off|
|Send typing and inking data to Microsoft to improve the recognition and suggestion platform.|	On|	Off|
|Let apps use your advertising ID for experience across apps.|	On|	Off|
|Let Skype (if installed) help you connect with friends in your address book and verify your mobile number. SMS and data charges may apply.|	On|	Off|
|**Location**| | |
|Turn on Find My Device and let Windows and apps request your location, including location history|	On|	Off|
|Connectivity and error reporting| | |
|Automatically connect to suggested open hotspots. Not all networks are secure.|	On|	Off|
|Automatically connect to open hotspots temporarily to see if paid network services are available.|	On|	Off|
|Send full diagnostic and usage data to Microsoft. Turning this off sends only basic data.|	On|	Off|
|**Browser, protection, and update**| | |
|Use SmartScreen online services to help protect against malicious content and downloads in sites loaded by Windows browsers and Store apps|	On|	On (If there is no Internet access, then set to Off.)
|Use page prediction to improve reading, speed up browsing, and make your overall experience better in Windows browsers. Your browsing data will be sent to Microsoft.|	On|	Off|
|Get updates from and send updates to other PCs on the Internet to speed up app and Windows Update downloads|	On|	Off|

Once installation is complete, you can continue adjusting settings starting with **Windows Settings**.

## In Windows Settings
To access Windows Settings, click **Start** (the Windows icon on the taskbar), and then click the **Settings** icon (shaped like a gear).

### In the "System" area of Windows Settings
In Windows Settings area, clicking the **System** icon gives you access to a number of system-related settings. Not all of them need adjustment for optimum VDI use--these settings are the most important:

#### Apps and features

To remove an app, thereby excluding it from your VDI image, click the app, and then click **Uninstall**. If **Uninstall** is grayed out, you cannot remove it by this method; you might be able to remove it with Windows PowerShell, or try these steps:
1. Click **Manage optional features** (immediately below the **Apps and features** heading on the same page).
2. Click the optional feature, and then click **Uninstall**.

Features to consider removing (if present) include the following:
- **Contact support**
- **English (United States) Retail Demo Content**
- **Neutral Retail Demo Content**
- **Quick Assist**

#### Default apps

This area defines the app to be used by default for certain generic functions such as e-mail, web browsing, and maps. If you want a different app to be used for a particular function, click the current entry, and then click the app you prefer to be used in the VDI image. For a non-Microsoft app to be an available choice, you must install the app prior to adjusting this setting.

#### Notifications and actions

These recommended values will reduce notifications and background network activity in a VDI environment:

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|Get notifications from apps and other senders|	On|	Off|
|Show notifications on the lock screen.|	On|	Off|
|Show alarms, reminders, and incoming VoIP calls on the lock screen.|	On|	Off|
|Show tips, tricks, and suggestions as you use Windows.|	On|	Off|


#### Offline maps

This setting is only applicable if the Maps app is installed. Its default value is **On**; for VDI use the recommended value is **Off**.

#### Tablet mode

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|When I sign in|	Use the appropriate mode for my hardware|	Use desktop mode|
|When this device automatically switches mode on or off|	Always ask me before switching|	Don't ask me and don't switch|
|Hide app icons on the taskbar in tablet mode|	On|	Off|


### In the "Devices" area of Windows Settings
In Windows Settings area, clicking the **Devices** icon gives you access to a number of system-related settings. Not all of them need adjustment for optimum VDI use--these settings are the most important:

#### Autoplay

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|Use Autoplay for all media and devices|	On|	Off|
|Removable drive:|Choose a default|Take no action|
|Memory card|Choose a default|Take no action|

### In the "Personalization" area of Windows Settings
In Windows Settings area, clicking the **Personalization** icon gives you access to a number of system-related settings. Not all of them need adjustment for optimum VDI use--these settings are the most important:

#### Background
Sometimes the default black background can cause users to think the computer is not responding. Changing the background color can help make it clearer. To do this, follow these steps:
1. In the **Background** area, click the pull-down menu.
2. To change the background color, click **Solid color**, and then click any of the colors other than black. Alternately, you could click **Picture** and then select an image to use as the background.

#### Start

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|Occasionally show suggestions in Start|	On|	Off|
|Show most used apps|On|Off|
|Show recently added apps|On|Off|
|Show recently opened items in Jump Lists on Start or the Taskbar|On|Off|

#### Taskbar
The default setting is to use large taskbar buttons (that is, a value of "Off" for **Use small taskbar buttons**). This setting causes the Cortana item to use a lot of taskbar area. To avoid this, set **Use small taskbar buttons** to "On." If you prefer that the taskbar items stay larger, but prefer not to have Cortana taking up so much space, right-click the taskbar, point to **Cortana**, and in the menu that flies out, select **Hidden**.

### In the "Privacy" area of Windows Settings
In Windows Settings area, clicking the **Privacy** icon gives you access to a number of system-related settings. Not all of them need adjustment for optimum VDI use--these settings are the most important:

#### General
Some of these settings are also set from the "Customize settings" window, discussed at the beginning of this topic.

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|Let apps use my advertising ID for experiences across apps (turning this off will reset your ID)|	On|	Off|
|Let websites provide locally relevant content by accessing my language list|On|Off|
|Let apps on my other devices open apps and continue experiences on this device|On|Off|

#### Camera

The default value for "Let apps use my camera" is **On**; for VDI use the recommended value is **Off**.


#### Microphone

The default value for "Let apps use my microphone" is **On**; for VDI use the recommended value is **Off**.

#### Notifications

The default value for "Let apps access my notifications" is **On**; for VDI use the recommended value is **Off**.

#### Contacts

The default value for "Let apps access my contacts" is **On**; for VDI use the recommended value is **Off**.

#### Calendar

The default value for "Let apps access my calendar" is **On**; for VDI use the recommended value is **Off**.

#### Call history

The default value for "Let apps access my call history" is **On**; for VDI use the recommended value is **Off**.

#### Email

The default value for "Let apps access and send email" is **On**; for VDI use the recommended value is **Off**.

#### Messaging

The default value for "Let apps read or send messages (text or MMS)" is **On**; for VDI use the recommended value is **Off**.

#### Radios

The default value for "Let apps control radios" is **On**; for VDI use the recommended value is **Off**.

#### Other devices

The default value for "Let your apps automatically share and sync info with wireless devices that don't explicitly pair with your PC, tablet, or phone" is **On**; for VDI use the recommended value is **Off**.

#### Feedback and diagnostics

The default value for "Windows should ask for my feedback" is **Automatically**; for VDI use, the recommended value is **Never**.

#### Background apps
Listed apps have a default value of **On**, which allows them to receive information, send notifications, and update themselves whether they are being used or not. You should disable (set to **Off**) any apps you don't want running in the background in the VDI image.

### Update and security
#### Windows Update
In the **Update settings** area, click **Advanced options** to adjust these settings:

|Setting|Default value|Recommended value for VDI use|
|-------------------|----------|--------------|
|Give me updates for other Microsoft products when I update Windows|	cleared|	selected|
|Defer feature updates|cleared|selected|
|Use my sign in info to automatically finish setting up my device after an update |cleared|Depends on specific VDI configuration|

On the **Advanced options** page, click **Choose how updates are delivered** to access the setting for "Updates from more than one place." The default value is **On**; for VDI use the recommended value is **Off**.

## In Control Panel and other system utilities

The settings in this section are adjustable either by navigating through Control Panel or opening the utility directly.

> [!NOTE]
> Any settings not specifically mentioned in this topic can be left at their default values (or set per your requirements and policies) without appreciable impact on VDI functionality.


### Task Scheduler
The fastest way to open Task Scheduler is to push the Windows button and type *task scheduler* or *taskschd.msc*. In the results that return, click **Task Scheduler** to open the utility. In Task Scheduler, expand **Task Scheduler Library**, expand **Microsoft**, and then expand **Windows**. You now have access to the list of task collections. To change the state of each scheduled task, right-click it, and then click the desired state (typically, **Disabled** for VDI use).

|Task collection|Task name|Default state|Recommended state for VDI use|
|-------------------|-------------|----------|--------------|
|Customer Experience Improvement Program||||
||Consolidator|Enabled|Disabled|
||KernelCeipTask|Enabled|Disabled|
||UsbCeip|Enabled|Disabled|
|Defrag||||
||ScheduledDefrag|Enabled|Disabled|
|Location||||
||Notifications|Enabled|Disabled|
||WindowsActionDialog|Enabled|Disabled|
|Maintenance||||
||WinSAT|Enabled|Disabled|
|Maps||||
||MapsToastTask|Enabled|Disabled|
||MapsUpdateTask|Enabled|Disabled|
|Mobile Broadband Accounts||||
||MNO Metadata Parser|Enabled|Disabled|
|Power Efficiency Diagnostics||||
||Analyze System|Enabled|Disabled|
|Recovery Environment||||
||VerifyWinRE|Enabled|Disabled|
|Retail Demo||||
||CleanupOfflineContent|Enabled|Disabled|
|Shell||||
||FamilySafetyMonitor|Enabled|Disabled|
||FamilySafetyRefreshTask|Enabled|Disabled|
|Windows Error Reporting||||
||QueueReporting|Enabled|Disabled|
|Windows Media Sharing||||
||UpdateLibrary|Enabled|Disabled|

Click **Windows** again to collapse it, then click **XblGameSave**. This gives you access to the tasks **XBLGameSaveTask** and **XBLGameSaveTaskLogon**; both of these can be set to **Disabled**.

### Performance Monitor
The fastest way to open Performance Monitor is to push the Windows button and type *performance monitor* or *perfmon.msc*. In the results that return, click **Performance Monitor**. In Performance Monitor, click **Data Collector Sets** and then double-click **Event Trace Sessions**. Right-click **WiFiSession**; if it is in the default state of **Running**, then click **Stop**.

Click **StartupEventTraceSessions**, then right-click **ReadyBoot**; if it is running, click **Stop**. Click **Event Trace Sessions**, right-click **ReadyBoot**, and then click **Properties**. In the dialog that opens, click the **Trace Session** tab. Clear the **Enabled** check box.

### Services
The fastest way to manage Services is to push the Windows button and type *services*. In the results that return, click **Services**. The following services are good candidates to disable for use in VDI scenarios; however, you might need to do some testing to verify that they aren't needed for your purposes. To disable a service, in the **Services** snap-in, right-click the service name, and then click **Properties**. On the **General** tab, click the **Startup type** pull-down menu, and then click **Disabled**. Click **OK**.

- BranchCache
- Delivery Optimization
- Diagnostic Service Host
- Windows Mobile Hotspot Service
- Xbox Live Auth Manager
- Xbox Live Game Save
- Xbox Live Networking Service

### File Explorer Options
Push the Windows button and type *control panel*. In the results that return, click **Control Panel**. In Control Panel, click **File Explorer Options**. In the dialog that opens, click the **Search** tab, and then in the **When searching non-indexed locations** area, clear the check box for **Include system directories**. Click **OK** to save.

### Flash settings
Push the Windows button and type *control panel*. In the results that return, click **Control Panel**. In Control Panel, click **Flash Player** to open the Flash Player Settings Manager. On the **Storage** tab, select the radio button for **Block all sites from storing information on this computer**. In the dialog that opens, click **OK**.

On the **Camera and Mic** tab, in the **Camera and Microphone Settings** area, select the radio button for **Block all sites from using the camera and microphone**.

On the **Playback** tab, in the **Peer-assisted Networking** area, select the radio button for **Block all sites from using peer-assisted networking**. Close the Flash Player Settings Manager.

### Internet Options
Push the Windows button and type *control panel*. In the results that return, click **Control Panel**. In Control Panel, click **Internet Options** to open Internet Properties. In the **Home page** area, enter the URL for the web site you want users to see as the home page in browsers. This could be a web site for your company or you can set it to a blank home page by entering *about:blank*.

In the **Browsing history** area, select the check box for **Delete browsing history on exit**.

### Power Options
Push the Windows button and type *control panel*. In the results that return, click **Control Panel**. In Control Panel, click **Power Options** to open the Power Options control panel. In the **Choose or customize a power plan** area, click the down arrow for **Show additional plans**, and then select the radio button for **High performance**. This setting will have very little impact on the VDI host.

### System
Push the Windows button and type *control panel*. In the results that return, click **Control Panel**. In Control Panel, click **System** to open the System control panel. In the left pane, click **Advanced system settings**. In the dialog that opens, click the **Advanced** tab. In the **Performance** area, click the **Settings** button, then on **Visual Effects** tab in the dialog that opens, select the **Adjust for best performance** radio button. Click **OK** to save and exit.

## Group Policy settings

To edit Group Policy settings, press the Windows button and type *group policy* or *gpedit.msc*. In the results that return, click **Edit group policy** to open Local Group Policy Editor.

> [!NOTE]
> Any settings not specifically mentioned in this topic can be left at their default values (or set per your requirements and policies) without appreciable impact on VDI functionality.

Under **Computer Configuration**, expand **Windows Settings**, and then expand **Security Settings**. Click **Network List Manager Policies**, and then double-click **All Networks**. In the dialog that opens, in the **Network location** area, select the radio button for **User cannot change location**. Click the **OK** button to save.

Collapse **Windows Settings**, and then expand **Administrative Templates**. Click or expand **Network**, and then adjust each setting as follows by double-clicking it, then selecting the radio button for the indicated value and clicking the **OK** button:

|Setting area|Setting|Recommended value for VDI use|
|-------------------|-------|----------|
|Background Intelligent Transfer Service (BITS)|||
||Do not allow the BITS client to use Windows Branch Cache|Enabled|
||Do not allow the computer to act as a BITS Peercaching client|Enabled|
||Do not allow the computer to act as a BITS Peercaching server|Enabled|
||Allow BITS Peercaching|Disabled|
|BranchCache||
||Turn on BranchCache|Disabled|
|Hotspot Authentication||
||Enable Hotspot Authentication|Disabled|
|Microsoft Peer-to-Peer Networking Services||
||Turn off Microsoft Peer-to-Peer Networking Services|Enabled|
|Offline Files||
||Allow or Disallow use of the Offline Files feature|Disabled|

Collapse **Network**, and then expand **System**. Adjust each setting as follows double-clicking it, then selecting the radio button for the indicated value and clicking the **OK** button:

|Setting area|Setting|Recommended value for VDI use|
|-------------------|----------|--------------|
|Device Installation||
||Do not send a Windows error report when a generic driver is installed on a device|Enabled|
||Prevent creation of a system restore point during device activity that would normally prompt creation of a restore point|Enabled|
||Prevent device metadata retrieval from the Internet|Enabled|
||Prevent Windows from sending an error report when a device driver requests additional software during installation|Enabled|
||Turn off "Found New Hardware" balloons during device installation|Enabled|

Expand **Filesystem**, double-click **NTFS**, double-click **Short name creation options**, select the radio button for **Enabled**, and then use the **Options** pull-down menu to select **Enable on all volumes**. Click the **OK** button to save.

Collapse **Filesystem**, and then expand **Internet Communication Management**. Click **Internet Communication settings**. Adjust each setting as follows by double-clicking it, then selecting the radio button for **Enabled**, and then clicking the **OK** button:

- Turn off Event Viewer "Events.asp" links
- Turn off handwriting personalization data sharing
- Turn off handwriting recognition error reporting
- Turn off Help and Support Center "Did you know?" content
- Turn off Help and Support Center Microsoft Knowledge Base search
- Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com
- Turn off Internet download for Web publishing and online ordering wizards
- Turn off Internet File Association service
- Turn off Registration if URL connection is referring to Microsoft.com
- Turn off the "Order Prints" picture task
- Turn off the "Publish to Web" task for files and folders
- Turn off the Windows Messenger Customer Experience Improvement Program
- Turn off Windows Customer Experience Improvement Program
- Turn off Windows Error Reporting
- Turn off Windows Update device driver searching

Click **Power Management** and then double-click **Select an active power plan**. Select the radio button for **Enabled**, and then use the **Options** pull-down menu to select **High Performance**. Click the **OK** button to save.

Click **Recovery**, and then double-click **Allow restore of system to default state**. Select the radio button for **Enabled**, and then click the **OK** button to save.

Expand **Troubleshooting and Diagnostics**. Click **Scheduled Maintenance**, double-click **Configure Scheduled Maintenance Behavior**, and then select the radio button for **Disabled**. Click the **OK** button to save.

For each of the following settings areas, click it, then double-click **Configure Scenario Execution Level**, select the radio button for **Disabled**, and then click the **OK** button to save:

- Windows Boot Performance Diagnostics
- Windows Memory Leak Diagnostics
- Windows Resource Exhaustion Detection and Resolution
- Windows Shutdown Performance Diagnostics
- Windows Standby/Resume Performance Diagnostics
- Windows System Responsiveness Performance Diagnostics

Collapse **System**, and then expand **Windows Components**. Adjust each setting as follows by double-clicking it, then selecting the radio button for the indicated value and clicking the **OK** button:

|Setting area|Setting|Recommended value for VDI use|
|-------------------|-------|----------|
|Add features to Windows 10|||
||Prevent the wizard from running|Enabled|
|Autoplay Policies|||
||Set the default behavior for AutoRun|Enabled, then use the **Options** pull-down menu to select **Do not execute any autorun commands**|
|Cloud Content|||
||Do not show Windows tips|Enabled|
||Turn off Microsoft consumer experiences|Enabled|
|Data Collection and Preview Builds|||
||Allow Telemetry|Enabled, then use the **Options** pull-down menu to select **1- Basic**|
||Disable pre-release features or settings|		Disabled|
||Do not show feedback notifications|		Enabled|
||Toggle user control over Insider builds|		Disabled|
|Desktop Window Manager|||
||Do not allow Flip3D invocation|		Enabled|
||Do not allow window animations|		Enabled|
||Use solid color for Start background|		Enabled|
|Edge UI|||
||Allow edge swipe|		Disabled|
||Disable help tips|		Enabled|
|File Explorer|||
||Do not show the ‘new application installed' notification|		Enabled|
|Game Explorer|||
||Turn off downloading of game information|		Enabled|
||Turn off game updates|		Enabled|
||Turn off tracking of last play time of games in the Games folder|		Enabled|
|Homegroup|||
||Prevent the computer from joining a homegroup|		Enabled|
|Internet Explorer|||
||Allow Microsoft services to provide enhanced suggestions as the user types in the Address bar|		Disabled|
||Disable Periodic Check for Internet Explorer software updates|		Enabled|
||Disable showing the splash screen|		Enabled|
||Install new versions of Internet Explorer automatically|		Disabled|
||Prevent participation in the Customer Experience Improvement Program|		Enabled|
||Prevent running First Run wizard	Go directly to home page|	Enabled, then use the **Options** pull-down menu to select **Go directly to home page**|
||Set tab process growth|Enabled, then type the following in the **Tab Process Growth** box: *Low*.|
||Specify default behavior for a new tab|Enabled, then use the **Options** pull-down menu to select **New tab page**|
||Turn off add-on performance notifications|		Enabled|
||Turn off browser geolocation|		Enabled|
||Turn off Reopen Last Browsing Session|		Enabled|
||Turn off suggestions for all user-installed providers|		Enabled|
||Turn on Suggested Site|		Disabled|

At the same level as the **Internet Explorer** settings you just adjusted in the preceding table, note another level of folders ranging from **Accelerators** to **Toolbars**. In other words, you are now at Local Computer Policy > Computer Configuration > Administrative Templates > Windows Components > Internet Explorer.

Open the **Delete Browsing History** folder, double-click **Allow deleting browsing history on exit**, select **Enable**, and then click **OK** to save and exit.

Use the back arrow in the upper left of Local Group Policy Editor to go back to the **Internet Explorer** level. Double-click **Internet Settings**, double-click **Advanced Settings**, and then adjust the settings in the subfolders as follows:

|Setting folder under **Advanced Settings**|Setting|Recommended value for VDI use|
|-------------------|-------|----------|
|**Browsing**|||
||Turn off phone number detection|Enabled|
|**Multimedia**|||
||Allow Internet Explorer to play media files that use alternative codecs|Disabled|

Go back up to the level of **Internet Explorer**, then double-click **Internet Settings**. In this folder, set these two settings under **AutoComplete** to **Enabled**:

- Turn off URL Suggestions
- Turn off Windows Search AutoComplete

Go back up four levels to **Windows Components**, double-click **Location and Sensors**, and then set these three settings to **Enabled** (for each, click **OK** to save and exit):

- Turn off location
- Turn off location scripting
- Turn off sensors

While at the level of **Location and Sensors**, double-click **Windows Location Provider** and set **Turn off Windows Location Provider** to **Enabled**. Click **OK** to save and exit.

In the left pane, click **Maps**, set these settings to **Enabled**; for each, then click **OK** to save and exit:

- Turn off Automatic Download and Update of Map Data
- Turn off unsolicited network traffic on the Offline Maps settings page

Using the left pane, enter each of the following settings subfolders and adjust the individual settings as follows:

|Settings folder under **Windows Components**|Setting|Recommended value for VDI use|
|-------------------|-------|----------|
|**OneDrive**|||
||Prevent the usage of OneDrive for file storage|Enabled|
||Save documents to OneDrive by default|Disabled|
|**RSS Feeds**|||
||Prevent automatic discovery of feeds and Web Slices|Enabled|
|**Search**|||
||Allow Cortana|		Disabled|
||Allow Cortana above lock screen|		Disabled|
||Allow search and Cortana to use location|		Disabled|
||Do not allow web search|		Enabled|
||Don't search the web or display web results in Search|		Enabled|
||Prevent adding UNC locations to index from Control Panel|		Enabled|
||Prevent indexing files in offline files cache|		Enabled|
|**Store**|||
||Turn off the offer to update to the latest version of Windows|Enabled|
|**Windows Error Reporting**|||
||Automatically send memory dumps for OS-generated error reports|		Disabled|
||Disable Windows Error Reporting|		Enabled|
|**Windows Installer**|||
||Control maximum size of baseline file cache|	Enabled, then use the spin box in the **Options** area to set **Baseline file cache maximum size** to *5*.|
||Turn off creation of System Restore checkpoints|		Enabled|
|**Windows Mail**|||
||Turn off the communities feature|Enabled|
|**Windows Media Player**|||
||Do Not Show First Use Dialog Boxes|		Enabled|
||Prevent Media Sharing|		Enabled|
|**Windows Mobility Center**|||
||Turn off Windows Mobility Center|Enabled|
|**Windows Reliability Analysis**|||
||Configure Reliability WMI Providers|Disabled|
|**Windows Update**|||
||Allow Automatic Updates immediate installation|		Enabled|
||Remove access to all Windows Update features|		Enabled|
|In the **Windows Update** folder, open **Defer Windows Update**|||
||Select when feature updates are received|Enabled, then in the **Options** area, use the **Select the branch readiness level for the feature updates you want to receive** pull-down menu to select **Current Branch for Business**. Set the **After a feature update is released, defer receiving it for this many days** spin box to *180 days*.
||Select when Quality Updates are received|Enabled, then in the **Options** area, Set the **After a quality update is released, defer receiving it for this many days** spin box to *30 days* and select the check box for **Pause quality updates**.

In the left pane of Local Group Policy Editor, click **User Configuration**. Using the left pane, click **Administrative Templates** and then enter each of the following settings subfolders and adjust the individual settings as follows:

|Settings folder under **Administrative Templates**|Setting|Recommended value for VDI use|
|-------------------|-------|----------|
|**Desktop**|||
||Do not add shares of recently opened documents to Network Locations|Enabled|
|In the **Desktop** folder, open **Active Directory**|||
||Maximum size of Active Directory searches|Enabled, then in the **Options** area, use the spin box to set **Number of objects returned** to *5000*.|
|**Start Menu and Taskbar**|||
||Clear the recent programs list for new users|		Enabled|
||Do not display or track items in Jump Lists from remote locations|		Enabled|
||Turn off feature advertisement balloon notifications|		Enabled|
||Turn off user tracking|		Enabled|
|In the **Start Menu and Taskbar** folder, open **Notifications**|||
||Turn off toast notifications|Enabled|
|In the **Windows Components** folder, open:|||
|**Cloud Content**|||
||Turn off all Windows spotlight features|Enabled|
|**File Explorer**|||
||Turn off caching of thumbnail pictures|		Enabled|
||Turn off display of recent search entries in the File Explorer search box|		Enabled|
||Turn off the caching of thumbnails in hidden thumbs.db file|		Enabled|

## Microsoft Store apps
There are a number of Microsoft Store apps that you might want to remove from the VDI image; removing them will decrease CPU usage and conserve disk space. Good candidates for removal include:

- Get Office
- Skype (preview)
- Get Started (especially if there is no Internet connection)
- Feedback Hub
- Microsoft Solitaire Collection
- Paid Wi-Fi and Cellular

To customize the default user profile used for creating VDI images, use the built-in Administrator account. If it is not already enabled, do so by using Local Users and Groups in Computer Management. Then log in to the Administrator account to complete the following steps.

> [!NOTE]
> Don't remove system apps such as the Store app. They are difficult to reinstall. Other apps are easily reinstallable from the Store.

### Delete unwanted apps from the Administrator user profile
1. In Windows PowerShell, run `Get-AppxPackage | ft PackageFamilyName` to see the list of installed apps.
2. For each app packager you want to uninstall run cmdlets of this example format:

    `Get-AppxPackage *messaging* | Remove-AppxPackage`

    `Get-AppxPackage *WindowsMaps* | Remove-AppxPackage`

    `Get-AppxPackage *ZuneMusic* | Remove-AppxPackage`

### Delete the payload of unwanted Store apps
This will prevent the apps from being reinstalled.
1. List Store apps and other items that have provisioned data in storage with this cmdlet: `Get-AppxProvisionedPackage -Online`.
2. Remove a given package with `Remove-AppxProvisionedPackage -Online -PackageName MyAppPackage`, using the appropriate MyAppPackage returned from Step 1. For example, to remove the Zune-related package, you would run `Remove-AppxProvisionedPackage -Online -PackageName Microsoft.ZuneMusic_2019.17012.10311.0_neutral_~_8wekyb3d8bbwe`.

## Removing other items
You can remove the OneDrive icon and app, turn off system icons, and delete downloaded updates.

### Remove OneDrive icon and app
1. Click **Start** and scroll to the **OneDrive** icon.
2. Right-click the **OneDrive** icon, point to **More**, and then click **Open file location**.
3. Right-click the **OneDrive** icon in its file location, and click **Delete**.

To remove the OneDrive app:
1. Click **Start** and scroll to the **OneDrive** icon.
2. Right-click the **OneDrive** icon, and then click **Uninstall**. Programs and Features opens.
3. In Programs and Features, right-click **Microsoft OneDrive** and click **Uninstall**.

### Programs and Features (from previous versions of Control Panel)
1. Push the **Start** button, type *Control*, and then press ENTER.
2. Tap or double-click **Programs and Features**.
3. On the far left, under **Control Panel Home**, tap or click **Turn Windows features on or off**. A new user interface will open.
4. Clear the check boxes for any items that you do not want or need in the base image, for example: **SMB 1.0/CIFS File Sharing Support**.

### Turn system icons off
1. Push or click **Start**, and then click **Settings** (the gear icon).
2. In the **Find a Setting** text area, type *Taskbar*, and then click **Taskbar Settings**.
3. Under the **Taskbar** section, scroll or swipe down to the **Notification area** section.
4. Click or tap **Turn system icons on or off**, and then turn each system icon on or off as you prefer for the image.

### Delete downloaded updates
1. Using File Explorer, navigate to **C:\Windows\Software Distribution\Download**.
2. Delete all files and folders in that directory.
