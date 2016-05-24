---
title: Procedure: Import a Trust Point
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 858f3f83-443b-4efb-8a0b-4ae3c153a6d4
---
# Procedure: Import a Trust Point
Use the following procedures to import a trust point for a zone that has been signed with DNSSEC. To import a trust point, the DSSET or KEYSET records for a zone must be available in a file. You can create this file manually, or export it from the Key Master.  
  
When you sign a zone on a DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or later, the DNSKEY RRSET \(also called the Keyset\) and the DS RRSET \(also called the dsset\) are stored in text files on the Key Master for use as trust points. By default these files are available in the **%windir%\\system32\\dns** directory. To import a trust point on a DNS server, these files must be made accessible to the DNS server. For more information, see [Procedure: Export a Trust Point](../Topic/Procedure--Export-a-Trust-Point.md).  
  
For more information about trust points, see [Trust Anchors](../Topic/Trust-Anchors.md).  
  
Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Import a trust point using DNS Manager](../Topic/Procedure--Import-a-Trust-Point.md#windows_ui)  
  
-   [Import a trust point using Windows PowerShell](../Topic/Procedure--Import-a-Trust-Point.md#PS)  
  
## <a name="windows_ui"></a>Import a trust point using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To import a trust point using DNS Manager  
  
1.  Open DNS Manager on the server where you wish to import the trust point, or connect to the DNS server from another location using DNS Manager.  
  
2.  In the console tree, right\-click **Trust Points**, point to **Import**, and then click **DNSKEY** or click **DS**.  
  
    If the trust point that you have made available is a KEYSET, then point to **DNSKEY**. If the trust point that is available is a DSSET, point to **DS**.  
  
3.  Click **Browse** or type the location of the KEYSET or DSSET file, and then click **OK**.  
  
If a trust point for the zone did not previously exist, a new folder will be created in the DNS Manager console tree under Trust Points. If the trust point for this zone had previously been imported or added to the DNS server, the trust point will be updated.  
  
## <a name="PS"></a>Import a trust point using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To import a trust point using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on the server where you wish to import the trust point.  
  
2.  To import a trust point, use the **Import\-DnsServerTrustAnchor** cmdlet. See the following example.  
  
    ```  
    PS C:\> Import-DnsServerTrustAnchor -KeySetFile "\\File1\DNSKeys\keyset-secure.contoso.com"  
    ```  
  
    In this example, a DNSKEY trust anchor for the zone *secure.contoso.com* is imported on the local DNS server. To import a DS trust anchor, use the **DSSetFile** parameter in place of **KeySetFile** and specify a filename of *dsset\-secure.contoso.com*.  
  
To verify that the trust point was successfully imported, you can use the **Get\-DnsServerTrustAnchor** cmdlet. See the following example:  
  
```  
PS C:\> Get-DnsServerTrustAnchor -Name secure.contoso.com  
  
TrustAnchorName                TrustAnchorType      TrustAnchorState     TrustAnchorData  
---------------                ---------------      ----------------     ---------------  
secure.contoso.com.            DNSKEY               Valid                [8000][DnsSec][RsaSha256][AwEAAY/kENeHkSmtd...  
secure.contoso.com.            DNSKEY               Valid                [62111][DnsSec][RsaSha256][DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
