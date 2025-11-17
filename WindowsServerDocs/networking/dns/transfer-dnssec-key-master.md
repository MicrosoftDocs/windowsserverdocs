---
title: Transfer the DNSSEC Key Master Role in Windows DNS Server
description: Learn how to transfer the DNSSEC Key Master role in Windows DNS Server between authoritative servers, including online transfers and disaster recovery scenarios.
#customer intent: As a DNS administrator, I want to transfer the DNSSEC Key Master role to another authoritative server so that I can maintain DNS security when the current Key Master becomes unavailable.
author: orin-thomas
ms.author: roharwoo
ms.topic: how-to
ms.date: 08/01/2025
ms.custom:
  - template-how-to, team=cloud_advocates
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/04/2025
  - ai-gen-description
ai-usage: ai-assisted
---

# Transfer Key Master role

This article explains how to transfer the DNSSEC Key Master role between authoritative DNS servers in Windows DNS Server environments. The DNSSEC Key Master is the DNS server responsible for key generation and management for a DNSSEC-signed zone. For a complete understanding of the Key Master role, its requirements, and key management concepts, see [DNSSEC Key Master](dnssec-key-master.md).

You might want to transfer in the following scenarios:

- You want to change the Key Master to a different authoritative DNS server for load balancing or administrative purposes.
- You are performing maintenance on the current Key Master and need to temporarily transfer the role to another server.
- You are migrating to a new DNS server and want to transfer the Key Master role as part of the migration process.

If the current Key Master is offline and you need to maintain DNSSEC signing operations, you'll need to seize the Key Master role to ensure continuity of service.

## Prerequisites

In order to transfer the Key master role, your environment must meet the following requirements:

- Primary authoritative DNS servers must support zone signing.
- Primary and secondary authoritative DNS servers must support hosting of signed zones.
- Recursive or forwarding DNS servers must support DNSSEC validation of DNS responses.
- Another qualifying DNS server must be available on the network.
- You must have administrative privileges on the DNS server where you want to transfer the Key Master role.
- (Optional) You must have Domain Admins group rights or be a member of a group with equivalent permissions in order for it to appear on the list of available Key Masters.

> [!IMPORTANT]
> You can't transfer the Key Master role if a zone is file-based because these zones have only one primary, authoritative DNS server. In this scenario, it's recommended to take other security precautions to protect the Key Master from attack and to protect private key material from becoming compromised or lost. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed in order to limit its attack surface.

## Find the current Key Master

To find the current Key Master for a DNS zone, you can use DNS Manager or Windows PowerShell. Select your preferred method.

### [DNS Manager](#tab/dns-manager)

To find the Key Master using DNS Manager, follow these steps:

1. Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.

1. In the console tree, expand **Forward Lookup Zones** or **Reverse Lookup Zones**.

1. Right-click the zone for which you want to find the Key Master, expand **DNSSEC**, then select **Properties**.

1. The name of the Key Master displays in the **Key Master** field is displayed on the **Key Master** tab of the DNSSEC properties page.

### [Windows PowerShell](#tab/windows-powershell)

You can also find the Key Master using the [Get-DnsServerDnsSecZoneSetting](/powershell/module/dnsserver/get-dnsserverdnsseczonesetting) cmdlet in PowerShell. Run the following command, replacing `<NameOfZone>` with the name of your DNS zone:

```powershell
Get-DnsServerDnsSecZoneSetting -ZoneName <NameOfZone> | Select KeyMasterServer
```

The name of the Key Master displays in the DNS Manager when you select **Forward Lookup Zones** or **Reverse Lookup Zones**. It also displays on the **Key Master** tab of the DNSSEC properties page. You can also run the `Get-DnsServerDnsSecZoneSetting` cmdlet in PowerShell to view the Key Master. The following example shows how to find the Key Master for a zone named `secure.contoso.com`:

```powershell
Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer 
```

---

## Transfer the Key Master

When the Key Master is online, you can transfer the Key Master role to another DNS server. This process requires another qualifying DNS server to be available on the network.

