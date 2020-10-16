---
title: Resolved issues in Windows Server 2008 SP2
description: Resolved issues in Windows Server 2008 SP2
keywords: ["Resolved issues in Windows Server 2008 SP2", "Windows Server 2008 SP2"]
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
ms.localizationpriority: high
---

# Resolved issues in Windows Server 2008 SP2

See a list of known issues that have been resolved for Windows Server 2008 SP2 over the last six months. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s) to search the page.

<hr class='cardsM'>

## Resolved issues

<table border ='0'><tr><td width='62%'>Summary</td><td width='15%'>Originating update</td><td width='8%'>Status</td><td width='15%' class='has-no-wrap'>Date resolved</td></tr>
      <tr><td><div id='364msg'></div><a href = '#364msgdesc'><b>TLS connections might fail or timeout</b></a><br>Transport Layer Security (TLS) connections might fail or timeout when connecting or attempting a resumption.<br></td><td class='has-no-wrap'> <a href ='https://support.microsoft.com/help/4520002' target='_blank'> KB4520002</a><br>2019-10-08</td><td>Resolved External<br></td><td>2020-07-14 <br>10:19 PT</td></tr>
      </table>

## Issue details


<h3>November 2019</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='364msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>TLS connections might fail or timeout</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Resolved External</td><td class='has-no-wrap'> <a href ='https://support.microsoft.com/help/4520002' target='_blank'> KB4520002</a><br>2019-10-08</td><td class='has-no-wrap'>Last updated: 2020-07-14, 10:19 PT<br>Opened: 2019-11-05, 03:36 PT</td></tr>
<tr><td width='100%' colspan='3'><div>Updates for Windows released October 8, 2019 or later provide protections, tracked by <a href="https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-1318" rel="noopener noreferrer" target="_blank">CVE-2019-1318</a>, against an attack that could allow unauthorized access to information or data within TLS connections.&nbsp;This type of attack is known as a man-in-the-middle exploit.&nbsp;Windows might fail to connect to TLS clients and servers that do not support Extended Master Secret for resumption (<a href="https://tools.ietf.org/html/rfc7627" rel="noopener noreferrer" target="_blank">RFC 7627</a>). Lack of RFC support might cause one or more of the following errors or logged events:</div><ul><li>"The request was aborted: Could not create SSL/TLS secure Channel"</li><li>SCHANNEL event 36887 is logged in the System event log with the description, "A fatal alert was received from the remote endpoint. The TLS protocol defined fatal alert code is 20.​"</li></ul><div></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709; Windows 10, version 1703; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise LTSC 2015; Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709 ; Windows Server 2016; Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><br></div><div><strong>Resolution: </strong>Connections between two devices running any supported version of Windows should not have this issue when fully updated.&nbsp;There is no update for Windows needed for this issue.&nbsp;These changes are required to address a security issue and security compliance. For information, see <a href="https://support.microsoft.com/help/4528489" rel="noopener noreferrer" target="_blank">KB4528489</a>.</div><div align='right'><a href ='#resolved-issues'>Back to top</a></div></td></tr>
</table>
<br>

