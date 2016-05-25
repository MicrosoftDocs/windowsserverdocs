---
title: Procedure: Move the Key Master Role
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16223f17-3fe2-4a7f-9f51-f033ed6b195d
author: vhorne
---
# Procedure: Move the Key Master Role
Use the following procedures to move the Key Master role for a zone that has been signed with DNSSEC when the current Key Master server is online and the DNS service is running. To move the Key Master role when the current Key Master is offline or the DNS service is unavailable, see [Procedure: Seize the Key Master Role](../Topic/Procedure--Seize-the-Key-Master-Role.md).  
  
To be a Key Master for a zone, a DNS server must be a primary, authoritative DNS server for that zone, and it must be capable of online signing of dynamic DNS zones. You cannot move the Key Master role for zones that are not Active Directory\-integrated because these zones can have only one primary, authoritative DNS server.  
  
For more information about the Key Master, see [The Key Master](../Topic/DNS-Servers.md#KM).  
  
Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Move the Key Master role using DNS Manager](../Topic/Procedure--Move-the-Key-Master-Role.md#windows_ui)  
  
-   [Move the Key Master role using Windows PowerShell](../Topic/Procedure--Move-the-Key-Master-Role.md#PS)  
  
## <a name="windows_ui"></a>Move the Key Master role using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To move the Key Master role using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.  
  
2.  In the console tree, right\-click the zone for which you plan to move the Key Master role, point to **DNSSEC**, and then click **Properties**.  
  
3.  On the **Key Master** tab, select **Use the following DNS server as the Key Master**.  
  
4.  Click the drop\-down list, and then click **Yes** in the pop\-up window that appears. The local DNS server will create a list of DNS servers that are capable of being the new Key Master for the zone.  
  
5.  Choose a DNS server from the list for the new Key Master, and then click **OK**.  
  
6.  Click **Yes** in the dialog box that appears in order to move the Key Master role to the DNS server that was chosen. If you click **No**, the operation will be cancelled, and the Key Master will remain unchanged.  
  
7.  Confirm that **The Key Master for the zone <zone name> has been updated successfully** is displayed, and then click **OK**.  
  
This procedure will immediately change the Key Master. You do not need to wait for Active Directory replication or re\-sign the zone.  
  
## <a name="PS"></a>Move the Key Master role using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names that you will use in your environment.  
  
#### To move the Key Master role using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To move the Key Master role, use the **Reset\-DnsServerZoneKeyMasterRole** cmdlet. See the following example.  
  
    ```  
    PS C:\> Reset-DnsServerZoneKeyMasterRole -ZoneName secure.contoso.com -KeyMasterServer dc3.contoso.com -Force  
    ```  
  
    In this example, the Force parameter is used to skip confirmation steps. The Key Master role for the zone *secure.contoso.com* is transferred to the server *dc3.contoso.com*.  
  
To verify that the Key Master role was successfully transferred, you can use the **Get\-DnsServerDnsSecZoneSetting** cmdlet. See the following example.  
  
```  
PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com  
  
ZoneName                      : secure.contoso.com  
IsKeyMasterServer             : False  
KeyMasterServer               : DC3.contoso.com  
KeyMasterStatus               : Online  
DenialOfExistence             : NSec3  
NSec3HashAlgorithm            : RsaSha1  
NSec3Iterations               : 50  
NSec3OptOut                   : False  
IsNSec3SaltConfigured         : True  
NSec3RandomSaltLength         : 8  
NSec3UserSalt                 : -  
DnsKeyRecordSetTTL            : 01:00:00  
DSRecordSetTTL                : 01:00:00  
DSRecordGenerationAlgorithm   : {Sha1, Sha256}  
DistributeTrustAnchor         : {None}  
EnableRfc5011KeyRollover      : True  
ParentHasSecureDelegation     : False  
SecureDelegationPollingPeriod : 12:00:00  
PropagationTime               : 2.00:00:00  
SignatureInceptionOffset      : 01:00:00  
  
```  
  
This procedure will immediately change the Key Master. You do not need to wait for Active Directory replication or re\-sign the zone.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
