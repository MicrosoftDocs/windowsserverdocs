---
title: Windows Admin Center Frequently Asked Questions
description: Windows Admin Center Frequently Asked Questions (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Windows Admin Center Frequently Asked Questions

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

## Q: What is Windows Admin Center?

**A:** Windows Admin Center is a lightweight, browser-based GUI platform and toolset for IT Admins to manage Windows Server and Windows 10. It is the evolution of familiar in-box administrative tools, such as Server Manager and Microsoft Management Console (MMC) into a modernized, simplified, integrated, and secure experience.  [Read more about the capabilities of Windows Admin Center](capabilities.md).

## Q: Why was "Windows Admin Center" chosen as the final name for Project "Honolulu"?

**A:** Windows Admin Center is now the official product name for Project "Honolulu" and reinforces our vision of an integrated experience for IT admins across a breadth of core administrative and management scenarios. It also highlights our customer-focus on IT admin user needs as central to how we invest and what we deliver.

## Q: Can I use Windows Admin Center in production environments?

**A:** Yes. Windows Admin Center is generally available and ready for broad usage and production deployments. As a platform that will continue to grow and mature, exiting preview means that the current platform capabilities and core tools have met Microsoft’s standard release criteria and our quality bar for usability, reliability, performance, accessibility, security, and adoption.

## Q: How much does it cost to use Windows Admin Center?

**A:** Windows Admin Center has no additional cost beyond Windows. As a separate download, Windows Admin Center can be used with valid licenses of Windows Server or Windows 10 at no additional cost since it’s licensed under a Windows Supplemental EULA.

## Q: What versions of Windows Server can I manage with Windows Admin Center?

**A:** Windows Admin Center will be optimized for Windows Server 2019 and enable key themes in the upcoming Windows Server 2019 release: hybrid cloud scenarios and hyper-converged infrastructure management in particular. Although Windows Admin Center will work best with Windows Server 2019, it supports managing a variety of versions that customers already use: Windows Server 2012 and newer. 

## Q: Is Windows Admin Center a complete replacement for all traditional in-box and RSAT tools?
**A:** No. Although Windows Admin Center can manage many common scenarios, it does not completely replace all traditional Microsoft Management Console (MMC) tools. For a detailed look at what tools are included with Windows Admin Center, read more about managing servers in our documentation. Windows Admin Center has the following key capabilities in its Server Manager solution:

-	Displaying resources and resource utilization
-	Certificate Management
-	Managing Devices
-	Event Viewer
-	File Explorer
-	Firewall Management
-	Configuring Local Users and Groups
-	Network Settings
-	Viewing/Ending Processes and Creating Process Dumps
-	Registry Editing
-	Managing Windows Services
-	Enabling/Disabling Roles and Features
-	Managing Hyper-V VMs and Virtual Switches
-	Managing Storage
-	Managing Windows Updates
-	PowerShell console
-	Remote Desktop connection
-   Storage Replica

Windows Admin Center also provides these solutions:
-	Computer Management – Provides a subset of the Server Manager features for managing Windows 10 client PCs
-	Failover Cluster Manager – Provides support for ongoing management of failover clusters and cluster resources
-	Hyper-Converged Cluster Manager – Provides an all-new experience tailored for Storage Spaces Direct and Hyper-V. It features the Dashboard and emphasizes charts and alerts for monitoring.

Windows Admin Center is complementary to and does not replace RSAT (Remote Server Administration Tools) since roles such as Active Directory, DHCP, DNS, IIS do not yet have equivalent management capabilities surfaced in Windows Admin Center.

## Q: Can Windows Admin Center be used to manage the free Microsoft Hyper-V Server?

**A:** Yes. Windows Admin Center can be used to manage Microsoft Hyper-V Server 2016 and Microsoft Hyper-V Server 2012 R2.

## Q: Can I deploy Windows Admin Center on a Windows 10 computer?

**A:** Yes, Windows Admin Center can be installed on a Windows 10 computer, running in desktop mode.  Windows Admin Center can also be installed on a server running Windows Server 2016 in service mode, and then accessed via a web browser from a Windows 10 computer.  [Learn more about installation options](..\plan\installation-options.md).

[need W10 1709 for Edge browser usage]

## Q: Which web browsers are supported by Windows Admin Center?
**A:** The latest versions of Microsoft Edge and Google Chrome browsers are tested and supported on Windows 10. Other modern web browsers or other platforms are not currently part of our test matrix and are therefore not officially supported.

## Q: How does Windows Admin Center handle security?
**A:** Traffic from the browser to the Windows Admin Center gateway uses HTTPS. Traffic from the gateway to managed servers is standard PowerShell and WMI over WinRM. We support LAPS (Local Administrator Password Solution), resource-based constrained delegation, gateway access control using AD or Azure AD, and role-based access control for managing target servers.

## Q: Are there any cloud dependencies?
**A:** Windows Admin Center does not require internet access and does not require Microsoft Azure. Windows Admin Center manages Windows Server and Windows instances anywhere: on physical systems, or in virtual machines on any hypervisor, or running in any cloud. Although integration with various Azure services will be added over time, these will be optional value-added features and not a requirement to use Windows Admin Center.

## Q: Are there any other dependencies or prerequisites?
**A:** Windows Admin Center can be installed on Windows 10 Fall Anniversary Update (1709) or newer, or Windows Server 2016 or newer. To manage Windows Server 2012 or 2012 R2, installation of Windows Management Framework 5.1 is required on those servers. There are no other dependencies. IIS is not required, agents are not required, SQL Server is not required.  

## Q: What about extensibility and 3rd-party support?
**A:** The Windows Admin Center SDK will soon launch in public preview. As a platform, growing our ecosystem and enabling partner extensibility has been a key priority since the beginning. We’ve been working with early-adopter partners to refine the extension development experience in a private preview of our SDK. Look for a public preview SDK release announcement in the coming weeks, and if you’re going to the Microsoft Build conference in May, be sure to stop by our booth.  [Read more about the Windows Admin Center SDK](..\extend\how-sdk-works.md).

## Q: What is the state of the Hyper-Converged UI, and will it support Windows Server 2016?
**A:** The hyper-converged cluster manager solution in Windows Admin Center is a production-ready preview and we will continue to enhance and complete key scenarios (in compute, storage, networking, and clustering) to align with the launch of Windows Server 2019 later this year. In the meantime, we are excited to announce the upcoming delivery of a top user request: support for managing hyper-converged clusters on Windows Server 2016. This takes the form of a Windows Update package for Windows Server 2016 which will be published in the catalog the third week of April, and will be part of the cumulative update package for May.  For more information, [read more about managing hyper-converged infrastructure](..\use\manage-hyper-converged.md).

## Q: When managing Hyper-Converged Infrastructure, are there differences between managing Windows Server 2016 and Windows Server Insider Preview?

**A:** Yes. Windows Admin Center for Hyper-Converged Infrastructure receives frequent updates that improve the experience for both Windows Server 2016 and Windows Server Insider Preview. However, certain new features are only available for Insider Preview – for example, the toggle switch for deduplication and compression.

## Q: Can I use Windows Admin Center to manage Storage Spaces Direct for other use cases (not hyper-converged), such as converged Scale-Out File Server (SoFS) or Microsoft SQL Server?

**A:** Project Honolulu for Hyper-Converged Infrastructure does not provide management or monitoring options specifically for other use cases of Storage Spaces Direct – for example, it can’t create file shares. However, the Dashboard and core features, such as creating volumes or replacing drives, work for any Storage Spaces Direct cluster.

## Q: What’s the difference between a Failover Cluster and a Hyper-Converged Cluster?

**A:** In general, the term “hyper-converged” refers to running Hyper-V and Storage Spaces Direct on the same clustered servers to virtualize compute and storage resources. In the context of Windows Admin Center, when you click + Add from the connections list, you can choose between adding a Failover Cluster connection or a Hyper-Converged Cluster connection:

- The Failover Cluster connection is the successor to the Failover Cluster Manager desktop app. It provides a familiar, general-purpose management experience for any cluster supporting any workload, including Microsoft SQL Server. It is available for Windows Server 2012 R2 and later.

- The Hyper-Converged Cluster connection is an all-new experience tailored for Storage Spaces Direct and Hyper-V. It features the Dashboard and emphasizes charts and alerts for monitoring. It is available for Windows Server 2016 and Windows Server Insider Preview.

## Q: When managing Hyper-Converged Infrastructure, why do I need the latest cumulative update for Windows Server 2016?

**A:** Windows Admin Center for Hyper-Converged Infrastructure depends on management APIs developed since Windows Server 2016 was released. These APIs are available as of April 2018.

## Q: Does Windows Admin Center require System Center?

**A:** No.  Windows Admin Center is complementary to System Center, but System Center is not required.

## Q: Can Windows Admin Center replace System Center Virtual Machine Manager (SCVMM)?

**A:** Windows Admin Center and SCVMM are complementary; Windows Admin Center is intended to replace the traditional Microsoft Management Console (MMC) snap ins and the server admin experience.  Windows Admin Center is not intended to replace the monitoring aspects of SCVMM.  

## Q: Where can I learn more about Windows Admin Center, or get more details on the topics above?

**A:** Our launch page: https://aka.ms/WindowsAdminCenter is the best starting point and has links to our newly categorized documentation content, download location, how to provide feedback, reference information, and other resources.

Q: [I'm having an issue with Windows Admin Center, what do I do]

A: [see our troubleshooting section]
