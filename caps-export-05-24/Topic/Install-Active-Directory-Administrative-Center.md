---
title: Install Active Directory Administrative Center
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8591cf3c-172c-4e04-ac45-bd135225d709
author: Femila
---
# Install Active Directory Administrative Center
  You can install Active Directory Administrative Center any of the following ways:  
  
-   By default, when you install the Active Directory Domain Services \(AD DS\) server role through Server Manager  
  
-   By default, when you make a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server a domain controller by running Dcpromo.exe  
  
-   With Remote Server Administration Tools \(RSAT\).  
  
 For detailed information about installing the AD DS server role, see Steps for Installing AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140178](http://go.microsoft.com/fwlink/?LinkId=140178)\).  
  
> [!NOTE]  
>  By default, the Active Directory Administrative Center is installed with the [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] and the Microsoft .NET Framework 3.5.1. The [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] and the .NET Framework 3.5.1 must be installed for the Active Directory Administrative Center to function correctly.  
>   
>  So that you can use the Active Directory Administrative Center to manage an Active Directory domain, the Active Directory Web Services \(ADWS\) service must be installed on at least one domain controller in the domain.  
  
## Special considerations for Active Directory Administrative Center  
  
-   Active Directory Administrative Center can be installed on computers running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or later. Active Directory Administrative Center cannot be installed on computers running Windows® 2000, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Vista.  
  
-   You cannot use Active Directory Administrative Center to manage Active Directory Lightweight Directory Services \(AD LDS\) instances and configuration sets.  
  
-   For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Active Directory Administrative Center can be run on any computer that can run [Remote Server Administration Tools](http://www.microsoft.com/download/details.aspx?id=28972).  
  
-   For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Active Directory Administrative Center is available in the following editions:  
  
    -   [!INCLUDE[nextref_server_7std](../Token/nextref_server_7std_md.md)]  
  
    -   [!INCLUDE[nextref_server_7ent](../Token/nextref_server_7ent_md.md)]  
  
    -   [!INCLUDE[nextref_server_7dat](../Token/nextref_server_7dat_md.md)]  
  
-   Active Directory Administrative Center is not available in the following editions of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
    -   [!INCLUDE[nextref_server_7itan](../Token/nextref_server_7itan_md.md)]  
  
    -   [!INCLUDE[nextref_server_7web](../Token/nextref_server_7web_md.md)]  
  
    -   The Server Core option of any edition of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]  
  
> [!IMPORTANT]  
>  To function correctly, Active Directory Administrative Center relies on the ADWS service, which requires TCP port 9389 to be open on the domain controller where ADWS is running. If you configure your firewall by using a Group Policy object \(GPO\), you must update the GPO to make sure that this port is open for ADWS.  
  
  