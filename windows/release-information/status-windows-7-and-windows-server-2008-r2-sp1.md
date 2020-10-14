---
title: Windows 7 and Windows Server 2008 R2 SP1
description: View announcements and review known issues and fixes for Windows 7 and Windows Server 2008 R2 SP1
keywords: Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
author: greglin
ms.author: greglin
ms.localizationpriority: high
layout: LandingPage
---

# Windows 7 and Windows Server 2008 R2 SP1

Find information on known issues for Windows 7 and Windows Server 2008 R2 SP1. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s). Want the latest Windows release health updates? Follow <a href="https://twitter.com/windowsupdate" rel="noopener noreferrer" target="_blank">@WindowsUpdate</a> on Twitter.</p>

|               |               |               |               |               |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 2004 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 2004 is now available](https://aka.ms/how-to-get-2004)** <br/> Find out how to get the update >| ![Wondering how to deploy feature updates remotely?](https://docs.microsoft.com/office/media/icons/migration-blue.png) | **[Wondering how to deploy feature updates remotely?](https://aka.ms/RemoteFeatureUpdates)** <br/> Get tips and best practices >| ![Optimize Windows monthly update deployment for remote devices](https://docs.microsoft.com/office/media/icons/trend-graph-blue.png) | **[Optimize Windows monthly update deployment for remote devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/optimize-windows-monthly-update-deployment-for-remote-devices/ba-p/1309917)** <br/> Get tips and best practices >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><tr><td width='65%'>Summary</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>Last updated</td></tr>
      <tr><td><div id='161msg'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><br>Operations performed on files or folders on a CSV may fail with the error: STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5).<br><br><a href = '#161msgdesc'>See details ></a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480970' target='_blank'>KB4480970</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>June 11, 2020 <br>02:06 PM PT</td></tr>
      </table>

## Issue details


## January 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='161msgdesc'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><div>Certain operations, such as <strong>rename</strong>, that you perform on files or folders that are on a Cluster Shared Volume (CSV) may fail with the error, “STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5)”. This occurs when you perform the operation on a CSV owner node from a process that doesn’t have administrator privilege.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Workaround</strong>: Do one of the following:</div><ul><li>Perform the operation from a process that has administrator privilege.</li><li>Perform the operation from a node that doesn’t have CSV ownership.</li></ul><div></div><div><strong>Next steps:</strong> Microsoft is working on a resolution and will provide an update in an upcoming release.</div><br><a href ='#161msg'>Back to top</a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480970' target='_blank'>KB4480970</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>Last updated:<br>June 11, 2020 <br>02:06 PM PT<br><br>Opened:<br>January 08, 2019 <br>10:00 AM PT</td></tr>
</table>

