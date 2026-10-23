---
title: Set Up DNS Forwarding in Windows Server
description: "DNS forwarding in Windows Server: Configure and validate server-level and conditional forwarders with DNS Manager or PowerShell."
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 10/22/2026
ai-usage: ai-generated

#customer intent: As a DNS administrator, I want to configure and validate DNS forwarding so that unresolved or namespace-specific queries use the intended DNS servers.
---

# Configure DNS forwarding in Windows Server

DNS forwarding sends queries that a DNS server can't resolve locally to other DNS servers. Server-level forwarders handle general unresolved queries, while conditional forwarders handle queries for specific DNS namespaces. Choosing the appropriate forwarding path helps ensure that queries reach the intended DNS servers and follow your required fallback policy.

This article describes how to configure and validate server-level or conditional DNS forwarding in Windows Server by using DNS Manager or PowerShell. It also describes how to validate DNS responses and restore the previous configuration.

## Prerequisites

- A Windows Server computer on which you installed and configured the DNS Server role to answer client queries.
- An account that's a member of the **DnsAdmins** group, the local **Administrators** group on the DNS server, or an equivalent delegated role.
- DNS Manager or the DnsServer PowerShell module on the computer that you use to manage the DNS server.
- One or more stable IPv4 or IPv6 addresses for the upstream DNS servers. Use independently available servers when the design requires redundancy.
- An upstream DNS server that accepts recursive queries from the source address of your DNS server, or that can answer queries for the namespace that you conditionally forward.
- Network access from the DNS server to each forwarder over UDP port 53 and TCP port 53.
- A known DNS name that each prospective forwarder can resolve.
- A documented decision about whether server-level queries can fall back to root hints and whether a private conditional-forwarder namespace can use another recursive path.

> [!WARNING]
> A server-level forwarder can affect every query that the DNS server can't answer from its authoritative zones or cache. A conditional forwarder can redirect an entire namespace. Record the existing configuration, test each prospective forwarder, and confirm the intended fallback policy before you change a production DNS server.

## Prepare the DNS server for DNS forwarding

Record the current configuration and test prospective forwarders from the DNS server that sends the queries. A test from an administrator workstation doesn't validate the DNS server's source address, network path, firewall access, or permission to query the forwarder. For more information about resolution paths and fallback, see [DNS forwarding in Windows Server](forwarding.md).

1. On the DNS server, open an elevated PowerShell session.

1. Record the current server-level forwarders, recursion settings, and conditional forwarders in your approved change record:

   ```powershell
   Get-DnsServerForwarder
   Get-DnsServerRecursion
   Get-DnsServerZone |
       Where-Object ZoneType -eq "Forwarder" |
       Select-Object ZoneName, IsDsIntegrated, MasterServers, ForwarderTimeout
   ```

1. For each prospective server-level forwarder, replace the sample name and address, and then test DNS over UDP and TCP:

   ```powershell
   Resolve-DnsName -Name "www.contoso.com" -Server "10.0.0.10" -DnsOnly
   Resolve-DnsName -Name "www.contoso.com" -Server "10.0.0.10" -DnsOnly -TcpOnly
   ```

1. For each prospective conditional forwarder, replace the sample name and address with a known record in the target namespace and the address of a target DNS server:

   ```powershell
   Resolve-DnsName -Name "server01.south.contoso.com" -Server "10.20.0.10" -DnsOnly
   Resolve-DnsName -Name "server01.south.contoso.com" -Server "10.20.0.10" -DnsOnly -TcpOnly
   ```

1. Confirm that both queries return a DNS response within an acceptable time. For a private namespace, test more than one known record when possible.

   > [!NOTE]
   > A negative answer such as `NXDOMAIN` is a DNS response, not a connectivity failure. It means that the name doesn't exist according to that server's resolution path. Verify the name and authoritative data instead of assuming that the forwarder is unreachable.

## Configure server-level forwarders

Server-level forwarders receive general unresolved queries that don't match a hosted zone, conditional forwarder, or delegation. Choose DNS Manager or PowerShell, and make the root-hint fallback choice explicit.

