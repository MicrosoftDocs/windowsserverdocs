---
title: "Set the WinSAT Score on the Server"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 911dc494-0f8f-4723-93d6-2106f914b906
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Set the WinSAT Score on the Server

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You should set the WinSAT CPU score for a server that is running the  Windows Server Essentials operating system to optimize the video streaming resolution. You do this by creating and installing the .xml file that contains the WinSAT score information.  
  
## Obtain the WinSAT CPU score  
 You are provided a program with the OPK called WinServerSAT.exe that discovers the WinSAT CPU score and puts that information in the WinServerSAT.xml file that the operating system reads.  
  
#### To obtain the WinSAT CPU score  
  
1. Copy the Resources\WinServerSAT\\* in ADK media to the reference computer.  
  
2. On the reference computer, open an elevated Command Prompt window.  
  
3. If the %ProgramFiles%\Windows Server\Bin\OEM folder does not exist, type the following command and then press Enter.  
  
    **mkdir "%ProgramFiles%\Windows Server\Bin\OEM"**  
  
4. Type the following command and then press Enter.  
  
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
