---
title: Nslookup set querytype
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5af54ac5-fc1a-4af6-977b-f8e97c8eba90
---
# Nslookup set querytype
Changes the resource record type for the query.  
  
## Syntax  
  
```  
set querytype=<ResourceRecordType>  
```  
  
## Parameters  
<ResourceRecordType>  
  
Specifies a DNS resource record type. The default resource record type is A. The following table lists the valid values for this command.  
  
|Value|Description|  
|---------|---------------|  
|A|Specifies a computer's IP address|  
|ANY|Specifies a computer's IP address.|  
|CNAME|Specifies a canonical name for an alias.|  
|GID|Specifies a group identifier of a group name.|  
|HINFO|Specifies a computer's CPU and type of operating system.|  
|MB|Specifies a mailbox domain name.|  
|MG|Specifies a mail group member.|  
|MINFO|Specifies mailbox or mail list information.|  
|MR|Specifies the mail rename domain name.|  
|MX|Specifies the mail exchanger.|  
|NS|Specifies a DNS name server for the named zone.|  
|PTR|Specifies a computer name if the query is an IP address; otherwise, specifies the pointer to other information.|  
|SOA|Specifies the start\-of\-authority for a DNS zone.|  
|TXT|Specifies the text information.|  
|UID|Specifies the user identifier.|  
|UINFO|Specifies the user information.|  
|WKS|Describes a well\-known service.|  
  
{help | ?}  
  
Displays a short summary of **nslookup** subcommands  
  
## Remarks  
  
-   The **set type** command performs the same function as the **set querytype** command.  
  
-   For more information about resource record types, see Request For Comment \(RFC\) 1035.  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Nslookup set type](../Topic/Nslookup-set-type.md)  
  
