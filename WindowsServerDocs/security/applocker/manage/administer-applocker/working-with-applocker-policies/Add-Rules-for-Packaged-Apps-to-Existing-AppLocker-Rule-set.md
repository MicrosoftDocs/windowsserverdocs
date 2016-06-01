---
title: Add Rules for Packaged Apps to Existing AppLocker Rule-set
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0229ef00-9d63-4c72-b34d-7b4ae7d42979
---
# Add Rules for Packaged Apps to Existing AppLocker Rule-set
This topic describes how to update your existing AppLocker policies for Packaged apps using the Remote Server Administration Toolkit \(RSAT\) in [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)] and [!INCLUDE[win8_client_1](includes/win8_client_1_md.md)].

You can create Packaged app rules for the computers running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] in your domain by updating your existing AppLocker rule set. All you need is a computer running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]. Download and install the Remote Server Administration Toolkit \(RSAT\) from the Microsoft Download Center.

RSAT comes with the Group Policy Management Console which allows you to edit the GPO or GPOs where your existing AppLocker policy are authored. RSAT for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] has the necessary files required to author Packaged app rules. Packaged app rules will be ignored on computers running Windows 7 but will be enforced on those computers in your domain running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)].

## See Also
[Administer AppLocker](Administer-AppLocker.md)


