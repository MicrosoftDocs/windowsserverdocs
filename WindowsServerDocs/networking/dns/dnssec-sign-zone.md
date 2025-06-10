---
title: DNSSEC Signing DNS Zones
description: Learn how to sign DNS zones in a DNSSEC deployment
author: orin-thomas
ms.author: orthomas
ms.topic: conceptual
ms.date: 04/20/2025
ms.custom: template-how-to, team=cloud_advocates #Required; leave this attribute/value as-is.
# Customer intent: As a DNS administrator, I want to understand how to sign DNS zones in a DNSSEC deployment.
---

# DNSSEC Signing DNS Zones

Signing a zone with DNSSEC adds several new DNSSEC related resource records. These new resource records can be sent in response to DNS queries for the zone along with the traditional, non-DNSSEC-related resource records. DNS servers must specifically request that DNSSEC records be included in DNS responses. Therefore, servers that don't support DNSSEC receives only traditional resource records in a DNS response.

A signed zone can be a forward or reverse lookup zone, a static, or dynamic zone, and can be Active Directory-integrated or file-backed. If the zone is Active Directory-integrated, private zone signing keys replicate automatically to all primary Key Master DNS servers through Active Directory replication. Each server that functions as Key Master signs its own copy of the zone when it receives the key. For optimal performance, and to prevent increasing the size of the Active Directory database file, the signed copy of the zone remains in memory for Active Directory-integrated zones. A DNSSEC signed zone is only committed to disk for file-backed zones.

In an Active Directory multi-master configuration, zone settings, including DNSSEC parameters, can be modified on any primary authoritative DNS server provided that the Key Master is online. You can't perform zone signing and unsigning or modify DNSSEC parameters of a zone on a secondary DNS server.

## Signing a zone

On a DNS server running Windows Server, you can use DNS Manager or Windows PowerShell to sign a zone. These methods are summarized below.

- DNS Manager. The zone signing wizard provides a step-by-step interface to input DNSSEC parameters and initiate zone signing. If the zone is already signed, you can also view or edit settings and re-sign a zone using the DNSSEC properties page. An unsign zone wizard is also provided to remove DNSSEC-signed records from a zone.

- Windows PowerShell. Many cmdlets are available to sign and unsign DNS zones, and to view or edit DNSSEC parameters.

Both methods for zone signing are compatible with each other. You can sign a zone with DNS Manager and view or edit settings with Windows PowerShell, and vice versa.

After selecting a zone signing method, you must also define the DNSSEC Parameter values to use. Three options are available to specify DNSSEC parameter values:

