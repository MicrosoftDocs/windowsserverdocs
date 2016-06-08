---
title: Pnpunattend
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fa88932-cff0-4dfc-936c-98c0e3dfbeb8
author: britw
---
# Pnpunattend
Audits a computer for device drivers, and perform unattended driver installations, or search for drivers without installing and, optionally, report the results to the command line. Use this command to specify the installation of specific drivers for specific hardware devices. See Remarks.  
  
## Syntax  
  
```  
PnPUnattend.exe auditSystem [/help] [/?] [/h] [/s] [/L]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|auditSystem|Specifies online driver install.<br /><br />Required, except when pnpunattend is run with either the **\/Help** or **\/?** parameters.|  
|\/s|Optional. Specifies to search for drivers without installing.|  
||Optional. Specifies to display the log information for this command in the command prompt.|  
|\/?|Optional. Displays help for this command at the command prompt.|  
  
## Remarks  
Preliminary preparation is required. Prior to using this command, you must complete the following tasks:  
  
1.  Create a directory for the drivers you want to install. For example, create a folder at **C:\\Drivers\\Video** for video adapter drivers.  
  
2.  Download and extract the driver package for your device. Copy the contents of the subfolder that contains the INF file for your version of the operating system and any subfolders to the video folder that you created. For example, copy the video driver files to C:\\Drivers\\Video.  
  
3.  Add a system environment path variable to the folder you created in step 1.For example, **C:\\Drivers\\Video**.  
  
4.  Create the following registry key, and then for the **DriverPaths** key you create, set the **Value Data** to **1**.  
  
-   For  Windows 7®  navigate the Registry path: **HKEY\_LOCAL\_Machine\\Software\\Microsoft\\Windows NT\\CurrentVersion\\**, and then create the keys: **UnattendSettings\\PnPUnattend\\DriverPaths\\**  
  
-   For Windows Vista, navigate to the Registry path: **HK\_LM\\Software\\Microsoft\\Windows NT\\CurrentVersion\\**, and then create the keys \= **\\UnattendSettings\\PnPUnattend\\DriverPaths**.  
  
## Examples  
The following example command shows how to use the **PNPUnattend.exe** to audit a computer for possible driver updates, and then report the findings to the Command Prompt.  
  
```  
pnpunattend auditsystem /s /l   
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

