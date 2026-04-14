---
title: Sign DNS Zones with DNSSEC on Windows Server
description: Protect DNS zones from tampering with DNSSEC signing. Learn to configure signing keys, set validity periods, and manage key rollover using DNS Manager and PowerShell commands.
#customer intent: As a DNS administrator, I want to sign my DNS zones with DNSSEC so that I can protect my zones from tampering and ensure data integrity.
author: orin-thomas
ms.author: roharwoo
ms.topic: how-to
ms.date: 08/01/2025
ai-usage: ai-assisted
ms.custom:
  - template-how-to, team=cloud_advocates
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/04/2025
  - ai-gen-description
---

# Sign DNS zones with DNSSEC

DNSSEC (Domain Name System Security Extensions) protects DNS zones from tampering and ensures data integrity by adding cryptographic signatures to DNS records. This article guides DNS administrators through the process of signing DNS zones with DNSSEC on Windows Server.

Signing a zone with DNSSEC adds several new DNSSEC related resource records. These new resource records can be sent in response to DNS queries for the zone along with the traditional, non-DNSSEC-related resource records. DNS servers must specifically request that DNSSEC records be included in DNS responses. Therefore, servers that don't support DNSSEC receives only traditional resource records in a DNS response.

A signed zone can be a forward or reverse lookup zone, a static, or dynamic zone, and can be Active Directory-integrated or file-backed. If the zone is Active Directory-integrated, private zone signing keys replicate automatically to all primary Key Master DNS servers through Active Directory replication. Each server that functions as Key Master signs its own copy of the zone when it receives the key. For optimal performance, and to prevent increasing the size of the Active Directory database file, the signed copy of the zone remains in memory for Active Directory-integrated zones. A DNSSEC signed zone is only committed to disk for file-backed zones.

## Signing parameters

Before you can sign a zone with DNSSEC, you must choose the DNSSEC parameter values that are used for signing. The parameters that you choose determine how the zone is signed and how DNSSEC operates for the zone.

Choosing to use default settings or parameters of an existing zone skip custom parameter pages. Some parameter values can also be modified after the zone is signed if desired.

The following options are available to specify the DNSSEC parameter values that are used for zone signing:

- Customize zone signing parameters (default option)

   If you choose this option, the wizard displays several pages that you can use to specific different parameter values, and provides you with default values for each parameter. These values can also be modified to any value within an acceptable range. If the zone was previously signed and then unsigned, the parameters that were most recently used are provided as the default values.

- Existing parameters

   To use this option, the DNS server must already be authoritative for one or more DNSSEC-signed zones. If you choose this option, you must provide the name of a signed zone to use as a template for signing the current zone. If the zone was previously signed, the parameters that were used to sign the zone are provided as the default values.

- Default parameters

   If you choose this option, the zone is signed with default parameters. These parameters appear by default when you choose to customize zone signing settings. If the zone was signed before with different settings, the most recent parameters are displayed instead. If you choose to sign the zone with default settings, the wizard skips to the summary page.

### Cryptographic algorithms and NSEC methods

If you're using custom parameters to sign a zone with DNSSEC, you must choose the cryptographic algorithms and next secure (NSEC) methods that are used for signing keys. The cryptographic algorithm determines how the keys are generated and used, while the NSEC method determines how authenticated denial of existence is provided in the signed zone.

Multiple cryptographic algorithms are available for use in either a KSK or ZSK. You can use different algorithms for Key Signing Keys (KSKs) and Zone Signing Keys (ZSKs). However, you can't sign a zone if one key uses the RSA/SHA-1 (NSEC3) algorithm while another key uses the RSA/SHA-1 algorithm. These two cryptographic algorithms are incompatible.

The following table shows cryptographic algorithms and compatible NSEC methods.

| Algorithm | Compatible NSEC methods |
|-----------|------------------------|
| ECDSAP256/SHA-256 | NSEC, NSEC3 |
| ECDSAP384/SHA-384 | NSEC, NSEC3 |
| RSA/SHA-1 | NSEC |
| RSA/SHA-1 (NSEC3) | NSEC3 |
| RSA/SHA-256 | NSEC, NSEC3 |
| RSA/SHA-512 | NSEC, NSEC3 |

