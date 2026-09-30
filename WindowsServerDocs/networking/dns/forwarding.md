---
title: DNS Forwarding and Fallback in Windows Server
description: DNS forwarding in Windows Server routes queries through conditional forwarders, delegations, and root hints. Learn how timeouts and fallback affect resolution.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 09/23/2026
ai-usage: ai-assisted
---

# DNS forwarding in Windows Server

DNS forwarding is a name-resolution process in which one DNS server sends a recursive query to another DNS server that acts as a forwarder. DNS Server can use server-level forwarders for general name resolution and conditional forwarders for selected DNS namespaces. Understanding how forwarding interacts with delegations, root hints, and timeouts helps you predict which server receives a query and when resolution can continue on another path.

This article explains how DNS Server selects among locally available data, conditional forwarders, delegations, server-level forwarders, and root hints when it processes recursive client queries. It also explains how timeout and fallback settings affect whether resolution continues or returns a failure.

## How DNS Server selects a resolution path

When DNS Server receives a recursive query from a client, it evaluates locally available data and then selects an applicable resolution path. The path depends on the zones that DNS Server hosts and its conditional forwarder, delegation, server-level forwarder, and root hint configuration.

The distinction between a terminal response and no response is central to this selection process. A DNS response such as `NXDOMAIN` or `NODATA` is a valid, terminal response and doesn't normally trigger fallback. Fallback generally applies when a configured server doesn't respond or when DNS Server classifies a result as retryable.

This resolution order applies when you disable `ForwardDelegations`. DNS policies and other DNS features can affect the path for a specific query.

1. **Check locally available DNS data.** The server evaluates the authoritative zones that it hosts and its cache. If a hosted authoritative zone covers the query, that zone determines the result. If authoritative data or the cache provides a terminal result, the server returns it.

1. **Use a matching conditional forwarder.** If the query name matches a conditional forwarder zone, the server sends the query to that zone's configured target DNS servers. If those servers don't respond or return a result that DNS Server classifies as retryable, the conditional forwarder's **Use recursion** setting determines whether the server can try other recursive resolution paths.

1. **Use an applicable delegation.** If a matching delegation identifies the next authoritative servers, the server sends iterative queries to the name servers in the delegation. With `ForwardDelegations` disabled, server-level forwarders don't control a query while an applicable delegation controls its resolution.

1. **Use server-level forwarders.** If no conditional forwarder or applicable delegation controls the query, the server uses its configured server-level forwarders in the active order and subject to the configured timeouts.

1. **Use root hints when the configuration permits.** If the server exhausts its server-level forwarders, it can fall back to root hints when the server configuration enables recursion and root hint fallback and the overall recursion timeout hasn't expired. If the server has no configured server-level forwarders, root hints can provide the starting point for iterative resolution.

1. **Return the result or a failure.** The server returns the result from the selected path. If the server configuration disables recursion, the server normally returns `REFUSED` for a query that requires recursion. If recursive processing can't complete, the server returns `SERVFAIL`.

> [!NOTE]
> An unresponsive forwarder doesn't guarantee that the server reaches root hint fallback. The server must exhaust the applicable forwarders before `RecursionTimeout` expires. If the overall recursion timeout expires first, the query fails without reaching the root hints.

## DNS Server forwarder resolution flow and fallback

The following flowchart shows the common decision path from locally available data through progressively broader resolution methods. A terminal response ends processing at any stage. An unresponsive server or a retryable result can lead to another path only when the configuration permits fallback and time remains in `RecursionTimeout`. The text description identifies every branch and outcome.

:::image type="complex" source="../media/forwarding/dns-forwarding-resolution-flow.svg" alt-text="Flowchart of DNS Server query resolution through local data, conditional forwarders, delegations, server-level forwarders, and root hints." border="false" lightbox="../media/forwarding/dns-forwarding-resolution-flow.svg":::
This description narrates the DNS Server resolution flow, from the initial client query through each fallback branch to the final response. The flow starts when DNS Server receives a recursive client query. It first checks whether authoritative data or the cache can provide a terminal response. If yes, the server sends that response. If no, the server checks for a matching conditional forwarder zone.

