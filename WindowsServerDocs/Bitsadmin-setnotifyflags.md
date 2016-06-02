---
title: Bitsadmin setnotifyflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d5763d95-94a6-45ca-9e03-891c20047e06
author: britw
---
# Bitsadmin setnotifyflags
Sets the event notification flags for the specified job.  
  
## Syntax  
  
```  
bitsadmin /SetNotifyFlags <Job> <NotifyFlags>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|NotifyFlags|See Remarks|  
  
## Remarks  
The **NotfiyFlags** parameter can contain one or more of the following notification flags.  
  
|||  
|-|-|  
|1|Generate an event when all files in the job have been transferred.|  
|2|Generate an event when an error occurs.|  
|4|Disable notifications.|  
  
## <a name="BKMK_examples"></a>Examples  
The following example sets the notify flags for transferred and error events job for job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /SetNotifyFlags myDownloadJob 3  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

