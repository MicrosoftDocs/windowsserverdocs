---
title: What's New in Windows Server, version 1803
description: "What are the new features in compute, identity, management, automation, networking, security, storage."
ms.prod: windows-server
ms.technology: server-general
ms.topic: article
author: greg-lindsay
ms.author: greg-lindsay
ms.localizationpriority: high
ms.date: 05/07/2018
---

# What's New in Windows Server version 1803

>Applies To: Windows Server (Semi-Annual Channel)

<img src="../media/landing-icons/new.png" style='float:left; padding:.5em;' alt="Icon showing a newspaper">&nbsp;To learn about the latest features in Windows, see [What's New in Windows Server](whats-new-in-windows-server.md). The content in this section describes what's new and changed in Windows Server, version 1803. The new features and changes listed here are the ones most likely to have the greatest impact as you work with this release. Also see [Windows Server Semi-Annual Channel update](https://cloudblogs.microsoft.com/windowsserver/2018/03/29/windows-server-semi-annual-channel-update/).

## Windows Admin Center

Project Honolulu is now the **Windows Admin Center**.
<br>&nbsp;
> [!video https://www.youtube.com/embed/WCWxAp27ERk?autoplay=false]

[Windows Admin Center](https://docs.microsoft.com/windows-server/manage/windows-admin-center/overview) consolidates all aspects of local and remote server management. Windows Admin Center is a locally deployed, browser-based management experience that does not require an Internet connection, giving you full control of all aspects of your Windows Server deployment.

## Windows Server release strategy

Windows Server version 1709 was released in September 2017 as the first release in the Semi-Annual Channel. The Semi-Annual Channel has a faster release cadence and addresses feedback from those who want rapid innovation every few months. This complements the Long-Term Servicing Channel where the release cadence is every 2-3 years.

Based on telemetry and feedback, these channels have demonstrated that they conform well to the following general strategy:
- The Semi-Annual Channel is ideal for modern applications and innovation scenarios, such as containers and micro-services.
- The Long-Term Servicing Channel is the preferred release for core infrastructure scenarios such as software-defined datacenter and hyper-converged infrastructure (HCI). 

The specific scenarios for the Semi-Annual Channel and the Long-Term Servicing Channel are as follows:

|   | Long Term Servicing Channel |  Semi-Annual Channel |
| ------------- | ------------- | ------------ |
| Recommended scenarios     | General purpose file servers, first and third-party workloads, traditional apps, infrastructure roles, software-defined Datacenter, and Hyper-converged infrastructure  | Containerized applications, container hosts, and application scenarios benefiting from faster innovation |
| New releases  | Every 2–3 years  | Every 6 months |
| Support  | 5 years of Mainstream support + 5 years of Extended support  | 18 months |
| Editions  | All available Windows Server editions  | Standard and Datacenter editions |
| Who can use  | All customers through all channels | Software Assurance and cloud customers only |
| Installation options  | Server Core and Server with Desktop Experience  | Server Core for container host, container image, and Nano Server container image |

## Application platform and containers

- Optimization
    - The Server Core base container image is reduced by 30% from Windows Server, version 1709. 
    - Application compatibility is also improved to help with containerizing of traditional applications.
    - Container boot performance and run-time performance are improved as well thanks to various fixes and optimizations.
- Container networking: Localhost and http proxy support has been added, and container scalability and startup time is improved.
- Tools: Support for Curl.exe, Tar.exe, and SSH has been enhanced to complement PowerShell for building and debugging scenarios.

### Server Core container image

A smaller Server Core container with better application compatibility is now available. Detailed information is available [here](https://blogs.technet.microsoft.com/virtualization/2018/01/22/a-smaller-windows-server-core-container-with-better-application-compatibility/).

- Unused optional features and roles have been removed. For more information see [Roles, Role Services, and Features not in Server Core containers](../administration/server-core/server-core-container-removed-roles.md).
    - Decreased download size to 1.58 GB, 30% reduction from Windows Server, version 1709.
    - Decreased size on disk to 3.61 GB, 20% reduction from Windows Server, version 1709.
- Nano Server container image is below 100MB

### Windows Subsystem for Linux (WSL)

WSL enables server administrators to use existing tools and scripts from Linux on Windows Server. Many improvements showcased in the [command line blog](https://blogs.msdn.microsoft.com/commandline/tag/wsl/) are now part of Windows Server, including Background tasks, DriveFS, WSLPath, and much more.

### Kubernetes 

Kubernetes (commonly referred to as K8s) is an open source system for automating deployment, scaling and management of containerized applications developed under the stewardship of the [Cloud Native Computing Foundation](https://www.cncf.io). 

In Windows Server, version 1709 users were able to take advantage of Kubernetes on Windows networking features, including:
- Shared pod compartments: Infrastructure and worker pods now share a network compartment (analogous to a Linux namespace).
- Endpoint optimization: Thanks to compartment sharing, container services need to track at least half as many endpoints.
- Data-path optimization: Improvements to the Virtual Filtering Platform and the Host Networking Service allow kernel-based load-balancing.

With the release of Windows Server, version 1803 more features will be available in coming Kubernetes releases: 
- [Storage plugins](https://github.com/Microsoft/K8s-Storage-Plugins) for Windows containers orchestrated by Kubernetes.
- Cloud scale networking though initiatives like our partnership with [Tigera on Project Calico](https://cloudblogs.microsoft.com/windowsserver/2017/12/07/securing-modernized-apps-and-simplified-networking-on-windows-with-calico/) support.
- Windows platform support for Hyper-V isolated Pods with multiple containers per Pod.

### Application compatibility and feature parity issues fixed

- Microsoft Message Queuing (MSMQ) now installs in a Server Core container.
- An issue that breaks ASP.net performance counters has been fixed.
- An issue where services running in containers did not receive shutdown notification has been fixed.
    - Specifically, the notification is changed to CTRL_SHUTDOWN_EVENT for both Server Core and Nano Server container based images. In addition, it extends the notification in Server Core container based images to affect all process running in the container, including sending service shutdown notifications to services running in the container.
- An incompatibility of docker pull & docker load with the policy setting that determines whether BitLocker protection is required for fixed data drives to be writable (FDVDenyWriteAccess) has been fixed. 

## Storage

With this release, it is possible to prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on all volumes when the service starts. This can conserve space on each volume, but will disable real-time file classification. For more information, see [File Server Resource Manager overview](https://docs.microsoft.com/windows-server/storage/fsrm/fsrm-overview).

## Features added to Server Core

The Transport Server role in Windows Deployment Services (WDS) role has been added to Server Core.

Transport Server contains only the core networking parts of WDS. You can use Transport Server to create multicast namespaces that transmit data (including operating system images) from a standalone server. You can also use it if you want to have a PXE server that allows clients to PXE boot and download your own custom setup application. You should use this option if you want to use either of these scenarios.

You can use the following Windows PowerShell command to enable the Transport Server service on Server Core:

```
Install-WindowsFeature -Name WDS
```

## See also

[Windows Server release information](https://docs.microsoft.com/windows-server/get-started/windows-server-release-info)<br>
[What's new in Windows 10, version 1803 IT Pro content](https://docs.microsoft.com/windows/whats-new/whats-new-windows-10-version-1803)
