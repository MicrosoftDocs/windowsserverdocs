---
title: Resolved issues in Windows Server 2008 SP2
description: Resolved issues in Windows Server 2008 SP2
keywords: ["Resolved issues in Windows Server 2008 SP2", "Windows Server 2008 SP2"]
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
author: greglin
ms.author: greglin
ms.localizationpriority: high
layout: LandingPage
---

# Resolved issues in Windows Server 2008 SP2

See a list of known issues that have been resolved for Windows Server 2008 SP2 over the last six months. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s) to search the page.


<hr class='cardsM'>

## Resolved issues

<table border ='0'><tr><td width='65%'>Summary</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>Date resolved</td></tr>
      <tr><td><div id='161msg'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><br>Operations performed on files or folders on a CSV may fail with the error: STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5).<br><br><a href = '#161msgdesc'>See details ></a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480968' target='_blank'>KB4480968</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4550951' target='_blank'>KB4550951</a></td><td>April 14, 2020 <br>10:00 AM PT</td></tr>
      <tr><td><div id='390msg'></div><b>After installing an update and restarting, you might receive an error</b><br>You might receive the error, “Failure to configure Windows updates. Reverting Changes.” or "Failed" in Update History.<br><br><a href = '#390msgdesc'>See details ></a></td><td>February 11, 2020<br><a href ='https://support.microsoft.com/help/4537810' target='_blank'>KB4537810</a></td><td>Resolved<br><a href = '' target='_blank'></a></td><td>February 12, 2020 <br>05:37 PM PT</td></tr>
      <tr><td><div id='374msg'></div><b>MSRT might fail to install and be re-offered from Windows Update or WSUS </b><br>The November 2019 update for Windows Malicious Software Removal Tool (MSRT) might fail to install from WU/WSUS.<br><br><a href = '#374msgdesc'>See details ></a></td><td><br><a href ='' target='_blank'></a></td><td>Resolved<br><a href = '' target='_blank'></a></td><td>January 23, 2020 <br>02:08 PM PT</td></tr>
      </table>

## Issue details


## February 2020
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='390msgdesc'></div><b>After installing an update and restarting, you might receive an error</b><div>After installing <a href='https://support.microsoft.com/help/4537810' target='_blank'>KB4537810</a> and restarting your device, you might receive the error, “Failure to configure Windows updates. Reverting Changes. Do not turn off your computer,” and the update might show as&nbsp;<strong>Failed&nbsp;</strong>in&nbsp;<strong>Update History</strong>.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 7 SP1</li><li>Server: Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Resolution: </strong>This is expected in the following circumstances:</div><ul><li>If you are installing this update on a device that is running an edition that is not supported for ESU. For a complete list of which editions are supported, see&nbsp;<a href="https://support.microsoft.com/help/4497181" rel="noopener noreferrer" target="_blank">KB4497181</a>.</li><li>If you do not have an ESU MAK add-on key installed and activated.&nbsp;</li></ul><div></div><div>If you have purchased an ESU key and have encountered this issue, please verify you have applied all prerequisites and that your key is activated. For information on activation, please see this&nbsp;<a href="https://aka.ms/Windows7ESU" rel="noopener noreferrer" target="_blank">blog</a>&nbsp;post.&nbsp;For information on the prerequisites, see the "How to get this update" section of this article.</div><br><a href ='#390msg'>Back to top</a></td><td>February 11, 2020<br><a href ='https://support.microsoft.com/help/4537810' target='_blank'>KB4537810</a></td><td>Resolved<br><a href = '' target='_blank'></a></td><td>Resolved:<br>February 12, 2020 <br>05:37 PM PT<br><br>Opened:<br>February 12, 2020 <br>03:47 PM PT</td></tr>
</table>


## November 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='374msgdesc'></div><b>MSRT might fail to install and be re-offered from Windows Update or WSUS </b><div>The November 2019 update for Windows Malicious Software Removal Tool (MSRT) might fail to install from Windows Update (WU), Windows Server Update Services (WSUS) or Configuration Manager and might be re-offered. If you use WU or WSUS, you might also receive the following error in the WindowsUpdate.log, “Misc&nbsp;&nbsp;WARNING: Digital Signatures on file C:\Windows\SoftwareDistribution\Download\XXXX are not trusted: Error 0x800b0109”. If you use Configuration Manager, you might also receive the following error in the WUAHandler.log, "Failed to download updates to the WUAgent datastore. Error = 0x800b0109.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WUAHandler&nbsp;&nbsp;&nbsp;14/11/2019 16:33:23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;980 (0x03D4)". <strong>Note</strong> All Configuration Manager information&nbsp;also applies to System Center Configuration Manager (SCCM) and Microsoft Endpoint Configuration Manager.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 7 SP1</li><li>Server: Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Resolution:</strong> This issue was resolved in the December 2019 release of Windows Malicious Software Removal Tool (MSRT).</div><br><a href ='#374msg'>Back to top</a></td><td><br><a href ='' target='_blank'></a></td><td>Resolved<br><a href = '' target='_blank'></a></td><td>Resolved:<br>January 23, 2020 <br>02:08 PM PT<br><br>Opened:<br>November 15, 2019 <br>05:59 PM PT</td></tr>
</table>


## January 2019
<table border ='0'><tr><td width='65%'>Details</td><td width='15%'>Originating update</td><td width='10%'>Status</td><td width='10%'>History</td></tr>
      <tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;'><div id='161msgdesc'></div><b>Certain operations performed on a Cluster Shared Volume may fail</b><div>Certain operations, such as <strong>rename</strong>, that you perform on files or folders that are on a Cluster Shared Volume (CSV) may fail with the error, “STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5)”. This occurs when you perform the operation on a CSV owner node from a process that doesn’t have administrator privilege.</div><div><br></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 8.1; Windows 7 SP1</li><li>Server: Windows Server 2012 R2; Windows Server 2012; Windows Server 2008 R2 SP1; Windows Server 2008 SP2</li></ul><div></div><div><strong>Resolution:</strong> This issue was resolved in <a href='https://support.microsoft.com/help/4550951' target='_blank'>KB4550951</a>.</div><br><a href ='#161msg'>Back to top</a></td><td>January 08, 2019<br><a href ='https://support.microsoft.com/help/4480968' target='_blank'>KB4480968</a></td><td>Resolved<br><a href = 'https://support.microsoft.com/help/4550951' target='_blank'>KB4550951</a></td><td>Resolved:<br>April 14, 2020 <br>10:00 AM PT<br><br>Opened:<br>January 08, 2019 <br>10:00 AM PT</td></tr>
</table>

