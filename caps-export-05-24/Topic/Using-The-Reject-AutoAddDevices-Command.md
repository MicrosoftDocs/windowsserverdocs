---
title: Using The Reject-AutoAddDevices Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea25a4b2-5fad-4360-9c47-c2c9df7ea31f
---
# Using The Reject-AutoAddDevices Command
Rejects computers that are pending administrative approval. When the Auto\-Add policy is enabled, administrative approval is required before unknown computers \(those that are not prestaged\) can install an image. You can enable this policy using the **PXE Response** tab of the server’s properties page.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Reject-AutoAddDevices [/Server:<Server name>] /RequestId:<Request ID or ALL>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/RequestId:<Request ID &#124; ALL>|Specifies the request ID assigned to the pending computer. To reject all pending computers, specify **ALL**.|  
  
## <a name="BKMK_examples"></a>Examples  
To reject a single computer, type:  
  
```  
WDSUTIL /Reject-AutoAddDevices /RequestId:12  
```  
  
To reject all computers, type:  
  
```  
WDSUTIL /Verbose /Reject-AutoAddDevices /Server:MyWDSServer /RequestId:ALL  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the Approve-AutoAddDevices Command](../Topic/Using-the-Approve-AutoAddDevices-Command.md)  
  
[Using the delete-AutoAddDevices Command](../Topic/Using-the-delete-AutoAddDevices-Command.md)  
  
[Using the get-AutoAddDevices Command](../Topic/Using-the-get-AutoAddDevices-Command.md)  
  