> [!NOTE]
> You can't use NSEC for authenticated denial of existence if you chose RSA/SHA-1 (NSEC3) as a cryptographic algorithm in any KSK or ZSK. You also can't use NSEC3 if you're using RSA/SHA-1 with any signing key.

You must have at least one (1) KSK and one (1) ZSK. You can have up to three (3) KSKs and three (3) ZSKs that use the same cryptographic algorithm, and you have multiple cryptographic algorithms.

To support automatic key rollover, another signing key is generated for each ZSK and KSK that is added to the zone. For automatic KSK rollover, only the double signature rollover method is supported. For automatic ZSK rollover, only the prepublish rollover method is supported.

Typically, a zone is signed with a single ZSK and a single KSK. You might use more than one key to sign a zone under the following circumstances:

1. All DNS validators don't support a single cryptographic algorithm.
1. You're transitioning the DNS infrastructure to use new signing key properties.
1. You're merging DNS zones or network elements that use different signing key properties.

Each extra signing key and cryptographic algorithm that you add increases the time and computational cost of zone signing.

## Prerequisites

Before you can sign a zone with DNSSEC, you must meet the following prerequisites:

- You must have the DNS Server role installed and configured.
- You must have the DNS Server Remote Administration Tools installed on the computer that you use to sign the zone.
- The DNS server must be a primary, authoritative DNS server for the zone that you want to sign. DNSSEC-related resource records are transferred to secondary servers, but you can't sign, view, or edit the DNSSEC properties of a secondary zone.
- The DNS zone must be unsigned. If the zone is already signed, you must unsign it before you can sign it again.
- You must have administrative privileges on the DNS server to sign a zone. If the DNS server is Active Directory-integrated, you must also have Domain Admin credentials, or equivalent, to sign a zone.

## Signing a zone

On a DNS server running Windows Server, you can use DNS Manager or Windows PowerShell to sign a zone.

- DNS Manager. The zone signing wizard provides a step-by-step interface to input DNSSEC parameters and initiate zone signing. If the zone is already signed, you can also view or edit settings and re-sign a zone using the DNSSEC properties page. An unsign zone wizard is also provided to remove DNSSEC-signed records from a zone.

- Windows PowerShell. Many cmdlets are available to sign and unsign DNS zones, and to view or edit DNSSEC parameters.

Both methods for zone signing are compatible with each other. You can sign a zone with DNS Manager and view or edit settings with Windows PowerShell, and vice versa.

> [!TIP]
>
> - In the DNS Manager console tree, zones that are signed with DNSSEC are indicated with a lock icon.
>
> - The length of time that is required to sign a zone depends on the parameters that you specify and the size of the zone.

To begin signing a zone, select your preferred method:

### [DNS Manager](#tab/dns-manager)

To sign a DNS zone using DNS Manager, follow these steps:

1. Open DNS Manager on a primary, authoritative DNS server.

1. To start the **Zone Signing Wizard** in DNS Manager, right-click a forward or reverse DNS zone on a primary, authoritative DNS server, point to **DNSSEC**, and choose **Sign the Zone**.

1. In the Zone Signing Wizard welcome page, review the DNSSEC information and select **Next**.

1. Select one of the three signing options and select **Next**. The follow steps assume you choose the first option, **Customize zone signing parameters**.

   - Customize zone signing parameters (selected by default)
   - Sign the zone with a new set of zone signing parameters
   - Use default settings to sign the zone

1. To select the Key Master, verify that the current DNS server is selected as the Key Master. Alternatively, select **Select another primary server as the Key Master** and choose a different server from the dropdown. Select **Next**.

1. Review the KSK details on the Key Signing Key (KSK) information page, then select **Next**.

