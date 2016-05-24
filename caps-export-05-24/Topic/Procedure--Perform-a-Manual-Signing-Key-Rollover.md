---
title: Procedure: Perform a Manual Signing Key Rollover
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c38ba03d-0b3e-4999-a7ed-07e52075dff8
---
# Procedure: Perform a Manual Signing Key Rollover
Use the following procedures to perform a manual signing key rollover using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
> [!CAUTION]  
> When you perform a manual signing key \(ZSK or KSK\) rollover, trust anchors that have been distributed for the zone must also be manually updated. Automatic trust anchor updates \(RFC 5011\) are only supported for automatic key rollover.  
>   
> Key rollover does not occur immediately:  
>   
> -   For rollover of ZSKs, the DNS server will wait for a minimum of 1 hour to allow for any existing RRSIG resource records that are cached on resolving DNS servers to expire. ZSK rollover can require a longer period of time if the DNSKEY TTL or maximum TTL that is configured for other resource records in the zone is greater than 1 hour.  
> -   For KSK rollover, the DNS server will wait for trust anchor updates. If the current rollover status is **KskWaitingForDSUpdate** and you know that the parent zone has been updated, you can use the **Step\-DnsServerSigningKeyrollover** cmdlet to force key rollover to continue.  
>   
> You are not allowed to add new signing keys or reconfigure signing key parameters during this waiting period.  
  
You can use DNS Manager or Windows PowerShell to manually rollover signing keys:  
  
-   [Perform a manual signing key rollover using DNS Manager](../Topic/Procedure--Perform-a-Manual-Signing-Key-Rollover.md#windows_ui)  
  
-   [Perform a manual signing key rollover using Windows PowerShell](../Topic/Procedure--Perform-a-Manual-Signing-Key-Rollover.md#PS)  
  
## <a name="windows_ui"></a>Perform a manual signing key rollover using DNS Manager  
Use the following procedure to perform a manual key rollover using the DNS Manager console.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To perform a manual signing key rollover using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Properties**.  
  
3.  Click the **KSK** tab or click the **ZSK** tab, click the signing key in the list that you will rollover, and then click **Rollover**.  
  
4.  When you are prompted to confirm the rollover on the selected key, click **Yes**.  
  
5.  Click **OK** to close DNSSEC properties of the zone.  
  
## <a name="PS"></a>Perform a manual signing key rollover using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone you wish to review.  
  
#### To perform a manual signing key rollover using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  Use the **Get\-DnsServerSigningKey** cmdlet to retrieve signing key IDs. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    96e2236a-4a4e-4409-afe7-c3aa8ffc254e   KeySigningKey   RsaSha256          2048       True            True  
    925795c2-4772-48d8-b0f0-0d79c8a7e5c7   ZoneSigningKey  RsaSha256          1024       True            True  
    ```  
  
3.  To roll over a signing key, use the **Invoke\-DnsServerSigningKeyRollover** cmdlet. See the following example.  
  
    ```  
    PS C:\> Invoke-DnsServerSigningKeyRollover -ZoneName secure.contoso.com -KeyID 925795c2-4772-48d8-b0f0-0d79c8a7e5c7 -Force  
    ```  
  
    In the previous example, the **Force** parameter is used to skip confirmation.  
  
To review the status of the key rollover, you can use the **Get\-DnsServerSigningKey** cmdlet. See the following example.  
  
```  
PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com -KeyId fd708ec9-e309-45ea-9cb8-f47992350c7b | fl *  
  
KeyId                         : 925795c2-4772-48d8-b0f0-0d79c8a7e5c7  
IsRolloverEnabled             : True  
ActiveKey                     : {EA067E8E-7A43-4C06-BF5A-385A9270BCB4}  
CryptoAlgorithm               : RsaSha256  
CurrentRolloverStatus         : ZskWaitingForDnsKeyTtl  
CurrentState                  : Active  
DnsKeySignatureValidityPeriod : 7.00:00:00  
DSSignatureValidityPeriod     : 7.00:00:00  
InitialRolloverOffset         : 00:00:00  
KeyLength                     : 1024  
KeyStorageProvider            : Microsoft Software Key Storage Provider  
KeyType                       : ZoneSigningKey  
LastRolloverTime              :  
NextKey                       : {8B36FED4-93A3-4E7F-B894-54B9EDAC4493}  
NextRolloverAction            : Normal  
NextRolloverTime              : 1/29/2014 3:00:48 PM  
RolloverPeriod                : 90.00:00:00  
RolloverType                  : PrePublish  
StandbyKey                    : {5F7AE18D-BDC3-4BAC-9784-4D6B1AAC45F6}  
StoreKeysInAD                 : True  
ZoneName                      : secure.contoso.com  
ZoneSignatureValidityPeriod   : 10.00:00:00  
PSComputerName                :  
CimClass                      : root/Microsoft/Windows/DNS:DnsServerSigningKey  
CimInstanceProperties         : {ActiveKey, CryptoAlgorithm, CurrentRolloverStatus, CurrentState...}  
CimSystemProperties           : Microsoft.Management.Infrastructure.CimSystemProperties  
  
```  
  
In the previous example, the value of **CurrentRolloverStatus** is **ZskWaitingForDnsKeyTtl**.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
