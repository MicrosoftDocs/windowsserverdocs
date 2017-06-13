---
title: Changes to the Windows Server release model
description: Microsoft is streamlining servicing of Windows Server to make operating system updates simpler to test, manage, and deploy.
ms.prod: Windows Server
ms.mktglfcycl: manage
ms.sitesec: library
author: jaimeo
localizationpriority: high
ms.date: 
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 9cf87597-b15d-4f43-8aa1-91e60367f011
---

>Applies To: Windows Server semi-annual channel

# Windows Server in the Semi-annual Channel (working title)
The Windows Server release model is offering a new option in order to align with similar release and servicing models for [Windows 10](https://docs.microsoft.com/en-us/windows/deployment/update/waas-overview) and [Office 365 ProPlus](https://support.office.com/en-us/article/Overview-of-the-upcoming-changes-to-Office-365-ProPlus-update-management-78b33779-9356-4cdf-9d2c-08350ef05cca?ui=en-US&rs=en-US&ad=US). If you've been working with Windows 10 or Office 365 ProPlus, these improvements might already be familiar to you.

**There will be two primary release channels available to Windows Server customers, the Long-term Servicing Channel, and the new semi-annual channel.**

## Long-term Servicing Channel
This is the release model you’re already familiar with (currently called the “Long-term Servicing *Branch*”) where a new major version of Windows Server is released every 2-3 years and entitled to 5 years of mainstream support with [Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx), 5 years of extended support, and optionally 6 more years with Premium Assurance. This channel is appropriate for systems that require a longer servicing option and functional stability. Deployments of Windows Server 2016 and earlier versions of Windows Server will not be affected by the new semi-annual channel releases. The Long-term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.



# semi-annual channel
The semi-annual channel releases will deliver new functionality for customers who are moving at a “cloud cadence," such as those on rapid development cycles or hosters keeping up with the latest Hyper-V investments. Windows Server products in the semi-annual channel will have new releases available twice a year, in March and September. Each release in this channel will be supported for 18 months from the initial release.

The features introduced in the semi-annual channel might be rolled up into the next Long-Term Servicing Channel release of Windows Server. The editions, functionality, and supporting content might vary from release to release depending on customer feedback.

The semi-annual channel will be available to volume-licensed customers with Software Assurance, as well as the Azure Marketplace or other cloud/hosting service providers and loyalty programs such as MSDN.

There will be two phases to each semi-annual channel release:

- **semi-annual channel (pilot)**: the first release, intended for application validation, developers and end-user acceptance testing before broad deployment. 
- **semi-annual channel (broad)**: several months later, the pilot release will be declared ready for broad deployment. Media sources will be refreshed with new media that contains the original pilot build plus any applicable security and non-security updates. The build is now appropriate for broad deployment in production. Customers who installed the original pilot build and have kept up with cumulative updates do not need to re-install the build when it is declared ready for broad deployment. 


![semi-annual channel release timing](media/SAC-release-timing.png)

In this new model, Windows Server releases are planned for a year/month such as 1709: in 2017, on the 9th month (September). Windows and Office, and now Windows Server as well, will release semi-annually in March and September. So we expect another release in March 2018 (1803), and every 6 months after that. The support lifecycle for each release is 18 months starting with day 1 of the pilot phase.


<include a recommendation about how customers should consume the semi-annual channel releases (deployment as a process rather than a project, how to use the pilot phase as opposed to the broad phase, etc.>

## Device compatibility
Unless otherwise communicated, the minimum hardware requirements to run the semi-annual channel releases will be the same as the most recent Long-term Servicing Channel release of Windows Server. (Today, that is Windows Server 2016.) Most hardware drivers will continue to function in these releases.

## Servicing
Both the Long-term Servicing Channel and the semi-annual channel releases will be supported with security updates and non-security updates. The difference is the length of time that the release is supported, as described above.

### Servicing tools
There are many tools with which IT pros can service Windows Server. Each option has its pros and cons, ranging from capabilities and control to simplicity and low administrative requirements. The following are examples of the servicing tools available to manage servicing updates:

- Windows Update (stand-alone). This option is only available for servers that are connected to the Internet and have Windows Update enabled.
- Windows Server Update Services (WSUS) provides extensive control over Windows 10 updates and is natively available in the Windows Server operating system. In addition to the ability to defer updates, organizations can add an approval layer for updates and choose to deploy them to specific computers or groups of computers whenever ready.
- System Center Configuration Manager provides the greatest control over servicing. IT pros can defer updates, approve them, and have multiple options for targeting deployments and managing bandwidth usage and deployment times.

With all these options, which an organization chooses depends on the resources, staff, and expertise its IT organization already has. For example, if IT already uses System Center Configuration Manager to manage updates, it can continue to use it. Similarly, if IT is using WSUS, it can continue to use that. This table provides a consolidated look at the benefits of each tool.

|Servicing tool|	Can updates be deferred?|	Ability to approve updates|	Peer-to-peer option|	Additional features|
|-----------------|-----------------------|-------------------------------|-------------------|-------------------------|
|Windows Update|	Yes (manual)|	No|	Delivery Optimization|	None|
|Windows Update for Business|	Yes|	No|	Delivery Optimization|	Other Group Policy objects|
|WSUS|	Yes|	Yes|	BranchCache or Delivery Optimization|	Upstream/downstream server scalability|
|System Center Configuration Manager|	Yes|	Yes|	BranchCache, Client Peer Cache|	Distribution points, multiple deployment options|

## Windows Insider Program
For many IT pros and application developers, gaining visibility into new functionality early--before they’re released--can be both intriguing and valuable. Testing the early builds of Windows Server helps both Microsoft and its customers because of the opportunity to discover possible issues before release. It also gives customers a unique opportunity to directly influence the functionality in the product. Microsoft depends on receiving feedback throughout the development process so that adjustments may be made as quickly as possible. Early testing and feedback is essential to the rapid release model.

Pre-release builds of Windows Server will be available for download via the Windows Insider Program and the Windows Insider Program for Business. The server editions available on the Windows Insider Program may vary depending on the current stage of the development cycle. To join the Windows Insider Program, follow these steps:

1. Register at [Windows Insider Program for Business](https://insider.windows.com/ForBusiness). 
2. Register a Windows 10 device for Insider flights. 
3. Choose one or more servers for preview testing. 
4. Download builds from the [Windows Server Insider Preview](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver) page.
5. Bookmark the Docker Hub or other external sites where some code and docs will be published.
6. Send us your feedback via the Windows 10 Feedback Hub application.
7. Join the [Windows Server Tech Community](https://techcommunity.microsoft.com/t5/Windows-Server/ct-p/Windows-Server) to collaborate, share and learn from experts. 


 
Related topics




