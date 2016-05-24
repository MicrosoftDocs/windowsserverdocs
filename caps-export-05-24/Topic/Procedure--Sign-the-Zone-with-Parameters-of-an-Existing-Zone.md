---
title: Procedure: Sign the Zone with Parameters of an Existing Zone
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1be3c242-f21c-4e45-af07-5d58231c8aca
---
# Procedure: Sign the Zone with Parameters of an Existing Zone
Use the following procedures to sign a DNS zone using an existing set of DNSSEC parameter values. Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Also see [DNS Zones](../Topic/DNS-Zones.md) for additional information about zone signing and DNSSEC parameter values.  
  
Choose DNS Manager or Windows PowerShell to sign a zone with existing parameter values:  
  
-   [Sign a zone with existing zone signing parameters in DNS Manager](../Topic/Procedure--Sign-the-Zone-with-Parameters-of-an-Existing-Zone.md#windows_ui)  
  
-   [Sign a zone with existing zone signing parameters in Windows PowerShell](../Topic/Procedure--Sign-the-Zone-with-Parameters-of-an-Existing-Zone.md#PS)  
  
## <a name="windows_ui"></a>Sign a zone with existing zone signing parameters in DNS Manager  
The **Zone Signing Wizard** is used to sign a zone in DNS Manager. For examples of the wizard, see [Zone Signing Wizard](../Topic/DNS-Zones.md#zsw).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To sign a zone with existing zone signing parameters in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  Right\-click an unsigned zone, point to **DNSSEC**, and then click **Sign the Zone**.  
  
3.  Click **Next**, on the **Signing Options** page choose **Customize zone signing parameters**, and then click **Next**.  
  
4.  On the **Key Master** page, choose **The DNS server <local server name> is the Key Master** if you wish to make the local server the Key Master. If you wish to make a different server the Key Master, choose **Select another primary server as the Key Master**, and then select a DNS server from the list of available DNS servers.  
  
5.  Click **Yes** on the alert that is displayed to wait for the local server to build a list of DNS servers that are capable of being the Key Master for this zone. Alternatively, you can type the fully qualified domain name of a DNS server and click **Next**. If you enter the name of a Key Master manually, you must click **Yes** when prompted to validate the Key Master.  
  
    > [!IMPORTANT]  
    > To choose a different DNS server as the Key Master, the local server must be able to contact other primary, authoritative DNS servers that are capable of DNSSEC online signing. The currently signed\-in user must also have administrative privileges on these DNS servers. If no other DNS servers can be selected as the Key Master, you must choose the local server as the Key Master. The Key Master can be changed after zone signing, if desired.  
  
6.  Click **Next** to view the first **Key Signing Key \(KSK\)** page. Review information on this page and then click **Next**.  
  
7.  On the second **Key Signing Key \(KSK\)** page, click **Add** to begin configuring KSK parameters.  
  
    > [!NOTE]  
    > If the zone was previously signed and then unsigned, any KSKs that were used previously are listed and will be used again if they are not removed. You can **Add** new KSKs, **Edit** the existing KSKs, or **Remove** these KSKs.  
  
8.  Enter or select values for all KSK parameters available in the **New Key Signing Key \(KSK\)**page. Default parameter values are provided. The **Guid** parameter is generated automatically. Click **OK** when finished.  
  
    > [!NOTE]  
    > At least one KSK is required. You can add additional KSKs if desired. If you select **Enable automatic rollover**, then a standby KSK is automatically generated to support the double signature rollover method for KSKs. Do not add additional KSKs to support manual rollover. All signing keys that are added in this dialog box will be used during zone signing.  
  
    > [!IMPORTANT]  
    > To support automatic key rollover, an additional signing key is generated for each ZSK and KSK that is added to the zone. For automatic KSK rollover, only the Double Signature rollover method is supported. For automatic ZSK rollover, only the Pre\-publish rollover method is supported.  
  
9. Click **Next** to view the first **Zone Signing Key \(ZSK\)** page. Review information on this page and then click **Next**.  
  
10. On the second **Zone Signing Key \(ZSK\)** page, click **Add** to begin configuring KSK parameters.  
  
    > [!NOTE]  
    > If the zone was previously signed and then unsigned, any ZSKs that were used previously are listed and will be used again if they are not removed. You can **Add** new ZSKs, **Edit** the existing ZSKs, or **Remove** these ZSKs.  
  
11. Enter or select values for all ZSK parameters available in the **New Zone Signing Key \(ZSK\)** dialog box. Default parameter values are provided. The **Guid** parameter is generated automatically. Click **OK** when you have finished.  
  
    > [!NOTE]  
    > At least one ZSK is required. You can add additional ZSKs if desired. If you select **Enable automatic rollover**, then the next ZSK is automatically generated to support the pre\-publish rollover method for ZSKs. Do not add additional ZSKs to support manual rollover. All signing keys that are added on this page are used during zone signing.  
  
12. Click **Next** to view the **Next Secure \(NSEC\)** page. You can choose NSEC or NSEC3 on this page, and configure NSEC3 parameters.  
  
13. Click **Next** to view the **Trust Anchors \(TAs\)** page. You can enable distribution of trust anchors and automatic update of trust anchors on this page.  
  
    > [!TIP]  
    > Trust anchors are not required on DNS servers that are authoritative for the zone. You should only enable distribution of trust anchors in the Active Directory forest if other DNS servers running on domain controllers will provide non\-authoritative responses for the zone that require DNSSEC validation.  
  
14. Click **Next** to view the **Signing and Polling Parameters** page. You can configure values for DNSSEC signing and polling on this page.  
  
15. Click **Next** to view the summary page. You can review current choices for all DNSSEC parameter values on this page. Click **Back** to configure different parameter values, click **Cancel** to close the zone signing wizard without signing the zone, or click **Next** to begin signing the zone.  
  
16. Verify that **The zone has been successfully signed** is displayed, and then click **Finish**.  
  
## <a name="PS"></a>Sign a zone with existing zone signing parameters in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the zone you wish to sign with DNSSEC. Also replace the example computer names with names of the DNS servers you will use.  
  
#### To sign a zone with existing zone signing parameters in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
    > [!NOTE]  
    > If the local DNS server is not the Key Master, you must specify the Key Master using the **ComputerName** parameter.  
  
2.  To sign a zone with an existing parameter set, use the **Get\-DnsServerDnsSecZoneSetting** and **Set\-DnsServerDnsSecZoneSetting** cmdlets. If both the source and destination zones are file\-backed, you can also use the **SigningMetadata** and **IncludeKSKMetadata** parameters to export signing key information and immediately sign the zone. This procedure will not work if one or both of the zones are Active Directory\-integrated. See the following example for file\-backed zones:  
  
    ```  
    Get-DnsServerDnsSecZoneSetting -SigningMetadata -ZoneName ext.contoso.com -IncludeKSKMetadata | Set-DnsServerDnsSecZoneSetting -ZoneName fin.contoso.com  
    ```  
  
    In this example, the DNSSEC settings for the signed zone *ext.contoso.com* are used to sign the *fin.contoso.com* zone.  
  
    > [!IMPORTANT]  
    > After running this command, the *fin.contoso.com* zone will be signed.  
  
3.  If one or both zones are Active Directory\-integrated, you can use the **Get\-DnsServerDnsSecZoneSetting** cmdlet to export settings. In this case, additional steps are required to sign the zone.  
  
4.  First, you must set the Key Master role on an unsigned zone. This is only required if the zone has never been signed. See the following example  
  
    ```  
    PS C:\> Reset-DnsServerZoneKeyMasterRole -ZoneName secure.contoso.com -KeyMasterServer dc2.contoso.com -SeizeRole -Force  
    ```  
  
    In this example, the server *dc2.contoso.com* was assigned the Key Master role for the zone *secure.contoso.com*. The **SeizeRole** parameter was used because the zone did not previously have an assigned Key Master.  
  
5.  Next, export and import DNSSEC parameter values. See the following example  
  
    ```  
    Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Set-DnsServerDnsSecZoneSetting -ZoneName ad.contoso.com  
    ```  
  
    In this example, DNSSEC settings \(but not signing keys\) are exported from the *secure.contoso.com* zone and imported to the *ad.contoso.com* zone. This step will not sign the zone.  
  
6.  To add signing key settings from an existing signed zone to an unsigned zone, use the **Get\-DnsServerSigningKey** and **Add\-DnsServerSigningKey** cmdlets. See the following example:  
  
    ```  
    Get-DnsServerSigningKey -ZoneName secure.contoso.com | Add-DnsServerSigningKey -ZoneName ad.contoso.com  
    ```  
  
    In this example, signing keys and all associated parameter values are exported from the signed zone: *secure.contoso.com*, and imported to the unsigned zone: *ad.contoso.com*.  
  
7.  Finally, sign the ad.contoso.com zone using the **Invoke\-DnsServerZoneSign** cmdlet. See the following example:  
  
    ```  
    Invoke-DnsServerZoneSign -ZoneName ad.contoso.com -Force  
    ```  
  
    In this example, the **Force** parameter is used to skip confirmation and immediately sign the zone.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