When the query matches a conditional forwarder zone, DNS Server queries the conditional forwarder's target DNS servers in order and subject to timeouts. If a target DNS server returns a terminal response, the server sends that response. Otherwise, the server checks whether the conditional forwarder's configuration permits recursion, the server-wide configuration enables recursion, an applicable recursive path exists, and time remains in `RecursionTimeout`. If any condition doesn't hold, the server sends `SERVFAIL`. If all conditions hold, the flow continues to the delegation decision.

When the query doesn't match a conditional forwarder zone, DNS Server checks whether an applicable delegation identifies the next authoritative DNS servers. If a delegation applies, DNS Server resolves iteratively by using the delegated name servers, then sends the resulting answer, `NODATA`, `NXDOMAIN`, or `SERVFAIL`. If no delegation applies, the flow continues to the server-level forwarder decision.

At the server-level forwarder decision, DNS Server checks whether its configuration specifies server-level forwarders. If it does, the server queries them in the active order, subject to forwarding and recursion timeouts. When a server-level forwarder returns a terminal DNS response, the server sends that response to the client. If no server-level forwarder returns a terminal response, the server checks whether its configuration enables root hint fallback and whether time remains in `RecursionTimeout`. If the configuration doesn't specify server-level forwarders, the flow performs the same root hint fallback check.

If the configuration doesn't enable root hint fallback or no time remains, DNS Server sends `SERVFAIL`. If the configuration enables root hint fallback and time remains, DNS Server uses root hints for iterative resolution, then sends the resulting answer, `NODATA`, `NXDOMAIN`, or `SERVFAIL`.
:::image-end:::

## Server-level forwarders in DNS Server

Server-level forwarders handle unresolved queries when neither a hosted authoritative zone, a matching conditional forwarder zone, nor an applicable delegation controls the query. The DNS server sends a recursive query to a forwarder, which becomes responsible for completing name resolution.

Centralizing external lookups through forwarders can reduce direct internet exposure, consolidate cached answers, simplify monitoring and access control, and reduce repeated external queries. If you don't configure server-level forwarders, DNS Server uses root hints for unresolved names when you enable recursion and usable root hint data is available.

Allow recursive queries only from trusted clients and networks, and don't expose recursive DNS service to untrusted networks. Use trusted forwarders and firewall rules to enforce DNS traffic boundaries.

### Server-level forwarder selection and ordering

You configure forwarder IP addresses in a preferred order. By default, Dynamic Forwarder Reordering maintains an active order based on response times and resets the list to the configured order approximately every 15 minutes.

- For each query, the DNS server selects forwarders from the active list.
- If a forwarder takes more than one second to respond, the server considers the response slow for reordering purposes.
- After three consecutive slow responses or timeouts, the server can move that forwarder to the end of the active list.
- DNS Server doesn't determine whether an unresponsive forwarder is offline or slow. Monitor forwarder health separately.

> [!NOTE]
> In Windows Server 2022 and later, if none of the forwarders respond, DNS Server uses only the first server in the dynamic list for subsequent queries until the DNS Server service restarts. To make the server cycle through all configured forwarders as in earlier versions, disable dynamic reordering with `Set-DnsServerForwarder -EnableReordering $false`.

### Server-level forwarder fallback to root hints

After the DNS server exhausts applicable server-level forwarders, it attempts standard recursion by default if the forwarders don't respond or return only results that DNS Server classifies as retryable. Standard recursion uses iterative queries that begin with the servers in the root hints. This fallback requires all the following conditions:

- The server exhausts the applicable forwarders before `RecursionTimeout` expires.
- The server allows recursion.
- The `UseRootHint` setting is `$true`, which you configure with `Set-DnsServerForwarder -UseRootHint $true`.
- The server has usable root hint data and network access to the required DNS servers.

Set `UseRootHint` to `$false` when the server must restrict unresolved queries to the forwarders in its configuration. With that configuration, the server doesn't try iterative resolution when the forwarders fail.

## Conditional forwarders in DNS Server

