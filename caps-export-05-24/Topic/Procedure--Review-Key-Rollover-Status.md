---
title: Procedure: Review Key Rollover Status
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4dffc3e-12ed-405d-85ed-cb641d8e0897
---
# Procedure: Review Key Rollover Status
Use the following procedures to display and review rollover status of signing keys using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
You can use DNS Manager or Windows PowerShell to review rollover status:  
  
-   [Review key rollover status in DNS Manager](../Topic/Procedure--Review-Key-Rollover-Status.md#windows_ui)  
  
-   [Review key rollover status in Windows PowerShell](../Topic/Procedure--Review-Key-Rollover-Status.md#PS)  
  
## <a name="windows_ui"></a>Review key rollover status in DNS Manager  
You can use DNS Manager to review basic key rollover status. However, Windows PowerShell provides additional settings for review.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To review key rollover status in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Properties**.  
  
3.  To review KSK status, click the **KSK** tab, click a signing key under **Key signing keys \(KSKs\)**, and then review information under **Rollover status**.  
  
4.  To review ZSK settings, click the **ZSK** tab, click a signing key under **Zone signing keys \(ZSKs\)**, and then review information under **Rollover status**.  
  
5.  Click **Cancel** when you have finished.  
  
## <a name="PS"></a>Review key rollover status in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone that you want to review.  
  
#### To review key rollover status in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To review signing key status, use the **Get\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | fl *  
  
    KeyId                         : 0316fff3-03a8-451d-a4ad-db2f93e4070a  
    IsRolloverEnabled             : True  
    ActiveKey                     : {8F7CB3C7-A9A1-496A-96E6-D6D845D2F0F1}  
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
    NextRolloverTime              : 2/10/2016 2:27:53 PM  
    RolloverPeriod                : 755.00:00:00  
    RolloverType                  : DoubleSignature  
    StandbyKey                    : {1F4FBEBD-D66F-485C-9076-187DD40B1993}  
    StoreKeysInAD                 : True  
    ZoneName                      : secure.contoso.com  
    ZoneSignatureValidityPeriod   : 10.00:00:00  
    PSComputerName                :  
    CimClass                      : root/Microsoft/Windows/DNS:DnsServerSigningKey  
    CimInstanceProperties         : {ActiveKey, CryptoAlgorithm, CurrentRolloverStatus, CurrentState...}  
    CimSystemProperties           : Microsoft.Management.Infrastructure.CimSystemProperties  
  
    KeyId                         : 60b46b4d-e1cb-433a-ac33-5d46687e860e  
    IsRolloverEnabled             : True  
    ActiveKey                     : {93BA0FC4-3931-4DBF-A205-F4EFB24C4E4E}  
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
    NextKey                       : {D1FDEAF4-F9AB-4D59-AF5A-A33856B2B0EE}  
    NextRolloverAction            : Normal  
    NextRolloverTime              : 4/16/2014 3:27:53 PM  
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
  
    In the previous example, the **Format\-List** \(fl\) parameter is used to display extended signing key status information.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
