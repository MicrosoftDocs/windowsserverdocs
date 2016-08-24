---
title: Sxstrace
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcd26eeb-fbd9-4a86-b6a9-dfa5e9c6e4fc
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Sxstrace
Diagnoses side-by-side problems.  For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
Sxstrace [{[trace /logfile:<FileName> [/nostop]|[parse /logfile:<FileName> /outfile:<ParsedFile>  [/filter:<AppName>]}]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|trace|Enables tracing for sxs (side-by-side)|  
|/logfile|Specifies the raw log file.|  
|<FileName>|Saves tracing log to *FileName*.|  
|/nostop|Specifies no prompt to stop tracing.|  
|parse|Translates the raw trace file.|  
|/outfile|Specifies the output filename.|  
|<ParsedFile>|Specifies the filename of the parsed file.|  
|/filter|Allows the output to be filtered.|  
|<AppName>|Specifies the name of the application.|  
|stoptrace|Stop the trace if it is not stopped before.|  
|/?|Displays Help at the command prompt.|  
## <a name="BKMK_Examples"></a>Examples  
Enable tracing and save trace file to **sxstrace.etl**:  
```  
sxstrace trace /logfile:sxstrace.etl  
```  
Translate the raw trace file into a human readable format and save the result to **sxstrace.txt**:  
```  
sxstrace parse /logfile:sxstrace.etl /outfile:sxstrace.txt  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