A conditional forwarder routes queries for a specific DNS namespace to designated DNS servers. For example, a conditional forwarder can send all queries for `south.contoso.com` to the DNS servers that host that namespace while the server handles other names through server-level forwarders or root hints.

DNS Server stores conditional forwarders as forwarder zones. When a query matches a conditional forwarder, the DNS server sends it to that zone's target DNS server list instead of immediately using the general server-level forwarding path.

### Hosted zone restrictions for conditional forwarders

You can't create a conditional forwarder for a DNS name that matches a primary, secondary, or stub zone that the same DNS server hosts. Because DNS Server stores a conditional forwarder as a forwarder zone, the server can't host another zone type and a conditional forwarder for the same name.

For example, if the server hosts `contoso.com` as an authoritative zone, you can't create a conditional forwarder named `contoso.com` on that server. DNS Manager or `Add-DnsServerConditionalForwarderZone` reports that the zone already exists, and the server continues to answer queries for `contoso.com` from its hosted zone.

If another DNS server should resolve the entire namespace, migrate the zone data and remove the hosted zone before you create the conditional forwarder. If other DNS servers host only a child namespace, keep the parent zone and create a delegation for the child namespace.

### Conditional forwarder fallback and recursion

The conditional forwarder's **Use recursion** setting controls what the DNS server can do if the zone's target DNS servers don't respond or return a result that DNS Server treats as retryable.

| Use recursion | Behavior after no terminal response | Result |
| --- | --- | --- |
| Enabled | The DNS server can try another recursive resolution path only when the server-wide configuration enables recursion, an applicable path exists, and time remains in `RecursionTimeout`. | Resolution can continue through an applicable recursive path. |
| Disabled | The DNS server doesn't try other DNS servers. | The query fails if the configured target DNS servers can't provide a terminal result. |

`ForwarderTimeout` controls the conditional forwarder timing window and the scheduling of target DNS server attempts. DNS Server doesn't start another conditional forwarder target attempt after `ForwarderTimeout` elapses. `RecursionTimeout` provides a separate server-wide limit on recursive processing.

## DNS Server delegation and forwarding

If a DNS server hosts a parent zone and the queried name falls under an applicable delegation, the server uses the delegation to locate the child zone's authoritative DNS servers. The delegation creates a zone cut: the parent server is authoritative for the delegation records but isn't authoritative for data inside the delegated child zone.

If no delegation applies and the queried name is inside a zone that the server hosts, the server remains authoritative for the query. If the requested name or record type doesn't exist, the server returns an authoritative negative response such as `NXDOMAIN` or `NODATA`. It doesn't send that query to a conditional forwarder, server-level forwarder, or root hints.

For example, if a server hosts `contoso.com` and other servers host `south.contoso.com`, create a delegation for `south` in the `contoso.com` zone. The parent zone returns a referral to the child zone's authoritative servers. A delegation doesn't send a recursive forwarded query.

This delegation behavior applies when `ForwardDelegations` is disabled. If your environment enables that setting, validate the resulting interaction between delegations and forwarders before relying on this resolution order.

> [!IMPORTANT]
> If the DNS server also hosts an authoritative copy of the child zone and you intend to move the child namespace to other servers, migrate and remove the local child zone copy. Otherwise, the server remains authoritative for that copy.

## DNS Server root hints and iterative resolution

Root hints are resource records that identify DNS servers authoritative for the root of a DNS namespace. DNS Server uses them as starting points for iterative resolution. A root server typically returns an answer, a referral to servers closer to the requested name, or a DNS failure or negative response.

If you don't configure server-level forwarders and no delegation or more specific forwarding configuration provides a starting point, the server can use root hints for an unresolved query. If you configure server-level forwarders, the server uses root hints as a fallback only after it exhausts the forwarders and when recursion, the remaining timeout, and `UseRootHint` permit fallback.

If a DNS server is authoritative for the root of a private namespace, it's a root server for that namespace. Don't assume that ordinary server-level forwarding or public root hints are appropriate for a private root. Use delegations or deliberately design a conditional forwarding configuration between namespaces.

## DNS Server timeouts and failure behavior