1. To create a Key Signing Key (KSK) select **Add**, complete the following information:

   | Parameter | Value |
   | --- | --- |
   | Key Generation | Select one of the following options: <br/><br/> - Generate new signing keys (default) <br/><br/> - Use pregenerated keys. <br/><br/> If using pregenerated keys, you must specify an available active and standby key using the GUID. Use the **Get-DnsServerSigningKey** cmdlet to view available keys. The GUID is also called the KeyId. |
   | Cryptographic algorithm | Select one of the following options: <br/><br/> - RSA/SHA-256 (default)<br/><br/> - ECDSAP256/SHA-256<br/><br/> - ECDSAP384/SHA-384<br/><br/> - RSA/SHA-1<br/><br/> - RSA/SHA-1 (NSEC3)<br/><br/> - RSA/SHA-512 |
   | Key length (bits) | Select one of the values from the dropdown menu. The default value is 2048 bits. <br/><br/> The key length must be in the range of 1024 - 4096 bits in increments of 64 bits. <br/><br/> For ECDSA keys, the key length is fixed at 256 bits or 384 bits. |
   | Key storage provider | Select one of the following options: <br/><br/> - Microsoft Software Key Storage Provider (default)<br/><br/> - Microsoft Passport Key Storage Provider<br/><br/> - Microsoft Platform Crypto Provider<br/><br/> - Microsoft Smart Card Key Storage Provider<br/><br/> If you intend to distribute the keys using Active Directory Domain Services, you must choose **Microsoft Software Key Storage Provider**. |
   | DNSKEY RRSET signature validity period (hours) | Select one of the following options: <br/><br/> - 168 hours (default)<br/><br/> - 6 - 720 hours<br/><br/> |
   | Replicate this private key to all DNS servers authoritative for this zone | Check the box to enable this option (default). This option is enabled by default. If you disable this option, the private key is only stored on the Key Master. |
   | Enable Key Rollover | Check the box to enable automatic rollover (default). <br/><br/> Enter the desired values - Rollover frequency (days): 755 days (default)<br/><br/> - Delay the first rollover by (days): 0 days (default)<br/><br/> |

   > [!TIP]
   >
   > - A minimum of one KSK is required. Up to three KSKs can be added for each of the available cryptographic algorithms.
   >
   > - If the zone has been signed and then unsigned, the KSKs and settings that were used to previously sign the zone are automatically provided again.

   After you enter the KSK parameters, select **OK** to add the KSK to the zone. Then select **Next** to continue.

1. On the Zone Signing Key (ZSK) information page, review the ZSK details and select **Next**.

1. To create a Zone Signing Key (ZSK), select **Add**, complete the following information:

   | Parameter | Value |
   | --- | --- |
   | Cryptographic algorithm | Select one of the following options: <br/><br/> - RSA/SHA-256 (default)<br/><br/> - ECDSAP256/SHA-256<br/><br/> - ECDSAP384/SHA-384<br/><br/> - RSA/SHA-1<br/><br/> - RSA/SHA-1 (NSEC3)<br/><br/> - RSA/SHA-512 |
   | Key length (bits) | Select one of the values from the dropdown menu. The default value is 1024 bits. <br/><br/> The key length must be in the range of 1024 - 4096 bits in increments of 64 bits. <br/><br/> For ECDSA keys, the key length is fixed at 256 bits or 384 bits. |
   | Key storage provider | Select one of the following options: <br/><br/> - Microsoft Software Key Storage Provider (default)<br/><br/> - Microsoft Passport Key Storage Provider<br/><br/> - Microsoft Platform Crypto Provider<br/><br/> - Microsoft Smart Card Key Storage Provider<br/><br/> If you intend to distribute the keys using Active Directory Domain Services, you must choose **Microsoft Software Key Storage Provider**. |
   | DNSKEY signature validity period (hours) | Select one of the following options: <br/><br/> - 168 hours (default)<br/><br/> - 6 - 720 hours<br/><br/> |
   | DS signature validity period (hours) | Select one of the following options: <br/><br/> - 168 hours (default)<br/><br/> - 6 - 720 hours<br/><br/> |
   | Zone record validity period (hours) | Select one of the following options: <br/><br/> - 240 hours (default)<br/><br/> - 6 - 720 hours<br/><br/> |
   | Enable Key Rollover | Check the box to enable automatic rollover. Rollover is enabled by default. <br/><br/> Enter the desired values <br/><br/>- Rollover frequency (days): 6 - 1825 days, 90 days is the default<br/><br/> - Delay the first rollover by (days): 0 - 30 days, 0 days is the default<br/><br/> |

   > [!TIP]
   >
   > - A minimum of one ZSK is required. Up to three ZSKs can be added for each of the available cryptographic algorithms.
   >
   > - If the zone has been signed and then unsigned, the KSKs and settings that were used to previously sign the zone are automatically provided again.

   After you enter the ZSK parameters, select **OK** to add the ZSK to the zone. Then select **Next** to continue.

