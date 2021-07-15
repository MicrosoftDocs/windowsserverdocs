---
title: Windows 10, version 1909 and Windows Server, version 1909
description: View announcements and review known issues and fixes for Windows 10 version 1909 and Windows Server 1909
keywords: Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
ms.localizationpriority: medium
ms.author: v-nishmi
author: DocsPreview
---

# Windows 10, version 1909 and Windows Server, version 1909

Find information on known issues and the status of the rollout for Windows 10, version 1909 and Windows Server, version 1909. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s). Want the latest Windows release health updates? Follow <a href="https://twitter.com/windowsupdate" rel="noopener noreferrer" target="_blank">@WindowsUpdate</a> on Twitter.</p>

 <table border = '0' class='box-info has-overflow-hidden'><tr>
<td bgcolor='#d3f1fb' class='alert is-primary'><div><strong>Current status as of May 11, 2021:</strong></div><div>As of May 11, 2021, the <a href="https://docs.microsoft.com/lifecycle/products/windows-10-home-and-pro" rel="noopener noreferrer" target="_blank">Home and Pro</a> editions of Windows 10, version 1909 and <a href="https://docs.microsoft.com/lifecycle/products/windows-server" rel="noopener noreferrer" target="_blank">all editions</a> of Windows Server, version 1909 have reached end of servicing. Devices running these editions will no longer receive monthly security and quality updates containing protections from the latest security threats. <a href="https://docs.microsoft.com/lifecycle/products/windows-10-enterprise-and-education" rel="noopener noreferrer" target="_blank">Education, Enterprise, and IoT Enterprise editions</a> of Windows 10, version 1909 will reach end of servicing May 11, 2022.</div><div><br></div><div>As always, we recommend that you update your devices to the latest version of Windows 10 as soon as possible to ensure that you can take advantage of the latest features and advanced protections from the latest security threats. For information about servicing timelines and lifecycle, see the&nbsp;<a href="https://docs.microsoft.com/windows/release-health/release-information" rel="noopener noreferrer" target="_blank">Windows 10 release information</a> and <a href="https://docs.microsoft.com/lifecycle/faq/windows" rel="noopener noreferrer" target="_blank">Lifecycle FAQ - Windows</a>.</div>
</td></tr></table>

|               |               |               |               |
| ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 21H1 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 21H1 is now available](https://aka.ms/how-to-get-21H1)** <br/> Find out how to get the update >| ![IT tools for Windows 10, version 21H1](https://docs.microsoft.com/office/media/icons/education-tutorial-blue.png) | **[IT tools for Windows 10, version 21H1](https://aka.ms/tools-for-21H1)** <br/> Explore the latest tools and resources to support your rollout >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><thead><tr><th width='62%'>Summary</th><th width='15%'>Originating update</th><th width='8%'>Status</th><th width='15%' class='has-no-wrap'>Last updated</th></tr></thead><tbody>
      <tr><td><div id='1643msg'></div><a href = '#1643msgdesc'><b>Azure Virtual Desktops may not be able to update via Windows Server Update Services</b></a><br>Manual download and installation of security updates is available, and may be necessary.<br></td><td class='has-no-wrap'>N/A <br> <br></td><td>Confirmed<br></td><td>2021-07-02 <br>13:01 PT</td></tr></tbody>
      </table>

## Issue details


<h3>July 2021</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='1643msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>Azure Virtual Desktops may not be able to update via Windows Server Update Services</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Confirmed</td><td class='has-no-wrap'>N/A <br> <br></td><td class='has-no-wrap'>Last updated: 2021-07-02, 13:01 PT<br>Opened: 2021-07-02, 12:40 PT</td></tr>
<tr><td width='100%' colspan='3'><div>We are investigating an issue where devices running Windows 10 Enterprise multi-session, version 1909 might not be able to download updates later than May 2021. This is observed in the Settings app under the Windows Update setting, which will display the message "You're up to date" even if no updates later than May 2021 have been installed.</div><div><br></div><div><strong>Workaround: </strong>There are 2 alternatives to resolve this issue. As the latest images from the Azure Marketplace will be up-to-date with all of the security updates, redeployment of images to existing devices will solve this issue. If redeployment is not an option, security updates can still be installed manually on these devices, via downloads from the Microsoft Update Catalog. For instructions, please see <a href="https://support.microsoft.com/help/5004926" rel="noopener noreferrer" target="_blank">KB5004926</a> and review the Workaround section.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10 Enterprise multi-session, version 1909</li><li>Server: Windows Server multi-session, version 1909</li></ul><div></div><div><strong>Next steps: </strong>We are working on a resolution and will provide an update in an upcoming release.</div><div align='right'><a href ='#known-issues'>Back to top</a></div></td></tr>
</table>
<br>

