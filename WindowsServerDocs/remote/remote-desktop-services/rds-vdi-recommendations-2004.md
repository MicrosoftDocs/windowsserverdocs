---
title: Optimizing Windows 10, Build 2004, for a Virtual Desktop role
description: Recommended settings and configuration to minimize overhead for Windows 10, version 2004 desktops used as VDI images.
ms.prod: windows-server
ms.reviewer: robsmi, timuessi
ms.technology: remote-desktop-services
author: Heidilohr
ms.author: helohr
ms.topic: article
manager: femila
ms.date: 09/24/2020
---

# Optimizing Windows 10, version 2004 for a Virtual Desktop Infrastructure (VDI) role

This article is intended to provide suggestions for configurations for Windows 10, build 2004, for optimal performance in Virtualized Desktop environments, including Virtual Desktop Infrastructure (VDI) and Azure Virtual Desktop. All settings in this guide are suggested optimization settings only and are in no way requirements.

The information in this guide is pertinent to Windows 10, version 2004, operating system (OS) build 19041.

The guiding principles to optimize performance of Windows 10 in a virtual desktop environment are to minimize graphic redraws and effects, background activities that have no major benefit to the virtual desktop environment, and generally reduce running processes to the bare minimum. A secondary goal is to reduce disk space usage in the base image to the bare minimum. With virtual desktop implementations, the smallest possible base, or "gold" image size, can slightly reduce memory utilization on the host system, as well as a small reduction in overall network operations required to deliver the desktop environment to the consumer.

No optimizations should reduce the user experience. Each optimization setting has been carefully reviewed to ensure that there is no appreciable degradation to the user experience.

> [!NOTE]
> The settings in this article can be applied to other Windows 10 installations, such as version 1909, physical devices, or other virtual machines. There are no recommendations in this article that should affect supportability of Windows 10 in a virtual desktop environment.

## VDI optimization principles

A "full" virtual desktop environment can present a complete desktop session, including applications, to a computer user over a network. The network delivery vehicle can be an on-premises network, the Internet, or both. Some implementations of virtual desktop environments use a "base" operating system image, which then becomes the basis for the desktops subsequently presented to the users for work. There are variations of virtual desktop implementations such as "persistent", "non-persistent", and "desktop session." The persistent type preserves changes to the virtual desktop operating system from one session to the next. The non-persistent type does not preserve changes to the virtual desktop operating system from one session to the next. To the user this desktop is little different than other virtual or physical device, other than it is accessed over a network.

The optimization settings could take place on a reference machine. A virtual machine (VM) would be an ideal place to build the VM, because state can be saved, checkpoints can be made, backups can be made, and so on. A default OS installation is performed to the base VM. That base VM is then optimized by removing unneeded apps, installing Windows updates, installing other updates, deleting temporary files, applying settings, and so on.

