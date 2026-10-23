---
title: Fix a DNS Forwarder Conflict in Windows Server
description: Resolve DNS conditional forwarder conflicts in Windows Server when the DNS server hosts a zone with the same name. Choose a delegation or replace the zone.
ms.topic: troubleshooting-problem-resolution
author: robinharwood
ms.author: roharwoo
ms.date: 10/22/2026
ai-usage: ai-generated
#customer intent: As a Windows Server administrator, I want to resolve a DNS zone conflict so that I can direct queries to the correct authoritative DNS servers.
---

# Resolve a DNS conditional forwarder zone conflict in Windows Server

A Domain Name System (DNS) conditional forwarder routes queries for a specific namespace to designated DNS servers. Windows Server can't create one when the DNS server already hosts a primary, secondary, or stub zone with the same name, so you must identify the existing zone's role before changing the configuration.

This article helps you identify the conflicting zone and either delegate a child namespace or replace a hosted zone with a conditional forwarder so that queries reach the intended authoritative DNS servers.

## Prerequisites to resolve a DNS conditional forwarder zone conflict

- Membership in the **Administrators** group, or equivalent permissions, on the DNS server.
- The names and IP addresses of the DNS servers that are authoritative for the target namespace.
- An approved maintenance window, a backup, and a tested recovery plan if you intend to remove a hosted zone.

## Symptoms of a DNS conditional forwarder zone conflict

You experience one or more of the following symptoms:

- DNS Manager prevents you from creating a conditional forwarder because a zone with the same name already exists.
- [`Add-DnsServerConditionalForwarderZone`](/powershell/module/dnsserver/add-dnsserverconditionalforwarderzone) doesn't create the conditional forwarder.
- The DNS server continues to answer authoritatively from a locally hosted zone instead of sending queries for that namespace to the intended DNS servers.

The exact message can vary. This article doesn't document a specific error code or verbatim error message.

## Why a DNS conditional forwarder conflicts with a hosted zone

DNS Server stores a conditional forwarder as a forwarder zone. A DNS server can't host a primary, secondary, or stub zone and a conditional forwarder that have the same name.

DNS Server also checks for a hosted authoritative zone that encloses the conditional forwarder's namespace. If it finds one, the conditional forwarder must be at or below an appropriate delegation in that zone. Without that delegation, DNS Server rejects the conditional forwarder even when its name differs from the hosted zone's name.

For example, if the server hosts `contoso.com` as a primary zone, you can't create a conditional forwarder named `contoso.com` on that server. A server-level forwarder also doesn't provide fallback for names covered by the locally hosted authoritative zone. An authoritative negative response, such as `NXDOMAIN` or `NODATA`, is a terminal DNS result rather than a forwarding failure.

If other DNS servers are authoritative only for a child namespace, such as `branch.contoso.com`, don't replace the parent `contoso.com` zone. Create a delegation in the parent zone instead. A delegation creates a zone cut and returns a referral to the child zone's authoritative name servers; it doesn't recursively forward the query.

## Choose the correct DNS configuration

Choose a configuration based on where you want the authoritative zone data to reside.

| You want to | Use | Considerations |
| --- | --- | --- |
| Hand off a child namespace to different authoritative DNS servers | Delegation | The parent zone stays on the local server and identifies the child zone's authoritative name servers. |
| Maintain a read-only, authoritative copy of a zone that another DNS server hosts | Secondary zone | The server gets zone data through zone transfer and is authoritative for the secondary copy. |
| Maintain a lightweight copy of authoritative-server information | Stub zone | The stub zone contains records that identify the zone's authoritative DNS servers. |
| Send recursive queries for an entire namespace to selected DNS servers | Conditional forwarder | The local server must not host a primary, secondary, or stub zone with the same name. If it hosts an enclosing authoritative zone, the conditional forwarder must be at or below an appropriate delegation in that zone. |

Don't delete and recreate a parent zone to resolve a conflict for a child namespace. This action can remove required records and cause a name-resolution outage.

## Solution 1: Delegate a child namespace

Use this solution when the DNS server hosts the parent zone but other DNS servers are authoritative for a child zone. The following examples delegate `branch.contoso.com` from the `contoso.com` parent zone.

> [!IMPORTANT]
> A delegation and a locally hosted child zone serve different roles. If this DNS server also hosts a primary or secondary copy of `branch.contoso.com`, migrate the child zone data and remove the local child-zone copy before you rely on the delegation. Otherwise, the server continues to answer authoritatively from its local copy. This article doesn't provide the child-zone migration procedure.

### Create a DNS delegation for a child namespace with PowerShell

- Verify that the server hosts the parent zone:

   ```powershell
   Get-DnsServerZone -Name "contoso.com"
   ```

- Review the existing name server (NS) records and delegations in the parent zone:

   ```powershell
   Get-DnsServerResourceRecord -ZoneName "contoso.com" -RRType NS
   ```

- Before you change the parent zone, query the prospective child-zone DNS server for a representative record:

   ```powershell
   Resolve-DnsName -Name "app.branch.contoso.com" -Server 192.0.2.53
   ```

