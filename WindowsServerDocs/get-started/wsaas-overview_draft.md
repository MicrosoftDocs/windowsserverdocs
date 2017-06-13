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

>Applies To: Windows Server Semi-annual Channel

# Windows Server in the Semi-annual Channel (working title)
The Windows Server release model is offering a new option in order to align with similar release and servicing models for Windows 10 [LINK] and Office 365 ProPlus [LINK]. If you've been working with Windows 10 or Office 365 ProPlus, these improvements might already be familiar to you.

**There will be two primary release channels available to Windows Server customers, the Long-term Servicing Channel, and the new Semi-annual Channel.**

## Long-term Servicing Channel
This is the release model you’re already familiar with (currently called the “Long-term Servicing *Branch*”) where a new major version of Windows Server is released every 2-3 years and entitled to 5 years of mainstream support and 6 years of support with Premium Assurance [Link]. This channel is appropriate for systems that require a longer servicing option and functional stability. Deployments of Windows Server 2016 and earlier versions of Windows Server will not be affected by the new Semi-annual Channel releases. The Long-term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.

# Semi-annual Channel
The Semi-annual Channel releases will deliver new functionality for customers who are moving at a “cloud cadence," such as those on rapid development cycles or hosters keeping up with the latest Hyper-V investments. Windows Server products in the Semi-annual Channel will have new releases available twice a year, in March and September. Each release in this channel will be supported for 18 months from the initial release.

The features introduced in the Semi-annual Channel might be rolled up into the next Long-Term Servicing Channel release of Windows Server. The editions, functionality, and supporting content might vary from release to release depending on customer feedback.

The Semi-annual Channel will be available to volume-licensed customers with Software Assurance, as well as the Azure Marketplace or other cloud/hosting service providers and loyalty programs such as MSDN.

There will be two phases to each Semi-annual Channel release:

- Semi-annual Channel (pilot): the first release, intended for application validation, developers and end-user acceptance testing before broad deployment. 
- Semi-annual Channel (broad): several months later, the pilot release will be declared ready for broad deployment. Media sources will be refreshed with new media that contains the original pilot build plus any applicable security and non-security updates. The build is now appropriate for broad deployment in production. Customers who installed the original pilot build and have kept up with cumulative updates do not need to re-install the build when it is declared ready for broad deployment. 


![Semi-annual Channel release timing](media/SAC-release-timing.png)

	• <This would be a good place to explain the numbering system (1709, 1803 and include the picture)>
	• <graphic below should have Creator's Update removed.>
	• 
 

	
<include a recommendation about how customers should consume the semi-annual channel releases (deployment as a process rather than a project, how to use the pilot phase as opposed to the broad phase, etc.>

## Device compatibility
Unless otherwise communicated, the minimum hardware requirements to run the Semi-Annual Channel releases will be the same as the most recent Long-term Servicing Channel release of Windows Server. (Today, that is Windows Server 2016). Most hardware drivers will continue to function in these releases.

## Servicing
Both the Long-term Servicing Channel and the Semi-annual Channel releases will be supported with security updates and non-security updates. The difference is the length of time that the release is supported, as described above.

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
For many IT pros and application developers, gaining visibility into new functionality early—before they’re released - can be both intriguing and valuable. Testing the early builds of Windows Server helps both Microsoft and its customers because of the opportunity to discover possible issues before release. It also gives customers a unique opportunity to directly influence the functionality in the product. Microsoft depends on receiving feedback throughout the development process so that adjustments may be made as quickly as possible. Early testing and feedback is essential to the rapid release model.

Pre-release builds of Windows Server will be available for download via the Windows Insider Program and the Windows Insider Program for Business. The server editions available on the Windows Insider Program may vary depending on the current stage of the development cycle. 


 
Related topics




