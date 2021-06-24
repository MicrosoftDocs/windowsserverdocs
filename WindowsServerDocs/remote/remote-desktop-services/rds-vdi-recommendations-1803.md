---
title: Optimizing Windows 10, version 1803, for a Virtual Desktop Infrastructure (VDI) role
description: Recommended settings and configuration to minimize overhead for Windows 10 1803) desktops used as VDI images
ms.author: robsmi
ms.topic: article
author: jaimeo
ms.date: 12/08/2020
---

# Optimizing Windows 10, version 1803, for a Virtual Desktop Infrastructure (VDI) role

This article helps you choose settings for Windows 10,  version 1803 (build 17134) that should result in the best performance in a Virtualized Desktop Infrastructure
(VDI) environment. All settings in this guide are *recommendations to be considered* and are in no way requirements.

In a VDI environment the key ways to optimize Windows 10 performance are to minimize app graphic redraws, background activities that have no major benefit to the VDI environment, and generally reduce running processes to the bare minimum. A secondary goal is to reduce disk space usage in the base image to the bare minimum. With VDI implementations, the smallest possible base, or “gold” image size, can slightly reduce memory usage on the hypervisor, as well as a small reduction in overall network operations required to deliver the desktop image to the consumer.

> [!NOTE]
> Settings recommended here can be applied to other installation of Windows 10, version 1803, including those on physical or other virtual devices. No recommendations in this topic should affect  the supportability of Windows 10, version 1803.