- Custom parameters. - You can provide custom values for each parameter.
- Existing parameters. - You can use values that were used previously.
- Default parameters. You can use a default parameter value set.

 For more information about specifying DNSSEC parameter values using the zone signing wizard in DNS Manager, see [Signing options](#signing-options) in this article.

> [!TIP]
> In the DNS Manager console tree, zones that are signed with DNSSEC are indicated with a lock icon.

## DNS Manager

DNS Manager in Windows Server provides a [Zone Signing Wizard](#zone-signing-wizard) and [Unsign zone wizard](#unsign-zone-wizard) to greatly simplify the process of applying or removing DNSSEC from a zone. After a zone has been signed, you can also view and edit several properties and values using the [DNSSEC properties page](#dnssec-properties-page).

## Zone Signing Wizard

To start the **Zone Signing Wizard** in DNS Manager, right-click a forward or reverse DNS zone on a primary, authoritative DNS server, point to **DNSSEC**, and choose **Sign the Zone**.

> [!IMPORTANT]
> You can't sign or unsign a zone, or view DNSSEC properties of a zone on a secondary DNS server. The server must be a primary, authoritative DNS server. DNSSEC-related resource records are transferred to secondary servers, but you can't view or edit the DNSSEC properties of a secondary zone.

After you choose **Sign the Zone**, the wizard displays an introductory page with a summary of DNSSEC. Choose **Next** to view the **Signing Options** page.

## Signing options

The **Signing Options** page requires you to choose a method for specifying DNSSEC parameter values. The method that you choose on this page determines which pages the zone signing wizard displays. Choosing to use default settings or parameters of an existing zone skip custom parameter pages. Some parameter values can also be modified after the zone is signed if desired.

The following options are available to specify the DNSSEC parameter values that will be used for zone signing:

- **Customize zone signing parameters**. This is the default option. If you choose this option, the wizard displays several pages that you can use to specific different parameter values, and provides you with default values for each parameter. These values can also be modified to any value within an acceptable range. If the zone was previously signed and then unsigned, the parameters that were most recently used are provided as the default values. For more information about this option, see [Custom parameters](#custom-parameters).
- **Sign the zone with parameters of an existing zone**. To use this option, the DNS server must already be authoritative for one or more DNSSEC-signed zones. If you choose this option, you must provide the name of a signed zone to use as a template for signing the current zone.
- **Use default settings to sign the zone**. If you choose this option, the zone is signed with default parameters. These parameters are the same as those that are displayed by default if you choose to customize zone signing parameters, provided the zone hasn't been previously signed with a different set of parameters. If you choose to sign the zone with default settings, the wizard skips to the summary page. For more information about this option, see [Default parameters](#default-parameters).

For a list of the default parameter values that are used in the wizard and the allowed range of custom parameter values, see [Parameter values](#parameter-values).

The length of time that is required to sign a zone depends on the parameters that you specify and the size of the zone.

## Custom parameters

The following table lists pages that are displayed in the zone signing wizard when you choose to customize zone signing parameters. Choose the link in the "More information" column for an explanation and example of each page.

| Action | Description |
|--------|-------------|
| Select the Key Master | Only one server can be the Key Master at a given time. By default, the Key Master is the local server, but a different DNS server can be selected if it meets requirements. |
| Add signing keys | You must choose at least one zone signing key (ZSK) and one key signing key (KSK). |
| Specify KSK parameter values | For each KSK that is added to a zone, you must specify individual parameter values. |
| Specify ZSK parameter values | For each ZSK that is added to a zone, you must specify individual parameter values. |
| Specify Next Secure (NSEC) values | You can choose **Use NSEC** or **Use NSEC3** to provide authenticated denial of existence. |
| Choose trust anchor distribution options | Select how trust anchors will be distributed and if automatic updates are enabled. |
| Specify signing and polling parameters | Specify DS and DNSKEY parameters. |
| Summary | Before zone signing starts, you're provided with a summary of all DNSSEC parameter values that will be used to sign the zone. Choosing **Next** on this page will initiate zone signing. |

## Choose the Key Master

In Windows Server DNS, signing a zone requires that you designate one DNS server as the Key Master. You can change the Key Master, but only one DNS server can be the Key Master at a given time. The Key Master is the DNS server where zone signing occurs, and it's responsible for DNSSEC-related cryptographic processes, such as signing key creation and management. The Key Master must be a primary authoritative DNS server for the zone.

The following options are available when selecting the Key Master:

- The DNS server **local computer** is the Key Master.
- Select another primary server as the Key Master.

By default, the local server is selected as the Key Master. You also have the option of choosing a different DNS server from a list of online, primary, authoritative DNS servers that support online DNSSEC signing.

> [!TIP]
> The signed-in user must have administrative privileges on a DNS server in order for it to be displayed in the allowed list of server that can function as a Key Master.

Only one DNS server can be the Key Master for a given zone at a given time.

## Signing keys

The zone signing wizard displays the following six pages that provide information and enable you to add signing keys to the zone:

1. **Key signing key (KSK)**: *A KSK is an authentication key that is used to sign other keys*.

    This introductory page provides a short description of a KSK and a link to more information. Choose **Next** on this page to add or edit KSKs.

1. **Key signing key (KSK)**: *Configure one or more KSKs*.

    This page lists the current KSKs. Choose **Add**, **Edit**, or **Remove** to modify KSKs, and then choose **Next** when you have finished.

1. **New/Edit Key Signing Key (KSK)**

    Use this page to edit individual KSK parameter values.

1. **Zone signing key (ZSK)**: *A ZSK is an authentication key used to sign the zone data*.

    This page provides a short description of a ZSK and a link to more information. Choose **Next** on this page to add or edit ZSKs.

1. **Zone Signing Key (ZSK)**: *Configure one or more ZSKs*.

    This page lists the current ZSKs. Choose **Add**, **Edit**, or **Remove** to modify ZSKs, and then choose **Next** when you have finished.

1. **New/Edit Zone Signing Key (ZSK)**

    Use this page to edit individual ZSK parameter values.

For more information, including examples of these pages, see the [KSK configuration](#ksk-configuration) and [ZSK configuration](#zsk-configuration) articles in this section.

To sign a zone with DNSSEC, you must configure at least one KSK and one ZSK. Multiple keys are also supported: up to three (3) for each cryptographic algorithm. A list of available [Cryptographic algorithms](#cryptographic-algorithms) is provided later in this article.

Typically, a zone is signed with a single ZSK and a single KSK. You might use more than one key to sign a zone under the following circumstances:

1. All DNS validators don't support a single cryptographic algorithm.
1. You're transitioning the DNS infrastructure to use new signing key properties.
1. You're merging DNS zones or network elements that use different signing key properties.

Each additional signing key and cryptographic algorithm that you add increases the time and computational cost of zone signing.

> [!IMPORTANT]
> To support automatic key rollover, an additional signing key is generated for each ZSK and KSK that is added to the zone. For automatic KSK rollover, only the double signature rollover method is supported. For automatic ZSK rollover, only the pre-publish rollover method is supported.

## Cryptographic algorithms

The following cryptographic algorithms are available for use in either a KSK or ZSK. You don't have to use the same algorithm for both types of signing keys, but you can't use RSA/SHA-1 and RSA-SHA-1 (NSEC3) together. The following table shows cryptographic algorithms and compatible NSEC methods.

| Algorithm | Compatible NSEC methods |
|-----------|------------------------|
| ECDSAP256/SHA-256 | NSEC, NSEC3 |
| ECDSAP384/SHA-384 | NSEC, NSEC3 |
| RSA/SHA-1 | NSEC |
| RSA/SHA-1 (NSEC3) | NSEC3 |
| RSA/SHA-256 | NSEC, NSEC3 |
| RSA/SHA-512 | NSEC, NSEC3 |

You must have at least one (1) KSK and one (1) ZSK. You can have up to three (3) KSKs and three (3) ZSKs that use the same cryptographic algorithm, and you have multiple cryptographic algorithms.

## KSK configuration

The key signing key (KSK) is an authentication key that signs all of the DNSKEY records at the root of the zone, and it's part of the chain of trust.

When you generate a new KSK, the Key Master can create an active and a standby key. Properties for the KSK include the following:

- **Cryptographic algorithm**: By default, the RSA/SHA-1 (NSEC3) algorithm is chosen. To sign a zone with NSEC3, you can't choose the RSA/SHA-1 algorithm. RSA/SHA-1 (NSEC3) and RSA/SHA-1 are two different available algorithms.
- **Key length**: By default, this is 2048 bits for keys that use the RSA/SHA-1 (NSEC3) algorithm. Typically, for greater security, the KSK has a longer key length than a ZSK. The KSK key length affects the time that is required for zone signing less than the ZSK key length.
- **Key storage provider**: If keys will be distributed using Active Directory Domain Services, you must choose **Microsoft Software Key Storage Provider**.
- **DNSKEY RRSET signature validity period**: By default, this is set to 72 hours. Signatures that are generated using the KSK might have a longer validity period than signatures that are generated by the ZSK to provide a more stable secure entry point into the zone.
- **Key Rollover**: You can enable automatic rollover and specify the rollover frequency. We highly recommend  automatic key rollover. You can also delay the first rollover by a specified number of days.

For more information, see [Parameter values](#parameter-values).

If the zone hasn't been previously signed, the KSK configuration page requires that you add at least one KSK.

> [!NOTE]
> If the zone has been signed and then unsigned, the KSKs and settings that were used to previously sign the zone are automatically provided again. You have the option to use the same keys and settings as before, to edit parameter values for these keys, or to remove these keys, and add new keys.

To create a Key Signing Key, in the Zone Signing Wizard on the Key Signing Key page:

1. Choose **Add** to display the **New Key Signing Key (KSK)** page.
1. Choose **OK** to accept default parameter values for the KSK, or enter new parameter values, and then choose **OK**. Information about KSK parameters is provided in the following section.
1. Add additional KSKs if desired, and then choose **Next** to continue.

## ZSK configuration

If the zone hasn't been previously signed, the ZSK configuration page requires that you add at least one ZSK.

To create a new Zone Signing Key, on the Zone Singing Key page of the Zone Signing Wizard:

1. Choose **Add**.
1. Choose **OK** to accept default parameter values for the ZSK, or enter new parameter values, and then choose **OK**.
1. Add additional ZSKs if desired, and then choose **Next** to continue.

> [!NOTE]
> If the zone has been signed and then unsigned, the ZSKs and settings that were used to previously sign the zone are automatically provided again. You have the option to use the same keys and settings as before, to edit parameter values for these keys, or to remove these keys and add new keys.

## ZSK parameters

The zone signing key (ZSK) is used to sign zone data. A ZSK is typically rolled over more frequently than a KSK. Properties for the ZSK include the following:

- **Cryptographic algorithm**: By default, the RSA/SHA-1 (NSEC3) algorithm is selected. To sign a zone with NSEC3, you can't select the RSA/SHA-1 algorithm. RSA/SHA-1 (NSEC3) and RSA/SHA-1 are two different available algorithms. The algorithm that you specify can affect the time that is required for zone signing.
- **Key length**: By default, this is 1024 bits for keys that use the RSA/SHA-1 (NSEC3) algorithm. Typically, the ZSK has a shorter key length than a KSK. The ZSK key length can affect the time that is required for zone signing.
- **Key storage provider**: If keys will be distributed by using Active Directory Domain Services, you must select **Microsoft Software Key Storage Provider**.
- **DNSKEY signature validity period**: By default, it's set to 72 hours.
- **DS signature validity period**: By default, it's set to 72 hours.
- **Zone record validity period**: By default, it's set to 240 hours.
- **Key Rollover**: You can enable automatic rollover and specify the rollover frequency. We highly recommend automatic key rollover. You can also delay the first rollover by a specified number of days.

For more information, see [Parameter values](#parameter-values).

Additional elements of the zone signing process include:

- **NSEC**. You should choose **NSEC3** on the **Next Secure (NSEC)** page of the Zone Signing Wizard unless you have a good reason to use NSEC, such as a requirement to use the RSA/SHA-1 algorithm, or some other incompatibility with NSEC3.
- **Trust anchors**. On the **Trust Anchors (TAs)** page, you can configure distribution and update settings for trust anchors (TAs).
- **Signing and polling**. On the **Signing and Polling Parameters** page, you can configure values for DS and DNSKEY records in the zone.
- **Existing parameters**. If you choose **Sign the zone with parameters of an existing zone**, you must provide the name of another zone hosted by the local DNS server that is signed with DNSSEC.

## Default parameters

Choose **Use default settings to sign the zone** and choose **Next** to designate the local DNS server as the Key Master and to skip to the **Summary** page. Choose **Next** on the summary page to initiate zone signing. Default settings that are used to sign a zone are provided in the table later in this article.

## Parameter values

The following table lists default and allowed DNSSEC parameter values that are used in the zone signing wizard.

| Action | Default | Allowed |
|--------|---------|---------|
| Key Master | The local DNS server is the Key Master. | Any DNS server found in Active Directory that is primary and authoritative for the zone can be the Key Master.<br><br>The signed-in user must have Domain Admin credentials, or equivalent, to designate the Key Master. |
| KSK | One KSK | A minimum of one KSK is required. Up to three KSKs can be added for each of the available cryptographic algorithms. |
| KSK: GUID | By default, all zeros are displayed. These values are a placeholder. The key's GUID is generated automatically during zone signing. | No values are allowed in this field. You can't manually input a GUID. The key GUID is also called the KeyId. |
| KSK: Key Generation | Generate new signing keys | Use pregenerated keys: If this option is chosen, you must specify an available active and standby key. Use the **Get-DnsServerSigningKey** cmdlet to view available keys. |
| KSK: Key Properties* | Cryptographic algorithm: RSA/SHA-256<br>Key length (bits): 2048<br>Select a key storage provider to generate and store keys: Microsoft Software Key Storage Provider<br>DNSKEY RRSET signature validity period (hours): 168<br>Replicate this private key to all DNS servers authoritative for this zone: Enabled | Cryptographic algorithm: ECDSAP256/SHA-256, ECDSAP256/SHA-384, RSA/SHA-1, RSA/SHA-1 (NSEC3), RSA/SHA-256, RSA/SHA-512.<br><br>Key length (bits): 1024 – 4096 in increments of 64<br><br>Select a key storage provider to generate and store keys: Microsoft Software Key Storage Provider, Microsoft Platform Crypto Provider, Microsoft Smart Card Key Storage Provider<br><br>DNSKEY RRSET signature validity period (hours): 6 - 720<br><br>Replicate this private key to all DNS servers that are authoritative for this zone: Enabled or disabled |
| KSK: Key Rollover | Enable automatic rollover: Enabled<br>Rollover frequency (days): 755<br>Delay the first rollover by (days): 0 | Enable automatic rollover: Enabled or disabled<br>Rollover frequency (days): 7 - 7300<br>Delay the first rollover by (days): 0 - 30 |
| ZSK | One ZSK | A minimum of one ZSK is required. Up to three ZSKs can be added for each of the available cryptographic algorithms. |
| ZSK: GUID | By default, all zeros are displayed. These values are a placeholder. The key's GUID is generated automatically during zone signing. | No values are allowed in this field. You can't manually input a GUID. The key GUID is also called the KeyId. |
| ZSK: Key Properties* | Cryptographic algorithm: RSA/SHA-256<br>Key length (bits): 1024<br>Select a key storage provider to generate and store keys: Microsoft Software Key Storage Provider<br>DNSKEY signature validity period (hours): 168<br>DS signature validity period (hours): 168<br>Zone record validity period (hours): 240 | Cryptographic algorithm: ECDSAP256/SHA-256, ECDSAP256/SHA-384, RSA/SHA-1, RSA/SHA-1 (NSEC3), RSA/SHA-256, RSA/SHA-512.<br><br>Key length (bits): 1024 – 4096 in increments of 64<br><br>Select a key storage provider to generate and store keys: Microsoft Software Key Storage Provider, Microsoft Platform Crypto Provider, Microsoft Smart Card Key Storage Provider<br><br>DNSKEY signature validity period (hours): 6 - 720<br>DS signature validity period (hours): 6 - 720<br>Zone record validity period (hours): 6 - 720 |
| ZSK: Key Rollover | Enable automatic rollover: Enabled<br>Rollover frequency (days): 90<br>Delay the first rollover by (days): 0 | Enable automatic rollover: Enabled or disabled<br>Rollover frequency (days): 7 - 1825<br>Delay the first rollover by (days): 0 - 30 |
| Next Secure (NSEC)** | Choose NSEC or NSEC3 for authenticated denial of existence: Use NSEC3 | Choose NSEC or NSEC3 for authenticated denial of existence: Use NSEC3, Use NSEC |
| Next Secure (NSEC): NSEC3 options | Iterations: 50<br>Generate and use a random salt of length: 8<br>Use opt-out to cover unsigned delegations: Disabled | Iterations: For key length values of 256-1024, 1088-2048, and 2112-4096, iterations must be in the range of 0-150, 0-500, and 0-2500, respectively<br><br>Generate and use a random salt of length: 1 - 255<br><br>Use opt-out to cover unsigned delegations: Enabled or disabled |
| Trust Anchors | Enable the distribution of trust anchors for this zone: Disabled<br>Enable automatic update of trust anchors on key rollover (RFC 5011): Enabled | Enable the distribution of trust anchors for this zone: Enabled or disabled<br>Enable automatic update of trust anchors on key rollover (RFC 5011): Enabled or disabled |
| Signing and polling parameters | DS record generation algorithm: SHA-1 and SHA-256<br>DS record TTL (seconds): 3600<br>DNSKEY record TTL (seconds): 3600<br>Secure delegation polling period (hours): 12<br>Signature inception (hours): 1 | DS record generation algorithm: All, None, SHA-1, SHA-1 and SHA-256, SHA-1 and SHA-384, SHA-256, SHA-256 and SHA-384, SHA-384<br><br>DS record TTL (seconds): 0 - 604800<br>DNSKEY record TTL (seconds): 0 - 604800<br>Secure delegation polling period (hours): 1 - 168<br>Signature inception (hours): 0 - 168 |

Note the following:

- You can't sign a zone with a key that uses the RSA/SHA-1 (NSEC3) algorithm if another signing key uses the RSA/SHA-1 algorithm. These two cryptographic algorithms are incompatible.
- You can't use NSEC for authenticated denial of existence if you have chosen RSA/SHA-1 (NSEC3) as a cryptographic algorithm in any KSK or ZSK. You also can't use NSEC3 if you're using RSA/SHA-1 with any signing key.

## Unsign zone wizard

DNS Manager also provides a wizard to unsign a DNS zone. To use DNS Manager to unsign a zone that was previously signed on a Windows Server DNS server:

1. Right-click the zone in the DNS Manager console tree, point to **DNSSEC**, and then choose **Unsign the Zone** to display the **Unsign zone** wizard.
1. To unsign the zone, choose **Next**. The zone is immediately unsigned. You can unsign a zone on any primary, authoritative DNS server.

After unsigning a zone using the wizard, you can't choose **Back** to re-sign the zone. Similarly, you can't unsign a zone by choosing **Back** after you have finished the zone signing process.

However, when you unsign a zone, the parameters that were used for zone signing are saved so that you can use them again. To re-sign a zone using the same parameters that were used previously, choose **Customize zone signing parameters** and accept the default values that are provided for each parameter. The KSK and ZSKs that were used to sign the zone previously, along with values for all custom DNSSEC parameters are automatically populated in the **Zone Signing Wizard**. If you're using Windows PowerShell, you can reuse the same parameters by specifying the **DoResign** parameter with the **Invoke-DnsServerZoneSign** cmdlet.

If you don't wish to use the same parameters, you also have the option of changing them. Re-signing the zone again replaces this default parameter set with the current one.

## DNSSEC properties page

To view the DNSSEC properties of a signed zone in DNS Manager, right-click the signed zone in the DNS Manager console tree, point to **DNSSEC**, and then choose **Properties**.

> [!TIP]
> To view DNSSEC properties, you must view the zone on a primary, authoritative DNS server. You can't view the DNSSEC properties page on a secondary, authoritative DNS server. The DNS server doesn't have to be the Key Master.

Choose the **Key Master**, **KSK**, **ZSK**, **Next Secure (NSEC)**, **Trust Anchor**, or **Advanced** tab to see information about the zone.

> [!TIP]
> The DNSSEC node in DNS Manager introduces a second properties page for each DNS zone. You can right-click a zone, and then choose **Properties**, or right-click a zone, point to **DNSSEC**, and then choose **Properties**. If you don't see the DNSSEC properties page, verify that you chose **DNSSEC** first.

You can modify DNSSEC parameters on the properties page. For example, you can choose the **ZSK** tab, choose a ZSK in the list, choose **Edit**, and modify one or more of the parameters.

If you edit DNSSEC parameters, the zone is re-signed using these new parameters when you choose **OK** in the DNSSEC properties page, and you're provided with zone signing status.

If you don't wish to commit the changes that you made to DNSSEC parameters, choose **No**, and parameters won't be changed. Choosing **Yes** will re-sign the zone with new parameters.

## Modifying DNSSEC properties

After a zone is signed, certain DNSSEC properties can be modified. For example, keys can be added after the zone is signed. If you add a new signing key, the zone is immediately signed again with this key and any other keys that are still present in the zone. Active signing keys can't be deleted, but you can retire a signing key provided that it isn't the last KSK or ZSK in the zone.

Some properties can be changed without unsigning and re-signing the zone. However, settings won't be used immediately. For example, changes to KSK settings won't take effect until the next KSK rollover. This behavior includes signature and polling settings on the **Advanced** tab of the DNSSEC properties page. Similarly, changes to ZSK settings don't take effect until the next ZSK rollover.

Certain DNSSEC settings can't be modified when a zone is signed. Changing these settings requires that the zone first be unsigned, and then signed again. In this scenario, any trust anchors that have been distributed to resolving DNS servers must be manually updated.

## Windows PowerShell

You can use PowerShell to manage DNSSEC on Windows Server.

## Sign a zone

You can use the [Invoke-DnsServerZoneSign](/powershell/module/dnsserver/invoke-dnsserverzonesign) cmdlet to sign a DNS zone, as shown in the following example.

```powershell
    PS C:\> Invoke-DnsServerZoneSign -ZoneName secure.contoso.com -ComputerName DC1 -SignWithDefault -PassThru -Verbose -Force
    VERBOSE: This will reset the DNSSEC settings for the zone to defaults and sign it.
    The following parameters will be configured:
    One KeySigningKey with:
     CryptoAlgorithm: RsaSha256
     Key Length: 2048
     Rollover Period: 755.00:00:00
    One ZoneSigningKey with:
     CryptoAlgorithm: RsaSha256
     Key Length: 1024
     Rollover Period: 90.00:00:00
    Authenticated Denial of Existence: NSec3
    Random Salt Length: 8 octets
    NSec3 Hash Algorithm: RsaSha1
    NSec3 Iterations: 50
    NSec3 OptOut: No.

    ZoneName                            ZoneType        IsAutoCreated   IsDsIntegrated  IsReverseLookupZone  IsSigned
    --------                            --------        -------------   --------------  -------------------  --------
    secure.contoso.com                  Primary         False           True            False                True
```

In this example, the secure.contoso.com zone is signed using default parameters. The computer DC1 is specified as the Key Master because it's where zone signing occurs. If the **ComputerName** parameter isn't specified, signing is attempted using the local computer as the Key Master.

## Unsign a zone

You can use the [Invoke-DnsServerZoneUnSign](/powershell/module/dnsserver/invoke-dnsserverzoneunsign) cmdlet to sign a DNS zone, as shown in the following example.

```powershell

    PS C:\> Invoke-DnsServerZoneUnSign -ZoneName secure.contoso.com -ComputerName DC2 -PassThru -Verbose -Force
    VERBOSE: This will initiate unsigning of the zone secure.contoso.com on server DC2.

    ZoneName                            ZoneType        IsAutoCreated   IsDsIntegrated  IsReverseLookupZone  IsSigned
    --------                            --------        -------------   --------------  -------------------  --------
    secure.contoso.com                  Primary         False           True            False                False
```

In this example, the secure.contoso.com zone is unsigned from the computer DC2. You can unsign a zone from any primary, authoritative DNS server that hosts a signed version of the zone; it doesn't have to be The Key Master. If the **ComputerName** parameter isn't specified, unsigning will be attempted using the local computer.

## Review DNSSEC properties

You can use the [Get-DnsServerDnsSecZoneSetting](/powershell/module/dnsserver/get-dnsserverdnsseczonesetting) cmdlet to view settings for a signed zone, as shown in the following example.

```powershell
    PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com -ComputerName DC1


    ZoneName                      : secure.contoso.com
    IsKeyMasterServer             : True
    KeyMasterServer               : DC1.contoso.com
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

In this example, the secure.contoso.com zone is viewed on DC1. Because DC1 is the Key Master, the value of **IsKeyMasterServer** is **True**. If a different primary, authoritative DNS server is specified on the command line, this value will be **False** to indicate that DNSSEC information is being viewed on a server that isn't the Key Master. The server that you use to view settings can be important if zone settings have recently changed and aren't yet fully replicated to all primary DNS servers. You can't view DNSSEC properties of a signed zone on a secondary DNS server.

## Review the status of signing keys

A DNSSEC key management strategy includes planning for key generation, key storage, key expiration, and key replacement. Together, key expiration and replacement in DNSSEC is called key rollover. You can use the [Get-DnsServerSigningKey](/powershell/module/dnsserver/get-dnsserversigningkey) cmdlet to view the status of KSKs and ZSKs for a signed zone, as shown in the following example.

```powershell
    PS C:\> Get-DnsServerSigningKey -ZoneName secure.contoso.com | fl *

    KeyId                         : 7479d44e-70ff-48d3-8f64-95622692f647
    IsRolloverEnabled             : True
    ActiveKey                     : {68550441-8E4D-4D99-921C-BC1807FFF7ED}
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
    NextRolloverTime              : 12/3/2025 2:05:12 PM
    RolloverPeriod                : 755.00:00:00
    RolloverType                  : DoubleSignature
    StandbyKey                    : {287C4DF6-E3A4-40F0-B09A-F7287343F2A9}
    StoreKeysInAD                 : True
    ZoneName                      : secure.contoso.com
    ZoneSignatureValidityPeriod   : 10.00:00:00
    PSComputerName                :
    CimClass                      : root/Microsoft/Windows/DNS:DnsServerSigningKey
    CimInstanceProperties         : {ActiveKey, CryptoAlgorithm, CurrentRolloverStatus, CurrentState...}
    CimSystemProperties           : Microsoft.Management.Infrastructure.CimSystemProperties

    KeyId                         : 00be2f93-ae8b-4381-8165-74f9028210d6
    IsRolloverEnabled             : True
    ActiveKey                     : {38C23E3E-6A6C-4C40-A792-208962C8EF21}
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
    NextKey                       : {ABF62EF6-3F6D-43D5-A09B-CECEF22E99C8}
    NextRolloverAction            : Normal
    NextRolloverTime              : 2/6/2025 2:05:12 PM
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

> [!IMPORTANT]
> It's a best practice to monitor key rollovers and to ensure that they're successful. If a key rollover doesn't occur, an administrator must identify and correct the problem, and then initiate a manual key rollover. The DNS server doesn't attempt to repeat a signing key rollover attempt that has failed.

## Modify DNSSEC properties

You can use the [Set-DnsServerDnsSecZoneSetting](/powershell/module/dnsserver/set-dnsserverdnsseczonesetting) cmdlet to configure settings for a signed zone, as shown in the following example.

```powershell
    PS C:\> Set-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com -ComputerName DC1 -PropagationTime 1:00:00 -Verbose
    VERBOSE: Modifies the DNSSEC properties for the zone secure.contoso.com on server DC1.
    VERBOSE: PropagationTime successfully set on server DC1.
```

In this example, the propagation time for secure.contoso.com zone is modified on DC1. This change must be made on DC1 because it's the Key Master for the secure.contoso.com zone. You can't specify a non-Key Master DNS server on the command line to modify DNSSEC properties.

As previously stated, some DNSSEC settings can't be modified when a zone is signed. Changing these settings requires that the zone first be unsigned, and then signed again.

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
