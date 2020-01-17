---
title: User Account Control Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-tpm
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b7a39cd-fc10-4408-befd-4b2c45806732
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Account Control Overview
User Account Control \(UAC\) is a fundamental component of Microsoft's overall security vision.  UAC helps mitigate the impact of a malicious program.

## <a name="BKMK_OVER"></a>Feature description
UAC allows all users to log on to their computers using a standard user account. Processes launched using a standard user token may perform tasks using access rights granted to a standard user. For instance, Windows Explorer automatically inherits standard user level permissions. Additionally, any programs that are executed using Windows Explorer \(for example, by double\-clicking an application shortcut\) also run with the standard set of user permissions. Many applications, including those that are included with the operating system itself, are designed to work properly in this way.

Other applications, especially those that were not specifically designed with security settings in mind, often require additional permissions to run successfully. These types of programs are referred to as legacy applications. Additionally, actions such as installing new software and making configuration changes to programs such as Windows Firewall, require more permissions than what is available to a standard user account.

When an applications needs to run with more than standard user rights, UAC can restore additional user groups to the token. This enables the user to have explicit control of programs that are making system level changes to their computer or device.

## <a name="BKMK_APP"></a>Practical applications
Admin Approval Mode in UAC helps prevent malicious programs from silently installing without an administrator's knowledge. It also helps protect from inadvertent system\-wide changes. Lastly, it can be used to enforce a higher level of compliance where administrators must actively consent or provide credentials for each administrative process.



