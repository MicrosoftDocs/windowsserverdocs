---
title: Procedure: Replace Signing Keys
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f555f00b-4508-4688-8034-0200759aadc5
author: vhorne
---
# Procedure: Replace Signing Keys
Use the following procedures to replace one or more signing keys by using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
> [!IMPORTANT]  
> To remove a signing key immediately, the zone must be unsigned and then re\-signed. In an emergency, such as when signing keys have been compromised, do not attempt to retire a signing key and perform a manual key rollover. Signing key rollover includes a waiting period so that validity periods can expire. It you wish to replace a signing key through retirement, see [Procedure: Retire a Signing Key](../Topic/Procedure--Retire-a-Signing-Key.md).  
  
When you replace a signing key, the zone will immediately be re\-signed.  
  
You can use DNS Manager or Windows PowerShell to replace DNSSEC signing keys:  
  
-   [Replace a signing key using DNS Manager](../Topic/Procedure--Replace-Signing-Keys.md#windows_ui)  
  
-   [Replace a signing key using Windows PowerShell](../Topic/Procedure--Replace-Signing-Keys.md#PS)  
  
## <a name="windows_ui"></a>Replace a signing key using DNS Manager  
You can use DNS Manager to review some signing key settings. However, Windows PowerShell provides additional settings for review.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To replace a signing key using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click a DNSSEC\-signed zone, point to **DNSSEC**, and then click **Unsign the Zone**.  
  
3.  Click **Next**, and then click **Finish**.  
  
4.  Right\-click the zone, point to **DNSSEC**, and then click **Sign the Zone**.  
  
5.  Click **Next**, choose **Customize zone signing parameters**, and then click **Next** until you get to the **Key Signing Key \(KSK\)** or **Zone Signing Key \(ZSK\)** page where you wish to replace a signing key.  
  
6.  Click the signing key that you wish to replace, and then click **Remove**.  
  
7.  Click **Add**, provide parameter values for a replacement signing key, and then click **OK**.  
  
8.  Click **Next** and provide any additional parameter values as needed, and continue clicking **Next** until you reach the **DNS Security Extensions \(DNSSEC\)** page that indicates that you have successfully configured zone signing parameters.  
  
9. Click **Next**, verify that **The zone has been successfully signed** is displayed, and then click **Finish**.  
  
After replacing signing keys, all trust anchors that have been distributed must also be replaced.  
  
## <a name="PS"></a>Replace a signing key using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the DNSSEC\-signed zone that you wish to review.  
  
#### To replace a signing key using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  First, you must unsign the zone. To unsign a zone, use the **Invoke\-DnsServerZoneUnsign** cmdlet. See the following example.  
  
    ```  
    PS C:\> Invoke-DnsServerZoneUnsign -ZoneName secure.contoso.com -Force  
    ```  
  
    In this example, the zone *secure.contoso.com* is unsigned on the local DNS server. The **Force** parameter is used to skip confirmation.  
  
3.  Next, use the **Get\-DnsServerSigningKey** cmdlet to retrieve signing key IDs. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    488a4688-39bd-4d15-a2bb-56474d665e38   KeySigningKey   RsaSha256          2048       True            True  
    7d1f81e4-230e-4704-a88c-d4bc9c9b5ab9   ZoneSigningKey  RsaSha256          1024       True            True  
    ```  
  
    In the previous example, there is one ZSK and one KSK.  
  
4.  To replace a signing key, a new signing key must first be added. To add a signing key, use the **Add\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    Add-DnsServerSigningKey -ZoneName secure.contoso.com -Type KeySigningKey -CryptoAlgorithm RsaSha1NSec3 –KeyLength 3072  
    ```  
  
5.  In this example, the **CryptoAlgorithm** and **KeyLength** parameters are set to a custom value. Parameters that are not specified will use default values.  
  
6.  To add a custom ZSK, use the **Add\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    Add-DnsServerSigningKey -ZoneName secure.contoso.com -Type ZoneSigningKey -CryptoAlgorithm RsaSha1NSec3  
    ```  
  
    In this example, the **CryptoAlgorithm** parameter is set to a custom value. Parameters that are not specified will use default values.  
  
7.  When you have completed adding new signing keys, remove the signing key that will be replaced with the **Remove\-DnsServerSigningKey** cmdlet. See the following example.  
  
    ```  
    PS C:\> Remove-DnsServerSigningKey -ZoneName secure.contoso.com -KeyId 488a4688-39bd-4d15-a2bb-56474d665e38 -Force  
    ```  
  
    In this example, the **Force** parameter is used to skip confirmation.  
  
8.  When you have completed adding signing keys, sign the zone. To sign the zone, use the **Invoke\-DnsServerZoneSign** cmdlet. See the following example.  
  
    ```  
    Invoke-DnsServerZoneSign -ZoneName secure.contoso.com -Force  
    ```  
  
    In this example, the **Force** parameter is used to skip confirmation and to immediately sign the zone.  
  
After replacing signing keys, all trust anchors that have been distributed must also be replaced.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
