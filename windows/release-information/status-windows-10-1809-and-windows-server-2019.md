---
title: Windows 10, version 1809 and Windows Server 2019
description: View announcements and review known issues and fixes for Windows 10 version 1809 and Windows Server 2019
keywords: Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
ms.localizationpriority: medium
ms.author: v-nishmi
author: DocsPreview
---

# Windows 10, version 1809 and Windows Server 2019

Find information on known issues for Windows 10, version 1809 and Windows Server 2019. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s). Want the latest Windows release health updates? Follow <a href="https://twitter.com/windowsupdate" rel="noopener noreferrer" target="_blank">@WindowsUpdate</a> on Twitter.</p>

 <table border = '0' class='box-info has-overflow-hidden'><tr>
<td bgcolor='#d3f1fb' class='alert is-primary'><div><strong>Current status as of May 11, 2021:</strong></div><div>As of May 11, 2021, all editions of Windows 10, version 1809 and Windows Server 2019 have reached end of servicing, except <a href="https://docs.microsoft.com/lifecycle/products/?terms=ltsc" rel="noopener noreferrer" target="_blank">LTSC editions</a>. Devices running these editions will no longer receive monthly security and quality updates containing protections from the latest security threats.</div><div><br></div><div>As always, we recommend that you update your devices to the latest version of Windows 10 as soon as possible to ensure that you can take advantage of the latest features and advanced protections from the latest security threats. For information about servicing timelines and lifecycle, see the&nbsp;<a href="https://docs.microsoft.com/windows/release-health/release-information" rel="noopener noreferrer" target="_blank">Windows 10 release information</a> and <a href="https://docs.microsoft.com/lifecycle/faq/windows" rel="noopener noreferrer" target="_blank">Lifecycle FAQ - Windows</a>.</div>
</td></tr></table>

|               |               |               |               |
| ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 21H1 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 21H1 is now available](https://aka.ms/how-to-get-21H1)** <br/> Find out how to get the update >| ![IT tools for Windows 10, version 21H1](https://docs.microsoft.com/office/media/icons/education-tutorial-blue.png) | **[IT tools for Windows 10, version 21H1](https://aka.ms/tools-for-21H1)** <br/> Explore the latest tools and resources to support your rollout >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><thead><tr><th width='62%'>Summary</th><th width='15%'>Originating update</th><th width='8%'>Status</th><th width='15%' class='has-no-wrap'>Last updated</th></tr></thead><tbody>
      <tr><td><div id='1603msg'></div><a href = '#1603msgdesc'><b>Security updates released May 11, 2021 might not offer in managed environments</b></a><br>Windows Server Update Services (WSUS) or Microsoft Endpoint Configuration Manager and managed devices are affected.<br></td><td class='has-no-wrap'>OS Build 17763.1935<br> <a href = 'https://support.microsoft.com/help/5003171' target = '_blank' > KB5003171</a><br>2021-05-11</td><td>Resolved<br></td><td>2021-05-11 <br>19:01 PT</td></tr>
      <tr><td><div id='211msg'></div><a href = '#211msgdesc'><b>Devices with some Asian language packs installed may receive an error</b></a><br>Devices with Asian language packs installed may receive the error, "0x800f0982 - PSFX_E_MATCHING_COMPONENT_NOT_FOUND."<br></td><td class='has-no-wrap'>OS Build 17763.437<br> <a href = 'https://support.microsoft.com/help/4493509' target = '_blank' > KB4493509</a><br>2019-04-09</td><td>Mitigated<br></td><td>2019-05-03 <br>10:59 PT</td></tr></tbody>
      </table>

## Issue details


<h3>May 2021</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='1603msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Security updates released May 11, 2021 might not offer in managed environments</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Resolved</td><td class='has-no-wrap'>OS Build 17763.1935<br> <a href = 'https://support.microsoft.com/help/5003171' target = '_blank' > KB5003171</a><br>2021-05-11</td><td class='has-no-wrap'>Resolved: 2021-05-11, 19:01 PT<br>Opened: 2021-05-11, 14:58 PT</td></tr>
<tr><td width='100%' colspan='3'><div>When checking for updates within Windows Server Update Services (WSUS) or Microsoft Endpoint Configuration Manager and managed devices that connect to these servers, <a href='https://support.microsoft.com/help/5003171' target='_blank'> KB5003171</a> might not be available or offered. Note: This might also affect Security Only and Internet Explorer Cumulative Rollups, on platforms that receive these types of updates.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 20H2; Windows 10, version 2004; Windows 10, version 1909; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise 2015 LTSB; Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server, version 20H2; Windows Server, version 2004; Windows Server, version 1909; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server 2016; Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Resolution:</strong> This issue is now resolved on the service-side and updates should be available. Note: If you initiate a synchronization cycle and are still not being offered the updates, please check again soon. There might be slight delay as it propagates to all servers in all regions.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>


<h3>May 2019</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='211msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Devices with some Asian language packs installed may receive an error</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Mitigated</td><td class='has-no-wrap'>OS Build 17763.437<br> <a href = 'https://support.microsoft.com/help/4493509' target = '_blank' > KB4493509</a><br>2019-04-09</td><td class='has-no-wrap'>Last updated: 2019-05-03, 10:59 PT<br>Opened: 2019-05-02, 16:36 PT</td></tr>
<tr><td width='100%' colspan='3'><div>After installing the April 2019 Cumulative Update (<a href="https://support.microsoft.com/help/4493509" target="_blank">KB4493509</a>), devices with some Asian language packs installed may receive the error, "0x800f0982 - PSFX_E_MATCHING_COMPONENT_NOT_FOUND."</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1809; Windows 10 Enterprise LTSC 2019</li><li>Server: Windows Server, version 1809; Windows Server 2019</li></ul><div></div><div><strong>Workaround: </strong></div><ol><li>Uninstall and reinstall any recently added language packs.&nbsp;For instructions, see "<a href="https://support.microsoft.com/help/4496404/windows-10-manage-the-input-and-display-language" target="_blank">Manage the input and display language settings in Windows 10</a>".</li><li>Click <strong>Check for Updates</strong> and install the April 2019 Cumulative Update. For instructions, see "<a href="https://support.microsoft.com/help/4027667/windows-10-update" target="_blank">Update Windows 10</a>".</li></ol><div><strong>Note: </strong>If reinstalling the language pack does not mitigate the issue, reset your PC as follows:</div><ol><ol><li>Go to <strong>Settings app</strong> -&gt; <strong>Recovery</strong>.</li><li>Click on <strong>Get Started</strong> under <strong>"Reset this PC"</strong> recovery option.</li><li>Select <strong>"Keep my Files"</strong>.</li></ol></ol><div><strong>Next steps: </strong>Microsoft is working on a resolution and will provide an update in an upcoming release.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>

