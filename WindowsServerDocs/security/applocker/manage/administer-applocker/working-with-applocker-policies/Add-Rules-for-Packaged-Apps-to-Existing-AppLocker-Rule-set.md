---
title: Add Rules for Packaged Apps to Existing AppLocker Rule-set
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0229ef00-9d63-4c72-b34d-7b4ae7d42979
---
# Add Rules for Packaged Apps to Existing AppLocker Rule-set
This topic describes how to update your existing AppLocker policies for Packaged apps using the Remote Server Administration Toolkit \(RSAT\) in Windows Server® 2012 and Windows® 8.

You can create Packaged app rules for the computers running  Windows Server 2012  or Windows 8 in your domain by updating your existing AppLocker rule set. All you need is a computer running Windows 8. Download and install the Remote Server Administration Toolkit \(RSAT\) from the Microsoft Download Center.

RSAT comes with the Group Policy Management Console which allows you to edit the GPO or GPOs where your existing AppLocker policy are authored. RSAT for Windows 8 has the necessary files required to author Packaged app rules. Packaged app rules will be ignored on computers running Windows 7 but will be enforced on those computers in your domain running  Windows Server 2012  and Windows 8.

## See Also
[Administer AppLocker]()


