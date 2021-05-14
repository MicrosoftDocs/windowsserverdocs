---
title: Windows Server 2008 SP2
description: View announcements and review known issues and fixes for Windows Server 2008 SP2
keywords: Windows, Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
ms.localizationpriority: medium
ms.author: v-nishmi
author: DocsPreview
---

# Windows Server 2008 SP2

Find information on known issues for Windows Server 2008 SP2. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s). Want the latest Windows release health updates? Follow <a href="https://twitter.com/windowsupdate" rel="noopener noreferrer" target="_blank">@WindowsUpdate</a> on Twitter.</p>

|               |               |               |               |
| ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 20H2 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 20H2 is now available](https://aka.ms/how-to-get-20H2)** <br/> Find out how to get the update >| ![What’s new for IT pros](https://docs.microsoft.com/office/media/icons/education-tutorial-blue.png) | **[What’s new for IT pros](https://aka.ms/new-in-20H2)** <br/> Explore the latest features and servicing innovations in Windows 10, version 20H2 >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><thead><tr><th width='62%'>Summary</th><th width='15%'>Originating update</th><th width='8%'>Status</th><th width='15%' class='has-no-wrap'>Last updated</th></tr></thead><tbody>
      <tr><td><div id='1603msg'></div><a href = '#1603msgdesc'><b>Security updates released May 11, 2021 might not offer in managed environments</b></a><br>Windows Server Update Services (WSUS) or Microsoft Endpoint Configuration Manager and managed devices are affected.<br></td><td class='has-no-wrap'> <a href = 'https://support.microsoft.com/help/5003210' target = '_blank' > KB5003210</a><br>2021-05-11</td><td>Resolved<br></td><td>2021-05-11 <br>19:01 PT</td></tr>
      <tr><td><div id='161msg'></div><a href = '#161msgdesc'><b>Certain operations performed on a Cluster Shared Volume may fail</b></a><br>Operations performed on files or folders on a CSV may fail with the error: STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5).<br></td><td class='has-no-wrap'> <a href = 'https://support.microsoft.com/help/4480968' target = '_blank' > KB4480968</a><br>2019-01-08</td><td>Mitigated<br></td><td>2020-06-11 <br>14:06 PT</td></tr></tbody>
      </table>

## Issue details


<h3>May 2021</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='1603msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Security updates released May 11, 2021 might not offer in managed environments</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Resolved</td><td class='has-no-wrap'> <a href = 'https://support.microsoft.com/help/5003210' target = '_blank' > KB5003210</a><br>2021-05-11</td><td class='has-no-wrap'>Resolved: 2021-05-11, 19:01 PT<br>Opened: 2021-05-11, 14:58 PT</td></tr>
<tr><td width='100%' colspan='3'><div>When checking for updates within Windows Server Update Services (WSUS) or Microsoft Endpoint Configuration Manager and managed devices that connect to these servers, <a href='https://support.microsoft.com/help/5003210' target='_blank'> KB5003210</a> might not be available or offered. Note: This might also affect Security Only and Internet Explorer Cumulative Rollups, on platforms that receive these types of updates.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 20H2; Windows 10, version 2004; Windows 10, version 1909; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise 2015 LTSB; Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server, version 20H2; Windows Server, version 2004; Windows Server, version 1909; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server 2016; Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Resolution:</strong> This issue is now resolved on the service-side and updates should be available. Note: If you initiate a synchronization cycle and are still not being offered the updates, please check again soon. There might be slight delay as it propagates to all servers in all regions.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>


<h3>January 2019</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='161msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Certain operations performed on a Cluster Shared Volume may fail</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Mitigated</td><td class='has-no-wrap'> <a href = 'https://support.microsoft.com/help/4480968' target = '_blank' > KB4480968</a><br>2019-01-08</td><td class='has-no-wrap'>Last updated: 2020-06-11, 14:06 PT<br>Opened: 2019-01-08, 10:00 PT</td></tr>
<tr><td width='100%' colspan='3'><div>Certain operations, such as <strong>rename</strong>, that you perform on files or folders that are on a Cluster Shared Volume (CSV) may fail with the error, “STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5)”. This occurs when you perform the operation on a CSV owner node from a process that doesn’t have administrator privilege.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Workaround</strong>: Do one of the following:</div><ul><li>Perform the operation from a process that has administrator privilege.</li><li>Perform the operation from a node that doesn’t have CSV ownership.</li></ul><div></div><div><strong>Next steps:</strong> Microsoft is working on a resolution and will provide an update in an upcoming release.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>

