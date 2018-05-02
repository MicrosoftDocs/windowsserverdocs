---
title: Windows Admin Center Frequently Asked Questions
description: Get answers about Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Windows Admin Center Frequently Asked Questions

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

Here are answers to the most commonly asked questions about Windows Admin Center.

## What is Windows Admin Center?

Windows Admin Center is a lightweight, browser-based GUI platform and toolset for IT Admins to manage Windows Server and Windows 10. It's the evolution of familiar in-box administrative tools, such as Server Manager and Microsoft Management Console (MMC) into a modernized, simplified, integrated, and secure experience.

## Why was "Windows Admin Center" chosen as the final name for "Project Honolulu"?

Windows Admin Center is the official product name for "Project Honolulu" and reinforces our vision of an integrated experience for IT admins across a breadth of core administrative and management scenarios. It also highlights our customer-focus on IT admin user needs as central to how we invest and what we deliver.

## Can I use Windows Admin Center in production environments?

Yes. Windows Admin Center is generally available and ready for broad usage and production deployments. As a platform that will continue to grow and mature, exiting preview means that the current platform capabilities and core tools meet Microsoft’s standard release criteria and our quality bar for usability, reliability, performance, accessibility, security, and adoption.

## How much does it cost to use Windows Admin Center?

Windows Admin Center has no additional cost beyond Windows. You can use Windows Admin Center (available as a separate download) with valid licenses of Windows Server or Windows 10 at no additional cost - it’s licensed under a Windows Supplemental EULA.

## What versions of Windows Server can I manage with Windows Admin Center?

Windows Admin Center will be optimized for Windows Server 2019 and enable key themes in the upcoming Windows Server 2019 release: hybrid cloud scenarios and hyper-converged infrastructure management in particular. Although Windows Admin Center will work best with Windows Server 2019, it supports managing a variety of versions that customers already use: Windows Server 2012 and newer.

## Is Windows Admin Center a complete replacement for all traditional in-box and RSAT tools?

No. Although Windows Admin Center can manage many common scenarios, it doesn't completely replace all traditional Microsoft Management Console (MMC) tools. For a detailed look at what tools are included with Windows Admin Center, read more about managing servers in our documentation. Windows Admin Center has the following key capabilities in its Server Manager solution:

* Displaying resources and resource utilization
* Certificate Management
* Managing Devices
* Event Viewer
* File Explorer
* Firewall Management
* Configuring Local Users and Groups
* Network Settings
* Viewing/Ending Processes and Creating Process Dumps
* Registry Editing
* Managing Windows Services
* Enabling/Disabling Roles and Features
* Managing Hyper-V VMs and Virtual Switches
* Managing Storage
* Managing Windows Updates
* PowerShell console
* Remote Desktop connection
* Storage Replica

Windows Admin Center also provides these solutions:

* Computer Management – Provides a subset of the Server Manager features for managing Windows 10 client PCs
* Failover Cluster Manager – Provides support for ongoing management of failover clusters and cluster resources
* Hyper-Converged Cluster Manager – Provides an all-new experience tailored for Storage Spaces Direct and Hyper-V. It features the Dashboard and emphasizes charts and alerts for monitoring.

Windows Admin Center is complementary to and does not replace RSAT (Remote Server Administration Tools) since roles such as Active Directory, DHCP, DNS, IIS do not yet have equivalent management capabilities surfaced in Windows Admin Center.

## Can Windows Admin Center be used to manage the free Microsoft Hyper-V Server?

Yes. Windows Admin Center can be used to manage Microsoft Hyper-V Server 2016 and Microsoft Hyper-V Server 2012 R2.

## Can I deploy Windows Admin Center on a Windows 10 computer?

Yes, Windows Admin Center can be installed on Windows 10 (version 1709 or later), running in desktop mode.  Windows Admin Center can also be installed on a server running Windows Server 2016 in gateway mode, and then accessed via a web browser from a Windows 10 computer.  [Learn more about installation options](..\plan\installation-options.md).

## Are there any plans for Windows Admin Center to manage Windows Server 2008 R2 or earlier?

We are investigating due to customer demand, but there is currently no locked plan to deliver, and support would be minimal at best. Windows Admin Center relies on PowerShell capabilities and platform technologies that don’t exist in Windows Server 2008 R2 and earlier, making full support infeasible. Furthermore, Windows Server 2008/2008 R2 are approaching end of support in January 2020 so Microsoft recommends customers move to Azure or upgrade to Windows Server 2016.

## Are there any plans for Windows Admin Center to manage Linux connections?

We are investigating due to customer demand, but there is currently no locked plan to deliver, and support may consist only of a PowerShell Core console connection over SSH.

