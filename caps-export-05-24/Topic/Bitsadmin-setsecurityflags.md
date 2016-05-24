---
title: Bitsadmin setsecurityflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0da5cbf5-5f7f-4833-bbbe-c4e8379a78ab
author: britw
---
# Bitsadmin setsecurityflags
Sets flags for HTTP that determine if BITS should check the certificate revocation list, ignore certain certificate errors, and define the policy to use when a server redirects the HTTP request. The value is an unsigned integer.  
  
## Syntax  
  
```  
bitsadmin /SetSecurityFlags <Job> <Value>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|Value|See Remarks|  
  
## Remarks  
The **Value** parameter can contain one or more of the following notification flags.  
  
|Action|Binary representation|  
|----------|-------------------------|  
|Enable CRL Check|Set the least significant bit|  
|Ignore invalid common name in server certificate|Set the 2nd bit from the right|  
|Ignore invalid date in server certificate|Set the 3rd bit from the right|  
|Ignore invalid certification authority in server certificate|Set the 4th bit from the right|  
|Ignore invalid usage of the certificate|Set the 5th bit from the right|  
|Redirection policy|Controlled by the 9th to 11th bits from the right<br /><br />0,0,0 \- Redirects will be automatically allowed.<br /><br />0,0,1 \- Remote name in the IBackgroundCopyFile interface will be updated if a redirect occurs.<br /><br />0,1,0 \- BITS will fail the job if a redirect occurs.|  
|Allow redirection from HTTPS to HTTP|Set the 12th bit from the right|  
  
## <a name="BKMK_examples"></a>Examples  
The following example sets the security flags to enable a CRL check for the job named *myJob*.  
  
```  
C:\>bitsadmin /SetSecurityFlags myJob 1  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
