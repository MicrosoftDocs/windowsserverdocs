---
title: Procedure: Unsign a Zone
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47208336-2974-4a76-b8f8-bc77dec2453d
---
# Procedure: Unsign a Zone
Use the following procedures to unsign a zone that has been signed with DNSSEC on [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]. Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Unsign a zone in DNS Manager](../Topic/Procedure--Unsign-a-Zone.md#windows_ui)  
  
-   [Unsign a zone in Windows PowerShell](../Topic/Procedure--Unsign-a-Zone.md#PS)  
  
## <a name="windows_ui"></a>Unsign a zone in DNS Manager  
The **Unsign zone** wizard is used to unsign a zone in DNS Manager. For examples of the wizard, see [Unsign Zone Wizard](../Topic/DNS-Zones.md#unsign).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To unsign a zone in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a signed zone, point to **DNSSEC**, and then click **Unsign the Zone**.  
  
3.  Click **Next** to immediately unsign the zone.  
  
4.  Verify that **The zone has been successfully unsigned** is displayed, and then click **Finish**.  
  
5.  Right\-click the zone and click **Refresh** to refresh the console view. DNSSEC\-related resource records will be removed from the zone.  
  
If the zone is Active Directory\-integrated, it will not be immediately unsigned on all primary authoritative DNS servers. For performance reasons, zone unsigning is staggered.  
  
## <a name="PS"></a>Unsign a zone in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To unsign a zone in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To unsign a zone, use the **Invoke\-DnsServerZoneUnsign** cmdlet. See the following example.  
  
    ```  
    PS C:\> Invoke-DnsServerZoneUnsign -ZoneName secure.contoso.com -Force  
    ```  
  
    In this example, the zone *secure.contoso.com* is unsigned on the local DNS server. The **Force** parameter is used to skip confirmation.  
  
If the zone is Active Directory\-integrated, it will not be immediately unsigned on all primary authoritative DNS servers. For performance reasons, zone unsigning is staggered.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