### [DNS Manager](#tab/dns-manager)

1. Open DNS Manager (`dnsmgmt.msc`).

1. In the console tree, open the shortcut menu for the DNS server, and then select **Properties**.

1. Select the **Forwarders** tab, and then select **Edit**.

1. Enter the IP address of each upstream DNS server. Put preferred addresses in the order you want.

1. Select **OK**.

1. On the **Forwarders** tab, select or clear **Use root hints if no forwarders are available** according to your fallback policy.

1. Select **OK** to apply the configuration.

Configure multiple forwarders when the design requires independent availability. Keep the list short enough that the overall recursion timeout can reach the required servers.

### [PowerShell](#tab/powershell)

1. Choose whether to append addresses without replacing existing forwarders or replace the complete list.

   To append addresses, run the following command:

   ```powershell
   Add-DnsServerForwarder -IPAddress @("10.0.0.10", "10.0.0.11") -PassThru
   ```

   To replace the complete list instead, run the following command:

   ```powershell
   Set-DnsServerForwarder -IPAddress @("10.0.0.10", "10.0.0.11") -PassThru
   ```

   > [!IMPORTANT]
   > `Set-DnsServerForwarder` replaces the existing server-level forwarder address list when you specify `-IPAddress`. Use `Add-DnsServerForwarder` when you intend to append addresses.

1. Choose one root-hint fallback policy. To permit root-hint fallback after the server exhausts its forwarders, run:

   ```powershell
   Set-DnsServerForwarder -UseRootHint $true -PassThru
   ```

   To restrict unresolved queries to the configured forwarders, run:

   ```powershell
   Set-DnsServerForwarder -UseRootHint $false -PassThru
   ```

1. Enforce a restricted resolution boundary with network controls in addition to the DNS setting.

---

## Configure a conditional forwarder

A conditional forwarder sends queries for one DNS namespace to designated DNS servers. Choose whether to store it locally or in Active Directory Domain Services, and replicate it only to the DNS servers that require the configuration.

> [!IMPORTANT]
> A conditional forwarder can't have the same name as a primary, secondary, or stub zone that the DNS server hosts. When the DNS server hosts an authoritative parent zone, you can create a conditional forwarder for a child namespace only if the child name is at or below a delegation in the parent zone. If the zone already exists, don't remove it until you understand its role and protect its data. For resolution choices and safe migration boundaries, see [Resolve a conditional forwarder zone conflict](troubleshoot/resolve-conditional-forwarder-zone-conflict.md).

### [DNS Manager](#tab/dns-manager)

To create an Active Directory-integrated conditional forwarder, perform this procedure on a writable domain controller. A read-only domain controller (RODC) can't create it.

> [!WARNING]
> DNS Manager initially creates the conditional forwarder with recursion fallback allowed. For a private namespace that exists only on the designated target servers, fallback can send queries to unintended DNS servers and produce inconsistent results. If you must prevent fallback from the moment of creation, use the PowerShell method and omit `-UseRecursion` instead of relying only on a postcreation change. This setting controls DNS resolver behavior; don't treat it as a network security boundary.

1. Open DNS Manager (`dnsmgmt.msc`).

1. Expand the DNS server, and then select **Conditional Forwarders**.

1. Open the shortcut menu for **Conditional Forwarders**, and then select **New Conditional Forwarder**.

1. In **DNS Domain**, enter the namespace to forward, such as `south.contoso.com`.

1. Enter the IP address of each target DNS server that can resolve the namespace.

1. If the conditional forwarder should replicate, select **Store this conditional forwarder in Active Directory**, and then select the required replication scope.

1. Select **OK**.

1. On the DNS server, open an elevated PowerShell session and run one of the following commands to make the fallback policy explicit.

   To prevent recursion fallback after you create the conditional forwarder in DNS Manager, run:

   ```powershell
   Set-DnsServerConditionalForwarderZone `
       -Name "south.contoso.com" `
       -UseRecursion $false `
       -PassThru
   ```

   To deliberately allow recursion fallback, run this command instead:

   ```powershell
   Set-DnsServerConditionalForwarderZone `
       -Name "south.contoso.com" `
       -UseRecursion $true `
       -PassThru
   ```

