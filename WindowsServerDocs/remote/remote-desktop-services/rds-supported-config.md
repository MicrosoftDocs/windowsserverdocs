---
title: Supported Configurations for Remote Desktop Services
description: Provides information about supported configurations for Remote Desktop Services (RDS) in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 07/07/2025
---

# Supported configurations for Remote Desktop Services

When it comes to the supported configurations for Remote Desktop Services (RDS) environments, the largest concern tends to be version interoperability. Most environments include multiple versions of Windows Server. For example, you might have an existing RDS deployment running an earlier version of Windows Server but want to upgrade to a later version of Windows Server to take advantage of the new features. The question then becomes: which RDS components can work with different versions and which need to use a consistent version?

This article provides basic guidelines for supported configurations of RDS in Windows Server.

> [!NOTE]
> Be sure to review the [system requirements for Windows Server](../../get-started/hardware-requirements.md).

## Best practices

- Use the most recent version of Windows Server for your Remote Desktop infrastructure (the Web Access, Gateway, Connection Broker, and license server). Windows Server is backward-compatible with these components. So a Windows Server 2022 RD Session Host can connect to a Windows Server 2025 RD Connection Broker, but not the other way around.

- For RD Session Hosts, all Session Hosts in a collection need to be at the same level, but you can have multiple collections. For example, you can have a collection with Windows Server 2019 Session Hosts and one with Windows Server 2025 Session Hosts.

- An RDS license server can only process client access licenses (CALs) from the same or previous versions of Windows Server. So, if you upgrade your RD Session Host to Windows Server 2025, you also need to upgrade the license server.

