---
title: "Set the WinSAT Score on the Server"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 911dc494-0f8f-4723-93d6-2106f914b906
caps.latest.revision: 9
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-hk
  - zh-tw
---
# Set the WinSAT Score on the Server
You should set the WinSAT CPU score for a server that is running the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials operating system to optimize the video streaming resolution. You do this by creating and installing the .xml file that contains the WinSAT score information.  
  
## Obtain the WinSAT CPU score  
 You are provided a program with the OPK called WinServerSAT.exe that discovers the WinSAT CPU score and puts that information in the WinServerSAT.xml file that the operating system reads.  
  
#### To obtain the WinSAT CPU score  
  
1.  Copy the Resources\WinServerSAT\\* in ADK media to the reference computer.  
  
2.  On the reference computer, open an elevated Command Prompt window.  
  
3.  If the %ProgramFiles%\Windows Server\Bin\OEM folder does not exist, type the following command and then press Enter.  
  
     **mkdir "%ProgramFiles%\Windows Server\Bin\OEM"**  
  
4.  Type the following command and then press Enter.  
  
     **WinServerSAT.exe "%ProgramFiles%\Windows Server\Bin\OEM\WinServerSAT.xml"**  
  
 The following example shows the XML contents of the WinServerSAT.xml file that is created.  
  
```  
  
<?xml version="1.0" encoding="UTF-16"?>  
<WinSAT>  
   <CpuScore description="WinSAT CPU score">WinSAT_Score</CpuScore>  
</WinSAT>  
```  
  
 Where *WinSAT_Score* is replaced with the value that is discovered on the server.  
  
> [!IMPORTANT]
>  You must remove WinServerSAT.exe, winsat.prx, winsat.wmv, and WinSATEncode.wmv files from the reference computer before you capture the image.