1. Verify the configured fallback policy:

   ```powershell
   Get-DnsServerZone -Name "south.contoso.com" |
       Format-List ZoneName, ZoneType, UseRecursion
   ```

If DNS Manager can't immediately validate a server name, verify the IP address and repeat the direct `Resolve-DnsName` tests before you treat the server as unusable.

### [PowerShell](#tab/powershell)

To create an Active Directory-integrated conditional forwarder, run PowerShell on a writable domain controller. A read-only domain controller (RODC) can't create it.

1. Choose the fallback policy. To prevent recursion fallback from the moment of creation, omit `-UseRecursion` from the command in the next step. To deliberately allow recursion fallback, add `-UseRecursion`.

   > [!WARNING]
   > For a private namespace that exists only on the designated target servers, `-UseRecursion` can send queries to unintended DNS servers and produce inconsistent results. Enable it only when fallback to another recursive path is part of the design.

1. Choose where to store the conditional forwarder. To create a conditional forwarder and store it locally rather than in Active Directory, run:

   ```powershell
   Add-DnsServerConditionalForwarderZone `
       -Name "south.contoso.com" `
       -MasterServers @("10.20.0.10", "10.20.0.11") `
       -PassThru
   ```

   To create an Active Directory-integrated conditional forwarder that replicates to DNS servers on domain controllers in the forest, run:

   ```powershell
   Add-DnsServerConditionalForwarderZone `
       -Name "south.contoso.com" `
       -MasterServers @("10.20.0.10", "10.20.0.11") `
       -ReplicationScope "Forest" `
       -PassThru
   ```

---

## Validate DNS forwarding

Validate both the stored settings and DNS responses. Test through the local DNS server first, and then use a representative client. A successful response alone doesn't prove which upstream path the DNS server used.

1. On the DNS server, review the server-level forwarder settings:

   ```powershell
   Get-DnsServerForwarder |
       Format-List IPAddress, UseRootHint, Timeout, EnableReordering
   ```

1. If you created a conditional forwarder, review its settings:

   ```powershell
   Get-DnsServerZone -Name "south.contoso.com" |
       Format-List ZoneName, ZoneType, IsDsIntegrated, MasterServers, ForwarderTimeout, UseRecursion
   ```

1. Replace the sample server address with the address of the Windows DNS server, and then query names through that server:

   ```powershell
   Resolve-DnsName -Name "www.contoso.com" -Server "192.0.2.53" -DnsOnly
   Resolve-DnsName -Name "server01.south.contoso.com" -Server "192.0.2.53" -DnsOnly
   ```

   If the DNS server might already have cached a result, use a valid name that you didn't query recently. Clear the DNS server cache only during an approved maintenance window and after you consider the temporary increase in upstream traffic.

1. From a representative DNS client, query the Windows DNS server:

   ```powershell
   Resolve-DnsName -Name "www.contoso.com" -Server "192.0.2.53" -DnsOnly
   ```

   Successful resolution from the client confirms that the client received a response from the Windows DNS server. It doesn't prove that the server used a forwarder because the response might come from an authoritative zone, the cache, or a fallback path. Repeating a name that you tested on the server might also use the newly populated cache. To prove that the server used the designated upstream path, use a controlled query for a known-valid name that isn't cached and capture traffic on the DNS server. For packet-capture guidance, see [Troubleshoot DNS name resolution failures related to DNS forwarders](/troubleshoot/windows-server/networking/troubleshoot-dns-forwarders-related-failures).

## Troubleshoot DNS forwarding validation failures

Change one setting at a time while you isolate a failure. Keep detailed timeout, ordering, delegation, and fallback explanations in the [DNS forwarding conceptual guidance](forwarding.md).

Confirm that the DNS Server service is running:

```powershell
Get-Service -Name "DNS"
```

Query each forwarder in the configuration directly from the Windows DNS server over UDP and TCP:

```powershell
Resolve-DnsName -Name "www.contoso.com" -Server "10.0.0.10" -DnsOnly
Resolve-DnsName -Name "www.contoso.com" -Server "10.0.0.10" -DnsOnly -TcpOnly
```

Review the forwarder, recursion, and conditional-forwarder settings:

```powershell
Get-DnsServerForwarder
Get-DnsServerRecursion
Get-DnsServerZone | Where-Object ZoneType -eq "Forwarder"
```

Query the same name through the Windows DNS server:

```powershell
Resolve-DnsName -Name "www.contoso.com" -Server "192.0.2.53" -DnsOnly
```

Use the following results to narrow the cause:

- If an ordinary DNS query succeeds but `-TcpOnly` fails, verify TCP port 53 end to end.
- If direct queries succeed but queries through the Windows DNS server fail, review recursion, root-hint fallback, hosted zones, conditional forwarders, delegations, DNS policies, and cached answers.
- If the DNS server returns `REFUSED`, verify that the upstream server accepts recursive queries from this source and that no DNS policy denies the query.
- If only some names in a namespace that uses conditional forwarding fail, query every target server for the same records and compare their authoritative data.
- If the client query fails but the test on the DNS server succeeds, investigate the client configuration and the path between the client and the Windows DNS server.

If the cause remains unclear, see [Troubleshoot DNS name resolution failures related to DNS forwarders](/troubleshoot/windows-server/networking/troubleshoot-dns-forwarders-related-failures) for packet-capture guidance.

## Roll back DNS forwarding

Use the server-level forwarder address list, root-hint fallback setting, and conditional-forwarder zone details that you recorded before the change. Replace the sample addresses and namespace in the following commands with those recorded values. Don't treat these examples as a substitute for an approved backup and recovery process.

If you appended server-level forwarders, remove only the addresses that you added:

```powershell
Remove-DnsServerForwarder `
    -IPAddress @("10.0.0.10", "10.0.0.11") `
    -Force `
    -PassThru
```

