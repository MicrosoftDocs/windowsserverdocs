---
title: DNSSEC Key Master Transfer
description: Learn how to transfer the DNSSEC Key master role in DNS Server and Windows Server
author: orin-thomas
ms.author: orthomas
ms.topic: conceptual
ms.date: 04/20/2025
ms.custom: template-how-to, team=cloud_advocates #Required; leave this attribute/value as-is.
# Customer intent: As a DNS administrator, I want to understand how to transfer the DNSSEC Key Master role.
---

# Transfer Key Master role

The DNSSEC Key Master is a component of a Windows DNSSEC deployment.

In Windows DNSSEC, the Key Master is the DNS server responsible for key generation and key management for a DNSSEC-signed zone. When you use default settings to sign a zone, DNSSEC selects the local server as Key Master. You also have the option of choosing a different DNS server from a list of servers that support online DNSSEC signing. Only one DNS server can be the Key Master for a given zone at a given time.

## Prerequisites

In order to transfer the Key master role, your environment must meet the following requirements:

- Primary authoritative DNS servers must support zone signing.
- Primary and secondary authoritative DNS servers must support hosting of signed zones.
- Recursive or forwarding DNS servers must support DNSSEC validation of DNS responses.
- Another qualifying DNS server must be available on the network.

You can transfer the Key Master role to a different authoritative name server after zone signing. You can perform this transfer if current Key Master is online or as part of a disaster recovery scenario if the current Key Master is offline.

You can't transfer the Key Master role if a zone is file-backed because these zones have only one primary, authoritative DNS server.

> [!IMPORTANT]
> If a zone is Active Directory-integrated, the Key Master is a domain controller and can benefit by enhanced security considerations that are used with domain controllers. If the zone is file-backed, the Key Master might not be also a domain controller. In this scenario, it's recommended to take additional security precautions to protect the Key Master from attack and to protect private key material from becoming compromised. For security reasons, a Key Master that isn't a domain controller should only have the DNS Server role installed in order to limit its attack surface.

The name of the Key Master is displayed in DNS Manager when you select **Forward Lookup Zones** or **Reverse Lookup Zones**, and is displayed on the **Key Master** tab of the DNSSEC properties page. You can also use the **Get-DnsServerDnsSecZoneSetting** Windows PowerShell cmdlet to view the Key Master. See the following example:

``` powershell
    PS C:\> Get-DnsServerDnsSecZoneSetting -ZoneName secure.contoso.com | Select KeyMasterServer

    KeyMasterServer
    ---------------
    DC1.contoso.com
```

The Key Master generates all keys for the zone, and is responsible for distribution of private keys and zone signing information. The Key Master is also responsible for performing all zone signing key (ZSK) and key signing key (KSK) rollovers and for polling child zones to keep signed delegations up-to-date.

> [!NOTE]
> An unsigned zone can also be assigned a Key Master. All zones that are signed have a Key Master setting, whether they're currently signed or not. A zone that has never been signed typically doesn't have a Key Master, but can be configured with a Key Master in preparation for zone signing with Windows PowerShell.

## Transfer an offline Key Master by seizing the Key Master role

If the Key Master is online, you can perform a successful transfer the Key Master role to another DNS server. Another qualifying DNS server must be available on the network.

To transfer the Key Master role using DNS Manager:

1. Open DNS Manager.
1. View the DNSSEC properties of the zone.
1. Select the **Key Master** tab, then select **Use the following DNS server as the Key Master**.
1. When you select the drop-down list, a pop-up alert asks if you want the local server to build a list of available, qualifying DNS servers that can be the Key Master. Select **OK**, choose a server from the list, and then select **OK**.

> [!IMPORTANT]
> The signed-in user must have Domain Admins group rights or be a member of a group with equivalent permissions on a DNS server in order for it to appear on the list.

You can also perform this operation using Windows PowerShell with the **Reset-DnsServerZoneKeyMasterRole** cmdlet. 