Timeout settings determine whether a DNS server reaches later forwarders or root hint fallback. `RecursionTimeout` is the overall time budget for recursive processing. `ForwardingTimeout` and `ForwarderTimeout` schedule individual attempts for server-level and conditional forwarders, respectively, within that budget; neither restarts or extends `RecursionTimeout`.

| Setting | Scope | Purpose | PowerShell parameter |
| --- | --- | --- | --- |
| `RecursionTimeout` | DNS server | Limits the overall recursive client query. When the timeout expires, recursive processing stops and the server returns `SERVFAIL`. | `Set-DnsServerRecursion -Timeout` |
| `ForwardingTimeout` | Server-level forwarders | Specifies how long the DNS server waits for each server-level forwarder before trying the next forwarder. | `Set-DnsServerForwarder -Timeout` |
| `ForwarderTimeout` | Conditional forwarder zone | Controls the conditional forwarder timing window and the scheduling of each target DNS server attempt. DNS Server doesn't start another conditional forwarder target attempt after this timeout elapses. | `Add-DnsServerConditionalForwarderZone -ForwarderTimeout` |

When a forwarder returns a terminal response, the server returns that response without trying another resolution path. When a forwarder doesn't respond or returns a result that DNS Server classifies as retryable, DNS Server can try the next configured server or an available fallback path while time remains.

Because `RecursionTimeout` limits the entire operation, configuring many forwarders doesn't guarantee that the server queries every forwarder or attempts root hints. If the overall timeout expires first, the server returns `SERVFAIL`. When you configure three or more forwarders, review the timeout values and verify the effective behavior through monitoring and packet captures in your environment.

## Choose a DNS Server forwarding design

Choose a resolution path based on who owns the namespace and which DNS servers should receive queries. The following scenarios show how each design affects forwarding and fallback.

| Scenario | Resolution design | Fallback decision |
| --- | --- | --- |
| Centralize general DNS resolution | Use server-level forwarders so that designated DNS servers handle names that local zones, the cache, conditional forwarders, or delegations don't resolve. | Keep root hint fallback when direct iterative resolution is acceptable. Disable it when policy requires all unresolved queries to remain within the forwarding boundary, and enforce the boundary with network controls. |
| Connect separately administered internal namespaces | Use a conditional forwarder to send names in one namespace, such as `south.contoso.com`, directly to its DNS servers without hosting a secondary zone. | Enable **Use recursion** only if another recursive path is valid for that namespace. |
| Resolve a partner namespace through designated servers | Use a conditional forwarder for the partner namespace instead of sending those queries through the public DNS hierarchy. | Disable **Use recursion** when only the partner's designated DNS servers should resolve the namespace. |
| Separate a child namespace from a hosted parent zone | Use a delegation in the parent zone to identify the child zone's authoritative DNS servers. A delegation returns referrals instead of forwarding recursive queries. | When you disable `ForwardDelegations`, the delegation controls resolution, so server-level forwarders don't provide fallback for the delegated query. |

Use multiple healthy forwarders when the design requires redundancy, and make sure the forwarding and recursion timeouts provide enough time to reach them. Monitor response time, failure rate, and network reachability separately because forwarding behavior isn't a substitute for health monitoring. Recursive servers that resolve internet names typically use public root hints, while private DNS hierarchies require root information that matches the private namespace.

## Related DNS forwarding resources

- To understand recursive and iterative DNS queries, review [DNS queries and lookups in Windows and Windows Server](queries-lookups.md).
- Configure general or namespace-specific forwarding with [Set-DnsServerForwarder](/powershell/module/dnsserver/set-dnsserverforwarder) and [Add-DnsServerConditionalForwarderZone](/powershell/module/dnsserver/add-dnsserverconditionalforwarderzone).
- Use [Manage DNS zones using DNS server in Windows Server](manage-dns-zones.md) when your namespace design requires a zone or delegation.
- Diagnose forwarding failures with [Troubleshoot DNS name resolution failures related to DNS forwarders](/troubleshoot/windows-server/networking/troubleshoot-dns-forwarders-related-failures) and [Forwarders resolution timeouts](/troubleshoot/windows-server/networking/forwarders-resolution-timeouts).
