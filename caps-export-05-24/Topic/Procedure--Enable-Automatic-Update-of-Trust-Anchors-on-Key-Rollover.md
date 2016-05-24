---
title: Procedure: Enable Automatic Update of Trust Anchors on Key Rollover
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d5492ac-898a-4bc6-befe-ea5e1e4f160b
---
# Procedure: Enable Automatic Update of Trust Anchors on Key Rollover
Use the following procedures to enable automatic update of trust anchors on key rollover using the DNS Manager console or Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
The following procedures enable automatic trust anchor updates for a zone that is already signed with DNSSEC.  
  
If the zone is not signed and you want to enable automatic trust anchor updates when the zone is signed, see [Procedure: Customize Zone Signing Parameters](../Topic/Procedure--Customize-Zone-Signing-Parameters.md) or [Procedure: Use Default Settings to Sign the Zone](../Topic/Procedure--Use-Default-Settings-to-Sign-the-Zone.md). This setting is enabled by default.  
  
> [!IMPORTANT]  
> If it is enabled, automatic update of trust anchors only occurs during an automatic key rollover. Trust anchors are not updated if you perform a manual key rollover.  
  
Choose to use DNS Manager or Windows PowerShell:  
  
-   [Enable automatic update of trust anchors on key rollover using DNS Manager](../Topic/Procedure--Enable-Automatic-Update-of-Trust-Anchors-on-Key-Rollover.md#windows_ui)  
  
-   [Enable automatic update of trust anchors on key rollover using Windows PowerShell](../Topic/Procedure--Enable-Automatic-Update-of-Trust-Anchors-on-Key-Rollover.md#PS)  
  
## <a name="windows_ui"></a>Enable automatic update of trust anchors on key rollover using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To enable automatic update of trust anchors on key rollover using DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  In the console tree, right\-click the zone where you plan to enable automatic update of trust anchors, point to **DNSSEC**, and then click **Properties**.  
  
3.  Click the **KSK** tab.  
  
4.  For each KSK that is listed under **Key signing keys \(KSKs\)**, click the KSK, click **Edit**, and in the **Key Rollover** section, select the **Enable automatic rollover** check box.  
  
5.  Edit the **Rollover frequency** if desired, and then click **OK**.  
  
6.  Click the **ZSK** tab.  
  
7.  For each ZSK that is listed under **Zone signing keys \(ZSKs\)**, click the ZSK, click **Edit**, and in the **Key Rollover** section, select the **Enable automatic rollover** check box.  
  
8.  Edit the **Rollover frequency** if desired, and then click **OK**.  
  
9. Click **OK** to close the DNSSEC properties dialog box.  
  
10. In the pop\-up window that appears, click **Yes** to confirm the changes that were made to the zone.  
  
11. Verify that **Configuration of DNSSEC parameters was successful** is displayed, and then click **OK**.  
  
## <a name="PS"></a>Enable automatic update of trust anchors on key rollover using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the example Windows PowerShell examples that are provided, replace the server and zone names with the names of the servers and zones that are used in your environment.  
  
#### To enable automatic update of trust anchors on key rollover using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  You can use the **Get\-DnsServerSigningKey** cmdlet to retrieve the **KeyId** values for signing keys in the zone, and then use the **Enable\-DnsServerSigningKeyRollover** cmdlet to enable key rollover for all signing keys. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | Enable-DnsServerSigningKeyRollover -Force  
    ```  
  
    In the previous example, the **Force** parameter is used to skip confirmation.  
  
3.  If you wish to enable rollover for some signing keys and not others, you must specify the individual **KeyId** of each signing key. See the following examples.  
  
    ```  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    5f7d05be-1bb6-4a0c-b923-f9be300bf6ea   KeySigningKey   RsaSha1NSec3       2048       True            False  
    a2a72d54-f9d7-4b4b-a115-a4097092f5bf   ZoneSigningKey  RsaSha1NSec3       1024       True            False  
  
    PS C:\> Enable-DnsServerSigningKeyRollover -ZoneName secure.contoso.com -KeyId 5f7d05be-1bb6-4a0c-b923-f9be300bf6ea -Force  
  
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com  
  
    KeyId                                  KeyType         CryptoAlgorithm    KeyLength  StoreKeysInAD   IsRolloverEnabled  
    -----                                  -------         ---------------    ---------  -------------   -----------------  
    5f7d05be-1bb6-4a0c-b923-f9be300bf6ea   KeySigningKey   RsaSha1NSec3       2048       True            True  
    a2a72d54-f9d7-4b4b-a115-a4097092f5bf   ZoneSigningKey  RsaSha1NSec3       1024       True            False  
    ```  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