If you replaced the server-level forwarder list, restore the previously recorded addresses:

```powershell
Set-DnsServerForwarder `
    -IPAddress @("192.0.2.10", "192.0.2.11") `
    -PassThru
```

Restore the previously recorded root-hint fallback setting. This example restores an enabled setting:

```powershell
Set-DnsServerForwarder -UseRootHint $true -PassThru
```

Before you remove a conditional forwarder, verify that the named zone is a forwarder:

```powershell
Get-DnsServerZone -Name "south.contoso.com" |
    Format-List ZoneName, ZoneType, IsDsIntegrated, MasterServers
```

If `ZoneType` is `Forwarder`, remove the conditional forwarder:

```powershell
Remove-DnsServerZone -Name "south.contoso.com" -Force -PassThru
```

> [!WARNING]
> `Remove-DnsServerZone` can remove any zone type. Verify that the zone is the intended conditional forwarder before you run the command. If it's Active Directory-integrated, the deletion replicates to other DNS servers in the selected replication scope.

Repeat the validation queries to confirm that resolution follows the restored path. For an Active Directory-integrated conditional forwarder, allow time for replication and verify the result on DNS servers in the replication scope.

## Related content

- [DNS forwarding in Windows Server](forwarding.md)
- [Resolve a conditional forwarder zone conflict](troubleshoot/resolve-conditional-forwarder-zone-conflict.md)
- [Network ports used by DNS](network-ports.md)
- [Add-DnsServerForwarder](/powershell/module/dnsserver/add-dnsserverforwarder)
- [Set-DnsServerForwarder](/powershell/module/dnsserver/set-dnsserverforwarder)
- [Add-DnsServerConditionalForwarderZone](/powershell/module/dnsserver/add-dnsserverconditionalforwarderzone)
- [Set-DnsServerConditionalForwarderZone](/powershell/module/dnsserver/set-dnsserverconditionalforwarderzone)
- [Remove-DnsServerZone](/powershell/module/dnsserver/remove-dnsserverzone)
