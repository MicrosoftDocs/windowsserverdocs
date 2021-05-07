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
<td bgcolor='#d3f1fb' class='alert is-primary'><div><strong>Current status as of April 9, 2021:</strong></div><div>On May 11, 2021 all editions of Windows 10, version 1809 will reach end of service, except <a href="https://docs.microsoft.com/lifecycle/products/?terms=ltsc" rel="noopener noreferrer" target="_blank">LTSC editions</a>. After that date, devices running these editions will no longer receive monthly security and quality updates containing protections from the latest security threats. We recommend that you update these devices to the latest version of Windows 10 immediately.&nbsp;For information about servicing timelines and lifecycle, see the&nbsp;<a href="https://support.microsoft.com/help/13853" rel="noopener noreferrer" target="_blank">Windows lifecycle fact sheet</a> and <a href="https://docs.microsoft.com/lifecycle/faq/windows" rel="noopener noreferrer" target="_blank">Lifecycle FAQ - Windows</a>.</div>
</td></tr></table>

|               |               |               |               |
| ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 20H2 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 20H2 is now available](https://aka.ms/how-to-get-20H2)** <br/> Find out how to get the update >| ![What’s new for IT pros](https://docs.microsoft.com/office/media/icons/education-tutorial-blue.png) | **[What’s new for IT pros](https://aka.ms/new-in-20H2)** <br/> Explore the latest features and servicing innovations in Windows 10, version 20H2 >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><thead><tr><th width='62%'>Summary</th><th width='15%'>Originating update</th><th width='8%'>Status</th><th width='15%' class='has-no-wrap'>Last updated</th></tr></thead><tbody>
      <tr><td><div id='211msg'></div><a href = '#211msgdesc'><b>Devices with some Asian language packs installed may receive an error</b></a><br>Devices with Asian language packs installed may receive the error, "0x800f0982 - PSFX_E_MATCHING_COMPONENT_NOT_FOUND."<br></td><td class='has-no-wrap'>OS Build 17763.437<br> <a href = 'https://support.microsoft.com/help/4493509' target = '_blank' > KB4493509</a><br>2019-04-09</td><td>Mitigated<br></td><td>2019-05-03 <br>10:59 PT</td></tr></tbody>
      </table>

## Issue details


<h3>May 2019</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='211msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Devices with some Asian language packs installed may receive an error</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Mitigated</td><td class='has-no-wrap'>OS Build 17763.437<br> <a href = 'https://support.microsoft.com/help/4493509' target = '_blank' > KB4493509</a><br>2019-04-09</td><td class='has-no-wrap'>Last updated: 2019-05-03, 10:59 PT<br>Opened: 2019-05-02, 16:36 PT</td></tr>
<tr><td width='100%' colspan='3'><div>After installing the April 2019 Cumulative Update (<a href="https://support.microsoft.com/help/4493509" target="_blank">KB4493509</a>), devices with some Asian language packs installed may receive the error, "0x800f0982 - PSFX_E_MATCHING_COMPONENT_NOT_FOUND."</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1809; Windows 10 Enterprise LTSC 2019</li><li>Server: Windows Server, version 1809; Windows Server 2019</li></ul><div></div><div><strong>Workaround: </strong></div><ol><li>Uninstall and reinstall any recently added language packs.&nbsp;For instructions, see "<a href="https://support.microsoft.com/help/4496404/windows-10-manage-the-input-and-display-language" target="_blank">Manage the input and display language settings in Windows 10</a>".</li><li>Click <strong>Check for Updates</strong> and install the April 2019 Cumulative Update. For instructions, see "<a href="https://support.microsoft.com/help/4027667/windows-10-update" target="_blank">Update Windows 10</a>".</li></ol><div><strong>Note: </strong>If reinstalling the language pack does not mitigate the issue, reset your PC as follows:</div><ol><ol><li>Go to <strong>Settings app</strong> -&gt; <strong>Recovery</strong>.</li><li>Click on <strong>Get Started</strong> under <strong>"Reset this PC"</strong> recovery option.</li><li>Select <strong>"Keep my Files"</strong>.</li></ol></ol><div><strong>Next steps: </strong>Microsoft is working on a resolution and will provide an update in an upcoming release.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>

