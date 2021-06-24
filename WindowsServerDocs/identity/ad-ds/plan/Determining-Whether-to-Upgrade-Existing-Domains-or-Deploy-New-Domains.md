---
description: "Learn more about: Determining Whether to Upgrade Existing Domains or Deploy New Domains"
ms.assetid: c20231dd-2b83-4494-9385-1172272e00d6
title: Determining Whether to Upgrade Existing Domains or Deploy New Domains
author: iainfoulds
ms.author: daveba
manager: daveba
ms.date: 05/31/2017
ms.topic: article
---

# Determining Whether to Upgrade Existing Domains or Deploy New Domains

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Each domain in your design will either be a new domain or an existing upgraded domain. Users from existing domains that you do not upgrade must be moved into new domains.

Moving accounts between domains can impact end users. Before deciding whether to move users into a new domain or to upgrade existing domains, evaluate the long-term administrative benefits of a new AD DS domain against the cost of moving users into the domain.

For more information about upgrading Active Directory domains to  Windows Server 2008, see [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731188(v=ws.10)).

For more information about restructuring AD DS domains within and between forests, see [ADMT Guide: Migrating and Restructuring Active Directory Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc974332(v=ws.10)).

For a worksheet to assist you in documenting your plans for new and upgraded domains, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from [Job Aids for Windows Server 2003 Deployment Kit](https://microsoft.com/download/details.aspx?id=9608) and open "Domain Planning" (DSSLOGI_5.doc).