- Create the delegation:

   ```powershell
   Add-DnsServerZoneDelegation `
       -Name "contoso.com" `
       -ChildZoneName "branch" `
       -NameServer "ns1.branch.contoso.com" `
       -IPAddress 192.0.2.53
   ```

   The IP address creates the glue record that the parent server can use to locate the delegated name server.

- Query a representative child-zone record through the parent DNS server. In this example, `192.0.2.10` is the parent server:

   ```powershell
   Resolve-DnsName -Name "app.branch.contoso.com" -Server 192.0.2.10
   ```

### Create a DNS delegation for a child namespace with DNS Manager

1. Open **DNS Manager**.

1. Expand the DNS server, expand **Forward Lookup Zones**, and then select the `contoso.com` parent zone.

1. Right-click the parent zone, and then select **New Delegation**.

1. In the **New Delegation Wizard**, enter `branch` as the delegated domain.

1. Add `ns1.branch.contoso.com` and its IP address as an authoritative name server for the child zone.

1. Complete the wizard, and then verify that the parent zone contains the expected NS and glue records.

1. Query representative records in both the parent and child namespaces through the parent DNS server.

If child-zone resolution fails, verify that the delegated name servers are authoritative for the child zone and that the parent zone contains the correct NS and required glue records.

## Solution 2: Replace a hosted zone with a conditional forwarder

Use this solution only when the DNS server should stop hosting the entire namespace locally and other DNS servers are authoritative for it.

> [!WARNING]
> Removing a DNS zone can interrupt name resolution. If the zone is integrated with Active Directory Domain Services, deletion can replicate to every DNS server in the zone's replication scope. Back up the zone, obtain approval, use a maintenance window, and define and test a recovery plan before you remove the zone.

- Record the current zone type, storage configuration, replication scope, and resource records. Verify that you have the information and backups required by your organization's recovery procedure.

- Query the prospective authoritative DNS server for multiple representative records. Don't remove the hosted zone until the server returns the intended positive and negative results.

   ```powershell
   Resolve-DnsName -Name "app.contoso.com" -Server 192.0.2.53
   ```

- If the hosted zone is Active Directory-integrated, you can export a snapshot of its resource records:

   ```powershell
   Export-DnsServerZone `
       -Name "contoso.com" `
       -FileName "contoso.com.dns"
   ```

   By default, [`Export-DnsServerZone`](/powershell/module/dnsserver/export-dnsserverzone) writes the file to `%SystemRoot%\System32\dns`. For an Active Directory-integrated zone, this export is for troubleshooting and isn't in the same format as a file-backed zone file. Don't treat the export as a complete backup or an independently validated restore procedure.

- Remove the hosted zone:

   ```powershell
   Remove-DnsServerZone -Name "contoso.com"
   ```

   [`Remove-DnsServerZone`](/powershell/module/dnsserver/remove-dnsserverzone) prompts for confirmation by default. The cmdlet supports primary, secondary, stub, and conditional forwarder zones.

- Create the conditional forwarder:

   ```powershell
   Add-DnsServerConditionalForwarderZone `
       -Name "contoso.com" `
       -MasterServers 192.0.2.53
   ```

   This example creates a locally stored conditional forwarder. If the design requires an Active Directory-integrated conditional forwarder, specify the approved replication scope. For detailed storage, replication, and DNS Manager options, see [Configure DNS forwarding in Windows Server](../configure-dns-forwarding.md).

   Add the `-UseRecursion` switch only when your design intentionally allows another recursive resolution path after the conditional forwarder's servers don't return a terminal response. Allowing fallback can send private namespace queries to unintended DNS servers and can produce inconsistent results.

- Query representative records through the local DNS server. In this example, `192.0.2.10` is the local server:

   ```powershell
   Resolve-DnsName -Name "app.contoso.com" -Server 192.0.2.10
   ```

### Roll back replacement of a hosted DNS zone with a conditional forwarder

If you must reverse the change, follow your tested recovery procedure. Remove the conditional forwarder by using `Remove-DnsServerZone`, recreate the original zone with its previous storage and replication settings, and restore the zone data from your validated backup.

```powershell
Remove-DnsServerZone -Name "contoso.com"
```

The `Remove-DnsServerZone` cmdlet removes conditional forwarder zones as well as other zone types.

## Verify DNS resolution after resolving the conditional forwarder zone conflict

After you apply either solution:

- Confirm that the intended zone, delegation, or conditional forwarder exists on every relevant DNS server.
- Query representative records in the parent and child namespaces through the DNS servers that clients use.
- Confirm expected positive answers and authoritative negative responses. Don't treat every `NXDOMAIN` or `NODATA` response as a connectivity or forwarding failure.
- Review the DNS Server event log for zone-loading, zone-transfer, or delegation errors.
- For Active Directory-integrated configurations, verify replication across the intended replication scope.
- Test from a representative DNS client after the server-side configuration is correct.

## Next steps

- [Configure DNS forwarding in Windows Server](../configure-dns-forwarding.md)
- [DNS forwarding in Windows Server](../forwarding.md)
- [Manage DNS zones using DNS Server in Windows Server](../manage-dns-zones.md)
- [Troubleshoot DNS servers](troubleshoot-dns-server.md)
