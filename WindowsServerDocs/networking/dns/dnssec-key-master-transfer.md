---
title: Transfer the DNSSEC Key Master Role in Windows DNS Server
description: Learn how to transfer the DNSSEC Key Master role in Windows DNS Server between authoritative servers, including online transfers and disaster recovery scenarios.
#customer intent: As a DNS administrator, I want to transfer the DNSSEC Key Master role to another authoritative server so that I can maintain DNS security when the current Key Master becomes unavailable.
author: orin-thomas
ms.author: roharwoo
ms.topic: how-to
ms.date: 07/07/2025
ms.custom:
  - template-how-to, team=cloud_advocates
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/04/2025
  - ai-gen-description
ai-usage: ai-assisted
---

# Transfer Key Master role

This article explains how to transfer the DNSSEC Key Master role between authoritative DNS servers in Windows DNS Server environments. Learn about online transfers (when the current Key Master is available) and disaster recovery scenarios (when the current Key Master is offline).

The DNSSEC Key Master role is critical for maintaining DNS security in your Windows DNS environment. The Key Master is the DNS server responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, DNSSEC selects the local server as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a given zone at a given time.

The Key Master generates all keys for the zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date. You can transfer the Key Master role to a different authoritative name server after zone signing. You can perform this transfer if current Key Master is online or as part of a disaster recovery scenario if the current Key Master is offline.

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

## Transfer an online Key Master

If the Key Master is online, you can perform a successful transfer the Key Master role to another DNS server. Another qualifying DNS server must be available on the network.

> [!NOTE]
> An unsigned zone can also be assigned a Key Master. All zones that are signed have a Key Master setting, whether they're currently signed or not. A zone that has never been signed usually doesn't have a Key Master. However, you can assign a Key Master in advance using Windows PowerShell to prepare for zone signing.

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

You can also perform this operation using Windows PowerShell with the **Reset-DnsServerZoneKeyMasterRole** cmdlet.

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

## Transfer an off-line Key Master (Seizing the Key Master role)

The server designated as the Key Master must remain online and highly available to ensure uninterrupted service for key signing operations. If the Key Master goes offline and you can't bring it back online easily, you can transfer the Key Master role to another DNS server. This process is called *seizing* the Key Master role. Don't seize the Key Master role and transfer it offline unless it's unavoidable, such as in a disaster recovery scenario.

You can seize the Key Master role using DNS Manager or Windows PowerShell. Select your preferred method.

### [DNS Manager](#tab/dns-manager)

To seize the Key Master role using DNS Manager

1. Open DNS Manager on a primary, authoritative DNS server or connect to a primary, authoritative DNS server from another location using DNS Manager.

1. In the console tree, right-click the zone for which you plan to move the Key Master role, point to **DNSSEC**, and then select **Properties**.

1. An alert is displayed indicating that DNSSEC settings for the zone couldn't be loaded from the Key Master, select **Yes**.

   :::image type="content" source="../media/dnssec-key-master-transfer/offline.png" alt-text="Screenshot of DNS Manager showing an alert dialog box that indicates DNSSEC settings for the zone couldn't be loaded from the Key Master.":::

   > [!CAUTION]
   > If you don't see an alert, verify that the Key Master is offline. If the Key Master is online, and you still wish to move the Key Master role, see the section [Transfer an online Key Master](#transfer-an-online-key-master). Don't seize the Key Master role.

1. On the **Key Master** tab, select **Use the following DNS server as the Key Master**.

1. Select the drop-down list, and then select **Yes** in the pop-up window that appears. The local DNS server creates a list of DNS servers that are capable of being the new Key Master for the zone.

1. Choose a DNS server from the list for the new Key Master, and select **OK**.

1. Select **Yes** in the dialog box that appears to move the Key Master role to the DNS server that was chosen. If you select **No**, the operation is canceled and the Key Master remains unchanged.

1. If you see a dialog box warning that the Key Master can't be contacted to transfer private key material, the current DNS server doesn't have access to signing keys. To learn more about this scenario, see the section [Transfer without access to the signing keys](#transfer-without-access-to-the-signing-keys).

1. Confirm that **The Key Master for the zone `<zone name>` has been updated successfully** is displayed, and then select **OK**.

The procedure will immediately change the Key Master. You don't need to wait for Active Directory replication or re-sign the zone.

### [Windows PowerShell](#tab/windows-powershell)

To seize the Key Master role using Windows PowerShell

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

The Key Master must have access to private key material for a DNSSEC-signed zone. If the current Key Master is offline, other DNS servers might have access to private key material if it's stored in a shared location such as Active Directory. If private key material isn't stored in Active Directory, and the new Key Master can't access the private keys for a zone in any other way, you must take extra steps. First, you must generate new keys. Then, you need to re-sign the zone using these new keys. After re-signing the zone with new keys, all trust anchors will need updating because the exist ones will become invalid.

To avoid a situation where the Key Master is offline and you can't access private key material, it's recommended to store private key material in Active Directory. This way, if the Key Master goes offline, you can seize the Key Master role on another DNS server that has access to the private key material. When signing the zone, use the **Replicate this private key to all DNS servers authoritative for this zone** option in the Key Signing Key (KSK) settings. This option ensures that the private key material is replicated to all DNS servers that are authoritative for the zone, making it available for use by any of these servers.

If you don't want to store private key material in Active Directory, you can also provide access to private key material using a certificate or hardware storage module (HSM) device. To learn more about options for storing private key material, see [Signing keys](dnssec-key-master.md#signing-keys).

If private key material isn't stored in Active Directory or an external device, run the following command in PowerShell to store this material in a certificate on the local computer.

```powershell
New-SelfSignedCertificate `
  -DnsName "YourDNSName" `
  -CertStoreLocation "Cert:\LocalMachine\MS-DNSSEC" `
  -KeyExportPolicy Exportable
```

After you've seized the Key Master role, perform the following steps:

1. Resign the zone using the new keys. To learn more about resigning the zone, see [Sign DNS Zones with DNSSEC](dnssec-sign-zone.md).

1. If the zone has trust anchors, you must also replace them. To learn more about distributing trust anchors, see [Distribute Trust Anchors in Active Directory](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593678(v=ws.11)).

If the original Key Master becomes available before the zone is re-signed, you can transfer the Key Master role back to this server without the requirement to re-sign the zone and redistribute trust anchors.

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
