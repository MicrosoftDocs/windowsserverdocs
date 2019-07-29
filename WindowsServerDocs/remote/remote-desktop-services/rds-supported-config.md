---
title: Supported configurations for Remote Desktop Services
description: Provides information about supported configurations for RDS in Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 12/20/2018  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c925c7eb-6880-411f-8e59-bd0f57cc5fc3
author: lizap
manager: dongill
---
# Supported configurations for Remote Desktop Services in Windows Server 2016

> Applies To: Windows Server 2016

When it comes to supported configurations for Remote Desktop Services environments, the largest concern tends to be version interoperability. Most environments include multiple versions of Windows Server - for example, you may have an existing Windows Server 2012 R2 RDS deployment but want to upgrade to Windows Server 2016 to take advantage of the new features (like support for OpenGL\OpenCL, Discrete Device Assignment, or Storage Spaces Direct). The question then becomes, which RDS components can work with different versions and which need to be the same?

So with that in mind, here are basic guidelines for supported configurations of Remote Desktop Services in Windows Server 2016.

> [!NOTE]
> Make sure to review the [system requirements for Windows Server 2016](../../get-started/system-requirements.md).

## Best practices
- Use Windows Server 2016 for your Remote Desktop infrastructure - the Web Access, Gateway, Connection Broker, and license server. Windows Server 2016 is backward compatible for these components - so a 2012 R2 RD Session Host can connect to a 2016 RD Connection Broker, but the reverse is not true.

- For RD Session Hosts - all Session Hosts in a collection need to be at the same level, but you can have multiple collections. You can have a collection with Windows Server 2012 R2 Session Hosts and one with Windows Server 2016 Session Hosts.

- If you upgrade your RD Session Host to Windows Server 2016, also upgrade the license server. Remember that a 2016 license server can process CALs from all previous versions of Windows Server, down to Windows Server 2003.

- Follow the upgrade order recommended in [Upgrading your Remote Desktop Services environment](upgrade-to-rds.md#flow-for-deployment-upgrades). 

- If you are creating a highly available environment, all of your Connection Brokers need to be at the same OS level.

## RD Connection Brokers

Windows Server 2016 removes the restriction for the number of Connection Brokers you can have in a deployment when using Remote Desktop Session Hosts (RDSH) and Remote Desktop Virtualization Hosts (RDVH) that also run Windows Server 2016. The following table shows which versions of RDS components work with the 2016 and 2012 R2 versions of the Connection Broker in a highly available deployment with three or more Connection Brokers.

| 3+ Connection Brokers in HA              | RDSH 2016 | RDVH 2016 | RDSH 2012 R2  | RDVH 2012 R2  |
|------------------------------------------|-----------|-----------|---------------|---------------|
| Windows Server 2016 Connection Broker    | Supported | Supported | Supported     | Supported     |
| Windows Server 2012 R2 Connection Broker | N/A       | N/A       | Supported     | Supported     |

## Support for GPU Acceleration with Hyper-V
The following table details the support for GPU acceleration on virtual machines. See [Which graphics virtualization technology is right for you?](rds-graphics-virtualization.md) for help figuring out what you need. For specific information about DDA, check out [Plan for deploying Discrete Device Assignment](../../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md).

|VM guest OS  |Windows Server 2012 R2 or Windows Server 2016<br> Hyper-V RemoteFX vGPU  (Gen 1 VM) |  Windows Server 2016  Hyper-V RemoteFX vGPU (Gen 2 VM) |  Windows Server 2016  Hyper-V Discrete Device Assignment (Gen 2 VM) |
|-----------------------------|------------------------------------------------------------|--------------------------------------------------------|---------------------------------------------------------------------|
| Windows 7 SP1               | Yes                                                        | No                                                     | No                                                                  |
| Windows 8.1                 | Yes                                                        | No                                                     | No                                                                  |
| Windows 10 1511 Update      | Yes                                                        | Yes                                                    | Yes                                                                 |
| Windows Server 2012 R2      | Yes                                                        | No                                                     | Yes (requires KB 3133690)                                           |
| Windows Server 2016         | Yes                                                        | Yes                                                    | Yes                                                                 |
| Windows Server 2012 R2 RDSH | No                                                         | No                                                     | Yes (requires KB 3133690)                                           |
| Windows Server 2016 RDSH    | No                                                         | No                                                     | Yes                                                                 |
## VDI deployment – supported guest OSs 
Windows Server 2016 RD Virtualization Host servers support the following guest OSs:

- Windows 10 Enterprise
- Windows 8.1 Enterprise 
- Windows 8 Enterprise 
- Windows 7 SP1 Enterprise 

The table below shows the supported RD Virtualization Hosts operating systems and guest operating system combinations:

| RDVH OS Version        | Guest OS Version           |
| ------------- |-------------|
| Windows Server 2016      | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012 R2   | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012      | Windows 7 SP1, Windows 8, Windows 8.1 |

> [!NOTE]  
> - Windows Server 2016 Remote Desktop Services does not support heterogeneous collections. All VMs in a collection must be same OS version. 
> - You can have separate homogeneous collections with different guest OS versions on the same host. 
> - VM templates must be created on a Windows Server 2016 Hyper-V host to used as guest OS on a Windows Server 2016 Hyper-V host.

## Single Sign-On (SSO)
Windows Server 2016 RDS supports two main SSO experiences:

 - In-app (Remote Desktop application on Windows, iOS, Android, and Mac)
 - Web SSO
 
Using the Remote Desktop application, you can store credentials either as part of the connection info ([Mac](clients/remote-desktop-mac.md)) or as part of managed accounts ([iOS](clients/remote-desktop-ios.md#manage-your-user-accounts), [Android](clients/remote-desktop-android.md#manage-your-user-accounts), Windows) securely through the mechanisms unique to each OS.

To connect to desktops and RemoteApps with SSO through the inbox Remote Desktop Connection client on Windows, you must connect to the RD Web page through Internet Explorer. The following configuration options are required on the server side. No other configurations are supported for Web SSO:

 - RD Web set to Forms-Based Authentication (Default)
 - RD Gateway set to Password Authentication (Default)
 - RDS Deployment set to "Use RD Gateway credentials for remote computers" (Default) in the RD Gateway properties

> [!NOTE]
> Due to the required configuration options, Web SSO is not supported with smartcards. Users who login via smartcards might face multiple prompts to login.

For more information about creating VDI deployment of Remote Desktop Services, check out [Supported Windows 10 security configurations for Remote Desktop Services VDI](rds-vdi-supported-config.md).

## Using Remote Desktop Services with application proxy services

You can use Remote Desktop Services, except for the web client, with [Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/application-proxy-publish-remote-desktop). Remote Desktop Services does not support using [Web Application Proxy](https://docs.microsoft.com/windows-server/remote/remote-access/web-application-proxy/web-application-proxy-windows-server), which is included in Windows Server 2016 and earlier versions.
