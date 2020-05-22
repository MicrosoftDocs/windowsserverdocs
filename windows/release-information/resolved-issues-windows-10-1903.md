---
title: Resolved issues in Windows 10, version 1903 and Windows Server, version 1903
description: Resolved issues in Windows 10, version 1903 and Windows Server 1903
keywords: ["Resolved issues in Windows 10", "Windows 10", "Windows 10, version 1903"]
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
author: v-heathp
ms.author: v-heathp
ms.localizationpriority: high
layout: LandingPage
---

# Resolved issues in Windows 10, version 1903 and Windows Server, version 1903

See a list of known issues that have been resolved for Windows 10, version 1903 and Windows Server, version 1903 over the last six months. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s) to search the page.


<hr class='cardsM'>

## Resolved issues

<table border ='0'><tr><td width='65%'>Summary</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>Date resolved</td></tr>
      <tr><td><div id='406msg'></div><b>Devices using a proxy might show limited or no internet connection status</b><br>Network Connectivity Status Indicator might show limited or no internet connection and apps may have issues connecting.<br><br><a href = '#406msgdesc'>See details ></a></td><td>OS Build 18362.693<br><br>February 27, 2020<br><a href ='https://support.microsoft.com/help/4535996' target='_blank'>KB4535996</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4554364' target='_blank'>KB4554364</a></td><td>March 30, 2020 <br>02:00 PM PT</td></tr>
      <tr><td><div id='348msg'></div><b>Unable to create local users in Chinese, Japanese and Korean during device setup</b><br>You might be unable to create users in Chinese, Japanese and Korean using Input Method Editor (IME) during OOBE.<br><br><a href = '#348msgdesc'>See details ></a></td><td>OS Build 18362.356<br><br>September 10, 2019<br><a href ='https://support.microsoft.com/help/4515384' target='_blank'>KB4515384</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4530684' target='_blank'>KB4530684</a></td><td>December 10, 2019 <br>10:00 AM PT</td></tr>
      <tr><td><div id='231msg'></div><b>Intermittent loss of Wi-Fi connectivity</b><br>Some older devices may experience loss of Wi-Fi connectivity due to an outdated Qualcomm driver. <br><br><a href = '#231msgdesc'>See details ></a></td><td>OS Build 18362.116<br><br>May 21, 2019<br><a href ='https://support.microsoft.com/help/4505057' target='_blank'>KB4505057</a></td><td>Resolved External<br></td><td>November 22, 2019 <br>04:10 PM PT</td></tr>
      </table>

## Issue details


## March 2020
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='406msgdesc'></div><b>Devices using a proxy might show limited or no internet connection status</b><div>Devices using a manual or auto-configured proxy, especially with a&nbsp;virtual private network (VPN),&nbsp;might show limited or no internet connection status in the Network Connectivity Status Indicator<strong> </strong>(NCSI) in the notification area.&nbsp;&nbsp;This might happen when connected or disconnected to a VPN or after changing state between the two.&nbsp;Devices with this issue, might also have issues reaching the internet using applications that use WinHTTP or WinInet. Examples of apps that might be affected on devices in this state are as follows but not limited to Microsoft Teams, Microsoft Office, Office365, Outlook, Internet Explorer 11, and some version of Microsoft Edge.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1909; Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709</li><li>Server: Windows Server, version 1909; Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709</li></ul><div></div><div><strong>Resolution:</strong> This issue was resolved in the out-of-band update <a href='https://support.microsoft.com/help/4554364' target='_blank'>KB4554364</a>. It is a cumulative update, so you do not need to apply any previous update before installing it. To get the standalone package for <a href='https://support.microsoft.com/help/4554364' target='_blank'>KB4554364</a>, search for it in the&nbsp;<a href="http://www.catalog.update.microsoft.com/home.aspx" rel="noopener noreferrer" target="_blank">Microsoft Update Catalog</a>. You can import this update&nbsp;into Windows Server Update Services (WSUS) manually. See the&nbsp;<a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-server-update-services/manage/wsus-and-the-catalog-site#the-microsoft-update-catalog-site" rel="noopener noreferrer" target="_blank">Microsoft Update Catalog</a>&nbsp;for instructions. <strong>Note </strong><a href='https://support.microsoft.com/help/4554364' target='_blank'>KB4554364</a> is not available&nbsp;from Windows Update and will not install automatically.</div><br><a href ='#406msg'>Back to top</a></td><td>OS Build 18362.693<br><br>February 27, 2020<br><a href ='https://support.microsoft.com/help/4535996' target='_blank'>KB4535996</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4554364' target='_blank'>KB4554364</a></td><td>Resolved:<br>March 30, 2020 <br>02:00 PM PT<br><br>Opened:<br>March 26, 2020 <br>10:00 AM PT</td></tr>
</table>


## October 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='348msgdesc'></div><b>Unable to create local users in Chinese, Japanese and Korean during device setup</b><div>When setting up a new Windows device using the Out of Box Experience (OOBE), you might be unable to create a local user when using Input Method Editor (IME). This issue might affect you if you are using the IME for Chinese, Japanese, or Korean languages.</div><div><br></div><div><strong>Note</strong> This issue does not affect using a Microsoft Account during OOBE.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1909; Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709</li><li>Server: Windows Server, version 1909; Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709</li></ul><div></div><div><strong>Resolution:</strong> This issue was resolved in <a href='https://support.microsoft.com/help/4530684' target='_blank'>KB4530684</a>.</div><br><a href ='#348msg'>Back to top</a></td><td>OS Build 18362.356<br><br>September 10, 2019<br><a href ='https://support.microsoft.com/help/4515384' target='_blank'>KB4515384</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4530684' target='_blank'>KB4530684</a></td><td>Resolved:<br>December 10, 2019 <br>10:00 AM PT<br><br>Opened:<br>October 29, 2019 <br>05:15 PM PT</td></tr>
</table>


## May 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='231msgdesc'></div><b>Intermittent loss of Wi-Fi connectivity</b><div>Some older devices may experience loss of Wi-Fi connectivity due to an outdated Qualcomm driver. An updated Wi-Fi driver should be available from your device manufacturer (OEM).</div><div><br></div><div>To safeguard your upgrade experience, we have applied a hold on devices with affected Qualcomm driver from being offered Windows 10, version 1903 or Windows 10, version 1909, until&nbsp;the updated driver is installed.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1909; Windows 10, version 1903</li></ul><div></div><div><strong>Resolution:&nbsp;</strong>This issue was resolved with an updated Qualcomm Wifi driver and the safeguard hold has been removed. Please note, it can take up to 48 hours before you can update to offered Windows 10, version 1909 or Windows 10, version 1903.</div><br><a href ='#231msg'>Back to top</a></td><td>OS Build 18362.116<br><br>May 21, 2019<br><a href ='https://support.microsoft.com/help/4505057' target='_blank'>KB4505057</a></td><td>Resolved External<br></td><td>Last updated:<br>November 22, 2019 <br>04:10 PM PT<br><br>Opened:<br>May 21, 2019 <br>07:13 AM PT</td></tr>
</table>