1. If you need to add a new ZSK, configure the key properties in the New Zone Signing Key (ZSK) dialog and select **OK**.

1. On the Next Secure (NSEC) page, select either Use NSEC3 (recommended) or Use NSEC, configure the iterations and salt length if using NSEC3, then select **Next**.

1. On the Trust Anchors (TAs) page, optionally select **Enable the distribution of trust anchors for this zone** and **Enable automatic update of trust anchors on key rollover**, then select **Next**.

1. On the Signing and Polling Parameters page, complete the following information:

   | Parameter | Value |
   | --- | --- |
   | DS record generation algorithm | Select one of the following options: <br/><br/> - All <br/><br/> - None <br/><br/> - SHA-1 <br/><br/> - SHA-1 and SHA-256 <br/><br/> (default) <br/><br/> - SHA-1 and SHA-384 <br/><br/> - SHA-256 <br/><br/> - SHA-256 and SHA-384 <br/><br/> - SHA-384 |
   | DS record TTL (seconds) | Enter a value between 0 and 604800 seconds. The default is 3,600 seconds. |
   | DNSKEY record TTL (seconds) | Enter a value between 0 and 604800 seconds. The default is 3,600 seconds. |
   | Secure delegation polling period (hours) | Enter a value between 1 and 168 hours. The default is 12 hours. |
   | Signature inception (hours) | Enter a value between 0 and 168 hours. The default is 1 hour. |

    After you enter the signing and polling parameters, select **Next** to continue.

1. To sign the zone, review the summary page that displays all of the DNSSEC parameters. If you need to make changes, select **Back** to return to the appropriate page and modify the settings. If everything looks correct, select **Next**.

1. On the final page, when the zone is successfully signed, select **Finish** to close the wizard.

### [Windows PowerShell](#tab/windows-powershell)

To sign a DNS zone using Windows PowerShell, you can use the [Invoke-DnsServerZoneSign](/powershell/module/dnsserver/invoke-dnsserverzonesign) cmdlet.

To sign a zone, follow these steps:

1. Open Windows PowerShell with administrative privileges on a primary, authoritative DNS server.

1. To create a signed zone, you first need to sign the zone using the default parameters. Use the following command, replacing `<ZoneName>` with the name of your zone and `<ComputerName>` with the name of your DNS server:

   ```powershell
   Invoke-DnsServerZoneSign -ZoneName <ZoneName> -ComputerName <ComputerName> -SignWithDefault -PassThru -Verbose -Force
   ```

   The `-SignWithDefault` parameter uses the default DNSSEC parameters to sign the zone. The `-PassThru` parameter returns the signed zone object, and the `-Verbose` parameter provides detailed output during the signing process. The `-Force` parameter suppresses confirmation prompts.

   After running this command, the zone will be signed with DNSSEC.

1. To change the DNSSEC parameters for the signed zone, you can use the [Set-DnsServerDnsSecZoneSetting](/powershell/module/dnsserver/set-dnsserverdnsseczonesetting) cmdlet. For example, to change the NSEC3 salt length and iterations, you can run the following command:

   ```powershell
   Set-DnsServerDnsSecZoneSetting -ZoneName <ZoneName> -NSec3RandomSaltLength 8 -NSec3Iterations 50 -Verbose
   ```

   This command modifies the NSEC3 salt length to 8 octets and the iterations to 50 for the specified zone.

