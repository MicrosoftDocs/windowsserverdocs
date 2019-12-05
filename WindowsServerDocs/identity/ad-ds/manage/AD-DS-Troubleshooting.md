---
ms.assetid: fd3bc84a-48eb-4f00-9dc2-846bf2c2668b
title: AD DS Troubleshooting
description: Overview of the troubleshooting section for AD DS
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dcscontentpm
ms.date: 11/22/2019
ms.topic: article
ms.prod: windows-server
audience: Admin
ms.custom:
- CSSTroubleshoot 
ms.technology: identity-adds
---

# AD DS Troubleshooting

>Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

This section includes troubleshooting recommendations and procedures for diagnosing and fixing problems that may occur during Active Directory replication. It focuses on how to respond to Directory Service event log entries and how to interpret messages that tools such as Repadmin.exe and Dcdiag.exe might report.

Repadmin.exe and Dcdiag.exe are available on all domain controllers that run Windows Server 2012 R2 or later versions. For more information about how to use these tools to troubleshoot problems, see the following articles.

- [Configuring a Computer for Troubleshooting Active Directory](../manage/troubleshoot/Configuring-a-Computer-for-Troubleshooting.md)
- [Troubleshooting Active Directory Replication Problems](../manage/troubleshoot/Troubleshooting-Active-Directory-Replication-Problems.md)

Another useful technology is Event Tracing for Windows (ETW). You can use ETW to troubleshoot LDAP communications among the domain controllers. For more information, see [Using ETW to troubleshoot LDAP connections](../manage/troubleshoot/troubleshoot-ldap-using-etw.md).

You can also install Remote Server Administration Tools (RSAT) on a member server that is running Windows 10. For information about how to install RSAT, see [Remote Server Administration Tools](https://docs.microsoft.com/windows-server/remote/remote-server-administration-tools).