> [!TIP]
> A script that implements the optimizations discussed in this topic--as well as a GPO export file that you can import with **LGPO.exe**--is available at [TheVDIGuys](https://github.com//TheVDIGuys) on GitHub.

## VDI optimization principles

A VDI environment presents a full desktop session, including applications, to a computer user over a network. VDI environments usually use a base operating system image, which then becomes the basis for the desktops subsequently presented to the users for work. There are variations of VDI implementations such as “persistent”, “non-persistent”, and “desktop session.” The persistent type preserves changes to the VDI desktop operating system from one session to the next. The non-persistent type does not preserve changes to the VDI desktop operating system from one session to the next. To the user this desktop is little different than other virtual or physical device, other than it is accessed over a network.

The optimization settings would take place on a reference device. A VM is an ideal place to build the image, because you can save the state, make checkpoints and backups can be made, and other useful tasks. Start by installing default operating system on the base VM, and then optimize the base VM for VDI use by removing unneeded apps, installing Windows updates, installing other updates, deleting temporary files, applying settings, etc.

There are other types of VDI such as persistent and Remote Desktop Services (RDS). An in-depth discussion regarding these technologies is outside the scope of this topic, which focuses on the Windows base image settings with reference to other factors in the environment such as host optimization.

### Persistent VDI

Persistent VDI is, at the basic level, a VM that saves operating system state in between restarts. Other software layers of the VDI solution provide the users easy and seamless access to their assigned VMs, often with a single sign-on solution.

There are several different implementations of persistent VDI:

- Traditional virtual machine, where the VM has its own virtual disk file, starts up normally, saves changes from one session to the next, and is essentially just a normal VM. The difference is how the user accesses this VM. There might be a web portal the user logs into that automatically directs the user to their one or more assigned VDI VMs.

- Image-based persistent virtual machine, with personal virtual disks. In this type of implementation there is a base/gold image on one or more host servers. A VM is created, and one or more virtual disks are created and assigned to this disk for persistent storage.

    - When the VM is started, a copy of the base image is read into the memory of the VM. At the same time, a persistent virtual disk assigned to that VM, with any previous operating system changes merged through a complex process.

    - Changes such as event log writes, log writes, etc. are redirected to the read/write virtual disk assigned to that VM.

    - In this circumstance, operating system and app servicing might operate normally, using traditional servicing software such as Windows Server Update Services or other management technologies.

### Non-Persistent VDI

When a non-persistent VDI implementation is based on a base or “gold” image, the optimizations are mostly performed in the base image, and then through local settings and local policies.

With image-based non-persistent VDI, the base image is read-only. When a non-persistent VDI VM is started, a copy of the base image is streamed to the VM. Activity that occurs during startup and thereafter until the next reboot is redirected to a temporary location. Usually the users are provided network locations to store their data. In some cases, the user's profile is merged with the standard VM to provide the user their settings.

One important aspect of non-persistent  VDI that is based on a single image is servicing. Updates to the operating system are delivered usually once per month.
With image-based VDI, there is a set of processes to perform in order to get updates to the image:

- On a given host, all the VMs on that host that are derived from the base image must be shut down or turned off. This means the users are redirected to other VMs.

- The base image is then opened and started up. All maintenance activities are then performed, such as operating system updates, .NET updates, app updates, etc.

- Any new settings that need to be applied are applied at this time.

- Any other maintenance is performed at this time.

- The base image is then shut down.

- The base image is sealed and set to go back into production.

-Users are allowed to log back on.

> [!NOTE]
> Windows 10 performs a set of maintenance tasks automatically, on a periodic basis. There is a scheduled task that is set to run at 3:00 AM local time every day by default. This scheduled task performs a list of tasks, including Windows Update cleanup. You can view all the categories of maintenance that take place automatically with this PowerShell command:
>
>```powershell
>Get-ScheduledTask | ? {$_.Settings.MaintenanceSettings}
>```
>

One of the challenges with non-persistent VDI is that when a user logs off, nearly all the operating system activity is discarded. The user's profile and or state might be
saved, but the virtual machine itself discards nearly all changes that were made since the last boot. Therefore, optimizations intended for a Windows computer that saves state from one session to the next are not applicable.

Depending on the architecture of VDI VM, things like PreFetch and SuperFetch are not going to help from one session to the next, as all the optimizations are discarded on VM restart. Indexing might be a partial waste of resources, as would be any disk optimizations such as a traditional defragmentation.

### To Sysprep or not Sysprep

Windows 10 has a built-in capability called the [System Preparation Tool](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview), (often abbreviated to "Sysprep"). The Sysprep tool is used to prepare a customized Windows 10 image for duplication. The Sysprep process assures the resulting operating system is properly unique to run in production.
There are reasons for and against running Sysprep. In the case of VDI, you might want the ability to customize the default user profile which would be used as the profile template for subsequent users that log on using this image. You might have apps that you want installed, but also able to control per-app settings.

The alternative is to use a standard .ISO to install from, possibly using an unattended installation answer file, and a task sequence to install applications or remove applications. You can also use a task sequence to set local policy settings in the image, perhaps using the [Local Group Policy Object Utility (LGPO)](/archive/blogs/secguide/lgpo-exe-local-group-policy-object-utility-v1-0)
tool.

#### VDI Optimization Categories

- Global operating system settings

    - UWP app cleanup

    - Optional Features cleanup

    - Local policy settings

    - System services

    -   Scheduled tasks

    -   Apply Windows updates

    -   Automatic Windows traces

    -   Disk cleanup prior to finalizing (sealing) image

-   User settings

-   Hypervisor/Host settings

- [Tuning Windows 10 network performance by using registry settings](#tuning-windows-10-network-performance-by-using-registry-settings)

- Additional settings from the [Windows Restricted Traffic Limited Functionality Baseline](https://go.microsoft.com/fwlink/?linkid=828887)
    guidance.

- [Disk cleanup](#disk-cleanup-including-using-the-disk-cleanup-wizard)

### Universal Windows Platform app cleanup

One of the goals of a VDI image is to be as small as possible. One way to reduce the size of the image is to remove UWP applications that will not be used in the environment. With UWP apps, there are the main application files, also known as the payload. There is a small amount of data stored in each user's profile for application specific settings. There is also a small amount of data in the All Users profile.

Connectivity and timing are everything when it comes to UWP app cleanup. If you deploy your base image to either a device with no network connectivity, Windows 10 cannot connect to the Microsoft Store and download apps and try to install them while you are trying to uninstall them.

If you modify your base .WIM that you use to install Windows 10 and remove unneeded UWP apps from the .WIM before you install, the apps will not be installed to begin with and your profile creation times should be shorter. Later in this section, you'll find information on how to remove UWP apps from your installation .WIM file.

A good strategy for VDI is to provision the apps you want in the base image, then limit or block access to the Microsoft Store afterward. Store apps are updated periodically in the background on normal computers. The UWP apps can be updated during the maintenance window when other updates are applied.

#### Delete the payload of UWP apps

UWP apps that are not needed are still in the file system consuming a small amount of disk space. For apps that will never be needed, the payload of unwanted UWP apps can be removed from the base image using PowerShell commands.

In fact, if you remove those from the installation .WIM file using the links provided later in this section, you should be able to start from the beginning with a very slim list of UWP apps.

Run the following command to enumerate provisioned UWP apps from a running Windows 10 operating system, as in this truncated example output from PowerShell:

```powershell

    Get-AppxProvisionedPackage -Online

    DisplayName  : Microsoft.3DBuilder
    Version      : 13.0.10349.0
    Architecture : neutral
    ResourceId   : \~
    PackageName  : Microsoft.3DBuilder_13.0.10349.0_neutral_\~_8wekyb3d8bbwe
    Regions      :
```

UWP apps that are provisioned to a system can be removed during operating system installation as part of a task sequence, or later after the operating system is installed. This might be the
preferred method because it makes the overall process of creating or maintaining an image modular. Once you develop the scripts, if something changes in a subsequent build you edit an existing script rather than repeat the process from scratch. Here are some links to information on this topic:

[Removing Windows 10 in-box apps during a task sequence](/archive/blogs/mniehaus/removing-windows-10-in-box-apps-during-a-task-sequence)

[Removing Built-in apps from Windows 10 WIM-File with Powershell - Version 1.3](https://gallery.technet.microsoft.com/Removing-Built-in-apps-65dc387b)

[Windows 10 1607: Keeping apps from coming back when deploying the feature update](/archive/blogs/mniehaus/windows-10-1607-keeping-apps-from-coming-back-when-deploying-the-feature-update)

Then run the [Remove-AppxProvisionedPackage](/powershell/module/dism/remove-appxprovisionedpackage) PowerShell command to remove UWP app payloads:

```powershell
Remove-AppxProvisionedPackage -Online -PackageName
```

Each UWP app should be evaluated for applicability in each unique environment. You will want to install a default installation of Windows 10, version 1803, then note which apps are running and consuming memory. For example, you might want to consider removing apps that start automatically, or apps that automatically display information on the Start menu, such as Weather and News, and that might not be of use in your environment.

One of the "inbox" UWP apps called Photos, has a default setting called **Show a notification when new albums are available**.  The Photos app can use approximately 145 MB of memory; specifically private working set memory, even if not being used.  Changing the **Show a notification when new albums are available** setting for all users is not practical at this time, hence the recommendation to remove the Photos app if it is not needed or desired.

### Clean up optional features

#### Managing optional features with PowerShell

 To enumerate currently installed Windows Features, run this PowerShell command:

```powershell
Get-WindowsOptionalFeature -Online
```

You can enable or disable a specific Windows optional feature as in this example:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "DirectPlay"
```

For more about this, see the [Windows a PowerShell forum](/answers/topics/windows-server-powershell.ht).

#### Enable or disable Windows features by using DISM

You can use the built-in **Dism.exe** tool to enumerate and control Windows optional features. You can set up a Dism.exe script to run during a task sequence that installs the operating system.

### Local policy settings

Many optimizations for Windows 10 in a VDI environment can be made using Windows policy. The settings listed here can be applied locally to the base image. Then if the equivalent settings are not specified in any other way such as by group policy, the settings would still apply.

Some decisions might be based on the specifics of the environment, for example:

-   Is the VDI environment allowed to access the Internet?

-   Is the VDI solution persistent or non-persistent?

The following settings specifically do not counter or conflict with any setting that has anything to do with security. These settings were chosen to remove settings that might not be applicable to VDI environments.

> [!NOTE]
> In this table of group policy settings, items marked with an asterisk are from the [Windows Restricted Traffic Limited Functionality Baseline](https://go.microsoft.com/fwlink/?linkid=828887).

| Policy Setting | Item | Sub-item | Possible setting and comments |
|--|--|--|--|
| **Local Computer Policy \\ Computer Configuration \\ Windows Settings \\ Security Settings** |  |  |  |
| **Network List Manager Policies** | All Networks Properties | Network Location | User cannot change location |
| **Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Control Panel** |  |  |  |
| \***Control Panel** | Allow Online Tips |  | Disabled (Settings will not contact Microsoft content services to retrieve tips and help content) |
| **\*Control Panel**\\ Personalization | Do not display the lock screen |  | Enabled (This policy setting controls whether the lock screen appears for users. If you enable this policy setting, users that are not required to press CTRL + ALT + DEL before signing in will see their selected tile after locking their PC.) |
| **\*Control Panel**\\ Personalization | Force a specific default lock screen and logon image | [![Image of UI to set path to lock screen image](media/lock-screen-image-settings.png)](media/lock-screen-image-settings.png) | Enabled (This setting lets you specify the default lock screen and logon image shown when no user is signed in, and also sets the specified image as the default for all users--it replaces the default image.) A low resolution, non-complex image would cause less data transmitted over the network each time the image is rendered. |
| **\*Control Panel**\\ Regional and Language Options\\Handwriting personalization | Turn off automatic learning |  | Enabled (If you enable this policy setting, automatic learning stops, and any stored data is deleted. Users cannot configure this setting in Control Panel) |
| **Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Network** |  |  |  |
| **Background Intelligent Transfer Service (BITS)** | Do not allow the BITS client to use Windows Branch Cache |  | Enabled |
| **Background Intelligent Transfer Service (BITS)** | Do not allow the computer to act as a BITS Peercaching client |  | Enabled |
| **Background Intelligent Transfer Service (BITS)** | Do not allow the computer to act as a BITS Peercaching server |  | Enabled |
| **Background Intelligent Transfer Service (BITS)** | Allow BITS Peercaching |  | Disabled |
| **BranchCache** | Turn on BranchCache |  | Disabled |
| \***Fonts** | Enable Font Providers |  | Disabled (Windows does not connect to an online font provider and only enumerates locally installed fonts.) |
| **Hotspot Authentication** | Enable hotspot authentication |  | Disabled |
| **Microsoft Peer-to-Peer Networking Services** | Turn off Microsoft Peer-to-Peer Networking Services |  | Enabled |
| **Network Connectivity Status Indicator** (Note that there are other settings in this section that can be used in isolated networks) | Specify passive polling | Disable passive polling (checkbox) | Enabled (Use this setting if on an isolated network, or using static IP addresses.) |
| **Offline Files** | Allow or Disallow use of the Offline Files feature |  | Disabled |
| **\*TCPIP Settings**\\ IPv6 Transition Technologies | Set Teredo State | Disabled State | Enabled (In the disabled state no Teredo interfaces are present on the host.) |
| **\*WLAN Service**\\ WLAN Settings | Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services |  | Disabled (**Connect to suggested open hotspots**, **Connect to networks shared by my contacts**, and **Enable paid services** will be turned off and users on this device will be prevented from enabling them.) |
| **Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Start Menu and Taskbar** |  |  |  |
| \***Notifications** | Turn off notifications network usage |  | Enabled (If you enable this policy setting, applications and system features will not be able to receive notifications from the network from WNS or by using notification-polling APIs.) |
| **Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ System** |  |  |  |
| **Device Installation** | Do not send a Windows error report when a generic driver is installed on a device |  | Enabled |
| **Device Installation** | Prevent creation of a system restore point during device activity that would normally prompt creation of a restore point |  | Enabled |
| **Device Installation** | Prevent device metadata retrieval from the Internet |  | Enabled |
| **Device Installation** | Prevent Windows from sending an error report when a device driver requests additional software during installation |  | Enabled |
| **Device Installation** | Turn off **Found New Hardware** balloons during device installation |  | Enabled |
| **Filesystem**\\NTFS | Short name creation options | Disabled on all volumes | Enabled |
| \***Group Policy** | Configure web-to-app linking with app URL handlers |  | Disabled (Disables web-to-app linking and http(s) URIs will be opened in the default browser instead of starting the associated app.) |
| \***Group Policy** | Continue experiences on this device |  | Disabled (The Windows device is not discoverable by other devices, and cannot participate in cross-device experiences.) |
| **Internet Communication Management**\\ Internet Communication settings | Turn off access to all Windows Update features |  | Enabled (If you enable this policy setting, all Windows Update features are removed. This includes blocking access to the Windows Update website at https://windowsupdate.microsoft.com, from the Windows Update hyperlink on the Start menu, and also on the Tools menu in Internet Explorer. Windows automatic updating is also disabled; you will neither be notified about nor will you receive critical updates from Windows Update. This policy setting also prevents Device Manager from automatically installing driver updates from the Windows Update website.) |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Automatic Root Certificates Update |  | Enabled (If you enable this policy setting, when you are presented with a certificate issued by an untrusted root authority, your computer will not contact the Windows Update website to see if Microsoft has added the CA to its list of trusted authorities.)    **NOTE:** Only use this policy if you have an alternate means to the latest certificate revocation list. |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Event Viewer "Events.asp" links |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off handwriting personalization data sharing |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off handwriting recognition error reporting |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Help and Support Center "Did you know?" content |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Help and Support Center Microsoft Knowledge Base search |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Internet Connection wizard if URL connection is referring to Microsoft.com |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Internet download for Web publishing and online ordering wizards |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Internet File Association service |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Registration if URL connection is referring to Microsoft.com |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off the "Order Prints" picture task |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off the "Publish to Web" task for files and folders |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off the Windows Messenger Customer Experience Improvement Program |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Windows Customer Experience Improvement Program |  | Enabled |
| **\*Internet Communication Management**\\ Internet Communication settings | Turn off Windows Network Connectivity Status indicator active tests |  | Enabled (This policy setting turns off the active tests performed by the Windows Network Connectivity Status Indicator (NCSI) to determine whether your computer is connected to the Internet or to a more limited network As part of determining the connectivity level, NCSI performs one of two active tests: downloading a page from a dedicated Web server or making a DNS request for a dedicated address. If you enable this policy setting, NCSI does not run either of the two active tests. This might reduce the ability of NCSI, and of other components that use NCSI, to determine Internet access) NOTE: There are other policies that allow you to redirect NCSI tests to internal resources, if this functionality is desired. |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Windows Error Reporting |  | Enabled |
| **Internet Communication Management**\\ Internet Communication settings | Turn off Windows Update device driver searching |  | Enabled |
| **Logon** | Show first sign-in animation |  | Disabled |
| **Logon** | Turn off app notifications on the lock screen |  | Enabled |
| **Logon** | Turn off Windows Startup sound |  | Enabled |
| **Power Management** | Select an active power plan | High Performance | Enabled |
| **Recovery** | Allow restore of system to default state |  | Disabled |
| \***Storage Health** | Allow downloading updates to the Disk Failure Prediction Model |  | Disabled (Updates would not be downloaded for the Disk Failure Prediction Failure Model) |
| \***Windows Time Services**\\ Time Providers | Enable Windows NTP Client |  | Disabled (If you disable or do not configure this policy setting, the local computer clock does not synchronize time with NTP servers) **NOTE**: *Consider this setting very carefully*. Windows devices that are joined to a domain should use **NT5DS**. DC to parent domain DC might use NTP. PDCe role might use NTP. Virtual machines sometimes use “enhancements” or “integration services”. |
| **Troubleshooting and Diagnostics**\\ Scheduled Maintenance | Configure Scheduled Maintenance Behavior |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows Boot Performance Diagnostics | Configure Scenario Execution Level |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows Memory Leak Diagnostics | Configure Scenario Execution Level |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows Resource Exhaustion Detection and Resolution | Configure Scenario Execution Level |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows Shutdown Performance Diagnostics | Configure Scenario Execution Level |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows Standby/Resume Performance Diagnostics | Configure Scenario Execution Level |  | Disabled |
| **Troubleshooting and Diagnostics**\\ Windows System Responsiveness Performance Diagnostics | Configure Scenario Execution Level |  | Disabled |
| \***User Profiles** | Turn off the advertising ID |  | Enabled (If you enable this policy setting, the advertising ID is turned off. Apps can't use the ID for experiences across apps.) |
| **Local Computer Policy \\ Computer Configuration \\ Administrative Templates \\ Windows Components** |  |  |  |
| **Add features to Windows 10** | Prevent the wizard from running |  | Enabled |
| \***App Privacy** | Let Windows apps access account information | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access account information and employees in your organization cannot change it) |
| \***App Privacy** | Let Windows apps access call history | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access the call history and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access contacts | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access contacts and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access diagnostic information about other apps | Default for all apps: Force Deny | Enabled (If you disable or do not configure this policy setting, employees in your organization can decide whether Windows apps can get diagnostic information about other apps by using Settings \> Privacy on the device) |
| \***App Privacy** | Let Windows apps access email | Default for all apps: Force Deny | Enabled (If you choose the "Force Allow" option, Windows apps are allowed to access email and employees in your organization cannot change it) |
| \***App Privacy** | Let Windows apps access location | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access location and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access messaging | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access location and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access motion | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access motion data and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access notifications | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access notifications and employees in your organization cannot change it) |
| \***App Privacy** | Let Windows apps access Tasks | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access tasks and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access the calendar | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access the calendar and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access the camera | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access the camera and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access the microphone | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access the microphone and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access trusted devices | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to access trusted devices and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps communicate with unpaired devices | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to communicate with unpaired wireless devices and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps access radios | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps will not have access to control radios and employees in your organization cannot change it.) |
| **App Privacy** | Let Windows apps make phone calls | Default for all apps: Force Deny | Enabled (Windows apps are not allowed to make phone calls and employees in your organization cannot change it.) |
| \***App Privacy** | Let Windows apps run in the background | Default for all apps: Force Deny | Enabled (If you choose the **Force Deny** option, Windows apps are not allowed to run in the background and employees in your organization cannot change it.) |
| **AutoPlay Policies** | Set the default behavior for AutoRun | Do not execute any autorun commands | Enabled |
| \***AutoPlay Policies** | Turn off Autoplay |  | Enabled (If you enable this policy setting, Autoplay is disabled on CD-ROM and removable media drives, or disabled on all drives.) |
| \***Cloud Content** | Do not show Windows tips |  | Enabled (This policy setting prevents Windows tips from being shown to users.) |
| \***Cloud Content** | Turn off Microsoft consumer experiences |  | Enabled (If you enable this policy setting, users will no longer see personalized recommendations from Microsoft and notifications about their Microsoft account.) |
| \***Data Collection and Preview Builds** | Allow Telemetry | 0 – Security [Enterprise Only] | Enabled (Setting a value of 0 applies to devices running Enterprise, Education, IoT, or Windows Server editions only.) |
| \***Data Collection and Preview Builds** | Do not show feedback notifications |  | Enabled |
| \***Data Collection and Preview Builds** | Toggle user control over Insider builds |  | Disabled |
| **Delivery Optimization** | Download Mode | Download Mode: Simple (99) | 99 = Simple download mode with no peering. Delivery Optimization downloads using HTTP only and does not attempt to contact the Delivery Optimization cloud services. |
| **Desktop Window Manager** | Do not allow Flip3D invocation |  | Enabled |
| **Desktop Window Manager** | Do not allow window animations |  | Enabled |
| **Desktop Window Manager** | Use solid color for Start background |  | Enabled |
| **Edge UI** | Allow edge swipe |  | Disable |
| **Edge UI** | Disable help tips |  | Enabled |
| \***File Explorer** | Configure Windows Defender SmartScreen |  | Disabled (SmartScreen will be turned off for all users. Users will not be warned if they try to run suspicious apps from the Internet.) |
|  |  |  | **NOTE**: If not connected to the internet, this will prevent the computers from trying to contact Microsoft for SmartScreen information. |
| **File Explorer** | Do not show the **new application installed** notification |  | Enabled |
| \***Find My Device** | Turn On/Off Find My Device |  | Disabled (When Find My Device is off, the device and its location are not registered and the Find My Device feature will not work. The user will also not be able to view the location of the last use of their active digitizer on their device.) |
| **Game Explorer** | Turn off downloading of game information |  | Enabled |
| **Game Explorer** | Turn off game updates |  | Enabled |
| **Game Explorer** | Turn off tracking of last play time of games in the Games folder |  | Enabled |
| **Homegroup** | Prevent the computer from joining a homegroup |  | Enabled |
| \***Internet Explorer** | Allow Microsoft services to provide enhanced suggestions as the user types in the Address bar |  | Disabled (users won't receive enhanced suggestions while typing in the Address bar. In addition, users won't be able to change the Suggestions setting.) |
| **Internet Explorer** | Disable Periodic Check for Internet Explorer software updates |  | Enabled |
| **Internet Explorer** | Disable showing the splash screen |  | Enabled |
| **Internet Explorer** | Install new versions of Internet Explorer automatically |  | Disabled |
| **Internet Explorer** | Prevent participation in the Customer Experience Improvement Program |  | Enabled |
| **Internet Explorer** | Prevent running First Run wizard | Go directly to home page | Enabled |
| **Internet Explorer** | Set tab process growth | Low | Enabled |
| **Internet Explorer** | Specify default behavior for a new tab | New tab page | Enabled |
| **Internet Explorer** | Turn off add-on performance notifications |  | Enabled |
| \***Internet Explorer** | Turn off the auto-complete feature for web addresses |  | Enabled (If you enable this policy setting, user will not be suggested matches when entering Web addresses. The user cannot change the auto-complete for setting web addresses.) |
| \***Internet Explorer** | Turn off browser geolocation |  | Enabled (If you enable this policy setting, browser geolocation support is turned off.) |
| **Internet Explorer** | Turn off Reopen Last Browsing Session |  | Enabled |
| \***Internet Explorer** | Turn on Suggested Sites |  | Disabled (If you disable this policy setting, the entry points and functionality associated with this feature are turned off.) |
| **\*Internet Explorer**\\ Compatibility View | Turn off Compatibility View |  | Enabled (If you enable this policy setting, the user cannot use the Compatibility View button or manage the Compatibility View sites list.) |
| **Internet Explorer**\\ Internet Control Panel<strong>\\</strong> Advanced Page | Play animations in web pages |  | Disabled |
| **Internet Explorer**\\ Internet Control Panel\\ Advanced Page | Play videos in web pages |  | Disabled |
| **\*Internet Explorer**\\ Internet Control Panel\\ Advanced Page | Turn off the flip ahead with page prediction features |  | Enabled (Microsoft collects your browsing history to improve how flip ahead with page prediction works. This feature isn't available for Internet Explorer for the desktop. If you enable this policy setting, flip ahead with page prediction is turned off and the next webpage isn't loaded into the background.) |
| **Internet Explorer**\\ Internet Settings\\ Advanced Settings\\ Browsing | Turn off phone number detection |  | Enabled |
| **Internet Explorer**\\ Internet Settings\\ Advanced Settings\\ Multimedia | Allow Internet Explorer to play media files that use alternative codecs |  | Disabled |
| \***Location and Sensors** | Turn off location |  | Enabled (f you enable this policy setting, the location feature is turned off, and all programs on this computer are prevented from using location information from the location feature.) |
| **Location and Sensors** | Turn off sensors |  | Enabled |
| **Locations and Sensors /** Windows Location Provider | Turn off Windows Location Provider |  | Enabled |
| \***Maps** | Turn off Automatic Download and Update of Map Data |  | Enabled (If you enable this setting the automatic download and update of map data is turned off.) |
| \***Maps** | Turn off unsolicited network traffic on the Offline Maps settings page |  | Enabled (If you enable this policy setting, features that generate network traffic on the Offline Maps settings page are turned off. Note: This might turn off the entire settings page.) |
| \***Messaging** | Allow Message Service Cloud Sync |  | Disabled (This policy setting allows backup and restore of cellular text messages to Microsoft's cloud services.) |
| \***Microsoft Edge** | Allow Address bar drop-down list suggestions |  | Disabled |
| \***Microsoft Edge** | Allow configuration updates for the Books Library |  | Disabled (Turns off compatibility lists in Microsoft Edge.) |
| \***Microsoft Edge** | Allow Microsoft Compatibility List |  | Disabled (If you disable this setting, the Microsoft Compatibility List isn't used during browser navigation.) |
| \***Microsoft Edge** | Allow web content on New Tab page |  | Disabled (Directs Edge to open with blank content when a new tab is opened.) |
| \***Microsoft Edge** | Configure Autofill |  | Disabled (Disables autofill on address bar.) |
| \***Microsoft Edge** | Configure Do Not Track |  | Enabled (If you enable this setting, Do Not Track requests are always sent to websites asking for tracking info.) |
| \***Microsoft Edge** | Configure Password Manager |  | Disabled (If you disable this setting, employees can't use Password Manager to save their passwords locally.) |
| \***Microsoft Edge** | Configure search suggestions in Address bar |  | Disabled (Users can't see search suggestions in the Address bar of Microsoft Edge.) |
| \***Microsoft Edge** | Configure Start pages |  | Enabled (If you enable this setting, you can configure one or more Start pages. If this setting is enabled, you must also include URLs to the pages, separating multiple pages by using angle brackets in this format: \<support.contoso.com\>\<support.microsoft.com\> Windows 10, version 1703 or later: If you don't want to send traffic to Microsoft, you can use the \<about:blank\> value, which is honored for devices whether joined to a domain or not, when it's the only configured URL. |
| \***Microsoft Edge** | Configure Windows Defender SmartScreen |  | Disabled (Windows Defender SmartScreen is turned off and employees can't turn it on.) |
|  |  |  | **NOTE**: Consider this setting within the environment. If not connected to the Internet, this will prevent the computers from trying to contact Microsoft for SmartScreen information. |
| \***Microsoft Edge** | Prevent the First Run web page from opening on Microsoft Edge |  | **Enabled** (Users won't see the First Run page when opening Microsoft Edge for the first time.) |
| **OneDrive** | Prevent OneDrive from generating network traffic until the user signs in to OneDrive |  | **Enabled** (Enable this setting to prevent the OneDrive sync client (OneDrive.exe) from generating network traffic (checking for updates, etc.) until the user signs in to OneDrive or starts syncing files to the local computer.) |
| \***OneDrive** | Prevent the usage of OneDrive for file storage |  | **Enabled** (unless OneDrive is used on- or off-premises.) |
| **OneDrive** | Save documents to OneDrive by default |  | **Disabled** (unless OneDrive is used on- or off-premises.) |
| **RSS Feeds** | Prevent automatic discovery of feeds and Web Slices |  | **Enabled** |
| \***RSS Feeds** | Turn off background synchronization for feeds and Web Slices |  | **Enabled** (If you enable this policy setting, the ability to synchronize feeds and Web Slices in the background is turned off.) |
| \***Search** | Allow Cortana |  | **Disabled** (When Cortana is off, users will still be able to use search to find things on the device.) |
| **Search** | Allow Cortana above lock screen |  | **Disabled** |
| \***Search** | Allow search and Cortana to use location |  | **Disabled** |
| **Search** | Do not allow web search |  | **Enabled** |
| \***Search** | Don't search the web or display web results in Search |  | **Enabled** (If you enable this policy setting, queries won't be performed on the web and web results won't be displayed when a user performs a query in Search.) |
| **Search** | Prevent adding UNC locations to index from Control Panel |  | **Enabled** |
| **Search** | Prevent indexing files in offline files cache |  | **Enabled** |
| \***Search** | Set what information is shared in Search | Anonymous info | **Enabled** (Share usage information but don't share search history, Microsoft account info or specific location.) |
| \***Software Protection Platform** | Turn off KMS Client Online AVC Validation |  | **Enabled** (Enabling this setting prevents this computer from sending data to Microsoft regarding its activation state.) |
| \***Speech** | Allow Automatic Update of Speech Data |  | **Disabled** (will not periodically check for updated speech models) |
| \***Store** | Turn off Automatic Download and Install of updates |  | **Enabled** (If you enable this setting, the automatic download and installation of app updates is turned off.) |
| \***Store** | Turn off Automatic Download of updates on Win8 devices |  | **Enabled** (If you enable this setting, the automatic download of app updates is turned off.) |
| **Store** | Turn off the offer to update to the latest version of Windows |  | **Enabled** |
| \***Sync your settings** | Do not sync | Allow users to turn syncing on (not selected) | **Enabled** (If you enable this policy setting, "sync your settings" will be turned off, and none of the "sync your setting" groups will be synced on this device. |
| **Text Input** | Improve inking and typing recognition |  | **Disabled** |
| **Windows Defender Antivirus**\\ MAPS | Join Microsoft MAPS |  | **Disabled** (If you disable or do not configure this setting, you will not join Microsoft MAPS.) |
| **Windows Defender Antivirus**\\ MAPS | Send file samples when further analysis is required | Never send | **Enabled** (only if not opted-in for MAPS diagnostic data) |
| **Windows Defender Antivirus**\\ Reporting | Turn off enhanced notifications |  | **Enabled** (If you enable this setting, Windows Defender Antivirus enhanced notifications will not display on clients.) |
| **Windows Defender Antivirus**\\ Signature Updates | Define the order of sources for downloading definition updates | FileShares | **Enabled** (If you enable this setting, definition update sources will be contacted in the order specified. Once definition updates have been successfully downloaded from one specified source, the remaining sources in the list will not be contacted.) |
| **Windows Error Reporting** | Automatically send memory dumps for operating system-generated error reports |  | **Disabled** |
| **Windows Error Reporting** | Disable Windows Error Reporting |  | **Enabled** |
| **Windows Game Recording and Broadcasting** | Enables or disables Windows Game Recording and Broadcasting |  | **Disabled** |
| **Windows Installer** | Control maximum size of baseline file cache | 5 | **Enabled** |
| **Windows Installer** | Turn off creation of System Restore checkpoints |  | **Enabled** |
| **Windows Mail** | Turn off the communities feature |  | **Enabled** |
| **Windows Media Player** | Do Not Show First Use Dialog Boxes |  | **Enabled** |
| **Windows Media Player** | Prevent Media Sharing |  | **Enabled** |
| **Windows Mobility Center** | Turn off Windows Mobility Center |  | **Enabled** |
| **Windows Reliability Analysis** | Configure Reliability WMI Providers |  | **Disabled** |
| **Windows Update** | Allow Automatic Updates immediate installation |  | **Enabled** |
| **Windows Update** | Do not connect to any Windows Update Internet locations |  | **Enabled** (Enabling this policy will disable that functionality, and might cause connection to public services such as the Windows Store to stop working. **Note:** This policy applies only when this device is configured to connect to an intranet update service using the "Specify intranet Microsoft update service location" policy. |
| **Windows Update** | Remove access to all Windows Update features |  | **Enabled** |
| **\*Windows Update**\\ Windows Update for Business | Manage preview builds | Set the behavior for receiving preview builds: | **Enabled** (Selecting **Disable preview builds** will prevent preview builds from installing on the device. This will prevent users from opting into the Windows Insider Program, through Settings -\> Update and Security.) |
|  |  | Disable preview builds |  |
| **\*Windows Update**\\ Windows Update for Business | Select when Preview Builds and Feature Updates are received | Semi-Annual Channel | **Enabled** (Enable this policy to specify the level of Preview Build or feature updates to receive, and when.) |
|  |  | Deferment: 365 days, |  |
|  |  | Pause start: yyyy-mm-dd |  |
| **Windows Update**\\ Windows Update for Business | Select when Quality Updates are received | 1. 30 days 2. Pause quality updates starting yyyy-mm-dd | **Enabled** |
| **Windows Restricted Traffic Custom Policy Settings** | Prevent OneDrive from generating network traffic until the user signs in to OneDrive |  | **Enabled** (Enable this setting if you would like to prevent the OneDrive sync client (OneDrive.exe) from generating network traffic (checking for updates, etc.) until the user signs in to OneDrive or starts syncing files to the local computer.) |
| **Windows Restricted Traffic Custom Policy Settings** | Turn off Windows Defender Notifications |  | **Enabled** (If you enable this policy setting, Windows Defender will not send notifications with critical information about the health and security of your device.) |
| **Local Computer Policy \\ User Configuration \\ Administrative Templates** |  |  |  |
| **Control Panel**\\ Regional and Language Options | Turn off offer text predictions as I type |  | **Enabled** |
| **Desktop** | Do not add shares of recently opened documents to Network Locations |  | **Enabled** |
| **Desktop** | Turn off Aero Shake window minimizing mouse gesture |  | **Enabled** |
| **Desktop** / Active Directory | Maximum size of Active Directory searches | 2500 | **Enabled** |
| **Start Menu and Taskbar** | Do not allow pinning Store app to the Taskbar |  | **Enabled** |
| **Start Menu and Taskbar** | Do not display or track items in Jump Lists from remote locations |  | **Enabled** |
| **Start Menu and Taskbar** | Do not use the search-based method when resolving shell shortcuts |  | **Enabled** (The system does not conduct the final drive search. It just displays a message explaining that the file is not found.) |
| **Start Menu and Taskbar** | Remove the People Bar from the taskbar |  | **Enabled** (The people icon will be removed from the taskbar, the corresponding settings toggle is removed from the taskbar settings page, and users will not be able to pin people to the taskbar.) |
| **Start Menu and Taskbar** | Turn off feature advertisement balloon notifications |  | **Enabled** (Users cannot pin the Store app to the Taskbar. If the Store app is already pinned to the Taskbar, it will be removed from the Taskbar on next sign in.) |
| **Start Menu and Taskbar** | Turn off user tracking |  | **Enabled** |
| **Start Menu and Taskbar** / Notifications | Turn off toast notifications |  | **Enabled** |
| **Windows Components** / Cloud Content | Turn off all Windows spotlight features |  | **Enabled** |
| **Edge UI** | Turn off tracking of app usage |  | **Enabled** |
| **File Explorer** | Turn off caching of thumbnail pictures |  | **Enabled** |
| **File Explorer** | Turn off display of recent search entries in the File Explorer search box |  | **Enabled** |
| **File Explorer** | Turn off the caching of thumbnails in hidden thumbs.db file |  | **Enabled** |

### Notes about Network Connectivity Status indicator

The group policy settings above include settings to turn off checking to see if
the system is connected to the Internet. If your environment does not connect to
the Internet at all, or connects indirectly, you can set a group policy setting
to remove the Network icon from the Taskbar. The reason you might want to remove
the Network icon from the Taskbar is if you turn off Internet connectivity
checks, there will be a yellow flag on the Network icon, even though the network
might be functioning normally. If you would like to remove the network icon as a
group policy setting, you can find that in this location:

| Windows Update or Windows Update for Business | Select when Quality Updates are received | 1. 30 days 2. Pause quality updates starting yyyy-mm-dd | Enabled |
|--|--|--|--|
| **Local Computer Policy \\ User Configuration \\ Administrative Templates** |  |  |  |
| **Start Menu and Taskbar** | Remove the networking icon |  | **Enabled** (the networking icon is not displayed in the system notification area.) |

For more about the Network Connection Status Indicator
(NCSI), see: [The Network Connection Status icon](https://techcommunity.microsoft.com/t5/networking-blog/bg-p/NetworkingBlog)

### System services

If you are considering disabling system services to conserve resources, take great care that the service being considered is not in some way a component
of some other service.

Also, most of these recommendations mirror recommendations for Windows Server
2016 with Desktop Experience; for more information, see [Guidance on disabling system services in Windows Server 2016 with Desktop Experience](../../security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server.md).

Note that a lot of services that might seem to be good candidates to disable are set to manual service start type. This means that the service will not automatically start and is not started unless a specific application or service triggers a request to the service being consider for disabling. Services that are already set to start type manual are usually not listed here.

| Windows Service | Item | Comment |
|--|--|--|
| CDPUserService | This user service is used for Connected Devices Platform scenarios | NOTE: This is a per-user service, and as such, the *template service* must be disabled. |
| Connected User Experiences and Telemetry | Enables features that support in-application and connected user experiences. Additionally, this service manages the event-driven collection and transmission of diagnostic and usage information (used to improve the experience and quality of the Windows Platform) when the diagnostics and usage privacy option settings are enabled under Feedback and Diagnostics. | Consider disabling if on disconnected network |
| Contact Data | Indexes contact data for fast contact searching. If you stop or disable this service, contacts might be missing from your search results. | (PimIndexMaintenanceSvc) NOTE: This is a per-user service, and as such, the *template service* must be disabled. |
| Diagnostic Policy Service | Enables problem detection, troubleshooting and resolution for Windows components. If this service is stopped, diagnostics will no longer function. |  |
| Downloaded Maps Manager | Windows service for application access to downloaded maps. This service is started on-demand by application accessing downloaded maps. Disabling this service will prevent apps from accessing maps. |  |
| Geolocation Service | Monitors the current location of the system and manages geofences |  |
| GameDVR and Broadcast user service | This user service is used for Game Recordings and Live Broadcasts | NOTE: This is a per-user service, and as such, the template service must be disabled. |
| MessagingService | Service supporting text messaging and related functionality. | NOTE: This is a per-user service, and as such, the *template service* must be disabled. |
| Optimize drives | Helps the computer run more efficiently by optimizing files on storage drives. | VDI solutions do not normally benefit from disk optimization. These “drives” are not traditional drives and often just a temporary storage allocation. |
| Superfetch | Maintains and improves system performance over time. | Generally doesn't improve performance on VDI, especially non-persistent, given that the operating system state is discarded each reboot. |
| Touch Keyboard and Handwriting Panel Service | Enables Touch Keyboard and Handwriting Panel pen and ink functionality |  |
| Windows Error Reporting | Allows errors to be reported when programs stop working or responding and allows existing solutions to be delivered. Also allows logs to be generated for diagnostic and repair services. If this service is stopped, error reporting might not work correctly, and results of diagnostic services and repairs might not be displayed. | With VDI, diagnostics are often performed in an offline scenario, and not in mainstream production. And in addition, some customers disable WER anyway. WER incurs a tiny amount of resources for many different things, including failure to install a device, or failure to install an update. |
| Windows Media Player Network Sharing Service | Shares Windows Media Player libraries to other networked players and media devices using Universal Plug and Play | Not needed unless customers are sharing WMP libraries on the network. |
| Windows Mobile Hotspot Service | Provides the ability to share a cellular data connection with another device. |  |
| Windows Search | Provides content indexing, property caching, and search results for files, e-mail, and other content. | Probably not needed especially with non-persistent VDI |

#### Per-user services in Windows

[Per-user services](/windows/application-management/per-user-services-in-windows) are services that are created when a user signs into Windows or Windows Server and are stopped and deleted when that user signs out. These services run in the security context of the user account - this provides better resource management than the previous approach of running these kinds of services in Explorer, associated with a preconfigured account, or as tasks.

### Scheduled tasks

Like other items in Windows, ensure that an item is not needed before you consider disabling it.

The following list of tasks are those that perform optimizations or data collections on computers that maintain their state across reboots. When a VDI VM task reboots and discards all changes since last boot, optimizations intended for physical computers are not helpful.

You can get all of the current scheduled tasks, including descriptions, with the following PowerShell code:

`Get-ScheduledTask | Select-Object -Property TaskPath,TaskName,State,Description |Export-CSV -Path C:\Temp\W10_1803_SchTasks.csv -NoTypeInformation`

Valid **Scheduled Task Name** values include:

- OneDrive Standalone Update Task v2
- Microsoft Compatibility Appraiser
- ProgramDataUpdater
- StartupAppTask
- CleanupTemporaryState
- Proxy
- UninstallDeviceTask
- ProactiveScan
- Consolidator
- UsbCeip
- Data Integrity Scan
- Data Integrity Scan for Crash Recovery
- ScheduledDefrag
- SilentCleanup
- Microsoft-Windows-DiskDiagnosticDataCollector
- Diagnostics
- StorageSense
- DmClient
- DmClientOnScenarioDownload
- File History (maintenance mode)
- ScanForUpdates
- ScanForUpdatesAsUser
- SmartRetry
- Notifications
- WindowsActionDialog
- WinSAT Cellular
- MapsToastTask
- ProcessMemoryDiagnosticEvents
- RunFullMemoryDiagnostic
- MNO Metadata Parser
- LPRemove
- GatherNetworkInfo
- WiFiTask
- Sqm-Tasks
- AnalyzeSystem
- MobilityManager
- VerifyWinRE
- RegIdleBackup
- FamilySafetyMonitor
- FamilySafetyRefreshTask
- IndexerAutomaticMaintenance
- SpaceAgentTask
- SpaceManagerTask
- HeadsetButtonPress
- SpeechModelDownloadTask
- ResPriStaticDbSync
- WsSwapAssessmentTask
- SR
- SynchronizeTimeZone
- Usb-Notifications
- QueueReporting
- UpdateLibrary
- Scheduled Start
- sih
- XblGameSaveTask

### Apply Windows and other updates

Whether from Microsoft Update, or from your internal resources, apply available updates including Windows Defender signatures. This is a good time to apply other available updates including those for Microsoft Office if installed.

### Automatic Windows traces

Windows is configured, by default, to collect and save limited diagnostic data. The purpose is to enable diagnostics, or to record data in the event that further troubleshooting is necessary. You can find automatic system traces by starting the Computer Management app, and then expanding **System Tools**, **Performance**, **Data Collector Sets**, and then selecting **Event Trace Sessions**.

Some of the traces displayed under **Event Trace Sessions** and **Startup Event Trace Sessions** cannot and should not be stopped. Others, such as the **WiFiSession** trace can be stopped. To stop a running trace under **Event Trace Sessions** right-click the trace and then select **Stop**. To prevent the traces from starting automatically on startup, follow these steps:

1.  Select the **Startup Event Trace Sessions** folder

2.  Locate the trace of interest, and then double-click that trace.

3.  Select the **Trace Session** tab.

4.  Clear the box labeled **Enabled**.

5.  Select **OK**.

Here are some system traces to consider disabling for VDI use:

| Name | Comment |
|--|--|
| AppModel | A collection of traces, one of which is phone |
| CloudExperienceHostOOBE |  |
| DiagLog |  |
| NtfsLog |  |
| TileStore |  |
| UBPM |  |
| WiFiDriverIHVSession | If not using a WiFi device |
| WiFiSession |  |

#### Servicing the operating system and apps

At some point during the image optimization process available Windows updates should be applied. You can set Windows Update to install updates for other Microsoft products as well as Windows. To set this, open **Windows Settings**, then select **Update & Security**, and then select **Advanced options**. Select **Give me updates for other Microsoft products when I update Windows** to set it to **On**.

This would be a good setting in case you are going to install Microsoft applications such as Microsoft Office to the base image. That way Office is up to date when the image is put in service. There are also .NET updates and certain non-Microsoft components such as Adobe that have updates available through Windows Update.

One very important consideration for non-persistent VDI VMs are security updates, including security software definition files. These updates might be released once or even more than once per day. There might be a way to retain these updates, including Windows Defender and non-Microsoft components.

For Windows Defender it might be best to allow the updates to occur, even on non-persistent VDI. The updates are going to apply nearly every logon session, but the updates are small and should not be a problem. Plus, the VM won't be behind on updates because only the latest available will apply. The same might be true for non-Microsoft definition files.

> [!NOTE]
> Store apps (UWP apps) update through the Windows Store. Modern versions of Office such as Microsoft 365 update through their own mechanisms when directly connected to the Internet, or via management technologies when not.

### Windows Defender optimization with VDI

Microsoft has recently published documentation regarding Windows Defender in a VDI environment. See [Deployment guide for Windows Defender Antivirus in a virtual desktop infrastructure (VDI) environment](/windows/security/threat-protection/windows-defender-antivirus/deployment-vdi-windows-defender-antivirus) for details.

The above article contains procedures to service the gold VDI image, and how to maintain the VDI clients as they are running. To reduce network bandwidth when VDI computers need to update their Windows Defender signatures, stagger reboots, and schedule reboots during off hours where possible. The Windows Defender signature updates can be contained internally on file shares, and where
practical, have those files shares on the same or close networking segments as the VDI virtual machines.

See the paper listed at the beginning of this section for much more information about optimizing Windows Defender with VDI.

### Tuning Windows 10 network performance by using registry settings

This is especially important in environments where the VDI or physical computer has a workload that is primarily network based. The settings in this section bias performance to favor networking, by setting up additional buffering and caching of things like directory entries and so on.

Note that some settings in this section are *registry-based only* and should be incorporated in the base image before the image is deployed for production use.

The following settings are documented in the [Windows Server 2016 Performance Tuning Guideline](../../administration/performance-tuning/index.md)
information, published on Microsoft.com by the Windows Product Group.

#### DisableBandwidthThrottling

HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\DisableBandwidthThrottling

Applies to Windows 10. The default is **0**. By default, the SMB redirector throttles throughput across high-latency network connections, in some cases to avoid network-related timeouts. Setting this registry value to **1** disables this throttling, enabling higher file transfer throughput over high-latency network connections, so you should consider this setting.

#### FileInfoCacheEntriesMax

HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\FileInfoCacheEntriesMax

Applies to Windows 10. The default is **64**, with a valid range of 1 to 65536. This value is used to determine the amount of file metadata that can be cached by the client. Increasing the value can reduce network traffic and increase performance when many files are accessed. Try increasing this value to **1024**.

#### DirectoryCacheEntriesMax

HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\DirectoryCacheEntriesMax

Applies to Windows 10. The default is **16**, with a valid range of 1 to 4096. This value is used to determine the amount of directory information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when large directories are accessed. Consider increasing this value to **1024**.

#### FileNotFoundCacheEntriesMax

HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\FileNotFoundCacheEntriesMax

Applies to Windows 10. The default is **128**, with a valid range of 1 to 65536. This value is used to determine the amount of file name information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when many file names are accessed. Consider increasing this value to **2048**.

#### DormantFileLimit

HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters\\DormantFileLimit

Applies to Windows 10. The default is **1023**. This parameter specifies the maximum number of files that should be left open on a shared resource after the application has closed the file. Where many thousands of clients are connecting to SMB servers, consider reducing this value to **256**.

You can configure many of these SMB settings by using the [Set-SmbClientConfiguration](/powershell/module/smbshare/set-smbclientconfiguration)
and [Set-SmbServerConfiguration](/powershell/module/smbshare/set-smbserverconfiguration)
Windows PowerShell cmdlets. You can configure registry-only settings by using Windows PowerShell as well, as in the following example:

`Set-ItemProperty -Path "HKLM:\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters" RequireSecuritySignature -Value 0 -Force`

### Additional settings from the Windows Restricted Traffic Limited Functionality Baseline guidance

Microsoft has released a baseline  created using the same procedures as the [Windows Security Baselines](/windows/device-security/windows-security-baselines), for environments that are either not connected directly to the Internet, or want to reduce data sent to Microsoft and other services.

The [Windows Restricted Traffic Limited Functionality Baseline](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services)
settings are marked in the Group Policy table with an asterisk.

### Disk cleanup (including using the Disk Cleanup wizard)

Disk cleanup can be especially helpful with master image VDI implementations. After the master image is prepared, updated, and configured, one of the last tasks to perform is disk cleanup. The Disk Cleanup wizard built into Windows can help clean up most potential areas of disk space savings.

> [!NOTE]
> The Disk Cleanup wizard is no longer being developed. Windows will use other methods to provide disk cleanup functions.



Here are suggestions for various disk cleanup tasks. You should test these before implementing any of them:

1. Run the Disk Cleanup wizard (elevated) after applying all updates. Include the categories **Delivery Optimization** and **Windows Update Cleanup**. You can automate this process with **Cleanmgr.exe** with the **/SAGESET:11** option. This option sets registry values that can be used later to automate disk cleanup, using every available option in the Disk Cleanup wizard.

   1.  On a test VM, from a clean installation, running **Cleanmgr.exe /SAGESET:11** reveals that there are only two automatic disk cleanup options enabled by default:

   - Downloaded Program Files

   - Temporary Internet Files

   2. If you set more options, or all options, those options are recorded in the registry, according to the index value provided in the previous command (**Cleanmgr.exe /SAGESET:11**). In this example, we use the value *11* as our index, for a subsequent automated disk cleanup procedure.

   3. After running **Cleanmgr.exe /SAGESET:11** you will see a number of categories of disk cleanup options. You can select every option, and then select **OK**. You will notice that the Disk Cleanup wizard just disappears. However, the settings you selected are saved in the registry, and can be invoked by running **Cleanmgr.exe /SAGERUN:11**.

2. Clean up Volume Shadow Copy storage, if any is in use. To do this, run the following commands in an elevated prompt:

   - **vssadmin list shadows**

   - **vssadmin list shadowstorage**

       If the output from these commands is *No items found that satisfy the query.*, then there is no VSS storage in use.

3. Cleanup temporary files and logs. From an elevated command prompt, run these commands:

   - **Del C:\\\*.tmp /s**

   - **Del C:\\Windows\\Temp\\.**

   - **Del %temp%\\.**

4. Delete any unused profiles on the system with this command:

   **wmic path win32_UserProfile where LocalPath="c:\\\\users\\\\\<user\>" Delete**

### Remove OneDrive

Removing OneDrive involves removing the package, uninstalling, and removing \*.lnk files. You can use following sample PowerShell code to assist in removing OneDrive from the image:

```azurecli

Taskkill.exe /F /IM "OneDrive.exe"
Taskkill.exe /F /IM "Explorer.exe"`
    if (Test-Path "C:\\Windows\\System32\\OneDriveSetup.exe")`
     { Start-Process "C:\\Windows\\System32\\OneDriveSetup.exe"`
         -ArgumentList "/uninstall"`
         -Wait }
    if (Test-Path "C:\\Windows\\SysWOW64\\OneDriveSetup.exe")`
     { Start-Process "C:\\Windows\\SysWOW64\\OneDriveSetup.exe"`
         -ArgumentList "/uninstall"`
         -Wait }
Remove-Item -Path
"C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\OneDrive.lnk" -Force
Remove-Item -Path "C:\\Windows\\ServiceProfiles\\NetworkService\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\OneDrive.lnk" -Force \# Remove the automatic start item for OneDrive from the default user profile registry hive
Start-Process C:\\Windows\\System32\\Reg.exe -ArgumentList "Load HKLM\\Temp C:\\Users\\Default\\NTUSER.DAT" -Wait
Start-Process C:\\Windows\\System32\\Reg.exe -ArgumentList "Delete HKLM\\Temp\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run /v OneDriveSetup /f" -Wait
Start-Process C:\\Windows\\System32\\Reg.exe -ArgumentList "Unload HKLM\\Temp" -Wait Start-Process -FilePath C:\\Windows\\Explorer.exe -Wait
```

For any questions or concerns about the information in this paper, contact your Microsoft account team, research the Microsoft VDI blog, post a message to Microsoft forums, or contact Microsoft for questions or concerns.
