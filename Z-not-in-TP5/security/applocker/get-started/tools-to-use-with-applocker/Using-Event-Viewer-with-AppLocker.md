---
title: Using Event Viewer with AppLocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7fd481a3-2cff-45fc-a39c-4932e8b45f98
---
# Using Event Viewer with AppLocker
This topic lists AppLocker events and describes how to use Event Viewer with AppLocker.

The AppLocker log contains information about applications that are affected by AppLocker rules. Each event in the log contains detailed information about:

-   Which file is affected and the path of that file

-   Which Packaged app is affected and the package identifier of the app

-   Whether the file or Packaged app is allowed or blocked

-   The rule type (path, file hash, or publisher)

-   The rule name

-   The security identifier (SID) for the user or group identified in the rule

Review the entries in the Event Viewer to determine if any applications are not included in the rules that you automatically generated. For instance, some line-of-business applications are installed to non-standard locations, such as the root of the active drive (for example: %SystemDrive%).

For information about what to look for in the AppLocker Event logs for  Windows Server 2012  and Windows 8, see [Monitor Application Usage with AppLocker](http://technet.microsoft.com/library/hh994604.aspx).

#### To review the AppLocker log in Event Viewer

1.  Open Event Viewer. To do this, click **Start**, type **eventvwr.msc** in the **Search programs and files** box, and then press ENTER. On  Windows Server 2012  and Windows 8, on the **Start** screen, type**eventvwr.msc**.

2.  In the console tree under **Application and Services Logs\Microsoft\Windows**, click **AppLocker**.

The following table contains information about the events that you can use to determine which applications are affected by AppLocker rules.

|Event ID|Level|Event message|Description|
|------------|---------|-----------------|---------------|
|8000|Error|Application Identity Policy conversion failed. Status *<%1>*|Indicates that the policy was not applied correctly to the computer. The status message is provided for troubleshooting purposes.|
|8001|Information|The AppLocker policy was applied successfully to this computer.|Indicates that the AppLocker policy was successfully applied to the computer.|
|8002|Information|*<File name>* was allowed to run.|Specifies that the .exe or .dll file is allowed by an AppLocker rule.|
|8003|Warning|*<File name>* was allowed to run but would have been prevented from running if the AppLocker policy were enforced.|Applied only when the **Audit only** enforcement mode is enabled. Specifies that the .exe or .dll file would be blocked if the **Enforce rules** enforcement mode were enabled.|
|8004|Error|*<File name>* was not allowed to run.|Access to *<file name>* is restricted by the administrator. Applied only when the **Enforce rules** enforcement mode is set either directly or indirectly through Group Policy inheritance. The .exe or .dll file cannot run.|
|8005|Information|*<File name>* was allowed to run.|Specifies that the script or .msi file is allowed by an AppLocker rule.|
|8006|Warning|*<File name>* was allowed to run but would have been prevented from running if the AppLocker policy were enforced.|Applied only when the **Audit only** enforcement mode is enabled. Specifies that the script or .msi file would be blocked if the **Enforce rules** enforcement mode were enabled.|
|8007|Error|*<File name>* was not allowed to run.|Access to *<file name>* is restricted by the administrator. Applied only when the **Enforce rules** enforcement mode is set either directly or indirectly through Group Policy inheritance. The script or .msi file cannot run.|
|8007|Error|AppLocker disabled on the SKU.|Added in  Windows Server 2012  and Windows 8.|
|8020|Information|Packaged app allowed.|Added in  Windows Server 2012  and Windows 8.|
|8021|Information|Packaged app audited.|Added in  Windows Server 2012  and Windows 8.|
|8022|Information|Packaged app disabled.|Added in  Windows Server 2012  and Windows 8.|
|8023|Information|Packaged app installation allowed.|Added in  Windows Server 2012  and Windows 8.|
|8024|Information|Packaged app installation audited.|Added in  Windows Server 2012  and Windows 8.|
|8025|Warning|Packaged app installation disabled.|Added in  Windows Server 2012  and Windows 8.|
|8027|Warning|No Packaged app rule configured.|Added in  Windows Server 2012  and Windows 8.|

## See Also
[Tools to Use with AppLocker](Tools-to-Use-with-AppLocker.md)


