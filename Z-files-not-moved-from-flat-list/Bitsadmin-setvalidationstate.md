---
title: Bitsadmin setvalidationstate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8fc8e8c-171c-4681-8057-6986b018e576
author: britw
---
# Bitsadmin setvalidationstate
Sets the content validation state of the given file within the job.  
  
## Syntax  
  
```  
bitsadmin /SetValidationState <Job> <file index> <true|false>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|File index|Starts from 0|  
|True&#124;False|Set to TRUE if the file content is valid, otherwise set to FALSE|  
  
## <a name="BKMK_examples"></a>Examples  
The following example sets the content validation state of file 2 to TRUE for the job named *myJob*.  
  
```  
C:\>bitsadmin /SetValidationState myJob 2 TRUE   
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

