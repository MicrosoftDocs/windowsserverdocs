---
title: sxstrace
description: Learn how to diagnose side-by-side problems.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcd26eeb-fbd9-4a86-b6a9-dfa5e9c6e4fc

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# sxstrace

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Diagnoses side-by-side problems.    

## Syntax  
```  
sxstrace [{[trace -logfile:<FileName> [-nostop]|[parse -logfile:<FileName> -outfile:<ParsedFile>  [-filter:<AppName>]}]  
```  

### Parameters  
|Parameter|Description|  
|-------|--------|  
|trace|Enables tracing for sxs (side-by-side)|  
|-logfile|Specifies the raw log file.|  
|\<FileName>|Saves tracing log to *FileName*.|  
|-nostop|Specifies no prompt to stop tracing.|  
|parse|Translates the raw trace file.|  
|-outfile|Specifies the output filename.|  
|\<ParsedFile>|Specifies the filename of the parsed file.|  
|-filter|Allows the output to be filtered.|  
|\<AppName>|Specifies the name of the application.|  
|stoptrace|Stop the trace if it is not stopped before.|  
|-?|Displays help at the command prompt.|  

## <a name="BKMK_Examples"></a>Examples  
Enable tracing and save trace file to **sxstrace.etl**:  
```  
sxstrace trace -logfile:sxstrace.etl  
```  
Translate the raw trace file into a human readable format and save the result to **sxstrace.txt**:  
```  
sxstrace parse -logfile:sxstrace.etl -outfile:sxstrace.txt  
```  

## Additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
