---
title: Windows 7 and Windows Server 2008 R2 SP1
description: View announcements and review known issues and fixes for Windows 7 and Windows Server 2008 R2 SP1
keywords: Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
author: v-heathp
ms.author: v-heathp
ms.localizationpriority: high
layout: LandingPage
---

# Windows 7 and Windows Server 2008 R2 SP1

Find information on known issues for Windows 7 and Windows Server 2008 R2 SP1. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s).


|               |               |               |               |               |
| ------------- | ------------- | ------------- | ------------- |
| ![Optimize Windows monthly update deployment for remote devices](https://docs.microsoft.com/office/media/icons/trend-graph-blue.png) | **[Optimize Windows monthly update deployment for remote devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/optimize-windows-monthly-update-deployment-for-remote-devices/ba-p/1309917)** <br/> Get tips and best practices >| ![Revised end of service date for Windows 10, version 1709](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Revised end of service date for Windows 10, version 1709](https://aka.ms/blog/1709lifecycle)** <br/> Learn more about this lifecycle change and affected editions >| ![Still have devices running Windows 7 in your enterprise?](https://docs.microsoft.com/office/media/icons/lock-protected-blue.png) | **[Still have devices running Windows 7 in your enterprise?](https://aka.ms/Windows7ESU)** <br/> Stay protected with Extended Security Updates >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><tr><td width='65%'>Summary</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>Last updated</td></tr>
      <tr><td><div id='364msg'></div><b>TLS connections might fail or timeout</b><br>Transport Layer Security (TLS) connections might fail or timeout when connecting or attempting a resumption.<br><br><a href = '#364msgdesc'>See details ></a></td><td>October 08, 2019<br><a href ='https://support.microsoft.com/help/4519976' target='_blank'>KB4519976</a></td><td>Mitigated External<br></td><td>November 05, 2019 <br>03:36 PM PT</td></tr>
      <tr><td><div id='310msg'></div><b>IA64 and x64 devices may fail to start after installing updates</b><br>After installing updates released on or after August 13, 2019, IA64 and x64 devices using EFI Boot may fail to start.<br><br><a href = '#310msgdesc'>See details ></a></td><td>August 13, 2019<br><a href ='https://support.microsoft.com/help/4512506' target='_blank'>KB4512506</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>August 17, 2019 <br>12:59 PM PT</td></tr>
      </table>

## Issue details


## November 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='364msgdesc'></div><b>TLS connections might fail or timeout</b><div>Updates for Windows released October 8, 2019 or later provide protections, tracked by <a href="https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-1318" rel="noopener noreferrer" target="_blank">CVE-2019-1318</a>, against an attack that could allow unauthorized access to information or data within TLS connections.&nbsp;This type of attack is known as a man-in-the-middle exploit.&nbsp;Windows might fail to connect to TLS clients and servers that do not support Extended Master Secret for resumption (<a href="https://tools.ietf.org/html/rfc7627" rel="noopener noreferrer" target="_blank">RFC 7627</a>). Lack of RFC support might cause one or more of the following errors or logged events:</div><ul><li>"The request was aborted: Could not create SSL/TLS secure Channel"</li><li>SCHANNEL event 36887 is logged in the System event log with the description, "A fatal alert was received from the remote endpoint. The TLS protocol defined fatal alert code is 20.​"</li></ul><div></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709; Windows 10, version 1703; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise LTSC 2015; Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709 ; Windows Server 2016; Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><br></div><div><strong>Next Steps: </strong>Connections between two devices running any supported version of Windows should not have this issue when fully updated.&nbsp;There is no update for Windows needed for this issue.&nbsp;These changes are required to address a security issue and security compliance. For information, see <a href="https://support.microsoft.com/help/4528489" rel="noopener noreferrer" target="_blank">KB4528489</a>.</div><br><a href ='#364msg'>Back to top</a></td><td>October 08, 2019<br><a href ='https://support.microsoft.com/help/4519976' target='_blank'>KB4519976</a></td><td>Mitigated External<br></td><td>Last updated:<br>November 05, 2019 <br>03:36 PM PT<br><br>Opened:<br>November 05, 2019 <br>03:36 PM PT</td></tr>
</table>


## August 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='310msgdesc'></div><b>IA64 and x64 devices may fail to start after installing updates</b><div>IA64 devices (in any configuration) and x64 devices using EFI boot that were provisioned after the July 9th updates and/or skipped the recommended update (KB3133977), may fail to start with the following error:</div><div><strong>"File: \Windows\system32\winload.efi</strong></div><div><strong>Status: 0xc0000428</strong></div><div><strong>Info: Windows cannot verify the digital signature for this file."</strong></div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 7 SP1</li><li>Server: Windows Server 2008 R2 SP1</li></ul><div></div><div><strong>Take Action: </strong>To resolve this issue please follow the steps outlined in the&nbsp;<a href="https://support.microsoft.com/help/4472027" target="_blank">SHA-2 support FAQ</a> article for error code 0xc0000428.</div><br><a href ='#310msg'>Back to top</a></td><td>August 13, 2019<br><a href ='https://support.microsoft.com/help/4512506' target='_blank'>KB4512506</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>Last updated:<br>August 17, 2019 <br>12:59 PM PT<br><br>Opened:<br>August 13, 2019 <br>08:34 AM PT</td></tr>
</table>

