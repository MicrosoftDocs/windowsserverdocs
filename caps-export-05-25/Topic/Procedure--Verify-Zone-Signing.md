---
title: Procedure: Verify Zone Signing
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d6a7c15c-e471-4587-b145-94b8e3033c8c
author: vhorne
---
# Procedure: Verify Zone Signing
Use the following procedures to verify a zone has been signed with DNSSEC using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
The procedure does not verify that resource record signatures are valid. To verify the validity of zone signing, see [Procedure: Verify Name Resolution Policy](../Topic/Procedure--Verify-Name-Resolution-Policy.md).  
  
You can use DNS Manager or Windows PowerShell to verify zone signing:  
  
-   [Verify zone signing in DNS Manager](../Topic/Procedure--Verify-Zone-Signing.md#windows_ui)  
  
-   [Verify zone signing in Windows PowerShell](../Topic/Procedure--Verify-Zone-Signing.md#PS)  
  
## <a name="windows_ui"></a>Verify zone signing in DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To verify zone signing in DNS Manager  
  
1.  Open DNS Manager on an authoritative DNS server, or connect to an authoritative DNS server with DNS Manager.  
  
2.  In the console tree, under **Forward Lookup Zones** or under **Reverse Lookup Zones**, click the zone you wish to verify.  
  
3.  In the right\-hand pane, review resource records in the zone and verify that DNSSEC\-related resource records are present. If the zone was recently signed, you might need to right\-click the zone and click **Refresh**.  
  
    For a zone to be validly signed, it must contain RRSIG, DNSKEY, and NSEC or NSEC3 records. See the following examples of a zone before and after zone signing.  
  
    The following simple, example zone has four resource records prior to zone signing: SOA, NS, A, and MX:  
  
    ![](../Image/DNSSEC_before.png)  
  
    The following example shows the same zone after zone signing with default parameter values:  
  
    ![](../Image/DNSSEC_after.png)  
  
    During zone signing, a matching resource record of **Type** RRSIG will be added to the zone for each of the resource records that were present prior to zone signing. The matching resource record type is displayed under **Data** \(ex: \[SOA\]\[Inception…\]\), and is also displayed by viewing properties of the RRSIG resource record.  
  
    In addition, DNSKEY and NSEC3 resource records are added. Because NSEC3 was used in this example, an NSEC3PARAM resource record is also present. This record will not be present if the zone was instead signed with NSEC.  
  
**Notes**:  
  
-   If you are viewing the zone on a primary authoritative DNS server, the icon for the zone in the console tree will display a lock symbol when the zone is signed. To see this icon, you might need to refresh the console view.  
  
-   If you are viewing the zone on a secondary authoritative DNS server, the icon for the zone in the console tree will not display a lock symbol even if the zone is signed.  
  
-   If the zone was signed on a server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], DNSSEC\-related resource records will be present, but the icon for the zone in the console tree will not display a lock symbol on either primary or secondary authoritative DNS servers. This is true even if you are viewing the zone on a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system.  
  
-   If the DNSSEC\-signed zone is Active Directory\-integrated, and was recently signed, it will not be immediately signed on all other primary authoritative DNS servers. For performance reasons, zone signing on other DNS servers in the domain is staggered. To verify a zone is signed immediately after zone signing, view the zone on the Key Master.  
  
## <a name="PS"></a>Verify zone signing in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the example Windows PowerShell commands that are provided, replace the server and zone names with the names of the servers and zones used in your environment.  
  
#### To verify zone signing in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on an authoritative DNS server.  
  
2.  To verify a zone is signed, use the **Get\-DnsServerZone** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerZone -Name corp.contoso.com  
  
    ZoneName                            ZoneType        IsAutoCreated   IsDsIntegrated  IsReverseLookupZone  IsSigned  
    --------                            --------        -------------   --------------  -------------------  --------  
    corp.contoso.com                    Primary         False           False           False                True  
    ```  
  
    Verify that **True** is displayed in the **IsSigned** column.  
  
    > [!NOTE]  
    > If the zone was signed on a server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], a value of *False* will be displayed under **IsSigned** even though the zone is signed. This is because static, offline\-signed zones are not automatically recognized as signed zones by computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later. DNSSEC validation is supported on these zones, however. To verify a zone that was signed on a DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], use the **Get\-DnsServerResourceRecord** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerResourceRecord -ZoneName dc1sec.contoso.com  
  
    HostName                  RecordType Timestamp            TimeToLive      RecordData  
    --------                  ---------- ---------            ----------      ----------  
    @                         NS         0                    01:00:00        dc1.contoso.com.  
    @                         NS         0                    01:00:00        dc2.contoso.com.  
    @                         SOA        0                    01:00:00        [3][dc1.contoso.com.][hostmaster.contoso.com.]  
    @                         RRSIG      0                    01:00:00        [DNSKEY][RsaSha1][35518]  
    @                         RRSIG      0                    01:00:00        [DNSKEY][RsaSha1][43498]  
    @                         RRSIG      0                    01:00:00        [NSEC][RsaSha1][35518]  
    @                         RRSIG      0                    01:00:00        [NS][RsaSha1][35518]  
    @                         RRSIG      0                    01:00:00        [SOA][RsaSha1][35518]  
    @                         NSEC       0                    01:00:00        [dc1.dc1sec.contoso.com.][NS SOA RRSIG NSEC DNS...  
    @                         DNSKEY     0                    01:00:00        [ZoneKey][RsaSha1][35518]  
    @                         DNSKEY     0                    01:00:00        [SEP][ZoneKey][RsaSha1][43498]  
    dc1                       A          0                    01:00:00        192.168.0.1  
    dc1                       RRSIG      0                    01:00:00        [NSEC][RsaSha1][35518]  
    dc1                       RRSIG      0                    01:00:00        [A][RsaSha1][35518]  
    dc1                       NSEC       0                    01:00:00        [www.dc1sec.contoso.com.][A RRSIG NSEC]  
    www                       A          0                    01:00:00        192.168.0.100  
    www                       RRSIG      0                    01:00:00        [NSEC][RsaSha1][35518]  
    www                       RRSIG      0                    01:00:00        [A][RsaSha1][35518]  
    www                       NSEC       0                    01:00:00        [dc1sec.contoso.com.][A RRSIG NSEC]  
    ```  
  
    Verify that RRSIG, DNSKEY, and NSEC resource records are present in the zone.  
  
Do not use Windows PowerShell cmdlets like **Get\-DnsServerDnsSecZoneSetting** to verify that a zone is signed. A zone can have DNSSEC settings even if it is not currently signed.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
