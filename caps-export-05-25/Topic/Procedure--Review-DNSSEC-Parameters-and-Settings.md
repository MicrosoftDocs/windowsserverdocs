---
title: Procedure: Review DNSSEC Parameters and Settings
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c81528f4-b5ab-4f90-9d14-05cc2be933dc
author: vhorne
---
# Procedure: Review DNSSEC Parameters and Settings
Use the following procedures to display and review DNSSEC parameter values and settings using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
You can use DNS Manager or Windows PowerShell to review DNSSEC parameters and settings:  
  
-   [Review DNSSEC parameters and settings in DNS Manager](../Topic/Procedure--Review-DNSSEC-Parameters-and-Settings.md#windows_ui)  
  
-   [Review DNSSEC parameters and settings in Windows PowerShell](../Topic/Procedure--Review-DNSSEC-Parameters-and-Settings.md#PS)  
  
## <a name="windows_ui"></a>Review DNSSEC parameters and settings in DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To review DNSSEC parameters and settings in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Properties**.  
  
3.  Review settings on the following tabs: **Key Master**, **Next Secure \(NSEC\)**, **Trust Anchor**, and **Advanced**.  
  
4.  To review KSK settings, click the **KSK** tab, click a signing key under **Key signing keys \(KSKs\)**, and then review information under **Summary**. You can also click **Edit** to review KSK settings.  
  
5.  To review ZSK settings, click the **ZSK** tab, click a signing key under **Zone signing keys \(ZSKs\)**, and then review information under **Summary**. You can also click **Edit** to review ZSK settings.  
  
6.  Click **Cancel** when you have finished.  
  
## <a name="PS"></a>Review DNSSEC parameters and settings in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell examples that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone that you wish to review.  
  
#### To review DNSSEC parameters and settings in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To review a summary of zone settings, use the **Get\-DnsServerDnsSecZoneSetting** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com  
  
    ZoneName                      : secure.contoso.com  
    IsKeyMasterServer             : True  
    KeyMasterServer               : DC2.contoso.com  
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
  
3.  To review a summary of signing keys, use the **Get\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    1adabf48-5039-4e71-907c-99ff87f43564   KeySigningKey   RsaSha256          2048       True            True  
    08bf6bd0-b242-49d5-8674-eff9d338ea2f   ZoneSigningKey  RsaSha256          1024       True            True  
    ```  
  
4.  You can also review detailed information for signing keys using **Format\-List** \(fl\). See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | fl *  
  
    KeyId                         : 1adabf48-5039-4e71-907c-99ff87f43564  
    IsRolloverEnabled             : True  
    ActiveKey                     : {B4F136C0-4CF8-4CF9-BDBE-73AC28780767}  
    CryptoAlgorithm               : RsaSha256  
    CurrentRolloverStatus         : NotRolling  
    CurrentState                  : Active  
    DnsKeySignatureValidityPeriod : 7.00:00:00  
    DSSignatureValidityPeriod     : 7.00:00:00  
    InitialRolloverOffset         : 00:00:00  
    KeyLength                     : 2048  
    KeyStorageProvider            : Microsoft Software Key Storage Provider  
    KeyType                       : KeySigningKey  
    LastRolloverTime              :  
    NextKey                       :  
    NextRolloverAction            : Normal  
    NextRolloverTime              : 1/17/2016 3:56:40 PM  
    RolloverPeriod                : 755.00:00:00  
    RolloverType                  : DoubleSignature  
    StandbyKey                    : {4F39AD5A-7FB7-43EF-BCD3-F33494ABE523}  
    StoreKeysInAD                 : True  
    ZoneName                      : secure.contoso.com  
    ZoneSignatureValidityPeriod   : 10.00:00:00  
    PSComputerName                :  
    CimClass                      : root/Microsoft/Windows/DNS:DnsServerSigningKey  
    CimInstanceProperties         : {ActiveKey, CryptoAlgorithm, CurrentRolloverStatus, CurrentState...}  
    CimSystemProperties           : Microsoft.Management.Infrastructure.CimSystemProperties  
  
    KeyId                         : 08bf6bd0-b242-49d5-8674-eff9d338ea2f  
    IsRolloverEnabled             : True  
    ActiveKey                     : {B426354D-9209-4CFD-9049-6E503ADA14D0}  
    CryptoAlgorithm               : RsaSha256  
    CurrentRolloverStatus         : NotRolling  
    CurrentState                  : Active  
    DnsKeySignatureValidityPeriod : 7.00:00:00  
    DSSignatureValidityPeriod     : 7.00:00:00  
    InitialRolloverOffset         : 00:00:00  
    KeyLength                     : 1024  
    KeyStorageProvider            : Microsoft Software Key Storage Provider  
    KeyType                       : ZoneSigningKey  
    LastRolloverTime              :  
    NextKey                       : {8265DEA2-A0EB-45B4-B1E8-69F61777EB0E}  
    NextRolloverAction            : Normal  
    NextRolloverTime              : 3/23/2014 4:56:40 PM  
    RolloverPeriod                : 90.00:00:00  
    RolloverType                  : PrePublish  
    StandbyKey                    :  
    StoreKeysInAD                 : True  
    ZoneName                      : secure.contoso.com  
    ZoneSignatureValidityPeriod   : 10.00:00:00  
    PSComputerName                :  
    CimClass                      : root/Microsoft/Windows/DNS:DnsServerSigningKey  
    CimInstanceProperties         : {ActiveKey, CryptoAlgorithm, CurrentRolloverStatus, CurrentState...}  
    CimSystemProperties           : Microsoft.Management.Infrastructure.CimSystemProperties  
    ```  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
