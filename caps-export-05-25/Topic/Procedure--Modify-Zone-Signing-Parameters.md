---
title: Procedure: Modify Zone Signing Parameters
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5224a735-dd77-4deb-990f-b27381b25e62
author: vhorne
---
# Procedure: Modify Zone Signing Parameters
Use the following procedures to review and modify DNSSEC parameter values and settings using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
> [!NOTE]  
> You can modify DNSSEC settings using DNS Manager on any primary, authoritative DNS server. However, settings are loaded from the Key Master and any changes are subsequently made on the Key Master. If the Key Master is not available, settings cannot be modified. When modifying settings using Windows PowerShell, you must either specify the Key Master using the ComputerName parameter, or run Windows PowerShell on the Key Master.  
  
You can use DNS Manager or Windows PowerShell to modify DNSSEC parameters and settings:  
  
-   [Modify DNSSEC parameters and settings in DNS Manager](../Topic/Procedure--Modify-Zone-Signing-Parameters.md#windows_ui)  
  
-   [Modify DNSSEC parameters and settings in Windows PowerShell](../Topic/Procedure--Modify-Zone-Signing-Parameters.md#PS)  
  
## <a name="windows_ui"></a>Modify DNSSEC parameters and settings in DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To modify DNSSEC parameters and settings in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Properties**.  
  
3.  You can modify some, but not all settings on the following tabs: **Key Master**, **Next Secure \(NSEC\)**, **Trust Anchor**, and **Advanced**.  
  
4.  To review and edit KSK settings, click the **KSK** tab, click a signing key under **Key signing keys \(KSKs\)**, and then click **Edit** to review or change KSK settings.  
  
5.  To review and edit ZSK settings, click the **ZSK** tab, click a signing key under **Zone signing keys \(ZSKs\)**, and then click **Edit** to review or change ZSK settings.  
  
6.  Click **OK** when you have finished.  
  
## <a name="PS"></a>Modify DNSSEC parameters and settings in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone that you wish to review.  
  
#### To modify DNSSEC parameters and settings in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on the Key Master or another primary authoritative DNS server. If the local server is not the Key Master, you must add the **ComputerName** parameter to specify the Key Master.  
  
2.  To modify signed zone settings, use the **Set\-DnsServerDnsSecZoneSetting** cmdlet. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com -DnsKeyRecordSetTTL 02:00:00  
    ```  
  
    Use the **Get\-DnsServerDnsSecZoneSetting** cmdlet to verify settings. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | select DnsKeyRecordSetTTL  
  
    DnsKeyRecordSetTTL  
    ------------------  
    02:00:00  
    ```  
  
3.  To modify signing keys, use the **Set\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerSigningKey -ZoneName secure.contoso.com -KeyId 925795c2-4772-48d8-b0f0-0d79c8a7e5c7 -ZoneSignatureValidityPeriod 8.00:00:00  
    ```  
  
    Use the **Get\-DnsServerSigningKey** cmdlet to verify settings. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | fl  
  
    ZoneName                      : secure.contoso.com  
    KeyId                         : 96e2236a-4a4e-4409-afe7-c3aa8ffc254e  
    KeyType                       : KeySigningKey  
    CryptoAlgorithm               : RsaSha256  
    KeyLength                     : 2048  
    KeyStorageProvider            : Microsoft Software Key Storage Provider  
    StoreKeysInAD                 : True  
    CurrentState                  : Active  
    IsRolloverEnabled             : True  
    RolloverType                  : DoubleSignature  
    RolloverPeriod                : 755.00:00:00  
    InitialRolloverOffset         : 00:00:00  
    CurrentRolloverStatus         : NotRolling  
    NextRolloverAction            : Normal  
    LastRolloverTime              :  
    NextRolloverTime              : 2/10/2016 5:09:37 PM  
    DnsKeySignatureValidityPeriod : 7.00:00:00  
    DSSignatureValidityPeriod     : 7.00:00:00  
    ZoneSignatureValidityPeriod   : 10.00:00:00  
    ActiveKey                     : {5A004FCE-55FE-41A2-84BA-90D0F8BF7CE2}  
    StandbyKey                    : {85F701CF-08B2-484F-8954-B737876B0A62}  
    NextKey                       :  
  
    ZoneName                      : secure.contoso.com  
    KeyId                         : 925795c2-4772-48d8-b0f0-0d79c8a7e5c7  
    KeyType                       : ZoneSigningKey  
    CryptoAlgorithm               : RsaSha256  
    KeyLength                     : 1024  
    KeyStorageProvider            : Microsoft Software Key Storage Provider  
    StoreKeysInAD                 : True  
    CurrentState                  : Active  
    IsRolloverEnabled             : True  
    RolloverType                  : PrePublish  
    RolloverPeriod                : 90.00:00:00  
    InitialRolloverOffset         : 00:00:00  
    CurrentRolloverStatus         : NotRolling  
    NextRolloverAction            : Normal  
    LastRolloverTime              :  
    NextRolloverTime              : 4/16/2014 6:09:37 PM  
    DnsKeySignatureValidityPeriod : 7.00:00:00  
    DSSignatureValidityPeriod     : 7.00:00:00  
    ZoneSignatureValidityPeriod   : 8.00:00:00  
    ActiveKey                     : {80FB1558-BA2A-4374-A99B-534828FACBB6}  
    StandbyKey                    :  
    NextKey                       : {08A68540-47EB-4F89-AF57-9ABC2B9A3A3A}  
    ```  
  
Some settings cannot be modified when the zone is currently signed or after signing keys have been provisioned. For example, you cannot change the key storage provider for an existing signing key. To change this parameter, you must add a new signing key. For a list of parameters that can be modified, view the syntax for the **Set\-DnsServerDnsSecZoneSetting** and **Set\-DnsServerSigningKey** cmdlets \(for example: Get\-Command Set\-DnsServerDnsSecZoneSetting \-Syntax\).  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
