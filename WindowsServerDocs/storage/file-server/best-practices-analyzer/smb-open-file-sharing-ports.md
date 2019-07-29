---
Title: 'SMB: File and printer sharing ports should be open'
TOCTitle: 'SMB: File and printer sharing ports should be open'
ms.date: 07/02/2012
ms.prod: windows-server-threshold
ms.technology: storage
author: JasonGerend
manager: elizapo
ms.author: jgerend
---

# SMB: File and printer sharing ports should be open


Updated: February 2, 2011

Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012, Windows Server 2008 R2

*This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the File Services Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?linkid=122786%0d%0a).


<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Operating System</strong></p></td>
<td><p>Windows Server</p></td>
</tr>
<tr class="even">
<td><p><strong>Product/Feature</strong></p></td>
<td><p>File Services</p></td>
</tr>
<tr class="odd">
<td><p><strong>Severity</strong></p></td>
<td><p>Error</p></td>
</tr>
<tr class="even">
<td><p><strong>Category</strong></p></td>
<td><p>Configuration</p></td>
</tr>
</tbody>
</table>

## Issue

> *The firewall ports necessary for file and printer sharing are not open (ports 445 and 139).*

## Impact

> *Computers will not be able to access shared folders and other Server Message Block (SMB)-based network services on this server.*

## Resolution

> *Enable File and Printer Sharing to communicate through the computer's firewall.*

Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure.

## To open the firewall ports to enable file and printer sharing

1.  Open Control Panel, click **System and Security**, and then click **Windows Firewall**.

2.  In the left pane, click **Advanced settings**, and in the console tree, click **Inbound Rules**.

3.  Under **Inbound Rules**, locate the rules **File and Printer Sharing (NB-Session-In)** and **File and Printer Sharing (SMB-In)**.

4.  For each rule, right-click the rule, and then click **Enable Rule**.

## Additional references

[Understanding Shared Folders and the Windows Firewall](https://technet.microsoft.com/library/cc731402.aspx)(https://technet.microsoft.com/library/cc731402.aspx)

