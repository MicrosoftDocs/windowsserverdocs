---
title: Resolved issues in Windows 10, version 20H2 and Windows Server, version 20H2
description: Resolved issues in Windows 10, version 20H2 and Windows Server 20H2
keywords: ["Resolved issues in Windows 10", "Windows 10", "Windows 10, version 20H2"]
ms.prod: w10
ms.topic: article
ms.mktglfcycl: deploy
ms.sitesec: library
ms.localizationpriority: high
---

# Resolved issues in Windows 10, version 20H2 and Windows Server, version 20H2

See a list of known issues that have been resolved for Windows 10, version 20H2 and Windows Server, version 20H2 over the last six months. Looking for a specific issue? Press CTRL + F (or Command + F if you are using a Mac) and enter your search term(s) to search the page.

<hr class='cardsM'>

## Resolved issues

<table border ='0'><tr><td width='62%'>Summary</td><td width='15%'>Originating update</td><td width='8%'>Status</td><td width='15%' class='has-no-wrap'>Date resolved</td></tr>
      <tr><td><div id='1492msg'></div><a href = '#1492msgdesc'><b>When installing incorrectly formatted third-party drivers, you might receive an error</b></a><br>You might receive, “Windows can’t verify the publisher of this driver software” or other errors.<br></td><td class='has-no-wrap'>N/A <br> <a href ='' target='_blank'></a><br></td><td>Resolved<br><a href = '' target='_blank'></a></td><td>2020-10-20 <br>09:53 PT</td></tr>
      </table>

## Issue details


<h3>October 2020</h3><table border ='0' class='has-text-wrap'>
<tr><td style='border-left-width:0px;border-right-width:0px;border-bottom-width:0px;font-size:1.5rem !important;margin-top:0px;margin-bottom:0px;' class='has-margin-top-none has-margin-bottom-none has-padding-left-none has-padding-right-none' colspan='3' width='100%'><div id='1492msgdesc'></div><h4 class='has-margin-top-none has-margin-bottom-none has-margin-right-none has-margin-left-none has-padding-left-none has-padding-right-none has-padding-top-none has-padding-bottom-none'>When installing incorrectly formatted third-party drivers, you might receive an error</h4></td></tr>
<tr><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Status</b></td><td width='30%' class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>Originating update</b></td><td class='has-margin-top-small has-padding-top-small has-margin-bottom-small has-padding-bottom-small'><b>History</b></td></tr><td class='has-no-wrap'>Resolved<a href = '' target='_blank'></a></td><td class='has-no-wrap'>N/A <br> <a href ='' target='_blank'></a><br></td><td class='has-no-wrap'>Resolved: 2020-10-20, 09:53 PT<br>Opened: 2020-10-13, 09:37 PT</td></tr>
<tr><td width='100%' colspan='3'><div>When installing a third-party driver, you might receive the error,&nbsp;“Windows can’t verify the publisher of this driver software”. You may also see the error “No signature was present in the subject” when attempting to view the signature properties using Windows Explorer.</div><div><br></div><div>This issue occurs when one or more of the following is present in a driver package:</div><ul><li>an improperly formatted catalog file is identified during validation by Windows.&nbsp;Starting with this release, Windows will require the validity of DER encoded PKCS#7 content in catalog files. Catalogs files must be signed per section 11.6 of describing&nbsp;DER-encoding for SET OF members&nbsp;in <a href="https://www.itu.int/rec/T-REC-X.690/" rel="noopener noreferrer" target="_blank">X.690</a>.</li><li>a driver catalog file extension is not one of the supported extensions.</li></ul><div></div><div><strong>Affected platforms:</strong></div><ul><li>Client: Windows 10, version 20H2, Windows 10, version 2004; Windows 10, version 1909; Windows 10, version 1903; Windows 10, version 1809; Windows 10 Enterprise LTSC 2019; Windows 10, version 1803; Windows 10, version 1709; Windows 10 Enterprise LTSC 2016; Windows 10, version 1607; Windows 10 Enterprise 2015 LTSB; Windows 8.1</li><li>Server: Windows Server, version 20H2, Windows Server, version 2004; Windows Server, version 1909; Windows Server, version 1903; Windows Server, version 1809; Windows Server 2019; Windows Server, version 1803; Windows Server, version 1709 ; Windows Server 2016; Windows Server 2012 R2</li></ul><div></div><div><strong>Next steps: </strong>If this happens you should contact the driver vendor or device manufacturer (OEM) and ask them for an updated driver to correct the issue.</div><div align='right'><a href ='#resolved-issues'>Back to top</a></div></td></tr>
</table>
<br>

