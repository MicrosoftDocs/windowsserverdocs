---
title: Netcfg
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2daaab7-12db-4e36-b70c-db8906d084f7
author: vhorne
---
# Netcfg
Installs the Windows Preinstallation Environment \(WinPE\), a lightweight version of Windows used to deploy workstations. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
netcfg [/v] [/e] [/winpe] [/l ] /c /i  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/v|Run in verbose \(detailed\) mode|  
|\/e|Use servicing environment variables during install and uninstall|  
|\/winpe|Installs TCP\/IP, NetBIOS and Microsoft Client for Windows preinstallation envrionment|  
|\/l|Provides the location of INF|  
|\/c|Provides the class of the component to be installed; protocol, Service, or client|  
|\/i|Provides the component ID|  
|\/s|Provides the type of components to show<br /><br />\\ta \= adapters, n \= net components|  
|\/?|Displays Help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To install the protocol *example* using c:\\oemdir\\example.inf:  
  
```  
netcfg /l c:\oemdir\example.inf /c p /i example  
```  
  
To install the *MS\_Server* service:  
  
```  
netcfg /c s /i MS_Server  
```  
  
To install TCP\/IP, NetBIOS and Microsoft Client for Windows preinstallation environment  
  
```  
netcfg /v /winpe  
```  
  
To display if component *MS\_IPX* is installed:  
  
```  
netcfg /q MS_IPX  
```  
  
To uninstall component *MS\_IPX*:  
  
```  
netcfg /u MS_IPX  
```  
  
To show all installed net components:  
  
```  
netcfg /s n  
```  
  
To shows binding paths containing *MS\_TCPIP*:  
  
```  
netcfg /b ms_tcpip  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

