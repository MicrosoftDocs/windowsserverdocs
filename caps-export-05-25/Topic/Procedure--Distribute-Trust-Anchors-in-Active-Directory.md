---
title: Procedure: Distribute Trust Anchors in Active Directory
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bc9fb50a-c7c2-49bc-91bc-e5de2dda3c2d
author: vhorne
---
# Procedure: Distribute Trust Anchors in Active Directory
Use the following procedures to distribute trust anchors in Active Directory using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
The following procedures enable automatic distribution of trust anchors in Active Directory for a zone that is already signed with DNSSEC.  
  
If the zone is not signed and you want to enable automatic trust anchor distribution when the zone is signed, see [Procedure: Customize Zone Signing Parameters](../Topic/Procedure--Customize-Zone-Signing-Parameters.md). This setting is not enabled by default.  
  
> [!IMPORTANT]  
> If this setting is enabled and the DNS server is also a domain controller, trust anchors will be distributed to all DNS servers running on domain controllers in the Active Directory forest. If the DNS server is not a domain controller, a trust anchor for the zone will be added only to the local trust anchor store, located by default in **%windir%\\system32\\dns\\TrustAnchors.dns**.  
  
Choose to use DNS Manager or Windows PowerShell:  
  
-   [Enable trust anchor distribution in Active Directory using DNS Manager](../Topic/Procedure--Distribute-Trust-Anchors-in-Active-Directory.md#windows_ui)  
  
-   [Enable trust anchor distribution in Active Directory using Windows PowerShell](../Topic/Procedure--Distribute-Trust-Anchors-in-Active-Directory.md#PS)  
  
## <a name="windows_ui"></a>Enable trust anchor distribution in Active Directory using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To enable trust anchor distribution in Active Directory using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  In the DNS Manager console tree, right\-click the zone where you will enable trust anchor distribution, point to **DNSSEC**, and then click **Properties**.  
  
3.  Click the **Trust Anchor** tab.  
  
4.  Select the **Enable the distribution of trust anchors for this zone** check box.  
  
5.  Click **OK** to close the DNSSEC properties dialog box.  
  
6.  In the pop\-up window that appears, click **Yes** to confirm the changes that were made to the zone.  
  
7.  Verify that **Configuration of DNSSEC parameters was successful** is displayed, and then click **OK**.  
  
## <a name="PS"></a>Enable trust anchor distribution in Active Directory using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the example Windows PowerShell examples that are provided, replace the server and zone names with the names of the servers and zones that are used in your environment.  
  
#### To enable trust anchor distribution in Active Directory using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  You can use the **Set\-DnsServerDnsSecZoneSetting** cmdlet with the **DistributeTrustAnchor** parameter to enable distribution of trust anchors in Active Directory. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com -DistributeTrustAnchor DnsKey  
    ```  
  
3.  You can use the **Get\-DnsServerDnsSecZoneSetting** cmdlet to confirm this setting. See the following example.  
  
    ```  
  
    PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | fl -Property ZoneName,DistributeTrustAnchor  
  
    ZoneName              : secure.contoso.com  
    DistributeTrustAnchor : {DnsKey}  
    ```  
  
    In the previous example, the **Format\-List** \(fl\) parameter was used to display only the **ZoneName** and **DistributeTrustAnchor** properties.  
  
Only DNSKEY trust anchors can be distributed in Active Directory. You cannot distribute a DS trust anchor.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