An unsigned zone can also be assigned a Key Master. All zones that are signed have a Key Master setting, whether they're currently signed or not. A zone that has never been signed usually doesn't have a Key Master. However, you can assign a Key Master in advance using Windows PowerShell to prepare for zone signing.

You can transfer the Key Master role to another DNS server using DNS Manager or Windows PowerShell. Select your preferred method.

### [DNS Manager](#tab/dns-manager)

To move the Key Master role using DNS Manager, follow these steps:

1. Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.

1. In the console tree, right-click the zone for which you plan to move the Key Master role, point to **DNSSEC**, and then select **Properties**.

1. On the **Key Master** tab, select **Use the following DNS server as the Key Master**.

1. Select the drop-down list, and then select **Yes** in the pop-up window that appears. The local DNS server creates a list of DNS servers that are capable of being the new Key Master for the zone.

1. Choose a DNS server from the list for the new Key Master, and then select **OK**.

1. Select **Yes** in the dialog box that appears in order to move the Key Master role to the DNS server that was chosen. If you select **No**, the operation is canceled, and the Key Master  remains unchanged.

1. Confirm that **The Key Master for the zone `<zone name>` has been updated successfully** is displayed, and then select **OK**.

The procedure immediately changes the Key Master. You don't need to wait for Active Directory replication or re-sign the zone.

### [Windows PowerShell](#tab/windows-powershell)

You can also perform this operation using Windows PowerShell with the [Reset-DnsServerZoneKeyMasterRole](/powershell/module/dnsserver/reset-dnsserverzonekeymasterrole) cmdlet.

1. To reset the Key Master role, run the following command in PowerShell, replacing `<NameOfZone>` with the name of your DNS zone and `<ServerName>` with the name of the DNS server you want to set as the new Key Master. The cmdlet prompts the user for confirmation before it transfers the role unless you use the `-Force` switch.

   ```powershell
   Reset-DnsServerZoneKeyMasterRole -ZoneName <NameOfZone> -KeyMasterServer <ServerName> -force
   ```

1. To verify the Key Master role transferred successfully, run the following command in PowerShell, replacing `<NameOfZone>` with the name of your DNS zone.

   ```powershell
   Get-DnsServerDnsSecZoneSetting -ZoneName <NameOfZone> | Select KeyMasterServer
   ```

In this example, the **Get-DnsServerDnsSecZoneSetting** cmdlet is also used to verify that the Key Master role was transferred successfully.

The procedure immediately changes the Key Master. You don't need to wait for Active Directory replication or re-sign the zone.

---

## Seizing the Key Master role (offline transfer)

If the Key Master goes offline and you can't bring it back online easily, you can transfer the Key Master role to another DNS server. This process is called *seizing* the Key Master role. Don't seize the Key Master role and transfer it offline unless it's unavoidable, such as in a disaster recovery scenario.

You can seize the Key Master role using DNS Manager or Windows PowerShell. Select your preferred method.

### [DNS Manager](#tab/dns-manager)

To seize the Key Master role using DNS Manager

1. Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.

1. In the console tree, right-click the zone for which you plan to move the Key Master role, point to **DNSSEC**, and then select **Properties**.

1. An alert is displayed indicating that DNSSEC settings for the zone couldn't be loaded from the Key Master, select **Yes**.

   :::image type="content" source="../media/dnssec-key-master-transfer/offline.png" alt-text="Screenshot of DNS Manager showing an alert dialog box that indicates DNSSEC settings for the zone couldn't be loaded from the Key Master.":::

   > [!CAUTION]
   > If you don't see an alert, verify that the Key Master is offline. If the Key Master is online, and you still wish to move the Key Master role, see the section [Transfer an online Key Master](#transfer-the-key-master). Don't seize the Key Master role.

1. On the **Key Master** tab, select **Use the following DNS server as the Key Master**.