There are other types of virtual desktop technology such as Remote Desktop Session (RDS) and the recently released Microsoft Azure [Azure Virtual Desktop](https://azure.microsoft.com/services/virtual-desktop/). An in-depth discussion regarding these technologies is outside the scope of this article. This article focuses on the Windows base image settings, without reference to other factors in the environment such as host hardware optimization.

Security and stability are among the highest priorities for Microsoft when it comes to products and services. In the virtual desktop realm, security is not handled much differently than physical devices. Enterprise customers may choose to utilize the built-in to Windows services of Windows Security, which comprises a suite of services that work well connected or not connected to the Internet. For those virtual desktop environments not connected to the Internet, security signatures can be downloaded proactively several times per day, because Microsoft may release more than one signature update per day. Those signatures can then be provided to the virtual desktop devices and scheduled to be installed during production, regardless of persistent or non-persistent. That way the VM protection is as current as possible.

There are some security settings that are not applicable to virtual desktop environments that are not connected to the Internet, and thus not able to participate in cloud-enabled security. There are other settings that "normal" Windows devices may utilize such as Cloud Experience, The Windows Store, and so on. Removing access to unused features reduces footprint, network bandwidth, and attack surface.

Regarding updates, Windows 10 utilizes a monthly update rhythm. In some cases virtual desktop administrators control the process of updating through a process of shutting down VMs based on a "master" or "gold" image, unseal that image which is read-only, patch the image, then reseal it and bring it back into production. Therefore, there is no need to have virtual desktop devices checking Windows Update. However, there are cases where normal patching procedures take place, like the case of persistent "personal" virtual desktop devices. In some cases, Windows Update can be utilized. In some cases, Intune could be utilized. In some cases Microsoft Endpoint Configuration Manager (formerly SCCM) is utilized to handle update and other package delivery. It is up to each organization to determine the best approach to updating virtual desktop devices, while reducing overhead cycles.

The local policy settings, as well as many other settings in this guide, can be overridden with domain-based policy. It is recommended to go through the policy settings thoroughly and remove or not use any that are not desired or applicable to your environment. The settings listed in this document try to achieve the best balance of performance optimization in virtual desktop environments, while maintaining a quality user experience.

> [!NOTE]
> There is a set of scripts available at GitHub.com, that will do all the work items documented in this paper. The Internet URL for the optimization scripts can be found at [https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool](https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool). This script was designed to be easily customizable for your environment and requirements. The main code is PowerShell, and the work is done by calling input files, which are plain text (now .JSON), with also Local Group Policy Object (LGPO) tool export files. These text files contain lists of the apps to be removed, services to be disabled, and so on. If you don't want to remove a particular app or disable a particular service, you can edit the corresponding text file and remove the item you do not want acted upon. Finally, there is an export of local policy settings that can be imported into your environment machines. It's better to have some of the settings within the base image, than to have the settings applied through group policy, as some of the settings take effect on the next restart or when a component is first used.

### Persistent virtual desktop environments

Persistent virtual desktop is at the basic level, a device that saves operating system state in between reboots. Other software layers of the virtual desktop solution provide the users easy and seamless access to their assigned VMs, often with a single sign-on solution.

There are several different implementations of persistent virtual desktop.

- Traditional VMs, where the VM has its own virtual disk file, starts up normally, and saves changes from one session to the next. The difference is how the user accesses this VM. There may be a web portal the user signs in to that automatically directs the user to one or more virtual desktop devices (VMs) assigned to them.
- Image-based persistent VMs, optionally with personal virtual disks (PVD). In this type of implementation there is a base/gold image on one or more host servers. A VM is created, and one or more virtual disks are created and assigned to this disk for persistent storage.
  - When the VM is started, a copy of the base image is read into the memory space of that VM. At the same time, a persistent virtual disk assigned to that VM, with any previous OS deltas is merged through a complex process.
  - Changes such as event log writes, log writes, and so on. are redirected to the read/write virtual disk assigned to that VM.
  - In this circumstance, OS and app servicing may operate normally, using traditional servicing software such as Windows Server Update Services, or other management technologies.
- The difference between a persistent virtual desktop device and a "normal" virtual desktop device is the relationship to the master/gold image. At some point updates must be applied to the master. It is at this point where organizations decide how the user persistent changes are handled. In some cases, the disk with the user changes is discarded or reset. It may also be that the changes the user makes to the machine are kept through monthly Quality Updates, and the base is reset following a Feature Update.

### Non-persistent virtual desktop environments

When a non-persistent virtual desktop implementation is based on a base or "gold" image, the optimizations are mostly performed in the base image, and then through local settings and local policies.

With image-based non-persistent (NP) virtual desktop environments, the base image is read-only. When an NP virtual desktop device (VM) is started, a copy of the base image is streamed to the VM. Activity that occurs during startup and thereafter until the next reboot is redirected to a temporary location. Usually the users are provided network locations to store their data. In some cases, the user’s profile is merged with the standard VM to provide the user their settings.

One important aspect of NP virtual desktop that is based on a single image, is servicing. Updates to the operating system (OS) and components of the OS are delivered usually once per month. With image based virtual desktop environment, there is a set of processes that must be performed to get updates to the image:

- On a given host, all the VMs on that host, based from the base image must be shut down or turned off. This means the users are redirected to other VMs.

- In some implementations, this is referred to as "draining." The virtual machine or session host, when set to draining mode, stops accepting new requests, but continues servicing users currently connected to the device.

- In draining mode, when the last user logs off the device, that device is then ready for servicing operations.
- The base image is then opened and started up. All maintenance activities are then performed, such as OS updates, .NET updates, app updates, and so on.
- Any new settings that need to be applied are applied at this time.
- Any other maintenance is performed at this time.
- The base image is then shut down.
- The base image is sealed and set to go back into production.
- Users are allowed to log back on.

> [!NOTE]
> Windows 10 performs a set of maintenance tasks, automatically, on a periodic basis. There is a scheduled task that is set to run at 3:00 AM every day by default. This scheduled task performs a list of tasks, including Windows Update cleanup. You can view all the categories of maintenance that take place automatically with this PowerShell command:
>
> ```powershell
> Get-ScheduledTask | Where-Object {$_.Settings.MaintenanceSettings}
> ```

One of the challenges with non-persistent virtual desktop is that when a user logs off, nearly all the OS activity is discarded. The user’s profile and/or state may be saved to a centralized location, but the virtual machine itself discards nearly all changes that were made since last boot. Therefore, optimizations intended for a Windows computer that saves state from one session to the next are not applicable.

Depending on the architecture of virtual desktop device, things like PreFetch and SuperFetch are not going to help from one session to the next, as all the optimizations are discarded on VM restart. Indexing may be a partial waste of resources, as would be any disk optimizations such as a traditional defragmentation.

> [!NOTE]
> If preparing an image using virtualization, and if connected to the Internet during image creation process, on first logon you should postpone Feature Updates by going to **Settings** > **Windows Update**.

### To sysprep or not sysprep

Windows 10 has a built-in capability called the [System Preparation Tool](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview), also known as sysprep. The sysprep tool is used to prepare a customized Windows 10 image for duplication. The sysprep process assures the resulting OS is properly unique to run in production.

There are reasons for and against running sysprep. In the case of virtual desktop environments, you may want the ability to customize the default user profile which would be used as the profile template for subsequent users that sign in using this image. You may have apps that you want installed, but also able to control per-app settings.

The alternative is to use a standard .ISO to install from, possibly using an unattended installation answer file, and a task sequence to install applications or remove applications. You can also use a task sequence to set local policy settings in the image, perhaps using the [Local Group Policy Object Utility (LGPO)](/archive/blogs/secguide/lgpo-exe-local-group-policy-object-utility-v1-0) tool.

To learn more about image preparation for Azure, see [Prepare a Windows VHD or VHDX to upload to Azure](/azure/virtual-machines/windows/prepare-for-upload-vhd-image)

### Supportability

Anytime that Windows defaults are changed, questions arise regarding supportability. Once a virtual desktop image (VM or session) is customized, every change made to the image needs to be tracked in a change log. If a time comes to troubleshoot, often an image can be isolated in a pool and configured for problem analysis. Once a problem has been tracked to root cause, that change can then be rolled out to the test environment first, and ultimately to the production workload.

This document intentionally avoids touching system services, policies, or tasks that affect security. After that comes Windows servicing. The ability to service virtual desktop images outside of maintenance windows is removed, as maintenance windows are when most servicing events take place in virtual desktop environments, except for security software updates. Microsoft has published guidance for Windows Security in virtual desktop environments, here:

**Microsoft**: [Deployment guide for Windows Defender Antivirus in a virtual desktop infrastructure (VDI) environment](/windows/security/threat-protection/windows-defender-antivirus/deployment-vdi-windows-defender-antivirus)

Please consider supportability when altering default Windows settings. Occasionally difficult to solve problems arise when altering system services, policies, or scheduled tasks, in the name of hardening, "lightening," and so on. Consult the Microsoft Knowledge Base for current known issues regarding altered default settings. The guidance in this document, and the associated script on GitHub will be maintained with respect to known issues, if any arise. In addition you can report issues in a number of ways to Microsoft.

You can use your favorite search engine with the terms `"start value" site:support.microsoft.com` to bring up known issues regarding default start values for services.

You might note that this document and the associated scripts on GitHub do not modify any default permissions. If you are interested in increasing your security settings, start with the project known as **AaronLocker**. For more information, see ["AaronLocker" overview](https://github.com/microsoft/AaronLocker).

### Virtual desktop optimization categories

- Universal Windows Platform (UWP) app cleanup
- Optional Features cleanup
- Local policy settings
- System services
- Scheduled tasks
- Apply Windows (and other) updates
- Automatic Windows traces
- Windows Defender optimization with VDI
- Client network performance tuning by registry settings
- Additional settings from the "Windows Restricted Traffic Limited Functionality Baseline" guidance.
- Disk cleanup

### Universal Windows Platform (UWP) application cleanup

One of the goals of a virtual desktop image is to be as light as possible with respect to persistent storage. One way to reduce the size of the image is to remove UWP applications (apps) that won't be used in the environment. With UWP apps, there are the main application files, also known as the payload. There is a small amount of data stored in each user’s profile for application-specific settings. There is also a small amount of data in the "All Users" profile.

In addition, all UWP apps are registered at either the user or machine level at some point after startup for the device, and login for the user. The UWP apps, which include the Start Menu and the Windows Shell, perform various tasks at or after installation, and again when a user logs in for the first time, and to a lesser extent at subsequent logins. For all UWP apps, there are occasional evaluations that take place, such as:

- Do you need to update the app to the latest version?
- The app, if pinned to the Start Menu, might have live tile data to download
- Does the app have a cache of data that needs to be updated, such as maps or weather?
- Does the app have persistent data from the user's profile that needs to be presented at login (for example, Sticky Notes)

With a default installation of Windows 10, not all UWP apps may be used by an organization. Therefore, if those apps are removed, there are fewer evaluations that need to take place, less caching, and so on. The second method here is to direct Windows to disable "consumer experiences." This reduces Store activity by having to check for every user what apps are installed, what apps are available, and then to start downloading some UWP apps. The performance savings can be significant when there are hundreds or thousands of users, all start work at approximately the same time, or even starting work at rolling times across time zones.

Connectivity and timing are important factors when it comes to UWP app cleanup. If you deploy your base image to a device with no network connectivity, Windows 10 cannot connect to the Microsoft Store and download apps and try to install them while you are trying to uninstall them. This might be a good strategy to allow you time to customize your image, and then update what remains at a later stage of the image creation process.

If you modify your base .WIM that you use to install Windows 10 and remove unneeded UWP apps from the .WIM before you install, the apps will not be installed from the beginning and your subsequent profile creation times will be shorter. There is a link later in this section with information on how to remove UWP apps from your installation .WIM file.

A good strategy for the virtual desktop environment is to provision the apps you want in the base image, then limit or block access to the Microsoft Store afterward. Store apps are updated periodically in the background on normal computers. The UWP apps can be updated during the maintenance window when other updates are applied.

#### Delete the payload of UWP apps

UWP apps that are not needed are still in the file system consuming a small amount of disk space. For apps that will never be needed, the payload of unwanted UWP apps can be removed from the base image using PowerShell commands. If you delete UWP app payloads out of the installation .WIM file using the links provided later in this section, you can start from the beginning with a very slim list of UWP apps.

Run the following command to enumerate provisioned UWP apps from a running OS, as in this truncated example output from PowerShell:

```powershell
Get-AppxProvisionedPackage -Online

DisplayName  : Microsoft.3DBuilder
Version      : 13.0.10349.0  
Architecture : neutral
ResourceId   : \~
PackageName  : Microsoft.3DBuilder_13.0.10349.0_neutral_\~_8wekyb3d8bbwe
Regions      :

DisplayName  : Microsoft.Appconnector
Version      : 2015.707.550  
Architecture : neutral
ResourceId   : \~
PackageName  : Microsoft.Appconnector_2015.707.550.0_neutral_\~_8wekyb3d8bbwe
Regions      :
...
```

UWP apps that are provisioned to a system can be removed during OS installation as part of a task sequence, or later after the OS is installed. This may be the preferred method because it makes the overall process of creating or  maintaining an image modular. Once you develop the scripts, if something changes in a subsequent build you edit an existing script rather than repeat the process from scratch.

If you want to learn more, here are some resources that can help you:

- [Removing Windows 10 in-box apps during a task sequence](/archive/blogs/mniehaus/removing-windows-10-in-box-apps-during-a-task-sequence)
- [Removing Built-in apps from Windows 10 WIM-File with PowerShell - Version 1.3](https://gallery.technet.microsoft.com/Removing-Built-in-apps-65dc387b)
- [Windows 10 1607: Keeping apps from coming back when deploying the feature update](/archive/blogs/mniehaus/windows-10-1607-keeping-apps-from-coming-back-when-deploying-the-feature-update)
- [Removing Windows 10 in-box apps during a task sequence](/archive/blogs/mniehaus/removing-windows-10-in-box-apps-during-a-task-sequence)

Then run the following PowerShell command to remove UWP app payloads:

```powershell
Remove-AppxProvisionedPackage -Online - PackageName MyAppxPackage
```

As a final note on this topic, each UWP app should be evaluated for applicability in each unique environment. You will want to install a default installation of Windows 10, version 2004, then note which apps are running and consuming memory. For example, you may want to consider removing apps that start automatically, or apps that automatically display information on the Start Menu, such as Weather and News, and that may not be of use in your environment.

> [!NOTE]
> If you're using the scripts from GitHub, you can easily control which apps are removed before running the script. After downloading the script files, locate the AppxPackage.json file, edit that file, and remove entries for apps that you want to keep, such as Calculator, Sticky Notes, and so on.

## Windows Optional Features cleanup

### Managing Optional Features with PowerShell

Microsoft: [Windows 10: Managing Optional Features with PowerShell](https://social.technet.microsoft.com/wiki/contents/articles/39386.windows-10-managing-optional-features-with-powershell.aspx)

You can manage Windows Optional Features using PowerShell. To enumerate currently installed Windows Features, run the following PowerShell command:

```powershell
Get-WindowsOptionalFeature -Online
```

Using PowerShell, an enumerated Windows Optional Feature can be configured as enabled or disabled, as in the following example:

```powershell
Enabled-WindowsOptionalFeature -Online -FeatureName "DirectPlay" -All
```

Here's an example command that disables the Windows Media Player feature in the virtual desktop image:

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer"
```

Next, you may want to remove the Windows Media Player package. This example command will show you how to do that:

```powershell

PS C:\> Get-WindowsPackage -Online -PackageName *media*

PackageName              : Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~~10.0.19041.153
Applicable               : True
Copyright                : Copyright (c) Microsoft Corporation. All Rights Reserved
Company                  :
CreationTime             :
Description              : Play audio and video files on your local machine and on the Internet.
InstallClient            : DISM Package Manager Provider
InstallPackageName       : Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~~10.0.19041.153.mum
InstallTime              : 5/11/2020 5:43:37 AM
LastUpdateTime           :
DisplayName              : Windows Media Player
ProductName              : Microsoft-Windows-MediaPlayer-Package
ProductVersion           :
ReleaseType              : OnDemandPack
RestartRequired          : Possible
SupportInformation       : http://support.microsoft.com/?kbid=777777
PackageState             : Installed
CompletelyOfflineCapable : Undetermined
CapabilityId             : Media.WindowsMediaPlayer~~~~0.0.12.0
Custom Properties        :

Features                 : {}
```

If you want to remove the Windows Media Player package (to free up about 60 MB disk space), you can run this command:

```powershell
PS C:\Windows\system32> Remove-WindowsPackage -PackageName Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~~10.0.19041.153 -Online

Path          :
Online        : True
RestartNeeded : False
```

### Enable of disabling Windows features using DISM

You can use the built-in Dism.exe tool to enumerate and control Windows Optional Features. A Dism.exe script could be developed and run during an operating system installation task sequence. The Windows technology involved is called Features on Demand. See the following article for more about Features on Demand in Windows:

Microsoft: [Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities)

### Default user settings

You can customize the Windows registry file at `C:\Users\Default\NTUSER.DAT`. Any setting changes you make to this file will be applied to any subsequent user profiles created from a machine running this image. You can control which settings you wish to apply to the default user profile by editing the **DefaultUserSettings.txt** file.

To reduce transmission of graphical data over the virtual desktop infrastructure, you can set the default background to a solid color instead of the default Windows 10 image. You can also set the sign-in screen to be a solid color, as well as turn off the opaque blurring effect on sign-in.

The following settings are applied to the default user profile registry hive, mainly to reduce animations. If some or all of these settings are not desired, delete out the settings that you do not wish to have applied to new user profiles based on this image. The goal with these settings is to enable the following equivalent settings:

- Show shadows under mouse pointer
- Show shadows under windows
- Smooth edges of screen fonts

![A screenshot of the performance options menu with the relevant items selected.](media/performance-options.png)

And, new to this version of settings is a method to disable the following two privacy settings for any user profile created after you run the optimization:

- Let websites provide locally relevant content by accessing my language list
- Show me suggested content in the Settings app

![A screenshot of the privacy settings window. The two disabled settings are highlighted in red.](media/privacy-settings.png)

The following are the optimization settings applied to the default user profile registry hive to optimize performance. Note that this operation is performed by first loading the default user profile registry hive **NTUser.dat**, as the ephemeral key name **Temp**, and then making the below listed modifications:

```regedit
Load HKLM\Temp C:\Users\Default\NTUSER.DAT
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShellState /t REG_BINARY /d 240000003C2800000000000000000000 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCompColor /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowInfoTip /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
add "HKLM\Temp\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\DWM" /v AlwaysHiberNateThumbnails /t REG_DWORD /d 0 /f
add "HKLM\Temp\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
add "HKLM\Temp\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
add "HKLM\Temp\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9032078010000000 /f
add "HKLM\Temp\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
add "HKLM\Temp\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v Disabled /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v DisabledByUser /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.SkypeApp_kzf8qxf38zg5c" /v Disabled /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.SkypeApp_kzf8qxf38zg5c" /v DisabledByUser /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.YourPhone_8wekyb3d8bbwe" /v Disabled /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.YourPhone_8wekyb3d8bbwe" /v DisabledByUser /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v Disabled /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v DisabledByUser /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
add "HKLM\Temp\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f
add "HKLM\Temp\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
Unload HKLM\Temp
```

Another series of default user settings recently added is to disable several Windows apps from starting and running in the background. While not significant on a single device, Windows 10 starts up a number of processes for each user session on a given device (host). The Skype app is one example, and Microsoft Edge is another. The settings included turn off several apps from being able to run in the background. If this functionality is desired as it is, just delete out the lines in the "DefaultUserSettings.txt" file that include the app names "**Windows.Photos**," "**SkypeApp**," "**YourPhone**," and/or "**MicrosoftEdge**."

### Local policy settings

Many optimizations for Windows 10 in a virtual desktop environment can be made using Windows policy. The settings listed in the table in this section can be applied locally to the base/gold image. Then if the equivalent settings are not specified in any other way, such as group policy, the settings would still apply.

Note that some decisions may be based on the specifics of the environment.

- Is the virtual desktop environment allowed to access the Internet?
- Is the virtual desktop solution persistent or non-persistent?

The following settings were chosen to not counter or conflict with any setting that has anything to do with security. These settings were chosen to remove settings or disable functionality that may not be applicable to virtual desktop environments.

| Policy setting | Item | Sub-item | Possible setting and comments |
|--------------|----|--------|----------------------------|
| Local Computer Policy \\ Computer Configuration \\ Windows Settings \\ Security Settings | N/A | N/A | N/A |
| Network List Manager policies | All networks properties | Network location | **User cannot change location** (This is set to prevent the right-hand side pop-up when a new network is detected) |
| Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Control Panel | N/A | N/A |
| Control Panel | Allow Online Tips | N/A  | **Disabled** (Settings will not contact Microsoft content services to retrieve tips and help content) |
| Control Panel \ Personalization | Force a specific default lock screen and logon image) | N/A | Enabled (This setting allows you to force a specific default lock screen and logon image by entering the path (location) of the image file. The same image will be used for both the lock and logon screens. <p>The reason for this recommendation is to reduce bytes transmitted over the network for virtual desktop environments. This setting can be removed or customized for each environment.)|
|Control Panel\ Regional and Language Options\Handwriting personalization|Turn off automatic learning| N/A |**Enabled** (With this policy setting enabled, automatic learning stops, and any stored data is deleted. Users cannot configure this setting in Control Panel)|
|Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Network|N/A|N/A|N/A|
|Background Intelligent Transfer Service (BITS)|Allow BITS Peercaching| N/A |**Disabled** (This policy setting determines if the Background Intelligent Transfer Service (BITS) peer caching feature is enabled on a specific computer.)|
|Background Intelligent Transfer Service (BITS)|Do not allow the BITS client to use Windows Branch Cache|N/A|**Enabled** (With this policy setting enabled, the BITS client does not use Windows Branch Cache.)<p>The reason for this recommendation is so that virtual desktop devices are not used for content caching, and the devices will not be allowed to use the network bandwidth to do so.|
|Background Intelligent Transfer Service (BITS)|Do not allow the computer to act as a BITS Peercaching client|N/A|**Enabled** (With this policy setting enabled, the computer will no longer use the BITS peer caching feature to download files; files will be downloaded only from the origin server.)|
Background Intelligent Transfer Service (BITS)|Do not allow the computer to act as a BITS Peercaching server|N/A|**Enabled** (With this policy setting enabled, the computer will no longer cache downloaded files and offer them to its peers.)|
|BranchCache|Turn on BranchCache|N/A|**Disabled** (With this selection disabled, BranchCache is turned off for all client computers where the policy is applied.)|
|*Fonts|Enabled Font Providers|N/A|**Disabled** (With this setting disabled, Windows does not connect to an online font provider and only enumerates locally installed fonts)|
|Hotspot Authentication|Enable hotspot Authentication| N/A |**Disabled** (This policy setting defines whether WLAN hotspots are probed for Wireless Internet Service Provider roaming (WISPr) protocol support. With this policy setting disabled, WLAN hotspots are not probed for WISPr protocol support, and users can only authenticate with WLAN hotspots using a web browser.)|
|Microsoft Peer-to-Peer Networking Services|Turn off Microsoft Peer-to-Peer Networking Services|N/A|**Enabled** (This setting turns off Microsoft Peer-to-Peer Networking Services in its entirety and will cause all dependent applications to stop working. If you enable this setting, peer-to-peer protocols will be turned off.)|
|Network Connectivity Status Indicator<p>(There are other settings in this section that can be used in isolated networks)|Specify passive polling|Disable passive poling (**checkbox**)|**Enabled** (This Policy setting enables you to specify passive polling behavior. NCSI polls various measurements throughout the network stack on a frequent interval to determine if network connectivity has been lost. Use the options to control the passive polling behavior.)<P>Disabling NCIS passive polling can improve CPU workload on servers or other machines whose network connectivity is static.|
|Offline Files|Allow or Disallow use of the Offline Files feature|N/A|**Disabled** (This policy setting determines whether the Offline Files feature is enabled. Offline Files saves a copy of network files on the user's computer for use when the computer is not connected to the network.With this policy setting disabled, Offline Files feature is disabled and users cannot enable it.)|
|*TCPIP Settings\ IPv6 Transition Technologies| Set Teredo State|Disabled State|**Enabled** (With this setting enabled, and set to "Disabled State", no Teredo interfaces are present on the host)|
*WLAN Service\ WLAN Settings|Allow Windows to automatically connect to suggested open hot spots, to networks shared by contacts, and to hot spots offering paid services|N/A|**Disabled** (This policy setting determines whether users can enable the following WLAN settings: "Connect to suggested open hotspots," "Connect to networks shared by my contacts," and "Enable paid services." With this policy setting disabled, "Connect to suggested open hotspots," "Connect to networks shared by my contacts," and "Enable paid services" will be turned off and users on this device will be prevented from enabling them.)|
|WWAN Service\ Cellular Data Access|Let Windows apps access cellular data|Default for all apps: **Force Deny**|**Enabled** (If you choose the "Force Deny" option, Windows apps are not allowed to access cellular data and users cannot change it.)|
|Local Computer Policy \ Computer Configuration \ Administrative Templates \ Start Menu and Taskbar|N/A|N/A|
|*Notifications|Turn off notifications network usage| N/A |**Enabled** (With this policy setting enabled, applications and system features will not be able receive notifications from the network from WNS or via notification polling APIs)|
|Local Computer Policy \ Computer Configuration \ Administrative Templates \ System| N/A | N/A |N/A|
|Device Installation|Do not send a Windows error report when a generic driver is installed on a device| N/A |**Enabled** (With this policy setting enabled, an error report is not sent when a generic driver is installed.)|
|Device Installation|Prevent creation of a system restore point during device activity that would normally prompt creation of a restore point| N/A |**Enabled** (With this policy setting enabled, Windows does not create a system restore point when one would normally be created.)|
|Device Installation|Prevent device metadata retrieval from the Internet| N/A |**Enabled** (This policy setting allows you to prevent Windows from retrieving device metadata from the Internet. With this policy setting enabled, Windows does not retrieve device metadata for installed devices from the Internet. This policy setting overrides the setting in the Device Installation Settings dialog box (Control Panel > System and Security > System > Advanced System Settings > Hardware tab).)|
|Device Installation|Turn off "Found New Hardware" balloons during device installation| N/A |**Enabled** (This policy setting allows you to turn off "Found New Hardware" balloons during device installation. With this policy setting enabled, "Found New Hardware" balloons do not appear while a device is being installed.)|
|Filesystem\NTFS|Short name creation options|Short name creation options: Disabled on all volumes|**Enabled** (These settings provide control over whether or not short names are generated during file creation. Some applications require short names for compatibility, but short names have a negative performance impact on the system. With short names disabled on all volumes then they will never be generated.)|
|*Group Policy|Continue experiences on this device| N/A |**Disabled** (This policy setting determines whether the Windows device is allowed to participate in cross-device experiences (continue experiences). Disabling this policy prevents this device from being discoverable by other devices, and thus cannot participate in cross-device experiences.)|
|Internet Communication Management\ Internet Communication settings|Turn off Event Viewer "Events.asp" links| N/A |**Enabled** (This policy setting specifies whether "Events.asp" hyperlinks are available for events within the Event Viewer application.)|
|Internet Communication Management\ Internet Communication settings|Turn off handwriting personalization data sharing| N/A |**Enabled** (Turns off data sharing from the handwriting recognition personalization tool.)|
|Internet Communication Management\ Internet Communication settings|Turn off handwriting recognition error reporting| N/A |**Enabled** (Turns off the handwriting recognition error reporting tool.)|
|Internet Communication Management\ Internet Communication settings|Turn off Help and Support Center Microsoft Knowledge Base search| N/A |**Enabled** (This policy setting specifies whether users can perform a Microsoft Knowledge Base search from the Help and Support Center.)|
|Internet Communication Management\ Internet Communication settings|Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com| N/A |**Enabled** (This policy setting specifies whether the Internet Connection Wizard can connect to Microsoft to download a list of Internet Service Providers (ISPs).)|
|Internet Communication Management\ Internet Communication settings|Turn off Internet download for Web publishing and online ordering wizards| N/A |**Enabled** (This policy setting specifies whether Windows should download a list of providers for the web publishing and online ordering wizards.)|
|Internet Communication Management\ Internet Communication settings|Turn off Internet File Association service| N/A |**Enabled** (This policy setting specifies whether to use the Microsoft Web service for finding an application to open a file with an unhandled file association.)|
|Internet Communication Management\ Internet Communication settings|Turn off Registration if URL connection is referring to Microsoft.com| N/A |**Enabled** (This policy setting specifies whether the Windows Registration Wizard connects to Microsoft.com for online registration.)|
|Internet Communication Management\ Internet Communication settings|Turn off Search Companion content file updates| N/A |**Enabled** (This policy setting specifies whether Search Companion should automatically download content updates during local and Internet searches.)|
|Internet Communication Management\ Internet Communication settings|Turn off the "Order Prints" picture task| N/A |**Enabled** (If you enable this policy setting, the task "Order Prints Online" is removed from Picture Tasks in File Explorer folders.)|
Internet Communication Management\ Internet Communication settings|Turn off the "Publish to Web" task for files and folders| N/A |**Enabled* (This policy setting specifies whether the tasks "Publish this file to the Web," "Publish this folder to the Web," and "Publish the selected items to the Web" are available from File and Folder Tasks in Windows folders.)|
|Internet Communication Management\ Internet Communication settings|Turn off Windows Customer Experience Improvement Program| N/A |**Enabled** (The Windows Customer Experience Improvement Program (CEIP) collects information about your hardware configuration and how you use our software and services to identify trends and usage patterns. If you enable this policy setting, all users are opted out of the Windows CEIP.)|
|Internet Communication Management\ Internet Communication settings|Turn off Windows Error Reporting| N/A |**Enabled** (This policy setting controls whether or not errors are reported to Microsoft. If you enable this policy setting, users are not given the option to report errors.)|
|Internet Communication Management\ Internet Communication settings|Turn off Windows Update device driver searching| N/A |**Enabled** (This policy setting specifies whether Windows searches Windows Update for device drivers when no local drivers for a device are present. If you enable this policy setting, Windows Update is not searched when a new device is installed.)|
|Logon|Do not display the Getting Started welcome screen at logon| N/A |**Enabled** (With this setting enabled, the welcome screen is hidden from the user logging on to a Windows device.)|
|Logon|Do not enumerate connected users on domain-joined computers| N/A |**Enabled** (With this setting enabled, the Logon UI will not enumerate any connected users on domain-joined computers.)|
|Logon|Enumerate local users on domain-joined computers| N/A |**Disabled** (With this setting disabled, the Logon UI will not enumerate local users on domain-joined computers.)|
|Logon|Show clear logon background| N/A |**Enabled** (This policy setting disables the acrylic blur effect on logon background image. With this setting enabled, the logon background image shows without blur.)|
|Logon|Show first sign-in animation| N/A |**Disabled** (This policy setting allows you to control whether users see the first sign-in animation when signing in to the computer for the first time. This applies to both the first user of the computer who completes the initial setup and users who are added to the computer later. It also controls if Microsoft account users will be offered the opt-in prompt for services during their first sign-in.<p>With this setting disabled, users will not see the first logon animation and Microsoft account users will not see the opt-in prompt for services.)|
|Logon|Turn off app notifications on the lock screen| N/A |**Enabled** (This policy setting allows you to prevent app notifications from appearing on the lock screen. With this setting enabled, no app notifications are displayed on the lock screen.)|
|Power Management|Select an active power plan|Active Power Plan: High Performance|**Enabled** (If you enable this policy setting, specify a power plan from the Active Power Plan list.) <p>With the "Power" service disabled, the Powercfg.cpl UI is not able to display these power options, and instead returns an RPC error.|
|Power Management \ Video and Display Settings|Turn on desktop background slideshow (plugged-in)| N/A |**Disabled** (This policy setting allows you to specify if Windows should enable the desktop background slideshow.) With this setting disabled, the desktop background slideshow is disabled. This setting likely has no effect on a VM.|
|Recovery|Allow restore of system to default state| N/A |**Disabled** (With this setting disabled, the items "Use a system image you created earlier to recover your computer" and "Reinstall Windows" (or "Return your computer to factory condition") in Recovery (in Control Panel) will be unavailable.)|
|*Storage Health|Allow downloading updates to the Disk Failure Prediction Model| N/A |**Disabled** (Updates would not be downloaded for the Disk Failure Prediction Failure Model)|
|System Restore|Turn off System Restore| N/A |**Enabled** (With this setting enabled, System Restore is turned off, and the System Restore Wizard cannot be accessed. The option to configure System Restore or create a restore point through System Protection is also disabled.).)|
|Troubleshooting and Diagnostics\ Scheduled Maintenance|Configure Scheduled Maintenance Behavior| N/A |**Disabled** (Determines whether scheduled diagnostics will run to proactively detect and resolve system problems. With this policy setting disabled, Windows will not be able to detect, troubleshoot or resolve problems on a scheduled basis.)|
|Troubleshooting and Diagnostics\ Scripted Diagnostics|Troubleshooting: Allow users to access and run Troubleshooting wizards| N/A |**Disabled** (With this setting disabled, users cannot access or run the troubleshooting tools from the Control Panel.)|
|Troubleshooting and Diagnostics\ Scripted Diagnostics|Troubleshooting: Allow users to access online troubleshooting content on Microsoft servers from the Troubleshooting Control Panel (via the Windows Online Troubleshooting Service – WOTS)| N/A |**Disabled** (With this setting disabled, users can only access and search troubleshooting content that is available locally on their computers, even if they are connected to the Internet. They are prevented from connecting to the Microsoft servers that host the Windows Online Troubleshooting Service.|
|Troubleshooting and Diagnostics\ Windows Boot Performance Diagnostics|Configure Scenario Execution Level| N/A |**Disabled** (Determines the execution level for Windows Boot Performance Diagnostics. If you disable this policy setting, Windows will not be able to detect, troubleshoot or resolve any Windows Boot Performance problems that are handled by the DPS.)<p>This setting can be very useful during design, test, development, or maintenance phases. This setting could be enabled on an isolated VM or session host, measurements taken, and results noted in event logs under "Microsoft-Windows-Diagnostics-Performance/Operational" Source: Diagnostics-Performance, Task Category "Boot Performance Monitoring."<p>**ALSO**: With the DPS service disabled, this setting has no effect, as Windows will not be logging performance data.|
|Troubleshooting and Diagnostics\ Windows Memory Leak Diagnostics|Configure Scenario Execution Level| N/A |**Disabled** (This policy setting determines whether Diagnostic Policy Service (DPS) diagnoses memory leak problems. With this setting disabled, the DPS is not able to diagnose memory leak problems.) <p>Many diagnostics modes can be enabled, and tools used such as WPT, though these are usually done in dev/test/maintenance scenarios and not enabled and used on production VMs or sessions|
|Troubleshooting and Diagnostics\ Windows Performance PerfTrack|Enable/Disable PerfTrack| N/A |**Disabled** (This policy setting specifies whether to enable or disable tracking of responsiveness events. With this setting disabled, responsiveness events are not processed.)|
|Troubleshooting and Diagnostics\ Windows Resource Exhaustion Detection and Resolution|Configure Scenario Execution Level| N/A |**Disabled** (Determines the execution level for Windows Resource Exhaustion Detection and Resolution. With this setting disabled, Windows will not be able to detect, troubleshoot or resolve any Windows Resource Exhaustion problems that are handled by the DPS.)|
|Troubleshooting and Diagnostics\ Windows Shutdown Performance Diagnostics|Configure Scenario Execution Level| N/A |**Disabled** (Determines the execution level for Windows Shutdown Performance Diagnostics. With this setting disabled, Windows will not be able to detect, troubleshoot or resolve any Windows Shutdown Performance problems that are handled by the DPS.)|
|Troubleshooting and Diagnostics\ Windows Standby/Resume Performance Diagnostics|Configure Scenario Execution Level| N/A |**Disabled** (Determines the execution level for Windows Standby/Resume Performance Diagnostics. With this setting disabled, Windows will not be able to detect, troubleshoot or resolve any Windows Standby/Resume Performance problems that are handled by the DPS.)|
|Troubleshooting and Diagnostics\ Windows System Responsiveness Performance Diagnostics|Configure Scenario Execution Level| N/A |**Disabled** (Determines the execution level for Windows System Responsiveness Diagnostics. With this setting disabled, Windows will not be able to detect, troubleshoot or resolve any Windows System Responsiveness problems that are handled by the DPS.)|
*User Profiles|Turn off the advertising ID| N/A |**Enabled** (With this setting enabled, the advertising ID is turned off. Apps can't use the ID for experiences across apps)|
|Local Computer Policy \ Computer Configuration \ Administrative Templates \ Windows Components| N/A | N/A | N/A |
|*App Privacy|Let Windows apps access diagnostic information about other apps|Default for all apps: Force Deny|**Enabled** (With this setting enabled, and using the "Force Deny" option, Windows apps are not allowed to get diagnostic information about other apps and employees in your organization cannot change it.)|
|*App Privacy|Let Windows apps access location|Default for all apps: Force Deny|**Enabled** (With this setting enabled, and using the "Force Deny" option, Windows apps are not allowed to access location and users cannot change the setting.|
|*App Privacy|Let Windows apps access motion|Default for all apps: Force Deny|**Enabled** (With this setting enabled, and using the "Force Deny" option, Windows apps are not allowed to access motion data and users cannot change the setting.)|
|*App Privacy|Let Windows apps access notifications|Default for all apps: Force Deny|**Enabled** (With this setting enabled, and using the "Force Deny" option, Windows apps are not allowed to access notifications and users cannot change the setting)|
|*App Privacy|Let Windows apps activate with voice|Default for all apps: Force Deny|**Enabled** (This policy setting specifies whether Windows apps can be activated by voice.)|
|*App Privacy|Let Windows apps activate with voice while the system is locked|Default for all apps: Force Deny|**Enabled** (This policy setting specifies whether Windows apps can be activated by voice while the system is locked.)|
|*App Privacy|Let Windows apps control radios|Default for all apps: Force Deny|**Enabled** (If you choose the "Force Deny" option, Windows apps will not have access to control radios and employees in your organization cannot change it)|
|Application Compatibility|Turn off Inventory Collector| N/A |**Enabled** (This policy setting controls the state of the Inventory Collector. The Inventory Collector inventories applications, files, devices, and drivers on the system and sends the information to Microsoft. With this policy setting enabled, the Inventory Collector will be turned off and data will not be sent to Microsoft. Collection of installation data through the Program Compatibility Assistant is also disabled.)|
|AutoPlay Policies|Set the default behavior for AutoRun|Do not execute any autorun commands|**Enabled** (This policy setting sets the default behavior for Autorun commands.)|
|*AutoPlay Policies|Turn off Autoplay|All drives|**Enabled** (If you enable this policy setting, Autoplay is disabled on all drives.)|
|*Cloud Content|Do not show Windows tips| N/A |**Enabled** (This policy setting prevents Windows tips from being shown to users)|
|*Cloud Content|Turn off Microsoft consumer experiences| N/A |**Enabled** (With this policy setting enabled, users will no longer see personalized recommendations from Microsoft and notifications about their Microsoft account)|
|*Data Collection and Preview Builds|Allow Telemetry|0 – Security [Enterprise Only]|**Enabled** (Setting a value of 0 applies to devices running Enterprise, Education, IoT, or Windows Server editions only, and reduces telemetry sent to the most basic level supported)|
|Data Collection and Preview Builds|Configure collection of browsing data for Desktop Analytics|Configure telemetry collection: Do not allow sending intranet or internet history|**Enabled** (You can configure Microsoft Edge to send intranet history only, internet history only, or both to Desktop Analytics for enterprise devices with a configured Commercial ID. If disabled or not configured, Microsoft Edge does not send browsing history data to Desktop Analytics.)|
|*Data Collection and Preview Builds|Do not show feedback notifications| N/A |**Enabled** (This policy setting allows an organization to prevent its devices from showing feedback questions from Microsoft.)|
|Delivery Optimization|Download Mode|Download Mode: Simple (99)|**Enabled** (99 = Simple download mode with no peering. Delivery Optimization downloads using HTTP only and does not attempt to contact the Delivery Optimization cloud services.)|
|Desktop Window Manager|Do not allow window animations| N/A |**Enabled** (This policy setting controls the appearance of window animations such as those found when restoring, minimizing, and maximizing windows. With this policy setting enabled, window animations are turned off.)|
|Desktop Window Manager|Use solid color for Start background| N/A |**Enabled** ((This policy setting controls the Start background visuals. With this policy setting enabled, the Start background will use a solid color.)|
|Edge UI|Allow edge swipe| N/A |**Disabled** (If you disable this policy setting, users will not be able to invoke any system UI by swiping in from any screen edge.)|
|Edge UI|Disable help tips| N/A |**Enabled** (If this setting is enabled, Windows will not show any help tips to the user.)|
|File Explorer|Do not show the "new application installed" notification| N/A |**Enabled** (This policy removes the end-user notification for new application associations. These associations are based on file types (for example, TXT files) or protocols (for example, HTTP). If this policy is enabled, no notifications will be shown to the end-user)|
|File History|Turn off File History| N/A |**Enabled** (With this policy setting enabled, File History cannot be activated to create regular, automatic backups.)|
|*Find My Device|Turn On/Off Find My Device| N/A |**Disabled** (When Find My Device is off, the device and its location are not registered, and the "Find My Device" feature will not work. The user will also not be able to view the location of the last use of their active digitizer on their device.)|
|Homegroup|Prevent the computer from joining a homegroup| N/A |**Enabled** (If you enable this policy setting, users cannot add computers to a homegroup. This policy setting does not affect other network sharing features.)|
|*Internet Explorer|Allow Microsoft services to provide enhanced suggestions as the user types in the Address bar| N/A |**Disabled** (users won't receive enhanced suggestions while typing in the Address bar. In addition, users won't be able to change the Suggestions setting)|
|Internet Explorer|Disable Periodic Check for Internet Explorer software updates| N/A |**Enabled** (Prevents Internet Explorer from checking whether a new version of the browser is available.)|
|Internet Explorer|Disable showing the splash screen| N/A |**Enabled** (Prevents the Internet Explorer splash screen from appearing when users start the browser.)|
|Internet Explorer|Install new versions of Internet Explorer automatically| N/A |**Disabled** (This policy setting configures Internet Explorer to automatically install new versions of Internet Explorer when they are available.)|
|Internet Explorer|Prevent participation in the Customer Experience Improvement Program| N/A |**Enabled** (This policy setting prevents the user from participating in the Customer Experience Improvement Program (CEIP).)|
|Internet Explorer|Prevent running First Run wizard|Go directly to home page|**Enabled** (This policy setting prevents Internet Explorer from running the First Run wizard the first time a user starts the browser after installing Internet Explorer or Windows.)|
|Internet Explorer|Set tab process growth|Low|**Enabled** (This policy setting allows you to set the rate at which Internet Explorer creates new tab processes.)|
|Internet Explorer|Turn off add-on performance notifications| N/A |**Enabled** (This policy setting prevents Internet Explorer from displaying a notification when the average time to load all the user's enabled add-ons exceeds the threshold.)|
|Internet Explorer|Turn off Automatic Crash Recovery| N/A |**Enabled** (This policy setting turns off Automatic Crash Recovery. With this policy setting enabled, Automatic Crash Recovery does not prompt the user to recover his or her data after a program stops responding.)|
|*Internet Explorer|Turn off browser geolocation| N/A |**Enabled** (With this policy setting enabled, browser geolocation support is turned off)|
|*Internet Explorer|Turn on Suggested Sites| N/A |**Disabled** (With this policy setting disabled, the entry points and functionality associated with this feature are turned off.)|
|Internet Explorer\ Internet Control Panel\ Advanced Page|Play animations in web pages| N/A |**Disabled** (This policy setting allows you to manage whether Internet Explorer will display animated pictures found in Web content. Generally only animated GIF files are affected by this setting; active Web content such as java applets are not.)|
|Internet Explorer\  Internet Control Panel\ Advanced Page|Play sounds in web pages| N/A |**Disabled** (With this policy setting disabled, Internet Explorer will not play or download sounds in Web content, helping pages display more quickly.)|
|Internet Explorer\  Internet Control Panel\ Advanced Page|Play videos in web pages| N/A |**Disabled** (If you disable this policy setting, Internet Explorer will not play or download videos, helping pages display more quickly.)|
|Internet Explorer\  Internet Control Panel\ Advanced Page|Turn off loading websites and content in the background to optimize performance| N/A |**Enabled** (With this policy setting enabled, IE doesn’t load any websites or content in the background.)|
|*Internet Explorer\  Internet Control Panel\ Advanced Page|Turn off the flip ahead with page prediction features| N/A |**Enabled** (Microsoft collects your browsing history to improve how flip ahead with page prediction works. If you enable this policy setting, flip ahead with page prediction is turned off and the next webpage isn't loaded into the background.)|
|Internet Explorer\ Internet Settings\ Advanced Settings\ Browsing|Turn off phone number detection| N/A |**Enabled** (This policy setting determines whether phone numbers are recognized and turned into hyperlinks, which can be used to invoke the default phone application on the system. If you disable this policy setting, phone number detection is turned on. Users won't be able to modify this setting.)|
|Internet Information Services|Prevent IIS installation| N/A |**Enabled** (With this policy setting enabled, IIS cannot be installed, and you will not be able to install Windows components or applications that require IIS.)|
|*Location and Sensors|Turn off location| N/A |**Enabled** (With this setting enabled, the location feature is turned off, and all programs on this device are prevented from using location information from the location feature)|
|Location and Sensors|Turn off sensors| N/A |**Enabled** (This policy setting turns off the sensor feature for this device. With this policy setting enabled, the sensor feature is turned off, and all programs on this computer cannot use the sensor feature.)|
|Locations and Sensors / Windows Location Provider|Turn off Windows Location Provider| N/A |**Enabled** (This policy setting turns off the Windows Location Provider feature for this device.)|
|*Maps|Turn off Automatic Download and Update of Map Data| N/A |**Enabled** (With this setting enabled, the automatic download and update of map data is turned off.)|
|*Maps|Turn off unsolicited network traffic on the Offline Maps settings page| N/A |**Enabled** (With this setting enabled, features that generate network traffic on the Offline Maps settings page are turned off. Note: This may turn off the entire settings page)|
|*Messaging|Allow Message Service Cloud Sync| N/A |**Disabled** (This policy setting allows backup and restore of cellular text messages to Microsoft's cloud services.)|
|*Microsoft Edge|Allow configuration updates for the Books Library| N/A |**Disabled** (With this setting disabled, Microsoft Edge won't automatically download updated configuration data for the Books Library.)|
|*Microsoft Edge|Allow extended telemetry for the Books tab| N/A |**Disabled** (With this setting disabled, Microsoft Edge only sends basic telemetry data, depending on your device configuration.)|
|Microsoft Edge|Allow Microsoft Edge to pre-launch at Windows startup, when the system is idle, and each time Microsoft Edge is closed|Configure pre-launch: Prevent pre-launching|**Enabled** (With this setting enabled and configured to prevent pre-launch, Microsoft Edge won’t pre-launch during Windows sign in, when the system is idle, or each time Microsoft Edge is closed.)|
|Microsoft Edge|Allow Microsoft Edge to start and load the Start and New Tab page at Windows startup and each time Microsoft Edge is closed|Configure tab preloading: Prevent tab-preloading|**Enabled** (This policy setting lets you decide whether Microsoft Edge can load the Start and New Tab page during Windows sign in and each time Microsoft Edge is closed. By default this setting is to allow preloading. With preloading disabled, Microsoft Edge won’t load the Start or New Tab page during Windows sign in and each time Microsoft Edge is closed.)|
|Microsoft Edge|Allow web content on New Tab page| N/A |**Disabled** (With this setting disabled, Edge opens a new tab with a blank page. If this setting is configured, users cannot change the setting.)|
|*Microsoft Edge|Prevent the First Run webpage from opening on Microsoft Edge| N/A |**Enabled** (users won’t see the First Run page when opening Microsoft Edge for the first time)|
|OneDrive|Prevent OneDrive from generating network traffic until the user signs in to OneDrive| N/A |**Enabled** (Enable this setting to prevent the OneDrive sync client (OneDrive.exe) from generating network traffic (checking for updates, and so on.) until the user signs in to OneDrive or starts syncing files to the local computer)|
|Online Assistance|Turn off Active Help| N/A |**Enabled** (With this policy setting enabled, active content links are not rendered. The text is displayed, but there are no clickable links for these elements.)|
|OOBE|Don’t launch privacy settings experience on user logon| N/A |**Enabled** (When logging into a new user account for the first time or after an upgrade in some scenarios, that user may be presented with a screen or series of screens that prompts the user to choose privacy settings for their account. Enable this policy to prevent this experience from launching.)|
|RSS Feeds|Prevent automatic discovery of feeds and Web Slices| N/A |**Enabled** (This policy setting prevents users from having Internet Explorer automatically discover whether a feed or Web Slice is available for an associated webpage.)|
|*RSS Feeds|Turn off background synchronization for feeds and Web Slices| N/A |**Enabled** (With this policy setting enabled, the ability to synchronize feeds and Web Slices in the background is turned off.)|
|*Search|Allow Cortana| N/A |**Disabled** (This policy setting specifies whether Cortana is allowed on the device. When Cortana is off, users will still be able to use search to find things on the device.)|
|Search|Allow Cortana above lock screen| N/A |**Disabled** (This policy setting determines whether or not the user can interact with Cortana using speech while the system is locked.)|
|*Search|Allow search and Cortana to use location| N/A |**Disabled** (This policy setting specifies whether search and Cortana can provide location aware search and Cortana results.)|
|Search|Control rich previews for attachments|Control Rich Previews for Attachments:**.docx;.xlsx;.txt;.xls**|**Enabled** (Enabling this policy defines a semicolon-delimited list of file extensions which will be allowed to have rich attachment previews.)<p>**NOTE**: This setting can be used to limit what types of attachments are previewed, which can also help prevent automatically previewing some potentially dangerous contents types.|
|Search|Do not allow web search| N/A |**Enabled** (Enabling this policy removes the option of searching the Web from Windows Desktop Search.)|
|*Search|Don’t search the web or display web results in Search| N/A |**Enabled** (With this policy setting enabled, queries won't be performed on the web and web results won't be displayed when a user performs a query in Search.)|
|Search|Enable indexing uncached Exchange folders| N/A |**Disabled** (Enabling this policy allows indexing of mail items on a Microsoft Exchange server when Microsoft Outlook is not running in cached mode. The default behavior for search is to not index uncached Exchange folders. Disabling this policy will block any indexing of uncached Exchange folders.)|
|Search|Prevent indexing files in offline files cache| N/A |**Enabled** (If enabled, files on network shares made available offline are not indexed. Otherwise they are indexed. Disabled by default.)|
|*Search|Set what information is shared in Search|Anonymous info|**Enabled** (Anonymous info: Share usage information but don't share search history, Microsoft account info or specific location)|
|Search|Stop indexing in the event of limited hard drive space|MB Limit: **5000**|**Enabled** (Enabling this policy prevents indexing from continuing after less than the specified amount of hard drive space is left on the same drive as the index location. Select between 0 and 2147483647 MB.)|
|Software Protection Platform|Turn off KMS Client Online AVS Validation| N/A |**Enabled** (With this setting enabled, the device does not send data to Microsoft regarding its activation state)|
|*Speech|Allow Automatic Update of Speech Data| N/A |**Disabled** (Specifies whether the device will receive updates to the speech recognition and speech synthesis models.)|
|Store|Turn off the offer to update to the latest version of Windows| N/A |**Enabled** (Enables or disables the Store offer to update to the latest version of Windows. If you enable this setting, the Store application will not offer updates to the latest version of Windows.)|
|Text Input|Improve inking and typing recognition| N/A |**Disabled** (This policy setting controls the ability to send inking and typing data to Microsoft to improve the language recognition and suggestion capabilities of apps and services running on Windows.)|
|Windows Error Reporting|Disable Windows Error Reporting| N/A |**Enabled** (With this policy setting enabled, Windows Error Reporting does not send any problem information to Microsoft. Additionally, solution information is not available in Security and Maintenance in Control Panel.)|
|Windows Game Recording and Broadcasting|Enables or disables Windows Game Recording and Broadcasting| N/A |**Disabled** (With this setting disabled, Windows Game Recording will not be allowed.)|
|Windows Ink Workspace|Allow Windows Ink Workspace|Choose one of the following actions: Disabled|**Enabled** (With this setting enabled and sub-setting set to disabled, Windows Ink Workspace functionality is unavailable.)|
|Windows Installer|Control maximum size of baseline file cache|5|**Enabled** (This policy controls the percentage of disk space available to the Windows Installer baseline file cache. With this policy setting enabled you can modify the maximum size of the Windows Installer baseline file cache.)|
|Windows Installer|Turn off creation of System Restore checkpoints| N/A |**Enabled** (With this policy setting enabled, the Windows Installer does not generate System Restore checkpoints when installing applications.)|
|Windows Mobility Center|Turn off Windows Mobility Center| N/A |**Enabled** (With this policy setting enabled, the user is unable to invoke Windows Mobility Center. The Windows Mobility Center UI is removed from all shell entry points and the .exe file does not launch it.)|
|Windows Reliability Analysis|Configure Reliability WMI Providers| N/A |**Disabled** (With this policy setting disabled, Reliability Monitor will not display system reliability information, and WMI-capable applications will be unable to access reliability information from the listed providers.)|
|Windows Security \ Notifications|Hide non-critical notifications| N/A |**Enabled** (With this setting enabled, local users will only see critical notifications from Windows Security. They will not see other types of notifications, such as regular PC or device health information.)|
|Windows Update|Turn on Software Notifications| N/A |**Disabled** (This policy setting allows you to control whether users see detailed enhanced notification messages about featured software from the Microsoft Update service. Enhanced notification messages convey the value and promote the installation and use of optional software. This policy setting is intended for use in loosely managed environments in which you allow the end user access to the Microsoft Update service.)|
|*Windows Update\ Windows Update for Business|Manage preview builds|Set the behavior for receiving preview builds: **Disable preview builds**|**Enabled** (Selecting "Disable preview builds" will prevent preview builds from installing on the device. This will prevent users from opting into the Windows Insider Program, through Settings -> Update and Security)|
|*Windows Update\ Windows Update for Business|Select when Preview Builds and Feature Updates are received|Select the Windows readiness level for the updates you want to receive:<p>**Semi-Annual Channel**<p>After a Preview Build or Feature Update is released, defer receiving it for this many days: **365**<p>Pause Preview Builds or Feature Updates starting: **yyyy-mm-dd**|**Enabled** (Enable this policy to specify the level of Preview Build or Feature Updates to receive, and when. Semi-Annual Channel: Receive feature updates when they are released to the general public.<p> When Selecting Semi-Annual Channel:<p>- You can defer receiving Feature Updates for up to 365 days.<p>- To prevent Feature Updates from being received on their scheduled time, you can temporarily pause them. The pause will remain in effect for 35 days from the start time provided.<p> - To resume receiving Feature Updates which are paused, clear the start date field.)|
|Windows Update\ Windows Update for Business|Select when Quality Updates are received|After a quality update is released, defer receiving it for this many days: **30**<p>Pause Quality Updates starting: yyyy-mm-dd|**Enabled** (Enable this policy to specify when to receive quality updates.<p>You can defer receiving quality updates for up to 30 days.<p>To prevent quality updates from being received on their scheduled time, you can temporarily pause quality updates. The pause will remain in effect for 35 days or until you clear the start date field.<p>To resume receiving Quality Updates which are paused, clear the start date field.)<p>This recommendation is to help control when updates are applied, and to ensure updates don’t get offered and installed unexpectedly|
|Local Computer Policy \ User Configuration \ Administrative Templates| N/A | N/A | N/A |
|Control Panel\ Regional and Language Options|Turn off offer text predictions as I type| N/A |**Enabled** (This policy turns off the offer text predictions as I type option. This does not, however, prevent the user or an application from changing the setting programmatically. With this policy setting enabled, the option will be locked to not offer text predictions.)|
|Desktop|Do not add shares of recently opened documents to Network Locations| N/A |**Enabled** (With this setting enabled, shared folders are not added to Network Locations automatically when you open a document in the shared folder.)|
|Desktop|Turn off Aero Shake window minimizing mouse gesture| N/A |**Enabled** (Prevents windows from being minimized or restored when the active window is shaken back and forth with the mouse. With this policy enabled, application windows will not be minimized or restored when the active window is shaken back and forth with the mouse.)|
|Desktop / Active Directory|Maximum size of Active Directory searches|Number of objects returned:**1500**|**Enabled** (Specifies the maximum number of objects the system displays in response to a command to browse or search Active Directory. This setting affects all browse displays associated with Active Directory, such as those in Local Users and Groups, Active Directory Users and Computers, and dialog boxes used to set permissions for user or group objects in Active Directory.)|
|Start Menu and Taskbar|Do not display or track items in Jump Lists from remote locations| N/A |**Enabled** (This policy setting allows you to control displaying or tracking items in Jump Lists from remote locations.)|
|Start Menu and Taskbar|Do not search Internet| N/A |**Enabled** (With this policy setting enabled, the Start Menu search box will not search for internet history or favorites.)|
|Start Menu and Taskbar|Do not use the search-based method when resolving shell shortcuts| N/A |**Enabled** (This policy setting prevents the system from conducting a comprehensive search of the target drive to resolve a shortcut.)|
|Start Menu and Taskbar|Turn off all balloon notifications| N/A |**Enabled** (With this policy setting enabled, no notification balloons are shown to the user.)
|Start Menu and Taskbar|Turn off feature advertisement balloon notifications| N/A |**Enabled** (With this policy setting enabled, certain notification balloons that are marked as feature advertisements are not shown.)|
|Start Menu and Taskbar|Turn off user tracking| N/A |**Enabled** (With this policy setting enabled, the system does not track the programs that the user runs and does not display frequently used programs in the Start Menu.)|
|Start Menu and Taskbar / Notifications|Turn off toast notifications| N/A |**Enabled** (With this policy setting enabled, applications will not be able to raise toast notifications.)|
|*Start Menu and Taskbar / Notifications|Turn off toast notifications on the lock screen| N/A |**Enabled** (With this policy setting enabled, applications will not be able to raise toast notifications on the lock screen.)|
|Local Computer Policy / User Configuration| N/A | N/A | N/A |
|Windows Components / Cloud Content|Configure Windows spotlight on lock screen| N/A |**Disabled** (With this policy disabled, Windows spotlight will be turned off and users will no longer be able to select it as their lock screen. Users will see the default lock screen image and will be able to select another image, unless you have enabled the "Prevent changing lock screen image" policy.)|
|*Windows Components / Cloud Content|Do not suggest third-party content in Windows spotlight| N/A |**Enabled** (With this policy enabled, Windows spotlight features like lock screen spotlight, suggested apps in Start menu or Windows tips will no longer suggest apps and content from third-party software publishers. Users may still see suggestions and tips to make them more productive with Microsoft features and apps.)|
|Windows Components / Cloud Content|Do not use diagnostic data for tailored experiences| N/A |**Enabled** (With this policy setting enabled, Windows will not use diagnostic data from this device (this data may include browser, app and feature usage, depending on the "diagnostic data" setting value) to customize content shown on lock screen, Windows tips, Microsoft consumer features and other related features.)|
|Windows Components / Cloud Content|Turn off all Windows spotlight features| N/A |**Enabled** (Windows spotlight on lock screen, Windows tips, Microsoft consumer features and other related features will be turned off. You should enable this policy setting if your goal is to minimize network traffic from target devices.)|
|Edge UI|Turn off tracking of app usage| N/A |**Enabled** (This policy setting prevents Windows from keeping track of the apps that are used and searched most frequently. If you enable this policy setting, apps will be sorted alphabetically in:<p> - search results<p> - the Search and Share panes<p> - the drop-down app list in the Picker)|
|File Explorer|Turn off caching of thumbnail pictures| N/A |**Enabled** (With this policy setting enabled, thumbnail views are not cached.)|
|File Explorer|Turn off common control and window animations| N/A |**Enabled** (Disabling animations can improve usability for users with some visual disabilities as well as improving performance and battery life in some scenarios.)|
|File Explorer|Turn off display of recent search entries in the File Explorer search box| N/A |**Enabled** (Disables suggesting recent queries for the Search Box and prevents entries into the Search Box from being stored in the registry for future references.)|
|File Explorer|Turn off the caching of thumbnails in hidden thumbs.db files| N/A |**Enabled** (With this policy setting enabled, File Explorer does not create, read from, or write to thumbs.db files.)|

\* Comes from the [Windows Restricted Traffic Limited Functionality Baseline](https://go.microsoft.com/fwlink/?linkid=828887).

### System services

If you're considering disabling system services to conserve resources, make sure the service isn't a component of some other service. In this paper and with the available GitHub scripts, some services are not in the list because they cannot be disabled in a supported manner.

Most of these recommendations mirror recommendations for Windows Server 2016, installed with the Desktop Experience, based on the instructions in [Guidance on disabling system services on Windows Server 2016 with Desktop Experience](../../security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server.md).

Many services that may seem like good candidates to disable are set to manual service start type. This means that the service will not automatically start and is not started unless process or event triggers a request to the service being considered for disabling. Services that are already set to start type manual are usually not listed here.

> [!NOTE]
> You can enumerate running services with this PowerShell sample code, outputting only the service short name:
>
> ```powershell
> Get-Service | Where-Object {$_.Status -eq 'Running'} | Select-Object -ExpandProperty Name
> ```

The following table contains some services that may be considered to disable in virtual desktop environments:

| Windows Service | Service Name | Item | Comment|
| --------------- | ------------ | ---- | ------ |
|Cellular Time|autotimesvc|This service sets time based on NITZ messages from a Mobile Network|Virtual desktop environments may not have such devices available. <p>To learn more, see [this article](/windows-hardware/drivers/network/mb-nitz-support). |
|GameDVR and Broadcast user service|BcastDVRUserService|This (per-user) service is used for Game Recordings and Live Broadcasts|NOTE: This is a "per-user service", and as such, the template service must be disabled. This user service is used for Game Recordings and Live Broadcasts.<p>To learn more, see [this article](/windows-hardware/drivers/network/mb-nitz-support). |
|CaptureService|CaptureService|Enables optional screen capture functionality for applications that call the Windows.Graphics.Capture API.|OneCore capture service: enables optional screen capture functionality for applications that call the Windows.Graphics.Capture API<p>For more information, see [this article](/uwp/api/windows.graphics.capture?view=winrt-19041&preserve-view=true).|
|Connected Devices Platform Service|CDPSvc|This service is used for Connected Devices Platform scenarios|Connected Devices Platform Service <p>To learn more, see [this article](/openspecs/windows_protocols/ms-cdp/929c2238-6d49-4ba4-a36a-37e732c4f736)|
|CDP User Service|CDPUserSvc| N/A |Connected Devices Platform User Service. To learn more, see [this article](/openspecs/windows_protocols/ms-cdp/f5a15c56-ac3a-48f9-8c51-07b2eadbe9b4).<p>This user service is used for Connected Devices Platform scenarios <br><br>This is a "per-user service", and as such, the template service must be disabled (CDPUserSvc).|
|Optimize drives|defragsvc|Helps the computer run more efficiently by optimizing files on storage drives.|Virtual desktop solutions do not normally benefit from disk optimization. The "drives" are often not traditional drives and often just a temporary storage allocation.|
|Diagnostic Execution Service|DiagSvc|Executes diagnostic actions for troubleshooting support|Disabling this service disables the ability to run Windows diagnostics Diagnostic Execution Service.|
|Connected User Experiences and Telemetry|DiagTrack|This service enables features that support in-application and connected user experiences. Additionally, this service manages the event driven collection and transmission of diagnostic and usage information (used to improve the experience and quality of the Windows Platform) when the diagnostics and usage privacy option settings are enabled under Feedback and Diagnostics.|Consider disabling if on disconnected network. To learn more, see [this article](/windows/privacy/configure-windows-diagnostic-data-in-your-organization).|
|Diagnostic Policy Service|DPS|The Diagnostic Policy Service enables problem detection, troubleshooting and resolution for Windows components. If this service is stopped, diagnostics will no longer function.|Disabling this service disables the ability to run Windows diagnostics. For more information, see [this article](/uwp/api/Windows.System.Diagnostics?view=winrt-19041&preserve-view=true).|
|Device Setup Manager|DsmSvc|Enables the detection, download and installation of device-related software. |If this service is disabled, devices may be configured with outdated software, and may not work correctly. <p>Virtual desktop environments very closely control what software is installed and maintain that consistency across the environment.|
|Data Usage service|DusmSvc|Network data usage, data limit, restrict background data, metered networks.|For more information, see [this article](/uwp/schemas/mobilebroadbandschema/dusm/schema-root).|
|Windows Mobile Hotspot Service|icssvc|Provides the ability to share a cellular data connection with another device.|To learn more, see [this article](/uwp/api/Windows.Networking.NetworkOperators.NetworkOperatorTetheringAccessPointConfiguration?view=winrt-19041&preserve-view=true).|
|Microsoft Store Install Service|InstallService|Provides infrastructure support for the Microsoft Store. |This service is started on demand and if disabled then installations will not function properly.<p>Consider disabling this service on non-persistent virtual desktop, leave as-is for persistent virtual desktop solutions.|
|Geolocation Service|Lfsvc|Monitors the current location of the system and manages geofences (a geographical location with associated events). |If you turn off this service, applications will be unable to use or receive notifications for geolocation or geofences. To learn more, see [this article](/uwp/api/Windows.Devices.Geolocation?view=winrt-19041&preserve-view=true).|
|Downloaded Maps Manager|MapsBroker|Windows service for application access to downloaded maps. This service is started on-demand by application accessing downloaded maps.|Disabling this service will prevent apps from accessing maps. TO learn more, see [this article](/uwp/api/Windows.Services.Maps?view=winrt-19041&preserve-view=true).|
|MessagingService|MessagingService|Service supporting text messaging and related functionality.|This is a "per-user service", and as such, the template service must be disabled.|
|Sync Host|OneSyncSvc|This service synchronizes mail, contacts, calendar and various other user data. |(UWP) Mail and other applications dependent on this functionality will not work properly when this service is not running. <p>This is a "per-user service", and as such, the template service must be disabled.|
|Contact Data|PimIndexMaintenanceSvc|Indexes contact data for fast contact searching. If you stop or disable this service, contacts might be missing from your search results.|This is a "per-user service", and as such, the template service must be disabled.|
|Power|Power|Manages power policy and power policy notification delivery.|Virtual machines have virtually no influence on power properties. If this service is disabled, power management and reporting are not available. To learn more, see [this article](/windows-hardware/drivers/powermeter/user-mode-power-service).|
|Payments and NFC/SE Manager|SEMgrSvc|Manages payments and Near Field Communication (NFC) based secure elements.|May not need this service for payments, in the enterprise environment.|
|Microsoft Windows SMS Router Service|SmsRouter|Routes messages based on rules to appropriate clients.|May not need this service, if other tools are used for messaging, such as Teams, Skype, or other. To learn more, see [this article](/dotnet/framework/wcf/feature-details/routing-service).|
|Superfetch (SysMain)|SysMain|Maintains and improves system performance over time.|Superfetch generally does not improve performance in virtual desktop environments for various reasons. The underlying storage is often virtualized and possibly striped across multiple drives. In some virtual desktop solutions the accumulated user state is discarded when the user logs off. The SysMain feature should be evaluated in each environment.|
|Update Orchestrator Service|UsoSvc|Manages Windows Updates. If stopped, your devices will not be able to download and install the latest updates.|Virtual desktop devices are often carefully managed with respect to updates. Servicing is usually performed during maintenance windows. In some cases, an update client may be utilized, such as SCCM. The exception would be security signature updates, that would be applied at any time, to any virtual desktop device, so as to maintain up-to-date signatures. If you disable this service, test to ensure that security signatures are still able to be installed.|
|Volume Shadow Copy|VSS|Manages and implements Volume Shadow Copies used for backup and other purposes. |If this service is stopped, shadow copies will be unavailable for backup and the backup may fail. If this service is disabled, any services that explicitly depend on it will fail to start. To learn more, see [this article](../../../WindowsServerDocs/storage/file-server/volume-shadow-copy-service.md).|
|Diagnostic System Host|WdiSystemHost|The Diagnostic System Host is used by the Diagnostic Policy Service to host diagnostics that need to run in a Local System context. If this service is stopped, any diagnostics that depend on it will no longer function.|Disabling this service disables the ability to run Windows diagnostics|
|Windows Error Reporting|WerSvc|Allows errors to be reported when programs stop working or responding and allows existing solutions to be delivered. Also allows logs to be generated for diagnostic and repair services. If this service is stopped, error reporting might not work correctly, and results of diagnostic services and repairs might not be displayed.|With virtual desktop environments, diagnostics are often performed in an "offline" scenario, and not in mainstream production. In addition, some customers disable WER anyway. WER incurs a tiny amount of resources for many different things, including failure to install a device, or failure to install an update. To learn more, see [this article](/windows/win32/wer/windows-error-reporting).|
|Windows Search|WSearch|Provides content indexing, property caching, and search results for files, e-mail, and other content.|Disabling this service prevents indexing of e-mail and other things. Test before disabling this service. To learn more, see [this article](/windows/win32/search/-search-3x-wds-overview#windows-search-service). |
|Xbox Live Auth Manager|XblAuthManager|Provides authentication and authorization services for interacting with Xbox Live. |If this service is stopped, some applications may not operate correctly.|
|Xbox Live Game Save|XblGameSave|This service syncs save data for Xbox Live save enabled games. |If this service is stopped, game save data will not upload to or download from Xbox Live.|
|Xbox Accessory Management Service|XboxGipSvc|This service manages connected Xbox Accessories.| N/A |
|Xbox Live Networking Service|XboxNetApiSvc|This service supports the Windows.Networking.XboxLive application programming interface.| N/A |

#### Per-user services in Windows

Per-user services are services that are created when a user signs into Windows or Windows Server and are stopped and deleted when that user signs out. These services run in the security context of the user account - this provides better resource management than the previous approach of running these kinds of services in Explorer, associated with a preconfigured account, or as tasks. For more information, see [Per-user services in Windows](/windows/application-management/per-user-services-in-windows).

If you intend to change a service start value, the preferred method is to open an elevated .CMD prompt and run the Service Control Manager tool `SC.EXE`. For more information, see [SC](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc754599(v=ws.11)).

### Scheduled tasks

Like other items in Windows, ensure an item is not needed before disabling a scheduled task. Some tasks in virtual desktop environments, such as **StartComponentCleanup**, may not be desirable to run in production, but may be good to run during a maintenance window on the "gold image" (reference image).

The following list of tasks includes tasks that perform optimizations or data collections on computers that maintain their state across reboots. When a virtual desktop device reboots and discards all changes since last boot, optimizations intended for physical computers are not helpful.

You can get all the current scheduled tasks, including descriptions, with the following PowerShell code:

```powershell
  Get-ScheduledTask | Select-Object -Property TaskPath,TaskName,State,Description
```

> [!NOTE]
> There are several tasks that can't be disabled with a script, even when run on an elevated command prompt. The recommendations here, and in the GitHub scripts do not attempt to disable tasks that cannot be disabled with a script.

|Scheduled Task Name|Description|
|-------------------|-----------|
|MNO|Mobile broadband account experience metadata parser|
|AnalyzeSystem|This task analyzes the system looking for conditions that may cause high energy use|
|Cellular|Related to cellular devices|
|Compatibility|Collects program telemetry information if opted-in to the Microsoft Customer Experience Improvement Program.|
|Consolidator|If the user has consented to participate in the Windows Customer Experience Improvement Program, this job collects and sends usage data to Microsoft|
|Diagnostics|(DiskFootprint in task path) 'DiskFootprint' is the combined contribution of all processes that issue storage I/O in the form of storage reads, writes, and flushes.|
|FamilySafetyMonitor|Initializes Family Safety monitoring and enforcement.|
|FamilySafetyRefreshTask|Synchronizes the latest settings with the Microsoft family features service.|
|MapsToastTask|This task shows various Map-related toasts|
|Microsoft-Windows-DiskDiagnosticDataCollector|The Windows Disk Diagnostic reports general disk and system information to Microsoft for users participating in the Customer Experience Program.|
|NotificationTask|Background task for performing per user and web interactions|
|ProcessMemoryDiagnosticEvents|Schedules a memory diagnostic in response to system events|
|Proxy|This task collects and uploads autochk SQM data if opted-in to the Microsoft Customer Experience Improvement Program.|
|QueueReporting|Windows Error Reporting task to process queued reports.|
|RecommendedTroubleshootingScanner|Check for recommended troubleshooting from Microsoft|
|RegIdleBackup|Registry Idle Backup Task|
|RunFullMemoryDiagnostic|Detects and mitigates problems in physical memory (RAM).|
|Scheduled|The Windows Scheduled Maintenance Task performs periodic maintenance of the computer system by fixing problems automatically or reporting them through Security and Maintenance.|
|ScheduledDefrag|This task optimizes local storage drives.|
|SilentCleanup|Maintenance task used by the system to launch a silent auto disk cleanup when running low on free disk space.|
|SpeechModelDownloadTask|
|Sqm-Tasks|This task gathers information about the Trusted Platform Module (TPM), Secure Boot, and Measured Boot.|
|SR|This task creates regular system protection points.|
|StartComponentCleanup|Servicing task that may be better performed during maintenance windows|
|StartupAppTask|Scans startup entries and raises notification to the user if there are too many startup entries.|
|SyspartRepair|
|WindowsActionDialog|Location Notification|
|WinSAT|Measures a system's performance and capabilities|
|XblGameSaveTask|Xbox Live GameSave standby task|

### Apply Windows (and other) updates

Whether from Microsoft Update, or from your internal resources, apply available updates including Windows Defender signatures. This is a good time to apply other available updates including Microsoft Office if installed, and other software updates. If PowerShell will remain in the image you can download the latest available help for PowerShell by running the command `Update-Help`.

#### Servicing OS and apps

At some point during the image optimization process available Windows updates should be applied. There is a setting in Windows 10 update settings that can provide additional updates. You can find it at **Settings** > **Advanced options**. Once there, set **Give me updates for other uMirosoft products when I update Windows** to **On**.

![A screenshot of the advanced options menu. The "Give me updates for other Microsoft products" setting is turned on.](media/rds-vdi-recommendations-1909/servicing.png)

This would be a good setting in case you are going to install Microsoft applications such as Microsoft Office to the base image. That way Office is up to date when the image is put in service. There are also .NET updates and certain third-party components such as Adobe that have updates available through Windows Update.

One very important consideration for non-persistent virtual desktop devices is security updates, including security software definition files. These updates may be released once or more times per day.

For Windows Defender it may be best to allow the updates to occur, even on non-persistent virtual desktop environments. The updates are going to apply nearly every time you sign in, but the updates are small and should not be a problem. Plus, the device won’t be behind on updates because only the latest available will apply. The same may be true for third-party definition files.

>[!NOTE]
> Store apps (UWP apps) update through the Windows Store. Modern versions of Office such as Office 365 update through their own mechanisms when directly connected to the Internet, or through management technologies when not.

#### Windows system startup event traces (AutoLoggers)

Windows is configured by default to collect and save diagnostic data. The purpose is to enable diagnostics, or to record data if further troubleshooting is necessary. Automatic system traces can be found at the location depicted in the following illustration:

![A screenshot of the computer management folder. The System Traces folder is open and the WiFi Session file is selected.](media/rds-vdi-recommendations-1909/system-traces.png)

Some of the traces displayed under **Event Trace Sessions** and **Startup Event Trace Sessions** can't and should not be stopped. Others, such as the WiFiSession trace can be stopped. To stop a running trace under **Event Trace Sessions**, right-click the trace and then select **Stop**. Use the following procedure to prevent the traces from starting automatically on startup:

1. Select the **Startup Event Trace Sessions** folder.

2. Find and select the trace file you want to look at to open it.

3. Select the **Trace Session** tab.

4. Uncheck the box labeled **Enabled**.

5. Select **Ok**.

The following table lists some system traces that you should consider disabling in your virtual desktop environments:

|Name|Comment|
|---|--------|
|Cellcore|Documented [here](/windows-hardware/drivers/network/cellular-architecture-and-driver-model)|
|CloudExperienceHostOOBE|Documented [here](/windows/security/identity-protection/hello-for-business/hello-how-it-works-technology#cloud-experience-host).|
|DiagLog|A log generated by the Diagnostic Policy Service, which is documented [here](../../security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server.md)|
|RadioMgr|Documented [here](/windows-hardware/drivers/nfc/what-s-new-in-nfc-device-drivers)|
|ReadyBoot|Documentation [here](/previous-versions/windows/desktop/xperf/readyboot-analysis).|
|WDIContextLog|Wireless Local Area Network (WLAN) Device Driver Interface, and is documented here. |
|WiFiDriverIHVSession|Documented [here](/windows-hardware/drivers/network/user-initiated-feedback-normal-mode).|
|WiFiSession|Diagnostic log for WLAN technology. If Wi-Fi isn't implemented, there's no need for this logger|
|WinPhoneCritical|Diagnostic log for phone (Windows?). If not using phones, no need for this logger|

#### Windows Defender optimization in the virtual desktop environment

For greater details about how to optimize Windows Defender in a virtual desktop environment, check out the [Deployment guide for Windows Defender Antivirus in a virtual desktop infrastructure (VDI) environment](/windows/security/threat-protection/windows-defender-antivirus/deployment-vdi-windows-defender-antivirus).

The above article contains procedures to service the "gold" virtual desktop image, and how to maintain the virtual desktop clients as they are running. To reduce network bandwidth when virtual desktop devices need to update their Windows Defender signatures, stagger reboots, and schedule reboots during off hours where possible. The Windows Defender signature updates can be contained internally on file shares, and where practical, have those files shares on the same or close networking segments as the virtual desktop devices.

#### Client network performance tuning by registry settings

There are some registry settings that can increase network performance. This is especially important in environments where the virtual desktop device or physical computer has a workload that is primarily network-based. The settings in this section are recommended to tune performance for the networking workload profile, by setting up additional buffering and caching of things like directory entries and so on.

> [!NOTE]
> Some settings in this section are registry-based only and should be incorporated in the base image before the image is deployed for production use.

The following settings are documented in the [Performance tuning guidelines for Windows Server 2016](../../administration/performance-tuning/index.md).

#### DisableBandwidthThrottling

`HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DisableBandwidthThrottling`

Applies to Windows 10. The default is **0**. By default, the SMB redirector throttles throughput across high-latency network connections, in some cases to avoid network-related timeouts. Setting this registry value to **1** disables this throttling, enabling higher file transfer throughput over high-latency network connections. Consider setting this value to **1**.

#### FileInfoCacheEntriesMax

`HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileInfoCacheEntriesMax`

Applies to Windows 10. The default is **64**, with a valid range of 1 to 65536. This value is used to determine the amount of file metadata that can be cached by the client. Increasing the value can reduce network traffic and increase performance when many files are accessed. Try increasing this value to **1024**.

#### DirectoryCacheEntriesMax

`HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheEntriesMax`

Applies to Windows 10. The default is **16**, with a valid range of 1 to 4096. This value is used to determine the amount of directory information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when large directories are accessed. Consider increasing this value to **1024**.

#### FileNotFoundCacheEntriesMax

`HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileNotFoundCacheEntriesMax`

Applies to Windows 10. The default is **128**, with a valid range of 1 to 65536. This value is used to determine the amount of file name information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when many file names are accessed. Consider increasing this value to **2048**.

#### DormantFileLimit

`HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantFileLimit`

Applies to Windows 10. The default is **1023**. This parameter specifies the maximum number of files that should be left open on a shared resource after the application has closed the file. Where many thousands of clients are connecting to SMB servers, consider reducing this value to **256**.: Windows Server 2022, Windows Server 2019,

You can configure many of these SMB settings by using the [Set-SmbClientConfiguration](/powershell/module/smbshare/set-smbclientconfiguration?view=win10-ps&preserve-view=true) and [Set-SmbServerConfiguration](/powershell/module/smbshare/set-smbserverconfiguration?view=win10-ps&preserve-view=true) Windows PowerShell cmdlets. Registry-only settings can be configured by using Windows PowerShell as well, as in the following example:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecuritySignature -Value 0 -Force
```

#### Additional settings from the Windows Restricted Traffic Limited Functionality Baseline guidance

Microsoft has released a baseline, created using the same procedures as the [Windows Security Baselines](/windows/device-security/windows-security-baselines), for environments that are either not connected directly to the Internet, or wish to reduce data sent to Microsoft and other services.

The [Windows Restricted Traffic Limited Functionality Baseline](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services) settings are called out in the group policy table with an asterisk.

#### Disk cleanup (including using the Disk Cleanup Wizard)

Disk cleanup can be especially helpful with gold/master image virtual desktop implementations. After the gold/master image is prepared, updated, and configured, one of the last tasks to perform is disk cleanup. The optimization scripts on Github.com have PowerShell code to perform common disk cleanup tasks

> [!NOTE]
> Disk cleanup settings and are in the Settings category "System" called "Storage." By default, Storage Sense runs when a low disk free space threshold is reached.
>
> To learn more about how to use Storage Sense with Azure custom VHD images, see [Prepare and customize a master VHD image](/azure/virtual-desktop/set-up-customize-master-image).
>
> For Azure Virtual Desktop session host that use Windows 10 Enterprise or Windows 10 Enterprise multi-session, we recommend disabling Storage Sense. You can disable Storage Sense in the Settings menu under **Storage**.

Here are suggestions for various disk cleanup tasks. These should all be tested before implementing:

1. Storage Sense may be utilized manually or automatically. For more information on Storage Sense, see this article:
Use OneDrive and Storage Sense in Windows 10 to manage disk space
2. Manually cleanup temporary files and logs. From an elevated command prompt, run these commands:

   1. `Del C:\*.tmp /s`
   2. `C:\*.etl /s`
   3. `C:\*.evtx /s`

   ```powershell
   Get-ChildItem -Path c:\ -Include *.tmp, *.dmp, *.etl, *.evtx, thumbcache*.db, *.log -File -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -ErrorAction SilentlyContinue

   Remove-Item -Path $env:ProgramData\Microsoft\Windows\WER\Temp\* -Recurse -Force -ErrorAction SilentlyContinue

   Remove-Item -Path $env:ProgramData\Microsoft\Windows\WER\ReportArchive\* -Recurse -Force -ErrorAction SilentlyContinue

   Remove-Item -Path $env:ProgramData\Microsoft\Windows\WER\ReportQueue\* -Recurse -Force -ErrorAction SilentlyContinue

   Clear-RecycleBin -Force -ErrorAction SilentlyContinue

   Clear-BCCache -Force -ErrorAction SilentlyContinue
   ```

3. Delete any unused profiles on the system by running the following command:

    `wmic path win32_UserProfile where LocalPath="C:\\users\\<users>" Delete`

For any questions or concerns about the information in this paper, contact your Microsoft account team, research the [Microsoft virtual desktop IT Pro blog](https://community.windows.com/stories/virtual-desktop-windows-10), post a message to [Microsoft Virtual Desktop forums](https://techcommunity.microsoft.com/t5/windows-virtual-desktop/bd-p/WindowsVirtualDesktop), or contact [Microsoft](https://support.microsoft.com/contactus/) for questions or concerns.

### Re-enable Windows Update

If you would like to enable the use of Windows Update after disabling it, as in the case of persistent virtual desktop, follow these steps:

1. Re-enable group policy settings:

   - Go to **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **System** > **Internet Communication Management** > **Internet Communication settings**.
     - Turn off access to all Windows Update features by changing the setting from **enabled** to **not configured**.
   - Go to **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update**.
     - Remove access to all Windows Update features by changing the setting from **enabled** to **not configured**.
     - Don't connect to any Windows Update Internet locations by changing the setting from **enabled** to **not configured**.
   - Go to **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update** > **Windows Update for Business**.
     - Select when Quality Updates are received (change from **enabled** to **not configured**)
   - Go to **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update** > **Windows Update for Business**.
     - Select when Preview Builds and Feature Updates are received (change from **enabled** to **not configured**)

2. Re-enable service(s):

   - Change **Update Orchestrator service** from **disabled** to **Automatic (Delayed Start)**.

3. Edit the Windows registry (warning, be careful when editing the registry).

   - Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState`.
     - Change **DeferQualityUpdates** from '1' to '0'.
   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings`
     - Delete any existing value for **PausedQualityDate** .
   - Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU`
     - Set to **Disabled**.

4. Re-enable scheduled tasks:

   - Go to **Task Scheduler Library** > **Microsoft** > **Windows** > **InstallService** > **ScanForUpdates**.
   - Go to **Task Scheduler Library** > **Microsoft** > **Windows** > **InstallService** > **ScanForUpdatesAsUser**.

5. Restart your device to make all these settings take effect.

6. If you do not want this device offered Feature Updates, go to **Settings** > **Windows Update** > **Advanced options** > **Choose when updates are installed** and manually set the option **A feature update includes new capabilities and improvements. It can be deferred for this many days** to any non-zero value, such as 180, 365, and so on.

## Additional information

Learn more about Microsoft's VDI architecture at our [Azure Virtual Desktop documentation](https://azure.microsoft.com/services/virtual-desktop/).

If you need additional help with troubleshooting sysprep, check out [Sysprep fails after you remove or update Microsoft Store apps that include built-in Windows images](https://support.microsoft.com/help/2769827/sysprep-fails-after-you-remove-or-update-windows-store-apps-that-inclu).
