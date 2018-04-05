---
title: Windows Admin Center Frequently Asked Questions
description: "Windows Admin Center Frequently Asked Questions"
ms.technology: Windows Admin Center
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.manager: samli
ms.date: 03/30/2018
---

# Windows Admin Center Frequently Asked Questions

## Q: What is Windows Admin Center?

**A:** Windows Admin Center is a lightweight, browser-based GUI platform and toolset for IT Admins to manage Windows Server and Windows 10. It is the evolution of familiar in-box administrative tools, such as Server Manager and Microsoft Management Console (MMC) into a modernized, simplified, integrated, and secure experience.  [Read more about the capabilities of Windows Admin Center](capabilities.md).

## Q: Did Microsoft change the name of Project "Honolulu" to Windows Admin Center?

**A:** Windows Admin Center is now the official product name for Project "Honolulu" and reinforces our vision of an integrated experience for IT admins across a breadth of core administrative and management scenarios. It also highlights our customer-focus on IT admin user needs as central to how we invest and what we deliver.

## Q: Is Windows Admin Center a complete replacement for all traditional Microsoft Management Console (MMC) tools?

**A:** Although Windows Admin Center can manage many common scenarios, it does not completely replace the MMC. For a detailed look at what tools are included with Windows Admin Center, [read more about managing servers](..\use\manage-servers.md). Windows Admin Center has the following capabilities:

-   Displaying resources and resource utilization
-   Certificate Management
-   Managing Devices
-   Event Viewer
-   File Explorer
-   Firewall Management
-   Configuring Local Users and Groups
-   Network Settings
-   Viewing/Ending Processes and Creating Process Dumps
-   Registry Editing
-   Managing Windows Services
-   Enabling/Disabling Roles and Features
-   Managing Hyper-V VMs and Virtual Switches
-   Managing Storage
-   Managing Windows Updates

Windows Admin Center does not currently replicate the following RSAT tools:

-   AD Directory Administrative Center
-   AD Domains and Trusts
-   AD Module for Windows PowerShell
-   AD Site and Services
-   AD Users and Computers
-   ADSI Edit
-   Cluster Aware Updating
-   Component Services
-   DFS Management
-   DHCP
-   DNS
-   Failover Cluster Manager
-   File Server Resource Manager
-   Group Policy Management
-   iSCSI initiator
-   Network Load Balancing Manager
-   Performance Monitor
-   Print Management
-   Remote Access management
-   Routing and Remote Access
-   Shielding Data File Wizard
-   Task Scheduler
-   Volume Activation Tools
-   Windows Server Update Services

## Q: What operating systems can Windows Admin Center manage?

**A:** Windows Admin Center can manage the following operating systems:

-   Windows Server 2016 Standard and Datacenter
-   Windows Server 2012 and 2012 R2 Standard and Datacenter
-   Microsoft Hyper-V Server 2016
-   Microsoft Hyper-V Server 2012 R2
-   Microsoft Windows 10

[Find out more about supported operating systems here](..\plan\installation-options.md)

## Q: Can Windows Admin Center be used to manage the free Microsoft Hyper-V Server?

**A:** Yes. Windows Admin Center can be used to manage Microsoft Hyper-V Server 2016 and Microsoft Hyper-V Server 2012 R2.

## Q: Can I deploy Windows Admin Center on a Windows 10 computer?

**A:** Yes, Windows Admin Center can be installed on a Windows 10 computer, running in desktop mode.  Windows Admin Center can also be installed on a server running Windows Server 2016 in service mode, and then accessed via a web browser from a Windows 10 computer.  [Learn more about installation options](..\plan\installation-options.md).

## Q: Will Windows Admin Center work with Windows Server 2019?

**A:** Windows Admin Center will be optimized for Windows Server 2019. We’re committed to continue adding customer value by addressing user feedback, improving and releasing updates on a regular basis, and enabling key themes in the upcoming Windows Server 2019 release: hybrid cloud scenarios and hyper-converged infrastructure management in particular.

## Q: Can Windows Admin Center be used in production?

**A:** Yes, as of April 12th, 2018, Windows Admin Center is generally available and ready for broad usage and production deployments. As a platform that will continue to grow and mature, exiting preview means that the current platform capabilities and core tools have met Microsoft’s standard release criteria and our quality bar for usability, reliability, performance, accessibility, security, and adoption. Deploy it today: https://aka.ms/WindowsAdminCenter

## Q: What does Windows Admin Center cost?

**A:** Windows Admin Center has no additional cost beyond Windows. As a separate download, Windows Admin Center can be used with valid licenses of Windows Server or Windows 10 at no additional cost, since it’s licensed under a Windows Supplemental EULA.

## Q: Does Windows Admin Center work with Hyper-Converged Infrastructure?

**A:** Windows Admin Center enables Hyper-Converged UI for Windows Server 2016. The hyper-converged cluster manager solution in Windows Admin Center is a production-ready preview and we will continue to enhance and complete key scenarios (in compute, storage, networking, and clustering) to align with the launch of Windows Server 2019 later this year. In the meantime, we are excited to announce the upcoming delivery of a top user request: support for managing hyper-converged clusters on Windows Server 2016.  For more information, [read more about managing hyper-converged infrastructure](..\use\manage-hyper-converged.md).

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

**A:** No.

## Q: Can Windows Admin Center replace System Center Virtual Machine Manager (SCVMM)?

**A:** Windows Admin Center and SCVMM are complementary; Windows Admin Center is intended to replace the traditional Microsoft Management Console (MMC) snap ins and the server admin experience.  Windows Admin Center is not intended to replace the monitoring aspects of SCVMM.  

## Q: Does Windows Admin Center require an Internet connection?

**A:** No. Although Windows Admin Center offers powerful and convenient integration with the Microsoft Azure cloud, the core management and monitoring experience for Hyper-Converged Infrastructure is completely on-premises. It can be installed and used without an Internet connection.

## Q: Is there an SDK for Windows Admin Center?

**A:** Windows Admin Center SDK will soon launch in public preview. As a platform, growing our ecosystem and enabling partner extensibility has been a key priority since the beginning. We’ve been working with early-adopter partners to refine the extension development experience in a private preview of our SDK. Look for a public preview SDK release announcement in the coming weeks, and if you’re going to the Microsoft Build conference in May, be sure to stop by our booth!  [Read more about the Windows Admin Center SDK](..\extend\how-sdk-works.md).

