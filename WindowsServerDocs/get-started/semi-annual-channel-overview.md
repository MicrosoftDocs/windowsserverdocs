---
title: Windows Server Semi-Annual Channel overview
description: Microsoft is streamlining servicing of Windows Server to make operating system updates simpler to test, manage, and deploy.
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: jaimeo
ms.localizationpriority: high
ms.date: 05/07/2018
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 9cf87597-b15d-4f43-8aa1-91e60367f011
---
# Windows Server Semi-Annual Channel overview

>Applies To: Windows Server (Semi-Annual Channel)

The Windows Server release model offers a new option in order to align with similar release and servicing models for [Windows 10](https://docs.microsoft.com/windows/deployment/update/waas-overview) and [Office 365 ProPlus](https://support.office.com/article/Overview-of-the-upcoming-changes-to-Office-365-ProPlus-update-management-78b33779-9356-4cdf-9d2c-08350ef05cca?ui=en-US&rs=en-US&ad=US). If you've been working with Windows 10 or Office 365 ProPlus, these improvements might already be familiar to you.

**There are two primary release channels available to Windows Server customers, the Long-Term Servicing Channel and the Semi-Annual Channel.** You can keep servers on the Long-Term Servicing Channel (LTSC), move them to the Semi-Annual Channel, or have some servers on either track, depending on what works best for your needs.


## Long-Term Servicing Channel (LTSC)
This is the release model you’re already familiar with (formerly called the “Long-Term Servicing *Branch*”) where a new major version of Windows Server is released every 2-3 years. Users are entitled to 5 years of mainstream support and 5 years of extended support. This channel is appropriate for systems that require a longer servicing option and functional stability. Deployments of Windows Server 2016 and earlier versions of Windows Server will not be affected by the new Semi-Annual Channel releases. The Long-Term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.

> [!Note]  
> **The current LTSC product is Windows Server 2016**. If you want to stay in this channel, you should install (or continue using) Windows Server 2016, which can be installed in Server Core installation option or Server with Desktop Experience installation option. See [Get Started with Windows Server 2016](https://docs.microsoft.com/windows-server/get-started/server-basic) for details. 



## Semi-Annual Channel 
The Semi-Annual Channel is perfect for customer who are innovating quickly to take advantage of new operating system capabilities at a faster pace, both in applications – particularly those built on containers and microservices, as well as in the software-defined hybrid datacenter. Windows Server products in the Semi-Annual Channel will have new releases available twice a year, in spring and fall. Each release in this channel will be supported for 18 months from the initial release.

Most of the features introduced in the Semi-Annual Channel will be rolled up into the next Long-Term Servicing Channel release of Windows Server. The editions, functionality, and supporting content might vary from release to release depending on customer feedback.

The Semi-Annual Channel will be available to volume-licensed customers with [Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx), as well as via the Azure Marketplace or other cloud/hosting service providers and loyalty programs such as Visual Studio Subscriptions.

> [!Note]  
> **The current Semi-Annual Channel release is Windows Server, version 1803**. If you want to put servers in this channel, you should install Windows Server, version 1803, which can be installed in Server Core mode or as Nano Server run in a container. See [Introducing Windows Server, version 1803](get-started-with-1803.md) to learn how to obtain and activate Windows Server, version 1803. In-place upgrades from Windows Server 2016 to Windows Server, version 1803 are not supported because they are in **different release channels**. Windows Server, version 1803 is not an update to Windows Server 2016 – it is the next Windows Server release in the Semi-Annual Channel.



In this model, Windows Server releases are identified by the year and month of release: for example, in 2017, a release in the 9th month (September) would be identified as **version 1709**. Fresh releases of Windows Server in the Semi-Annual Channel will occur twice each year. The support lifecycle for each release is 18 months.

## Should you keep servers on the LTSC or move them to the Semi-Annual Channel?
These are the key differences to take into account:

- Do you need to innovate rapidly? Do you need early access to the newest Windows Server features? Do you need to support fast-cadence hybrid applications, dev-ops, and Hyper-V fabrics? If so, you should consider **joining the Semi-Annual Channel** by installing [Windows Server, version 1803](get-started-with-1803.md). As described in this topic, you will receive new versions twice a year, with 18 months of mainstream production support per release. You get it through volume licensing, Azure, or Visual Studio Subscription Services. Currently, releases in the Semi-Annual Channel require volume licensing and Software Assurance if you intend to run the product in production.
- Do you need stability and predictability? Do you need to run virtual machines and traditional workloads on physical servers? If so, you should consider **keeping those servers on the Long-Term Servicing Channel**. The current LTSC release is [Windows Server 2016](server-basics.md). As described in this topic, you'll have access to new versions every 2-3 years, with 5 years of mainstream support followed by 5 years of extended support per release. LTSC releases are available through all release mechanisms. Releases in the LTSC are available to anyone regardless of the licensing model they are using. 

The following table summarizes the key differences between the channels, starting with Windows Server, version 1803:

|  | Long-Term Servicing Channel (Windows Server 2016) |Semi-Annual Channel (Windows Server) |
| ------------------- | ------------------------------------ | ------------------------------------------------- |
|Recommended scenarios | General purpose file servers, Microsoft and non-Microsoft workloads, traditional apps, infrastructure roles, software-defined Datacenter, and hyper-converged infrastructure | Containerized applications, container hosts, and application scenarios benefiting from faster innovation |
| New releases | Every 2–3 years |Every 6 months |
| Support |5 years of mainstream support, plus 5 years of extended support | 18 months |
| Editions | All available Windows Server editions | Standard and Datacenter editions |
| Who can use | All customers through all channels | Software Assurance and cloud customers only |
| Installation options | Server Core and Server with Desktop Experience | Server Core for container host and image and Nano Server container image |                |


## Device compatibility
Unless otherwise communicated, the minimum hardware requirements to run the Semi-Annual Channel releases will be the same as the most recent Long-Term Servicing Channel release of Windows Server. For example, **the current Long-Term Servicing Channel release is Windows Server 2016**. Most hardware drivers will continue to function in these releases.

## Servicing
Both the Long-Term Servicing Channel and the Semi-Annual Channel releases will be supported with security updates and non-security updates. The difference is the length of time that the release is supported, as described above.

### Servicing tools
There are many tools with which IT pros can service Windows Server. Each option has its pros and cons, ranging from capabilities and control to simplicity and low administrative requirements. The following are examples of the servicing tools available to manage servicing updates:

- **Windows Update (stand-alone)**: This option is only available for servers that are connected to the Internet and have Windows Update enabled.
- **Windows Server Update Services (WSUS)** provides extensive control over Windows 10 and Windows Server updates and is natively available in the Windows Server operating system. In addition to the ability to defer updates, organizations can add an approval layer for updates and choose to deploy them to specific computers or groups of computers whenever ready.
- **System Center Configuration Manager** provides the greatest control over servicing. IT pros can defer updates, approve them, and have multiple options for targeting deployments and managing bandwidth usage and deployment times.

You’ve likely already chosen to use at least one of these options based on your resources, staff, and expertise. You can continue using the same process for Semi-Annual Channel Releases: for example, if you already use System Center Configuration Manager to manage updates, you can continue to use it. Similarly, if you are using WSUS, you can continue to use that.

## Obtain preview releases through the Windows Insider Program
For many IT pros and application developers, gaining access to new functionality early--before they’re released--can be both intriguing and valuable. Testing the early builds of Windows Server helps both Microsoft and its customers because of the opportunity to discover possible issues before release. It also gives customers a unique opportunity to directly influence the functionality in the product. Microsoft depends on receiving feedback throughout the development process so that adjustments may be made as quickly as possible. Early testing and feedback is essential to the rapid release model.

Pre-release builds of Windows Server will be available for download via the Windows Insider Program and the [Windows Insider Program for Business](https://insider.windows.com/en-us/for-business-getting-started-server/). The server editions available on the Windows Insider Program may vary depending on the current stage of the development cycle. To join the Windows Insider Program, follow these steps:

1. Register at [Windows Insider Program for Business](https://insider.windows.com/ForBusiness). 
2. Choose one or more servers for preview testing. 
3. Download builds from the [Windows Server Insider Preview](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver) page. See the [Windows Server blog](https://blogs.technet.microsoft.com/windowsserver/ ) for an announcement when the preview is available.
4. Bookmark the Docker Hub or other external sites where some code and docs will be published. See [Windows Containers Documentation](https://aka.ms/containers/insiders).
5. Send us your feedback via the Windows 10 Feedback Hub application.
6. Join the [Windows Server Tech Community](https://techcommunity.microsoft.com/t5/Windows-Server/ct-p/Windows-Server) to collaborate, share and learn from experts. 


 
# Related topics
[Changes to Nano Server in Windows Server Semi-Annual Channel](nano-in-semi-annual-channel.md)

[Windows Server support lifecycle](https://support.microsoft.com/en-us/lifecycle)

[Windows Server 2016 System Requirements](https://docs.microsoft.com/windows-server/get-started/system-requirements) 




