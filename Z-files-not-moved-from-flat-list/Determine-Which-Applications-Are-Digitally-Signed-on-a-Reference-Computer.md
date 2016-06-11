---
title: Determine Which Applications Are Digitally Signed on a Reference Computer
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a5d091b-8669-4a43-90b6-80ac0a807a17
---
# Determine Which Applications Are Digitally Signed on a Reference Computer
This topic for the IT professional describes how to use AppLocker logs and tools to determine which applications are digitally signed.

The Windows PowerShell cmdlet **Get\-AppLockerFileInformation** can be used to determine which applications installed on your reference computers are digitally signed. Perform the following steps on each reference computer that you used to define the AppLocker policy. The computer does not need to be joined to the domain.

[!INCLUDE[mingrp_admins](includes/mingrp_admins_md.md)]

#### To determine which applications are digitally signed on a reference computer

1.  From the command line on the reference computer, run **Get\-AppLockerFileInformation** with the appropriate parameters.

    The **Get\-AppLockerFileInformation** cmdlet retrieves the AppLocker file information from a list of files or from an event log. File information that is retrieved can include publisher information, file hash information, and file path information. File information from an event log may not contain all of these fields. Files that are not signed do not have any publisher information.

2.  Analyze the publisher's name and digital signature status from the output of the command.

For command parameters, syntax, and examples, see [Get\-AppLockerFileInformation](http://technet.microsoft.com/library/ee460961.aspx).

## See Also
[Use a Reference Computer to Create and Maintain AppLocker Policies]()


