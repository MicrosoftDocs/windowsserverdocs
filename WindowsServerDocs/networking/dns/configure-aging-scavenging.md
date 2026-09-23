---
title: Configure DNS aging and scavenging in Windows Server
description: Enable, configure, verify, and operate DNS aging and scavenging on Windows Server using DNS Manager or the DnsServer PowerShell module.
keywords: ["configure DNS aging and scavenging", "enable DNS scavenging", "scavenging pass", "Set-DnsServerScavenging", "Set-DnsServerZoneAging", "Start-DnsServerScavenging", "DNS scavenging event 2501"]
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 09/23/2026
ai-usage: ai-assisted

#customer intent: As a DNS or AD DS administrator, I want to enable, configure, verify, and operate DNS aging and scavenging so that stale resource records are removed automatically without deleting records that are still in use.
---

# Configure DNS aging and scavenging

Aging and scavenging remove stale resource records that accumulate in zone data over time. Without them, obsolete records build up, which wastes storage, slows zone transfers, and causes clients to receive outdated name resolution answers.

In this article, you enable aging on your zones, enable scavenging on the DNS server, protect critical records from deletion, and verify that scavenging runs. You configure everything by using either DNS Manager or the DnsServer PowerShell module.

For background on how aging and scavenging decide when a record is stale, see [DNS aging and scavenging](aging-scavenging.md). This article focuses on the configuration and operational tasks.

## Prerequisites

Before aging and scavenging can function, make sure the following prerequisites are in place:

- A server running Windows Server with the DNS Server role installed. You configure this server.
- Administrative permissions to manage the DNS server: membership in the DnsAdmins group or the local Administrators group on the DNS server. For an Active Directory-integrated zone, use an account that's a member of the Domain Admins group.
- The DNS management tools for the method you use: DNS Manager, which installs with the DNS Server role or through Remote Server Administration Tools (RSAT), and the DnsServer PowerShell module. This article documents both methods.
- Server-level scavenging enabled on each DNS server where you want it. This setting doesn't replicate, so configure it individually on every server that needs to scavenge.
- Zone-level aging enabled on your zones. For an AD-integrated zone, enable aging once and the setting replicates with the zone data to other DNS servers that host the zone. For a non-AD-integrated zone, enable aging in each zone individually. For a standard primary zone, configure aging on the primary DNS server.
- DNS records with a nonzero timestamp. Records added dynamically receive a timestamp automatically. Records added manually, from the DNS console or a text-based zone file, receive a timestamp of zero, which excludes them from scavenging until you assign a nonzero timestamp.
- A supported zone type. Aging and scavenging apply only to standard primary and AD-integrated zones. Secondary and stub zones don't support these processes.

> [!WARNING]
> Aging and scavenging are disabled by default. Enable them only when you understand every interval you set. A misconfiguration can delete legitimate records, which leaves users unable to resolve those names. Test your configuration in a lab and back up your zone data before you enable scavenging in production.

## Configure aging and scavenging

Configure aging and scavenging by using either DNS Manager or the DnsServer PowerShell module. Choose the method that matches how you prefer to work.

# [DNS Manager](#tab/dns-manager)

Use DNS Manager (`dnsmgmt.msc`) when you prefer a graphical interface. The following sections enable aging on a zone, apply settings to all zones, enable automatic scavenging on the server, and protect a record.

### Enable aging on a zone

1. Open DNS Manager (`dnsmgmt.msc`).
1. Select and hold (or right-click) the zone, select **Properties**, and then select **Aging**.
1. Select **Scavenge stale resource records**.
1. Set the **No-refresh interval** and the **Refresh interval**. The default of seven days for each interval suits most environments.
1. Select **OK**.

:::image type="content" source="../media/configure-aging-scavenging/enable-zone-aging.png" alt-text="Screenshot of the Aging tab in a zone's Properties dialog box with Scavenge stale resource records selected.":::

The No-refresh interval suppresses unnecessary timestamp updates during that period. The Refresh interval lets active clients renew their timestamps during that period. A record becomes eligible for scavenging (that is, the server considers it stale) only after both intervals elapse, which is 14 days with the defaults. The next scavenging pass on an eligible zone deletes any stale records it finds. Shorter intervals remove stale records sooner but increase replication traffic and the risk of deleting records for clients that are temporarily offline.

:::image type="content" source="../media/configure-aging-scavenging/aging-properties.png" alt-text="Screenshot of the No-refresh interval and Refresh interval values set to 7 days each in the zone Aging dialog box.":::

### Set aging and scavenging for all zones

Use this task to apply aging settings to every zone at once, including existing AD-integrated zones.