1. To view the DNSSEC settings for the signed zone, you can use the [Get-DnsServerDnsSecZoneSetting](/powershell/module/dnsserver/get-dnsserverdnsseczonesetting) cmdlet:

   ```powershell
   Get-DnsServerDnsSecZoneSetting -ZoneName <ZoneName>
   ```

   This command retrieves the DNSSEC settings for the specified zone on the specified DNS server.

> [!IMPORTANT]
> Some DNSSEC settings can't be modified when a zone is signed. Changing these settings requires that the zone is first unsigned, and then signed again. To learn more about changing DNSSEC settings, see the [Modifying DNSSEC properties](#modifying-dnssec-properties) section.

---

## Unsign zone wizard

To remove DNSSEC from a signed zone, you can use the **Unsign zone** wizard in DNS Manager or using PowerShell. The unsign zone wizard removes all DNSSEC-related resource records from the zone, including the DNSKEY, DS, and RRSIG records. After a zone is unsigned, it can be modified or deleted like any other unsigned zone.

To unsign a zone, select your preferred method:

### [DNS Manager](#tab/dns-manager)

To unsign a zone using DNS Manager, follow these steps:

1. Open DNS Manager on a primary, authoritative DNS server.

1. In the DNS Manager console tree, right-click the signed zone that you want to unsign, point to **DNSSEC**, and then choose **Unsign the Zone**.

The zone is immediately unsigned, and all DNSSEC-related resource records are removed from the zone. You can unsign a zone on any primary, authoritative DNS server that hosts a signed version of the zone; it doesn't have to be the Key Master.

### [Windows PowerShell](#tab/windows-powershell)

To unsign a DNS zone using Windows PowerShell, you can use the [Invoke-DnsServerZoneUnSign](/powershell/module/dnsserver/invoke-dnsserverzoneunsign) cmdlet.

To unsign a zone, follow these steps:

1. Open Windows PowerShell with administrative privileges on a primary, authoritative DNS server.

1. To unsign a zone, use the following command, replacing `<ZoneName>` with the name of your zone and `<ComputerName>` with the name of your DNS server:

   ```powershell
   Invoke-DnsServerZoneUnSign -ZoneName <ZoneName> -PassThru -Verbose -Force
   ```

   The `-PassThru` parameter returns the unsigned zone object, and the `-Verbose` parameter provides detailed output during the unsigning process. The `-Force` parameter suppresses confirmation prompts.

   After running this command, the zone will be unsigned, and all DNSSEC-related resource records will be removed.

---

When you unsign a zone, the parameters that were used for zone signing are saved so that you can use them again. To re-sign a zone using the same parameters that were used previously, choose **Customize zone signing parameters** and use the values that are provided for each parameter. The KSK and ZSKs that were used to sign the zone previously, along with values for all custom DNSSEC parameters are automatically populated in the **Zone Signing Wizard**. If you don't wish to use the same parameters, you also have the option of changing them.

If you're using Windows PowerShell, you can reuse the same parameters by specifying the **DoResign** parameter with the **Invoke-DnsServerZoneSign** cmdlet. To use the default parameters, you can specify the **SignWithDefault** parameter.

## Modifying DNSSEC properties

After a zone is signed, certain DNSSEC properties can be modified. For example, keys can be added after the zone is signed. If you add a new signing key, the zone is immediately signed again with this key and any other keys that are still present in the zone. Active signing keys can't be deleted, but you can retire a signing key if it isn't the last KSK or ZSK in the zone.

Some properties can be changed without unsigning and re-signing the zone. However, those settings aren't used immediately. For example, changes to KSK settings don't take effect until the next KSK rollover. This behavior includes signature and polling settings on the **Advanced** tab of the DNSSEC properties page. Similarly, changes to ZSK settings don't take effect until the next ZSK rollover.

Certain DNSSEC settings can't be modified when a zone is signed. Changing these settings requires that the zone is first unsigned, and then signed again. In this scenario, any trust anchors that have been distributed to resolving DNS servers must be manually updated.

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
