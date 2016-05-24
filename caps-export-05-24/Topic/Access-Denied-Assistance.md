---
title: Access-Denied Assistance
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9ef9ff28-ff5a-4fd1-a56a-a7de0520be88
---
# Access-Denied Assistance
Access\-denied assistance provides users who are denied access to a file or file share with additional information about the issue, and optionally, it suggests a way to request assistance from the designated owner or owners of the file share.  
  
## Security considerations  
Enabling access\-denied assistance adds the Access\-Denied Assistance Users group to the Remote Management Users group, which by default contains the Authenticated Users group. This allows all authenticated users to obtain assistance.  
  
The inbound Windows Firewall rule, Windows Remote Management \(HTTP\-In\), must be enabled for access\-denied assistance to work. This rule is enabled by default.  
  
## Message formatting considerations  
The access\-denied assistance messages can contain only plain text and hyperlinks that are enclosed in valid HTML <a> tags. For example, <a href\="http:\/\/support.microsoft.com">Microsoft Support<\/a>.  
  
## See also  
  
-   [Scenario: Access\-Denied Assistance](http://technet.microsoft.com/library/hh831788.aspx)  
  
