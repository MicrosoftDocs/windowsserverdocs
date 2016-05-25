---
title: Turn on Windows Firewall and Configure Default Behavior
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 56dd326c-0b9a-42ff-92c0-8a40b91f6c43
author: vhorne
---
# Turn on Windows Firewall and Configure Default Behavior
To enable Windows Firewall and configure its default behavior, use the [!INCLUDE[wfas](../Token/wfas_md.md)] node \(for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\) in the Group Policy Management MMC snap\-in.  
  
**Administrative credentials**  
  
To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
## <a name="bkmk_1"></a>  
#### To enable Windows Firewall and configure the default behavior on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  In the details pane, in the **Overview** section, click **Windows Firewall Properties**.  
  
3.  For each network location type \(Domain, Private, Public\), perform the following steps.  
  
    > [!NOTE]  
    > The steps shown here indicate the recommended values for a typical deployment. Use the settings that are appropriate for your firewall design.  
  
    1.  Click the tab that corresponds to the network location type.  
  
    2.  Change **Firewall state** to **On \(recommended\)**.  
  
    3.  Change **Inbound connections** to **Block \(default\)**.  
  
    4.  Change **Outbound connections** to **Allow \(default\)**.  
  