1. Select and hold (or right-click) the server name, select **Set Aging/Scavenging for All Zones**.
1. Select **Scavenge stale resource records** and set the intervals.
1. Select **OK**.
1. Select **Apply these settings to the existing Active Directory-integrated zones**, and then select **OK**.

:::image type="content" source="../media/configure-aging-scavenging/set-aging-all-zones.png" alt-text="Screenshot of the Server Aging/Scavenging Properties dialog box with Scavenge stale resource records selected.":::

The **Apply these settings to the existing Active Directory-integrated zones** option is how you age the records in zones that already exist, such as after you convert a standard zone to AD-integrated. Without this option, new settings apply only to zones created afterward.

:::image type="content" source="../media/configure-aging-scavenging/apply-existing-zones.png" alt-text="Screenshot of the confirmation dialog box to apply aging and scavenging settings to existing Active Directory-integrated zones.":::

> [!NOTE]
> When you first enable aging on a zone, the zone gets one refresh interval of protection from scavenging. This grace period prevents the server from deleting records that look stale by timestamp but that clients might have updated while aging was disabled, when the server wasn't recording those timestamps. The grace period lets dynamic updates refresh those records before scavenging deletes them.

### Enable automatic scavenging on the server

1. Select and hold (or right-click) the DNS server, select **Properties**, and then select the **Advanced** tab.
1. Select **Enable automatic scavenging of stale records**.
1. Set the **Scavenging period**. The default and recommended value is seven days.
1. Select **OK**.

:::image type="content" source="../media/configure-aging-scavenging/enable-server-scavenging.png" alt-text="Screenshot of the Advanced tab in the DNS server Properties dialog box with Enable automatic scavenging of stale records selected.":::

The scavenging period determines how often the server checks for and removes eligible stale records. It doesn't determine when a record becomes stale.

### Protect a record from scavenging

To protect a critical record from scavenging, clear its timestamp:

1. Open the record's properties.
1. Clear **Delete this record when it becomes stale**.

When you clear this checkbox, it sets the record's timestamp to zero, which prevents scavenging.

> [!NOTE]
> A record with a zero timestamp can still receive dynamic updates to its data, such as a new IP address, but its timestamp stays zero. The record stays protected from scavenging. The record becomes eligible for scavenging again only if you set a nonzero timestamp on it.

# [PowerShell](#tab/powershell)

Use the DnsServer module cmdlets when you prefer the command line or need to script the configuration. The following cmdlets manage aging and scavenging.

| Cmdlet | Purpose |
|--|--|
| `Get-DnsServerScavenging` | Retrieve the current scavenging settings from a DNS server. |
| `Set-DnsServerScavenging` | Enable or configure server-level scavenging. Use `-ApplyOnAllZones` to push settings to all zones. |
| `Start-DnsServerScavenging` | Trigger an immediate scavenging pass without waiting for the next scheduled pass. This pass doesn't reset or change the next automatic pass. Use `-Verbose` to see what it deletes. |
| `Set-DnsServerZoneAging` | Enable or configure aging on a specific zone. Use `-ScavengeServers` to restrict which servers scavenge the zone. |
| `Get-DnsServerZoneAging` | Retrieve the aging settings for a specific zone. |

Enable scavenging at the server level with a seven-day interval and apply it to all zones:

```powershell
Set-DnsServerScavenging -ScavengingState $true -ScavengingInterval 7.00:00:00 -ApplyOnAllZones
```

The `-ApplyOnAllZones` parameter is the PowerShell equivalent of the DNS Manager **Apply these settings to the existing Active Directory-integrated zones** option, so use it to age records in zones that already exist.

Enable aging on a specific zone:

```powershell
Set-DnsServerZoneAging -Name "contoso.com" -Aging $true -NoRefreshInterval 7.00:00:00 -RefreshInterval 7.00:00:00
```

> [!NOTE]
> When you first enable aging on a zone, the zone gets one refresh interval of protection from scavenging. This grace period prevents the server from deleting records that look stale by timestamp but that clients might have updated while aging was disabled, when the server wasn't recording those timestamps. The grace period lets dynamic updates refresh those records before scavenging deletes them.

Restrict scavenging of a zone to a single DNS server:

```powershell
Set-DnsServerZoneAging -Name "contoso.com" -Aging $true -ScavengeServers 192.0.2.10
```

Review the current settings before or after you make changes:

```powershell
Get-DnsServerScavenging
Get-DnsServerZoneAging -Name "contoso.com"
```

Trigger an immediate scavenging pass and see which records it deletes:

```powershell
Start-DnsServerScavenging -Verbose
```

### Protect a record from scavenging

A record is protected from scavenging when it's static, which means its timestamp is zero. When you add a record by using `Add-DnsServerResourceRecordA` (or the generic `Add-DnsServerResourceRecord`) and omit the `-AgeRecord` switch, the new record has a zero timestamp and is never scavenged:

```powershell
Add-DnsServerResourceRecordA -ZoneName "contoso.com" -Name "criticalhost" -IPv4Address "192.0.2.50"
```

Including `-AgeRecord` does the opposite: it adds a timestamp so the record ages and becomes eligible for scavenging. The `Set-DnsServerResourceRecordAging` cmdlet also adds timestamps, but it stamps every record at a node, or the whole zone with `-Recurse`, and requires you to enable zone-level aging first. Don't use it to age a single record.

No single cmdlet clears an existing record's timestamp. To protect an existing dynamically registered record, remove it and re-add it as a static record without `-AgeRecord`.

> [!CAUTION]
> Removing and re-adding the record temporarily removes the DNS name and creates a new administrator-created static record. This action changes the record's ownership and permissions and can affect later dynamic registration by the client. Before you remove the record, capture its existing data and assess how the ownership and permission changes affect later dynamic updates.

Inspect a record's timestamp by using `Get-DnsServerResourceRecord`. A static, protected record shows a zero or empty timestamp:

```powershell
Get-DnsServerResourceRecord -ZoneName "contoso.com" -Name "criticalhost"
```

---

## Monitor scavenging with the event log

After a scavenging pass finishes, the DNS server writes one of the following events to the DNS server event log. Review these events to confirm that scavenging runs and to see which records scavenging removed.

| Event ID | Meaning |
|--|--|
| 2501 | A scavenging pass ran and records **were** scavenged. Check which records scavenging removed. For AD-integrated zones, deleted records might be tombstoned and the change propagates through AD replication. |
| 2502 | A scavenging pass ran but **no** records were scavenged. This event indicates the normal, healthy state when all records are current. |
| 4013 | The DNS server waits for Active Directory Domain Services to initialize before it loads AD-integrated zones. The DNS server delays scavenging until AD DS initialization finishes. |
| 4515 | The DNS server detects a duplicate zone in Active Directory, which can prevent the affected zone from loading or being scavenged correctly. Verify zone configuration and AD replication health. |
| 4521 | The DNS server couldn't load an AD-integrated zone, so it can't scavenge the zone until you resolve the underlying error. Review the DNS Server and Directory Service event logs for details. |

The DNS server schedules the next automatic pass for approximately the start time of the preceding pass plus the configured scavenging interval. Adding the scavenging period to the timestamp of event 2501 or 2502 gives an estimate, but the event time reflects completion of the pass rather than its start time.

> [!TIP]
> Monitor event ID 2501 regularly to confirm that scavenging runs and to review the records it removes.

For AD-integrated zones, also monitor the DNS Server and Directory Service event logs for events 4013, 4515, and 4521, which can indicate zone-loading, replication, or configuration issues. When you investigate record inconsistencies, query each authoritative DNS server directly with `Resolve-DnsName`, and verify Active Directory replication health with `repadmin /replsummary` and `repadmin /showrepl`. Cached responses can persist in a client's cache or in a non-authoritative server's cache after replication finishes, so a stale cached response doesn't necessarily indicate a replication failure.

## Best practices and common mistakes

Follow these practices to operate scavenging safely:

- **Test in a lab first.** Validate your configuration in a non-production environment before you enable it in production.
- **Back up your DNS Server configuration.** Export your server configuration before you make changes.
- **Back up your zone data.** Export zone data before you enable aging or trigger scavenging.
- **Use one scavenging server per zone.** Restrict scavenging to a single DNS server with the `-ScavengeServers` parameter to simplify troubleshooting.
- **Protect critical static records.** Create records for servers, printers, web services, and domain controllers as static records, and ensure you clear **Delete this record when it becomes stale**.
- **Monitor event ID 2501.** Review the DNS event log to confirm scavenging runs and to check the records it removes.
- **Verify AD replication.** For AD-integrated zones, check the output of `repadmin /replsummary` and `repadmin /showrepl` before you enable or troubleshoot scavenging.

Avoid these common mistakes:

- **Setting the refresh interval too short.** If the refresh interval is shorter than the time clients need to re-register, scavenging deletes legitimate records. Align the combined No-refresh and Refresh intervals with your DHCP lease duration so that the combined interval is equal to or less than the lease.
- **Scavenging on multiple servers without coordination.** Multiple servers scavenging independently increases the chance of race conditions and makes unexpected deletions harder to trace.
- **Expecting static records to be scavenged.** Manually created records have a zero timestamp and don't age out unless you assign a nonzero timestamp. This behavior is intentional.

## Related content

- [DNS aging and scavenging](aging-scavenging.md)
- [Manage DNS resource records](manage-resource-records.md)
