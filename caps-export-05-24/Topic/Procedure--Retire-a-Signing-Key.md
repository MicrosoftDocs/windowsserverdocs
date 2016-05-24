---
title: Procedure: Retire a Signing Key
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a445f6e-2c67-47d3-80ee-5a058cf3e1df
---
# Procedure: Retire a Signing Key
Use the following procedures to retire \(revoke\) a signing key using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
> [!IMPORTANT]  
> To revoke a signing key, it must not be the last ZSK or KSK available in the zone. If only one signing key of each type \(ZSK and KSK\) is currently configured in the zone, you must add an additional signing key to replace the key that is to be retired.  
  
When you retire a signing key, it will remain active in the zone until the next key rollover. To expedite key retirement, you can perform a manual key rollover. For more information, see [Procedure: Perform a Manual Signing Key Rollover](../Topic/Procedure--Perform-a-Manual-Signing-Key-Rollover.md).  
  
> [!IMPORTANT]  
> When you rollover a ZSK, the rollover will wait for the MaxZone TTL before starting rollover, even if you attempt to manually roll the ZSK. If you have configured one or more resource records in the zone with a long TTL, rollover will be delayed by this period of time. To expedite key rollover, change the TTL of zone records to no more than 1 hour.  
  
You can use DNS Manager or Windows PowerShell to retire DNSSEC signing keys:  
  
-   [Revoke a signing key using DNS Manager](../Topic/Procedure--Retire-a-Signing-Key.md#windows_ui)  
  
-   [Revoke a signing key using Windows PowerShell](../Topic/Procedure--Retire-a-Signing-Key.md#PS)  
  
## <a name="windows_ui"></a>Revoke a signing key using DNS Manager  
You can use DNS Manager to review some signing key settings. However, Windows PowerShell provides additional settings for review.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To revoke a signing key using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Properties**.  
  
3.  Click the **KSK** tab or click the **ZSK** tab, click the signing key in the list that you will retire, and then click **Retire**.  
  
4.  When you are prompted that the key will be marked for retirement, click **OK**, and then click **OK** again.  
  
## <a name="PS"></a>Revoke a signing key using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone you wish to review.  
  
#### To revoke a signing key using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  Use the **Get\-DnsServerSigningKey** cmdlet to retrieve signing key IDs. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    96e2236a-4a4e-4409-afe7-c3aa8ffc254e   KeySigningKey   RsaSha256          2048       True            True  
    bddf9bee-bfdd-41fc-a5c9-e5df8966dbaa   ZoneSigningKey  RsaSha256          1024       True            True  
    925795c2-4772-48d8-b0f0-0d79c8a7e5c7   ZoneSigningKey  RsaSha256          1024       True            True  
    ```  
  
    In the previous example, there are two ZSKs; therefore, one ZSK can be retired.  
  
3.  To retire a signing key, use the **Set\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerSigningKey -ZoneName secure.contoso.com -KeyID bddf9bee-bfdd-41fc-a5c9-e5df8966dbaa –NextRolloverAction Retire  
    ```  
  
To retire all but two signing keys in a zone, you can combine both cmdlets that are used in the previous procedure. See the following example.  
  
```  
PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | Set-DnsServerSigningKey -NextRolloverAction Retire  
```  
  
An error will be displayed if you run this command because the last signing key of each type \(KSK or ZSK\) cannot be retired. All other keys are marked for retirement, however. The result of this command is that the zone will be signed with one KSK and one ZSK after the next key rollover.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
