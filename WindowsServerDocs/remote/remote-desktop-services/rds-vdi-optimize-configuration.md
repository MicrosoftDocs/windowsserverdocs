---
title: Optimizing Windows configuration for VDI desktops
description: Recommended settings and configuration to minimize overhead for Windows VDI desktops.
ms.service: windows-server
ms.subservice: remote-desktop-services
author: meaghanlewis
ms.author: mosagie
ms.topic: article
manager: femila
ms.date: 05/29/2024
---

# Optimizing Windows configuration for VDI desktops

Although the Windows operating system is very well tuned out of the box, there are opportunities for you to refine it further specifically for the corporate Microsoft Virtual Desktop Infrastructure (VDI) environment. In the VDI environment, many background services and tasks are disabled from the beginning. 

This topic is not a blueprint, but rather a guide or starting point. Some recommendations might disable functionality that you would prefer to use, so you should consider the cost versus the benefit of adjusting any particular setting in your scenario. 

**Note:** 

Any settings not specifically mentioned in this topic can be left at their default values (or set per your requirements and policies) without appreciable impact on VDI functionality.

## VDI optimization principles 

A "full" virtual desktop environment can present a complete desktop session, including applications, to a computer user over a network. The network delivery vehicle can be an on-premises network, the Internet, or both. Some implementations of virtual desktop environments use a "base" operating system image, which then becomes the basis for the desktops subsequently presented to the users for work. There are variations of virtual desktop implementations such as **persistent**, **non-persistent**, and **desktop session**. The persistent type preserves changes to the virtual desktop operating system from one session to the next. The non-persistent type does not preserve changes to the virtual desktop operating system from one session to the next. To the user this desktop is little different than other virtual or physical device, other than it is accessed over a network. 

The optimization settings could take place on a reference machine. A virtual machine (VM) would be an ideal place to build the VM, because state can be saved, checkpoints can be made, backups can be made, and so on. A default OS installation is performed to the base VM. That base VM is then optimized by removing unneeded apps, installing Windows updates, installing other updates, deleting temporary files, applying settings, and so on. 

Security and stability are among the highest priorities for Microsoft when it comes to products and services. In the virtual desktop realm, security isn't handled much differently than physical devices. Enterprise customers may choose to utilize the built-in to Windows services of Windows Security, which comprises a suite of services that work well connected or not connected to the Internet. For those virtual desktop environments not connected to the Internet, security signatures can be downloaded proactively several times per day, because Microsoft may release more than one signature update per day. Those signatures can then be provided to the virtual desktop devices and scheduled to be installed during production, regardless of persistent or non-persistent. That way the VM protection is as current as possible. 
 
There are some security settings that are not applicable to virtual desktop environments that are not connected to the Internet, and thus not able to participate in cloud-enabled security. There are other settings that "normal" Windows devices may utilize such as Cloud Experience, The Windows Store, and so on. Removing access to unused features reduces footprint, network bandwidth, and attack surface. 

Regarding updates, Windows utilizes a monthly update rhythm. In some cases virtual desktop administrators control the process of updating through a process of shutting down VMs based on a "master" or "gold" image, unseal that image which is read-only, patch the image, then reseal it and bring it back into production. Therefore, there is no need to have virtual desktop devices checking Windows Update. However, there are cases where normal patching procedures take place, like the case of persistent "personal" virtual desktop devices. In some cases, Windows Update can be utilized. In some cases, Intune could be utilized. In some cases Microsoft Endpoint Configuration Manager (formerly SCCM) is utilized to handle update and other package delivery. It is up to each organization to determine the best approach to updating virtual desktop devices, while reducing overhead cycles. 

The local policy settings, as well as many other settings in this guide, can be overridden with domain-based policy. It is recommended to go through the policy settings thoroughly and remove or not use any that are not desired or applicable to your environment. The settings listed in this document try to achieve the best balance of performance optimization in virtual desktop environments, while maintaining a quality user experience. 

>[!NOTE]
> There is a set of [scripts available at GitHub.com](https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool) that will do all the work items documented in this paper. The scripts are designed to be easily customizable for your environment and requirements. The main code is PowerShell, and the work is done by calling input files, which are plain text (now .JSON), with also Local Group Policy Object (LGPO) tool export files. These text files contain lists of the apps to be removed, services to be disabled, and so on. If you don't want to remove a particular app or disable a particular service, you can edit the corresponding text file and remove the item you do not want acted upon. Finally, there is an export of local policy settings that can be imported into your environment machines. It's better to have some of the settings within the base image, than to have the settings applied through group policy, as some of the settings take effect on the next restart or when a component is first used.

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

