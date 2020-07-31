---
title: Windows Server 2008 SP2
description: View announcements and review known issues and fixes for Windows Server 2008 SP2
keywords: Windows, Windows 10, issues, fixes, announcements, Windows Server, advisories
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
author: greglin
ms.author: greglin
ms.localizationpriority: high
layout: LandingPage
---

# Windows Server 2008 SP2

Find information on known issues for Windows Server 2008 SP2. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s). Want the latest Windows release health updates? Follow <a href="https://twitter.com/windowsupdate" rel="noopener noreferrer" target="_blank">@WindowsUpdate</a> on Twitter.</p>

|               |               |               |               |               |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![Windows 10, version 2004 is now available](https://docs.microsoft.com/office/media/icons/whats-new-megaphone-blue.png) | **[Windows 10, version 2004 is now available](https://aka.ms/how-to-get-2004)** <br/> Find out how to get the update >| ![What’s new for IT pros](https://docs.microsoft.com/office/media/icons/education-tutorial-blue.png) | **[What’s new for IT pros](https://aka.ms/whats-new-2004)** <br/> Explore the latest features and and servicing innovations in Windows 10 >| ![Wondering how to deploy feature updates remotely?](https://docs.microsoft.com/office/media/icons/migration-blue.png) | **[Wondering how to deploy feature updates remotely?](https://aka.ms/RemoteFeatureUpdates)** <br/> Get tips and best practices >|
<div align='right' style='font-size:0.87rem'><a class='is-size-7' href='https://docs.microsoft.com/windows/release-information/windows-message-center'>See all messages ></a></div><hr class='cardsM'>

## Known issues
<div>This table offers a summary of current active issues and those issues that have been resolved in the last 30 days.</div><br>
<table border ='0'><tr><td width='65%'>Summary</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>Last updated</td></tr>
      <tr><td><div id='364msg'></div><b>TLS connections might fail or timeout</b><br>Transport Layer Security (TLS) connections might fail or timeout when connecting or attempting a resumption.<br><br><a href = '#364msgdesc'>See details ></a></td><td>October 08, 2019<br><a href ='https://support.microsoft.com/help/4520002' target='_blank'>KB4520002</a></td><td>Resolved External<br></td><td>July 14, 2020 <br>10:19 AM PT</td></tr>
      <tr><td><div id='161msg'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><br>Operations performed on files or folders on a CSV may fail with the error: STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5).<br><br><a href = '#161msgdesc'>See details ></a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480968' target='_blank'>KB4480968</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>June 11, 2020 <br>02:06 PM PT</td></tr>
      </table>

## Issue details


## November 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='364msgdesc'></div><b>TLS connections might fail or timeout</b><div>Updates for Windows released October 8, 2019 or later provide protections, tracked by <a href="https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-1318" rel="noopener noreferrer" target="_blank">CVE-2019-1318</a>, against an attack that could allow unauthorized access to information or data within TLS connections.&nbsp;This type of attack is known as a man-in-the-middle exploit.&nbsp;Windows might fail to connect to TLS clients and servers that do not support Extended Master Secret for resumption (<a href="https://tools.ietf.org/html/rfc7627" rel="noopener noreferrer" target="_blank">RFC 7627</a>). Lack of RFC support might cause one or more of the following errors or logged events:</div><ul><li>"The request was aborted: Could not create SSL/TLS secure Channel"</li><li>SCHANNEL event 36887 is logged in the System event log with the description, "A fatal alert was received from the remote endpoint. The TLS protocol defined fatal alert code is 20.​"</li></ul><div></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709; Windows 10, version 1703; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise LTSC 2015; Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709 ; Windows Server 2016; Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><br></div><div><strong>Resolution: </strong>Connections between two devices running any supported version of Windows should not have this issue when fully updated.&nbsp;There is no update for Windows needed for this issue.&nbsp;These changes are required to address a security issue and security compliance. For information, see <a href="https://support.microsoft.com/help/4528489" rel="noopener noreferrer" target="_blank">KB4528489</a>.</div><br><a href ='#364msg'>Back to top</a></td><td>October 08, 2019<br><a href ='https://support.microsoft.com/help/4520002' target='_blank'>KB4520002</a></td><td>Resolved External<br></td><td>Last updated:<br>July 14, 2020 <br>10:19 AM PT<br><br>Opened:<br>November 05, 2019 <br>03:36 PM PT</td></tr>
</table>


## January 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='161msgdesc'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><div>Certain operations, such as <strong>rename</strong>, that you perform on files or folders that are on a Cluster Shared Volume (CSV) may fail with the error, “STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5)”. This occurs when you perform the operation on a CSV owner node from a process that doesn’t have administrator privilege.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Workaround</strong>: Do one of the following:</div><ul><li>Perform the operation from a process that has administrator privilege.</li><li>Perform the operation from a node that doesn’t have CSV ownership.</li></ul><div></div><div><strong>Next steps:</strong> Microsoft is working on a resolution and will provide an update in an upcoming release.</div><br><a href ='#161msg'>Back to top</a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480968' target='_blank'>KB4480968</a></td><td>Mitigated<br><a href = '' target='_blank'></a></td><td>Last updated:<br>June 11, 2020 <br>02:06 PM PT<br><br>Opened:<br>January 08, 2019 <br>10:00 AM PT</td></tr>
</table>

