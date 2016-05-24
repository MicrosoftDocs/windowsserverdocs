---
title: Procedure: Deploy a Root Trust Point
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4d32bdf-d528-41b3-9b18-772bb2effe52
---
# Procedure: Deploy a Root Trust Point
Use the following procedures to deploy an Internet root \(.\) trust point.  
  
Do not use this procedure if your network uses a local DNS server as a root DNS server. Instead, use the procedures for importing or adding a trust point and specify the zone name to be the root zone \(.\). For more information, see [Procedure: Import a Trust Point](../Topic/Procedure--Import-a-Trust-Point.md) or [Procedure: Add a Trust Point](../Topic/Procedure--Add-a-Trust-Point.md).  
  
The following procedures are used to deploy a root trust anchor from the Internet Assigned Numbers Authority \(IANA\) using the URL that is specified in the **RootTrustAnchorsURL** property of the DNS server. You can view the **RootTrustAnchorsURL** property by using the **Get\-DnsServerSetting** cmdlet. See the following example.  
  
```  
PS C:\> Get-DnsServerSetting -All | Select RootTrustAnchorsURL  
RootTrustAnchorsURL  
-------------------  
https://data.iana.org/root-anchors/root-anchors.xml  
```  
  
To modify the **RootTrustAnchorsURL** property, use the **Set\-DnsServerSetting** cmdlet.  
  
Procedures are provided using Windows PowerShell.  
  
> [!IMPORTANT]  
> The **Root** parameter is not available for use with the **Add\-DnsServerTrustAnchor** cmdlet in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This parameter is new in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. To deploy a root trust anchor on a DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can use the **Dnscmd.exe** utility \(for example, Dnscmd.exe \/RetrieveRootTrustAnchors.  
  
When you have completed the procedures in this topic, return to the parent checklist.  
  
## <a name="PS"></a>Deploy a root trust point using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
> [!IMPORTANT]  
> To add a root trust point, the computer must be connected to the Internet.  
  
#### To deploy a root trust point using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on the resolving DNS server where you wish to add the root trust anchor.  
  
2.  To add a root trust anchor, use the **Add\-DnsServerTrustAnchor** cmdlet with the **Root** parameter. See the following example.  
  
    ```  
    PS C:\> Add-DnsServerTrustAnchor -Root  
    ```  
  
To verify that the root trust point was successfully added, you can use the **Get\-DnsServerTrustPoint** cmdlet. If you do not specify a value for the **Name** parameter, then all current trust points are displayed. See the following example.  
  
```  
PS C:\> Get-DnsServerTrustPoint  
  
TrustPointName                           TrustPointState      LastActiveRefreshTime     NextActiveRefreshTime  
--------------                           ---------------      ---------------------     ---------------------  
.                                        Active               1/23/2014 1:02:01 PM      1/23/2014 1:02:17 PM  
adatum.com.                              Active               1/23/2014 1:02:01 PM      1/23/2014 1:02:17 PM  
```  
  
> [!WARNING]  
> If the status of a DS trust point is DS Pending, this means that the DNS server currently does not have access to the zone’s DNSKEY resource records. You might also need to verify that the DS trust point is current and uses a supported cryptographic algorithm.  
>   
> After adding a valid DS trust point, the DNS server will automatically acquire the current DNSKEY RRSET and use it to update the trust anchor.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
