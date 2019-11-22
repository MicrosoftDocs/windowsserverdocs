---
ms.assetid: fd3bc84a-48eb-4f00-9dc2-846bf2c2668b
title: AD DS Troubleshooting
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/07/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# AD DS Troubleshooting

>Applies To: Windows Server 2016, Windows Server 2012 R2

This section includes troubleshooting recommendations and procedures for diagnosing and fixing problems that may occur during Active Directory replication.

This content focuses primarily on responses to Directory Service event log messages and tool-based error messages that might be reported by the Repadmin.exe and Dcdiag.exe tools. These tools are available on all domain controllers that run Windows Server 2012 R2 or later versions. For more information about using these tools to troubleshoot problems, see the following articles.

- [Configuring a Computer for Troubleshooting Active Directory](../manage/troubleshoot/Configuring-a-Computer-for-Troubleshooting.md)
- [Troubleshooting Active Directory Replication Problems](../manage/troubleshoot/Troubleshooting-Active-Directory-Replication-Problems.md)

Another useful technology is Event Tracing for Windows (ETW), which you can use to troubleshoot LDAP communications among the domain controllers. For more information, see [Using ETW to troubleshoot LDAP connections](../manage/troubleshoot/troubleshoot-ldap-using-etw.md).

You can also install Remote Server Administration Tools (RSAT) on a member server that is running Windows 10. For information about installing RSAT, see [Remote Server Administration Tools](https://docs.microsoft.com/windows-server/remote/remote-server-administration-tools).