- Follow the upgrade order recommended in [Upgrading your Remote Desktop Services environment](upgrade-to-rds.md#flow-for-deployment-upgrades).

- If you're creating a highly available environment, all of your Connection Brokers need to be at the same OS level.

## RD Connection Brokers

Starting in Windows Server 2016, there's no restriction for the number of Connection Brokers you can have in a deployment when using Remote Desktop Session Hosts (RDSH) and Remote Desktop Virtualization Hosts (RDVH). The following table shows which versions of RDS components work in a highly available deployment with three or more Connection Brokers.

|3 or more Connection Brokers in HA|RDSH or RDVH 2025|RDSH or RDVH 2022|RDSH or RDVH 2019|RDSH or RDVH 2016|
|---|---|---|---|---|
 |Windows Server 2025 Connection Broker|Supported|Supported|Supported|Supported|
 |Windows Server 2022 Connection Broker|N/A|Supported|Supported|Supported|
 |Windows Server 2019 Connection Broker|N/A|N/A|Supported|Supported|
 |Windows Server 2016 Connection Broker|N/A|N/A|N/A|Supported|

## Support for graphics processing unit (GPU) acceleration

RDS supports systems equipped with GPUs. Applications that require a GPU can be used over the remote connection. Additionally, GPU-accelerated rendering and encoding can be enabled for improved app performance and scalability.

Remote Desktop Session Hosts and single-session client operating systems can take advantage of the physical or virtual GPUs presented to the operating system in many ways, including the [Azure GPU optimized virtual machine sizes](/azure/virtual-machines/windows/sizes-gpu), GPUs available to the physical RDSH server, and GPUs presented to the VMs by supported hypervisors.

See [Which graphics virtualization technology is right for you?](rds-graphics-virtualization.md) for help with figuring out what you need. For specific information about Discrete Device Assignment, see [Plan for deploying Discrete Device Assignment](../../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md).

GPU vendors might have a separate licensing scheme for RDSH scenarios or restrict GPU use on the server OS. Verify the requirements with your vendor.

GPUs presented by a non-Microsoft hypervisor or cloud platform must have drivers digitally signed by WHQL and supplied by the GPU vendor.

### Remote Desktop Session Host support for GPUs

The following table shows the scenarios supported by different versions of RDSH hosts.

|Feature|Windows Server 2016|Windows Server 2019|Windows Server 2022|Windows Server 2025|
|---|---|---|---|---|
|Use of hardware GPU for all RDP sessions|Yes|Yes|Yes|Yes|
|H.264/AVC hardware encoding (if supported by the GPU)|Yes|Yes|Yes|Yes|
|Load balancing between multiple GPUs presented to the OS|No|Yes|Yes|Yes|
|H.264/AVC encoding optimizations for minimizing bandwidth usage|No|Yes|Yes|Yes|
|H.264/AVC support for 4K resolution|No|Yes|Yes|Yes|

### VDI support for GPUs

The following table shows support for GPU scenarios in the client OS.

|Feature|Windows 7 SP1|Windows 8.1|Windows 10|
|---|---|---|---|
|Use of hardware GPU for all RDP sessions|No|Yes|Yes|
|H.264/AVC hardware encoding (if supported by the GPU)|No|No|Windows 10 1703 or later|
|Load balancing between multiple GPUs presented to the OS|No|No|Windows 10 1803 or later|
|H.264/AVC encoding optimizations for minimizing bandwidth usage|No|No|Windows 10 1803 or later|
|H.264/AVC support for 4K resolution|No|No|Windows 10 1803 or later|

### RemoteFX 3D Video Adapter (vGPU) support

> [!NOTE]
> Because of security concerns, RemoteFX vGPU is disabled by default on all versions of Windows starting with the July 14, 2020 Security Update and removed starting with the April 13, 2021 Security Update. To learn more, see [KB 4570006](https://support.microsoft.com/help/4570006).

RDS supports RemoteFX vGPUs when the VM is running as a Hyper-V guest on Windows Server. The following guest operating systems have RemoteFX vGPU support:

- Windows 11
- Windows 10
- Windows Server, in a single-session deployment only

### Discrete Device Assignment support

RDS supports physical GPUs presented with Discrete Device Assignment from Hyper-V hosts running Windows Server 2016 or later. See [Plan for deploying Discrete Device Assignment](../../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md) for more details.

## VDI deployment – supported guest operating systems

Windows Server RD Virtualization Host servers support the following guest operating systems:

- Windows 11 Enterprise
- Windows 10 Enterprise

> [!NOTE]
>
> - RDS doesn't support heterogeneous session collections. The operating systems of all VMs in a collection must be the same version.
> - You can have separate homogeneous collections with different guest OS versions on the same host.
> - The Hyper-V host used to run VMs must be the same version as the Hyper-V host used to create the original VM templates.

## Single sign-on

RDS in Windows Server supports two main single sign-on (SSO) experiences:

- In-app (Remote Desktop application on Windows, iOS, Android, and Mac)
- Web SSO

Using the Remote Desktop application, you can store credentials either as part of the connection info ([Mac](clients/remote-desktop-mac.md)) or as part of managed accounts ([iOS](clients/remote-desktop-ios.md#manage-your-user-accounts), [Android](clients/remote-desktop-android.md#manage-your-user-accounts), Windows) securely through the mechanisms unique to each OS.

To connect to desktops and RemoteApps with SSO through the inbox Remote Desktop Connection client on Windows, you must connect to the RD Web page through Internet Explorer. The following configuration options are required on the server side. No other configurations are supported for Web SSO.

- RD Web set to form-based authentication (Default)
- RD Gateway set to password authentication (Default)
- RDS Deployment set to "Use RD Gateway credentials for remote computers" (Default) in the RD Gateway properties

> [!NOTE]
> Due to the required configuration options, Web SSO isn't supported with smart cards. Users who sign in by using smart cards might face multiple prompts to sign in.

For more information about creating a VDI deployment of RDS, see [Supported Windows 10 security configurations for Remote Desktop Services VDI](rds-vdi-supported-config.md).

## Using RDS with application proxy services

You can use RDS with [Microsoft Entra application proxy](/azure/active-directory/application-proxy-publish-remote-desktop). RDS doesn't support [Web Application Proxy](../remote-access/web-application-proxy/web-app-proxy-windows-server.md).