## Which web browsers are supported by Windows Admin Center?

The latest versions of Microsoft Edge (Windows 10, version 1709 or later) and Google Chrome browsers are tested and supported on Windows 10. Other modern web browsers or other platforms are not currently part of our test matrix and are therefore not officially supported.

## How does Windows Admin Center handle security?

Traffic from the browser to the Windows Admin Center gateway uses HTTPS. Traffic from the gateway to managed servers is standard PowerShell and WMI over WinRM. We support LAPS (Local Administrator Password Solution), resource-based constrained delegation, gateway access control using AD or Azure AD, and role-based access control for managing target servers.

## Are there any cloud dependencies?

Windows Admin Center does not require internet access and does not require Microsoft Azure. Windows Admin Center manages Windows Server and Windows instances anywhere: on physical systems, or in virtual machines on any hypervisor, or running in any cloud. Although integration with various Azure services will be added over time, these will be optional value-added features and not a requirement to use Windows Admin Center.

## Are there any other dependencies or prerequisites?

Windows Admin Center can be installed on Windows 10 Fall Anniversary Update (1709) or newer, or Windows Server 2016 or newer. To manage Windows Server 2012 or 2012 R2, installation of Windows Management Framework 5.1 is required on those servers. There are no other dependencies. IIS is not required, agents are not required, SQL Server is not required.

## What about extensibility and 3rd-party support?

The Windows Admin Center SDK is available in public preview. As a platform, growing our ecosystem and enabling partner extensibility has been a key priority since the beginning. We’ve been working with early-adopter partners to refine the extension development experience of our SDK. If you’re going to the Microsoft Build conference in May, be sure to stop by our booth.  [Read more about the Windows Admin Center SDK](..\extend\extensibility-overview.md).

## Can I manage Hyper-Converged Infrastructure with Windows Admin Center?

Yes. Windows Admin Center supports the management of hyper-converged clusters running Windows Server 2016 or Windows Server 2019 Insider Preview builds. The hyper-converged cluster manager solution in Windows Admin Center is a production-ready preview and we will continue to enhance and complete key scenarios (in compute, storage, networking, and clustering) to align with the launch of Windows Server 2019 later this year.  For more information, [read more about managing hyper-converged infrastructure](..\use\manage-hyper-converged.md).

## Does Windows Admin Center require System Center?

No.  Windows Admin Center is complementary to System Center, but System Center is not required.

## Can Windows Admin Center replace System Center Virtual Machine Manager (SCVMM)?

Windows Admin Center and SCVMM are complementary; Windows Admin Center is intended to replace the traditional Microsoft Management Console (MMC) snap ins and the server admin experience.  Windows Admin Center is not intended to replace the monitoring aspects of SCVMM.

## Where can I learn more about Windows Admin Center, or get more details on the topics above?

Our [launch page](https://aka.ms/WindowsAdminCenter) is the best starting point and has links to our newly categorized documentation content, download location, how to provide feedback, reference information, and other resources.

## What is the version history of Project Honolulu leading up to Windows Admin Center GA?

Leading up to the Microsoft Ignite conference in September 2017, we announced Project Honolulu Technical Preview, and explained our rationale and our vision.

* Version [1804](https://aka.ms/WindowsAdminCenter) is released as Windows Admin Center and adds security features, role-based access control, and is our first GA release.
* Version [1803](https://blogs.windows.com/windowsexperience/2018/03/13/announcing-project-honolulu-technical-preview-1803-and-rsat-insider-preview-for-windows-10) added support for AAD access control, detailed logging, resizable content, and a bunch of tool improvements.
* Version [1802](https://blogs.windows.com/windowsexperience/2018/02/13/announcing-windows-server-insider-preview-build-17093-project-honolulu-technical-preview-1802) added support for accessibility, localization, high-availability deployments, tagging, Hyper-V host settings, and gateway authentication.
* Version [1712](https://blogs.windows.com/windowsexperience/2017/12/19/announcing-project-honolulu-technical-preview-1712-build-05002) added more virtual machine features and performance improvements throughout the tools.
* Version [1711](https://cloudblogs.microsoft.com/windowsserver/2017/12/01/1711-update-to-project-honolulu-technical-preview-is-now-available/) added highly anticipated tools (Remote Desktop, and PowerShell) along with other improvements.
* Version [1709](https://cloudblogs.microsoft.com/windowsserver/2017/09/22/project-honolulu-technical-preview-is-now-available-for-download/) launched as our first public preview release.

## I'm having an issue with Windows Admin Center, where can I get help?

See our [troubleshooting guide](..\use\troubleshooting.md) and our list of [known issues](..\use\known-issues.md).