1. Run the following commands to reset the Key Master role:

```powershell
Reset-DnsServerZoneKeyMasterRole -ZoneName <NameOfZone> | Select KeyMasterServer <ServerName> -force
```

1. Next, run this command to verify the Key Master role transferred successfully:

```powershell
Get-DnsServerDnsSecZoneSetting -ZoneName <NameOfZone> | Select KeyMasterServer

    KeyMasterServer
    ---------------
    <NameOfZone>

```

In this example, the **Get-DnsServerDnsSecZoneSetting** cmdlet is also used to verify that the Key Master role was transferred successfully.

## Transfer an off-line Key Master (Seizing the Key Master role)

The server that's designated as the Key Master should be online and highly available to ensure uninterrupted service for key signing operations. However, if the Key Master goes offline and can't easily be restored to online status, it's possible to forcibly transfer the Key Master role to another qualifying DNS server by using a process called *seizing*. Don't seize the Key Master role and transfer it offline unless it's unavoidable, such as in a disaster recovery scenario.

### Private key material

> [!IMPORTANT]
> The Key Master must have access to private key material for a DNSSEC-signed zone. If the current Key Master is offline, other DNS servers might have access to private key material if it's stored in a shared location such as Active Directory. If private key material isn't stored in Active Directory and the new Key Master can't access the private keys for a zone through other means, then you must generate new keys and re-sign the zone with them. After re-signing with new keys, all trust anchors that exist on other DNS servers become invalid and need updating.

To store private key material in Active Directory:

1. Select the **Replicate this private key to all DNS servers authoritative for this zone** check box in KSK settings for all KSKs you're using.
1. If you don't want to store private key material in Active Directory, you can also provide access to private key material using a certificate or hardware storage module (HSM) device. This storage media must be accessible to the DNS server that's selected as the new Key Master.
1. If private key material isn't stored in Active Directory or an external device, run the following command in PowerShell to store this material in a certificate on the local computer.

```powershell
New-SelfSignedCertificate `
  -DnsName "YourDNSName" `
  -CertStoreLocation "Cert:\LocalMachine\MS-DNSSEC" `
  -KeyExportPolicy Exportable
```

If the new Key Master can't access private key material for the zone, a message displays that says private key material isn't accessible and that you must generate new keys.

> [!IMPORTANT]
> If you select **Yes** and continue seizing the Key Master role, new ZSKs and KSKs don't automatically generate. You must re-sign the zone so that private key material is available. If the zone has trust anchors, you must also replace them. If the original Key Master becomes available before the zone is re-signed, you can transfer the Key Master role back to this server without the requirement to re-sign the zone and redistribute trust anchors.

1. If private key material is stored in Active Directory, you can seize the Key Master role on another primary, authoritative Active Directory-integrated DNS server and have full access to private key material. In this case, you don't have to replace the signing keys (ZSKs and KSKs).
1. If you use DNS Manager to access an Active Directory-integrated authoritative DNS server with a primary copy of the zone when the Key Master is offline, a notification appears when you try to view the zone's DNSSEC properties that says the DNSSEC settings couldn't load.
1. Select **OK** to load DNSSEC settings using the local server. These settings are the same settings you configured during the last successful replication.
1. On the **Key Master** tab, you can choose a new Key Master from a list of available DNS servers. 
1. After choosing a new Key Master and selecting **OK**, a notification is displayed with information about the changes to be made. Select **OK** again to proceed with the seizing operation. Another notification is displayed with the status of the role transfer.
1. Select **OK**.
1. Review the information for your new Key Master to make sure it's correct, then select **OK**.
1. Wait for the seizing process to finish.

Information about the new Key Master replicates in Active Directory to all primary DNS servers. After seizing the Key Master role on another server, if the old Key Master comes online, it detects that it's no longer the Key Master. You don't have to modify settings further.

## Related content

- [Overview of DNSSEC](dnssec-overview.md)