1. Select the drop-down list, and then select **Yes** in the pop-up window that appears. The local DNS server creates a list of DNS servers that are capable of being the new Key Master for the zone.

1. Choose a DNS server from the list for the new Key Master, and select **OK**.

1. Select **Yes** in the dialog box that appears to move the Key Master role to the DNS server that was chosen. If you select **No**, the operation is canceled and the Key Master remains unchanged.

1. If you see a dialog box warning that the Key Master can't be contacted to transfer private key material, the current DNS server doesn't have access to signing keys. To learn more about this scenario, see the section [Transfer without access to the signing keys](#transfer-without-access-to-the-signing-keys).

1. Confirm that **The Key Master for the zone `<zone name>` has been updated successfully** is displayed, and then select **OK**.

The procedure will immediately change the Key Master. You don't need to wait for Active Directory replication or re-sign the zone.

### [Windows PowerShell](#tab/windows-powershell)

To seize the Key Master role using the [Reset-DnsServerZoneKeyMasterRole](/powershell/module/dnsserver/reset-dnsserverzonekeymasterrole) cmdlet in PowerShell, follow these steps:

1. Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.

1. To seize the Key Master role, run the following command, replacing `<NameOfZone>` with the name of your DNS zone and `<ServerName>` with the name of the DNS server you want to set as the new Key Master. The `-SeizeRole` parameter is used to seize, rather than move, the Key Master role, and the `-Force` parameter is used to skip confirmation steps.

   ```powershell
   Reset-DnsServerZoneKeyMasterRole -ZoneName <NameOfZone> -KeyMasterServer <ServerName> –SeizeRole -Force
   ```

1. To verify that the Key Master role was successfully transferred, run the following command in PowerShell, replacing `<NameOfZone>` with the name of your DNS zone.

   ```powershell
   Get-DnsServerDnsSecZoneSetting -ZoneName <NameOfZone> | Select KeyMasterServer
   ```

The procedure will immediately change the Key Master. You don't need to wait for Active Directory replication or re-sign the zone.

---

### Transfer without access to the signing keys

If the current Key Master is offline and the new Key Master can't access the private keys, you must generate new keys and re-sign the zone. For detailed information about private key storage options, see [Signing keys](dnssec-key-master.md#signing-keys).

To avoid a situation where the Key Master is offline and you can't access private key material, it's recommended to store private key material in Active Directory. This way, if the Key Master goes offline, you can seize the Key Master role on another DNS server that has access to the private key material. When signing the zone, use the **Replicate this private key to all DNS servers authoritative for this zone** option in the Key Signing Key (KSK) settings. This option ensures that the private key material is replicated to all DNS servers that are authoritative for the zone, making it available for use by any of these servers.

If you don't want to store private key material in Active Directory, you can also provide access to private key material using a certificate or hardware storage module (HSM) device. To learn more about options for storing private key material, see [Signing keys](dnssec-key-master.md#signing-keys).

After you've seized the Key Master role, perform the following steps:

1. If private key material isn't stored in Active Directory or an external device, run the [New-SelfSignedCertificate](/powershell/module/pki/new-selfsignedcertificate) command in PowerShell to store this material in a certificate on the local computer.

   ```powershell
   New-SelfSignedCertificate `
     -DnsName "YourDNSName" `
     -CertStoreLocation "Cert:\LocalMachine\MS-DNSSEC" `
     -KeyExportPolicy Exportable
   ```

1. Re-sign the zone using the new keys. To learn more about re-signing the zone, see [Sign DNS Zones with DNSSEC](sign-dnssec-zone.md).

1. If the zone has trust anchors, you must also replace them. To learn more about distributing trust anchors, see [Distribute Trust Anchors in Active Directory](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593678(v=ws.11)).

If the original Key Master becomes available before the zone is re-signed, you can transfer the Key Master role back to this server without the requirement to re-sign the zone and redistribute trust anchors.

## Related content

- Learn more about the [DNSSEC Key Master](dnssec-key-master.md)
- [Overview of DNSSEC](dnssec-overview.md)