Windows has a built-in capability called the [System Preparation Tool](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview), also known as sysprep. The sysprep tool is used to prepare a customized Windows 10 image for duplication. The sysprep process assures the resulting OS is properly unique to run in production.

There are reasons for and against running sysprep. In the case of virtual desktop environments, you may want the ability to customize the default user profile which would be used as the profile template for subsequent users that sign in using this image. You may have apps that you want installed, but also able to control per-app settings.

The alternative is to use a standard .ISO to install from, possibly using an unattended installation answer file, and a task sequence to install applications or remove applications. You can also use a task sequence to set local policy settings in the image, perhaps using the [Local Group Policy Object Utility (LGPO)](/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10#what-is-the-local-group-policy-object-lgpo-tool) tool.

To learn more about image preparation for Azure, see [Prepare a Windows VHD or VHDX to upload to Azure](/azure/virtual-machines/windows/prepare-for-upload-vhd-image)

### Supportability 

Anytime that Windows defaults are changed, questions arise regarding supportability. Once a virtual desktop image (VM or session) is customized, every change made to the image needs to be tracked in a change log. If a time comes to troubleshoot, often an image can be isolated in a pool and configured for problem analysis. Once a problem has been tracked to root cause, that change can then be rolled out to the test environment first, and ultimately to the production workload. 

This document intentionally avoids touching system services, policies, or tasks that affect security. After that comes Windows servicing. The ability to service virtual desktop images outside of maintenance windows is removed, as maintenance windows are when most servicing events take place in virtual desktop environments, except for security software updates. Microsoft has published guidance for Windows Security in virtual desktop environments, here: 

**Microsoft**: [Deployment guide for Windows Defender Antivirus in a virtual desktop infrastructure (VDI) environment](/windows/security/threat-protection/windows-defender-antivirus/deployment-vdi-windows-defender-antivirus)

Consider supportability when altering default Windows settings. Occasionally difficult to solve problems arise when altering system services, policies, or scheduled tasks, in the name of hardening, "lightening," and so on. Consult the Microsoft Knowledge Base for current known issues regarding altered default settings. The guidance in this document, and the associated script on GitHub will be maintained with respect to known issues, if any arise. In addition you can report issues in a number of ways to Microsoft. 

You can use your favorite search engine with the terms `"start value" site:support.microsoft.com` to bring up known issues regarding default start values for services. 

You might note that this document and the associated scripts on GitHub do not modify any default permissions. If you are interested in increasing your security settings, start with the project known as AaronLocker. For more information, ["AaronLocker" overview](https://github.com/microsoft/AaronLocker).

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

With a default installation of Windows, not all UWP apps may be used by an organization. Therefore, if those apps are removed, there are fewer evaluations that need to take place, less caching, and so on. The second method here is to direct Windows to disable "consumer experiences." This reduces Store activity by having to check for every user what apps are installed, what apps are available, and then to start downloading some UWP apps. The performance savings can be significant when there are hundreds or thousands of users, all start work at approximately the same time, or even starting work at rolling times across time zones. 

Connectivity and timing are important factors when it comes to UWP app cleanup. If you deploy your base image to a device with no network connectivity, Windows cannot connect to the Microsoft Store and download apps and try to install them while you are trying to uninstall them. This might be a good strategy to allow you time to customize your image, and then update what remains at a later stage of the image creation process. 

If you modify your base .WIM that you use to install Windows and remove unneeded UWP apps from the .WIM before you install, the apps will not be installed from the beginning and your subsequent profile creation times will be shorter. There is a link later in this section with information on how to remove UWP apps from your installation .WIM file. 

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

UWP apps that are provisioned to a system can be removed during OS installation as part of a task sequence, or later after the OS is installed. This may be the preferred method because it makes the overall process of creating or maintaining an image modular. Once you develop the scripts, if something changes in a subsequent build you edit an existing script rather than repeat the process from scratch. 

Then run the following PowerShell command to remove UWP app payloads: 

```powershell
Remove-AppxProvisionedPackage -Online - PackageName MyAppxPackage
```


As a final note on this topic, each UWP app should be evaluated for applicability in each unique environment. You will want to install a default installation of Windows 10, version 2004, then note which apps are running and consuming memory. For example, you may want to consider removing apps that start automatically, or apps that automatically display information on the Start Menu, such as Weather and News, and that may not be of use in your environment.

> [!NOTE]
> If you're using the scripts from GitHub, you can easily control which apps are removed before running the script. After downloading the script files, locate the AppxPackage.json file, edit that file, and remove entries for apps that you want to keep, such as Calculator, Sticky Notes, and so on.
