---
title: Supported configurations for Remote Desktop Services
description: Provides information about supported configurations for RDS in Windows Server 2016 and Windows Server 2019.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 10/22/2019  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c925c7eb-6880-411f-8e59-bd0f57cc5fc3
author: lizap
manager: dongill
---
# Supported configurations for Remote Desktop Services

> Applies To: Windows Server 2016, Windows Server 2019

When it comes to supported configurations for Remote Desktop Services environments, the largest concern tends to be version interoperability. Most environments include multiple versions of Windows Server - for example, you may have an existing Windows Server 2012 R2 RDS deployment but want to upgrade to Windows Server 2016 to take advantage of the new features (like support for OpenGL\OpenCL, Discrete Device Assignment, or Storage Spaces Direct). The question then becomes, which RDS components can work with different versions and which need to be the same?

So with that in mind, here are basic guidelines for supported configurations of Remote Desktop Services in Windows Server.

> [!NOTE]
> Make sure to review the [system requirements for Windows Server 2016](../../get-started/system-requirements.md) and [system requirements for Windows Server 2019](../../get-started-19/sys-reqs-19.md).

## Best practices

- Use Windows Server 2019 for your Remote Desktop infrastructure (the Web Access, Gateway, Connection Broker, and license server). Windows Server 2019 is backward-compatible with these components, which means a Windows Server 2016 or Windows Server 2012 R2 RD Session Host can connect to a 2019 RD Connection Broker, but not the other way around.

- For RD Session Hosts - all Session Hosts in a collection need to be at the same level, but you can have multiple collections. You can have a collection with Windows Server 2016 Session Hosts and one with Windows Server 2019 Session Hosts.

- If you upgrade your RD Session Host to Windows Server 2019, also upgrade the license server. Remember that a 2019 license server can process CALs from all previous versions of Windows Server, down to Windows Server 2003.

- Follow the upgrade order recommended in [Upgrading your Remote Desktop Services environment](upgrade-to-rds.md#flow-for-deployment-upgrades).

- If you are creating a highly available environment, all of your Connection Brokers need to be at the same OS level.

## RD Connection Brokers

Windows Server 2016 removes the restriction for the number of Connection Brokers you can have in a deployment when using Remote Desktop Session Hosts (RDSH) and Remote Desktop Virtualization Hosts (RDVH) that also run Windows Server 2016. The following table shows which versions of RDS components work with the 2016 and 2012 R2 versions of the Connection Broker in a highly available deployment with three or more Connection Brokers.

|3+ Connection Brokers in HA|RDSH or RDVH 2019|RDSH or RDVH 2016|RDSH or RDVH 2012 R2|
|---|---|---|---|
 |Windows Server 2019 Connection Broker|Supported|Supported|Supported|
 |Windows Server 2016 Connection Broker|N/A|Supported|Supported|
 |Windows Server 2012 R2 Connection Broker|N/A|N/A|Not Supported|

## Support for graphics processing unit (GPU) acceleration

Remote Desktop Services support systems equipped with GPUs. Applications that require a GPU can be used over the remote connection. Additionally, GPU-accelerated rendering and encoding can be enabled for improved app performance and scalability.

Remote Desktop Services Session Hosts and single-session client operating systems can take advantage of the physical or virtual GPUs presented to the operating system in many ways, including the [Azure GPU optimized virtual machine sizes](/en-us/azure/virtual-machines/windows/sizes-gpu), GPUs available to the physical RDSH server, RemoteFX vGPUs (Only on Windows Server 2016), and GPUs presented to the VMs by supported hypervisors.

See [Which graphics virtualization technology is right for you?](rds-graphics-virtualization.md) for help figuring out what you need. For specific information about DDA, check out [Plan for deploying Discrete Device Assignment](../../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md).

GPU vendors may have a separate licensing scheme for RDSH scenarios or restrict GPU use on the server OS, verify the requirements with your favorite vendor.

GPUs presented by a non-Microsoft hypervisor or Cloud Platform must have drivers digitally-signed by WHQL and supplied by the GPU vendor.

### Remote Desktop Session Host support for GPUs

The following table shows the scenarios supported by different versions of RDSH hosts.

|Feature|Windows Server 2008 R2|Windows Server 2012 R2|Windows Server 2016|Windows Server 2019|
|---|---|---|---|---|
|Use of hardware GPU for all RDP sessions|No|Yes|Yes|Yes|
|H.264/AVC hardware encoding (if suppported by the GPU)|No|No|Yes|Yes|
|Load balancing between multiple GPUs presented to the OS|No|No|No|Yes|
|H.264/AVC encoding optimizations for minimizing bandwidth usage|No|No|No|Yes|
|H.264/AVC support for 4K resolution|No|No|No|Yes|

### VDI support for GPUs

The following table shows support for GPU scenarios in the client OS.

|Feature|Windows 7 SP1|Windows 8.1|Windows 10|
|---|---|---|---|
|Use of hardware GPU for all RDP sessions|No|Yes|Yes|
|H.264/AVC hardware encoding (if suppported by the GPU)|No|No|Windows 10 1703 and later|
|Load balancing between multiple GPUs presented to the OS|No|No|Windows 10 1803 and later|
|H.264/AVC encoding optimizations for minimizing bandwidth usage|No|No|Windows 10 1803 and later|
|H.264/AVC support for 4K resolution|No|No|Windows 10 1803 and later|

### RemoteFX 3D Video Adapter (vGPU) support

Remote Desktop Services supports RemoteFX vGPUs when VM is running as a Hyper-V guest on Windows Server 2012 R2 or Windows Server 2016. The following guest operating systems have RemoteFX vGPU support:

- Windows 7 SP1
- Windows 8.1
- Windows 10 1703 or later
- Windows Server 2016 in a single-session deployment only
- Windows Server 2019 in a single-session deployment only

### Discrete Device Assignment support

Remote Desktop Services supports Physical GPUs presented with Discrete Device Assignment from Windows Server 2016 or Windows Server 2019 Hyper-V hosts. See [Plan for deploying Discrete Device Assignment](../../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md) for more details.


## VDI deployment – supported guest OSes

Windows Server 2016 and Windows Server 2019 RD Virtualization Host servers support the following guest OSes:

- Windows 10 Enterprise
- Windows 8.1 Enterprise
- Windows 7 SP1 Enterprise

> [!NOTE]
> - Remote Desktop Services doesn't support heterogeneous session collections. The OSes of all VMs in a collection must be the same version.
> - You can have separate homogeneous collections with different guest OS versions on the same host.
> - The Hyper-V host used to run VMs must be the same version as the Hyper-V host used to create the original VM templates.

## Single sign-on

Windows Server 2016 and Windows Server 2019 RDS supports two main SSO experiences:

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
