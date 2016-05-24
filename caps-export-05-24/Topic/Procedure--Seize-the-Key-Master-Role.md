---
title: Procedure: Seize the Key Master Role
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d5ae3887-acba-4a56-acca-7d894418b940
---
# Procedure: Seize the Key Master Role
Use the following procedures to seize the Key Master role for a zone that has been signed with DNSSEC when the current Key Master server is offline and the DNS service is not available. To move the Key Master role when the current Key Master is online and available, see [Procedure: Move the Key Master Role](../Topic/Procedure--Move-the-Key-Master-Role.md).  
  
> [!IMPORTANT]  
> When you seize the Key Master role, the new Key Master must have access to private key material for the zone. If the new Key Master does not have this access, all signing keys in the zone must be replaced with new keys, and the zone must be re\-signed. If trust anchors have been distributed for the zone, these trust anchors must also be manually updated after zone re\-signing. For more information, see [Seizing the Key Master role](../Topic/DNS-Servers.md#seize).  
  
To be a Key Master for a zone, a DNS server must be a primary, authoritative DNS server for that zone, and it must be capable of online signing of dynamic DNS zones. You cannot move the Key Master role for zones that are not Active Directory\-integrated because these zones can have only one primary, authoritative DNS server.  
  
Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Seize the Key Master role using DNS Manager](../Topic/Procedure--Seize-the-Key-Master-Role.md#windows_ui)  
  
-   [Seize the Key Master role using Windows PowerShell](../Topic/Procedure--Seize-the-Key-Master-Role.md#PS)  
  
## <a name="windows_ui"></a>Seize the Key Master role using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To seize the Key Master role using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.  
  
2.  In the console tree, right\-click the zone for which you plan to move the Key Master role, point to **DNSSEC**, and then click **Properties**. An alert will be displayed indicating that DNSSEC settings for the zone could not be loaded from the Key Master.  
  
3.  In the pop\-up window that appears, click **Yes**.  
  
    > [!NOTE]  
    > If you do not see an alert, verify that the Key Master is offline. If the Key Master is online, and you still wish to move the Key Master role, see [Procedure: Move the Key Master Role](../Topic/Procedure--Move-the-Key-Master-Role.md) to move the Key Master. Do not use this procedure to seize the Key Master role.  
  
4.  On the **Key Master** tab, select **Use the following DNS server as the Key Master**.  
  
5.  Click the drop\-down list, and then click **Yes** in the pop\-up window that appears. The local DNS server will create a list of DNS servers that are capable of being the new Key Master for the zone.  
  
6.  Choose a DNS server from the list for the new Key Master, and click **OK**.  
  
7.  Click **Yes** in the dialog box that appears to move the Key Master role to the DNS server that was chosen. If you click **No**, the operation will be cancelled and the Key Master will remain unchanged.  
  
8.  If you see a dialog box warning that the Key Master cannot be contacted to transfer private key material, this means that the current DNS server does not have access to private key material. In this scenario, transferring the Key Master role also requires that the zone be re\-signed and trust anchors must be updated. Click **Yes** to continue.  
  
9. Confirm that **The Key Master for the zone <zone name> has been updated successfully** is displayed, and then click **OK**.  
  
This procedure will immediately change the Key Master.  
  
## <a name="PS"></a>Seize the Key Master role using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To seize the Key Master role using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To seize the Key Master role, use the **Reset\-DnsServerZoneKeyMasterRole** cmdlet with the **SeizeRole** parameter. See the following example.  
  
    ```  
    PS C:\> Reset-DnsServerZoneKeyMasterRole -ZoneName secure.contoso.com -KeyMasterServer dc3.contoso.com –SeizeRole -Force  
    ```  
  
    In this example, the **SeizeRole** parameter is used to seize, rather than move, the Key Master role, and the **Force** parameter is used to skip confirmation steps. The Key Master role for the zone *secure.contoso.com* is transferred to the server *dc3.contoso.com*.  
  
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
  
This procedure will immediately change the Key Master.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
