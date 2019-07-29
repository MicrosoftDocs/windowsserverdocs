---
title: nslookup set querytype
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5af54ac5-fc1a-4af6-977b-f8e97c8eba90
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup set querytype

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the resource record type for the query.
## Syntax
```
set querytype=<ResourceRecordtype>
```
## Parameters
<ResourceRecordtype>
Specifies a DNS resource record type. The default resource record type is A. The following table lists the valid values for this command.

| Value |                                                   Description                                                   |
|-------|-----------------------------------------------------------------------------------------------------------------|
|   A   |                                      Specifies a computer&#39;s IP address                                      |
|  ANY  |                                     Specifies a computer&#39;s IP address.                                      |
| CNAME |                                    Specifies a canonical name for an alias.                                     |
|  GID  |                                  Specifies a group identifier of a group name.                                  |
| HINFO |                          Specifies a computer&#39;s CPU and type of operating system.                           |
|  MB   |                                        Specifies a mailbox domain name.                                         |
|  MG   |                                         Specifies a mail group member.                                          |
| MINFO |                                   Specifies mailbox or mail list information.                                   |
|  MR   |                                     Specifies the mail rename domain name.                                      |
|  MX   |                                          Specifies the mail exchanger.                                          |
|  NS   |                                 Specifies a DNS name server for the named zone.                                 |
|  PTR  | Specifies a computer name if the query is an IP address; otherwise, specifies the pointer to other information. |
|  SOA  |                                Specifies the start-of-authority for a DNS zone.                                 |
|  TXT  |                                         Specifies the text information.                                         |
|  UID  |                                         Specifies the user identifier.                                          |
| UINFO |                                         Specifies the user information.                                         |
|  WKS  |                                         Describes a well-known service.                                         |
| {help |                                                       ?}                                                        |

Displays a short summary of <strong>nslookup</strong> subcommands
## Remarks
- The <strong>set type</strong> command performs the same function as the <strong>set querytype</strong> command.
- for more information about resource record types, see Request for Comment (Rfc) 1035.
  ## additional references
  <a href="command-line-syntax-key.md" data-raw-source="[Command-Line Syntax Key](command-line-syntax-key.md)">Command-Line Syntax Key</a>
  <a href="nslookup-set-type.md" data-raw-source="[nslookup set type](nslookup-set-type.md)">nslookup set type</a>
