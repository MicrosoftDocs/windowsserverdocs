---
title: Introducing Windows Server, version 1709
description: How to obtain, install, and activate
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: jaimeo
ms.localizationpriority: high
ms.date: 12/5/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 9cf87597-b15d-4f43-8aa1-91e60367f011
---
# Introducing Windows Server, version 1709

>Applies To: Windows Server (Semi-Annual Channel)

**Windows Server, version 1709 is the first release in the new Semi-Annual Channel.** 

## What the Semi-Annual Channel is--and isn't
As the first release in this new channel, Windows Server, version 1709 is *not* an "update" or "service pack" for Windows Server 2016. It's the first of twice-yearly server releases on a **new release track** that is designed for customers who are moving at a “cloud cadence," such as those on rapid development cycles or hosters keeping up with the latest Hyper-V investments. Each release in this track is supported for 18 months from the initial release. For more about Semi-Annual Channel, plus **tips for deciding which channel to join** (or remain on) see [Semi-Annual Channel Overview](semi-annual-channel-overview.md).


**The current Long-Term Servicing Channel (LTSC) product is Windows Server 2016**. The LTSC is best if you need long-term stability and predictability in your server operating system to support traditional workloads and applications. If you want to stay in the LTSC, you should install (or continue using) Windows Server 2016, which can be installed in either Server Core mode or Server with Desktop Experience mode. See [Get Started with Windows Server 2016](https://docs.microsoft.com/windows-server/get-started/server-basics) for details.


## What's different about 1709?

Windows Server, version 1709 runs in Server Core mode. That means there is no graphical user interface, so you manage it remotely. However, it offers great advantages such as smaller hardware requirements, much smaller attack surface, and a reduction in the need for updates. If you're new to working with Server Core, [Manage a Server Core server](../administration/server-core/server-core-manage.md) will help you get used to this environment. [Manage Windows Server 2016](../administration/manage-windows-server.md) shows you the various options for managing servers remotely.

[What's New in Windows Server version 1709](whats-new-in-windows-server-1709.md) introduces you to the new features and functionality added in Windows Server, version 1709.

### Why does Windows Server, version 1709 offer only the Server Core installation option?
One of the most important steps we take in planning each release of Windows Server is listening to customer feedback – how are you using Windows Server? What new features will have the greatest impact on your Windows Server deployments, and by extension, your day-to-day business? Your feedback tells us that delivering new innovation as quickly and efficiently as possible is a key priority. At the same time, for those customers innovating most quickly, you’ve told us that you’re primarily using command line scripting with PowerShell to manage your datacenters, and as such don’t have a strong need for the desktop GUI available in the installation of Windows Server with Desktop Experience. By focusing on the Server Core installation option, we’re able to dedicate more resources toward those new innovations, while also maintaining traditional Windows Server platform functionality and application compatibility. If you have feedback about this or other issues concerning Windows Server and our future releases, you can make suggestions and comments through the [Feedback Hub](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app).


### What about Nano Server?
Nano Server is available as a container operating system. See [Changes to Nano Server in Windows Server Semi-Annual Channel](nano-in-semi-annual-channel.md) for details.

## Additional information about this release
To get a comprehensive view of the key facts about Windows Server, version 1709, you should also review these topics prior to installing it:

- What hardware is needed to run it? See [System requirements](system-requirements.md); the system requirements for this release are the same as for Windows Server 2016.
- What new features and functionality have been added? See [What's New in Windows Server version 1709](whats-new-in-windows-server-1709.md)
- What has been removed? See [Features Removed or Planned for Replacement starting with Windows Server (version 1709)](Removed-Features-1709.md)
- What issues unique to this release need to be worked around? See [Release notes--Important issues in Windows Server, version 1709](server-1709-relnotes.md)


## Where to obtain Windows Server, version 1709

This release should be installed as a clean installation.

- VLSC: Volume-licensed customers with [Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx) can obtain this release by going to the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) and clicking **Sign In**. Then click **Downloads and Keys** and search for this release. 

- Windows Server, version 1709 is also available in  [Microsoft Azure](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/Microsoft.WindowsServer?tab=Overview).

- Participants in **Visual Studio Subscriptions:** If you already participate in Visual Studio Subscriptions, you can obtain Windows Server, version 1709 by going to the [Visual Studio Subscriber download page](https://my.visualstudio.com/downloads?pid=2347) and completing the download available there. If you are not already a subscriber, go to [Visual Studio Subscriptions](https://www.visualstudio.com/subscriptions/) to sign up, and then visit the [Visual Studio Subscriber download page](https://my.visualstudio.com/downloads?pid=2347) as above. Releases obtained through Visual Studio Subscriptions are for development and testing only.




## Activating Windows Server, version 1709

- If you've obtained this release from the Volume Licensing Service Center, you can activate it by using your Windows Server 2016 activation key.
- If you are using Microsoft Azure, this release should automatically be activated.
- If you obtain this release from Visual Studio Subscriptions, it should automatically be activated.