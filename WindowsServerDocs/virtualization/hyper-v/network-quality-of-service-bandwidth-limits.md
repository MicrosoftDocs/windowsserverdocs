---
title: Network QoS Minimum Bandwidth Best Practices for Hyper-V
description: Guidance and best practices for configuring Hyper-V Quality of Service (QoS) minimum bandwidth on Windows Server.
author: dknappettmsft
ms.author: daknappe
ms.topic: best-practice
ms.date: 10/28/2025
---

# Network QoS minimum bandwidth best practices for Hyper-V

Use these best practices to configure Hyper‑V network Quality of Service (QoS) Minimum Bandwidth on Windows Server. The guidance helps you choose the appropriate mode (weight or bits per second), assign effective weights, and avoid configuration pitfalls with NIC Teaming and Data Center Bridging (DCB).

The article covers: weight assignment strategy, when to prefer weight over absolute bandwidth, interaction with teaming algorithms, coexistence considerations for QoS and DCB, and mitigation techniques for uneven bandwidth distribution.

## Guidelines for using Minimum Bandwidth

Following are guidelines for configuring Minimum Bandwidth.

1. **Keep the sum of the weights near or under 100**. The larger the value for weight, the higher rounding error or quantization error there is when QoS Packet Scheduler partitions the bandwidth among workloads. For example, if there are 20 VMs that you want to share the network bandwidth, rather than assigning a weight of 10 to each of them (sum would be 200), assign each VM a weight of 1.
1. **Assign a relatively large weight to critical workloads even if they don't require that percentage of bandwidth**. For example, management and cluster heartbeat traffic on a computer that is running Hyper-V rarely require more than 1–2% of bandwidth over a 10 GbE NIC—but they're critical. Instead of assigning them a weight of 1 or 2, assign each a weight of 5 or more.
1. **Gap the weight assignment to differentiate service levels**. Don't use consecutive numbers (1,2,3). For example, if you have VMs named Gold, Silver, and Bronze on the same Hyper-V virtual switch, assign weights 5 (Gold), 3 (Silver), 1 (Bronze) rather than 3,2,1.
1. **Account for unfiltered / catch‑all traffic**. For example, if Storage, Live Migration, and Cluster are filtered out with workload-specific filters, group the rest of the network traffic with a wildcard filter as a single flow that has a weight assignment.

## Minimum Bandwidth modes

When you create a Hyper-V virtual switch with PowerShell, choose one of two Minimum Bandwidth configuration modes. These modes determine how you quantify minimum bandwidth for a workload:

- Weight (integer 1–100)
- Bits per second (BPS)

> [!TIP]
> Configure Minimum Bandwidth by weight rather than BPS. Weight is more flexible and compatible with features such as Live Migration and NIC Teaming.

Example scenario: A VM configured with a Minimum Bandwidth of 500 Mbps might fail Live Migration to a destination host that can't guarantee 500 Mbps spare bandwidth. If you specify Minimum Bandwidth by weight (for example, 3), the sum of weights simply increases by 3 and migration succeeds (assuming no other constraints).

If you must specify minimum bandwidth in an absolute number (BPS), use these guidelines:

- The minimum unit is 1% of link capacity. On a 10 GbE NIC, the minimum allocatable bandwidth per virtual network adapter is 100 Mbps.
- Values are rounded to the nearest percent point. For example, 234 Mbps rounds down to 200 Mbps (2% of a 10 GbE link).

Use the `-MinimumBandwidthMode` parameter of `New-VMSwitch` to specify the mode:

```powershell
New-VMSwitch "QoS Switch by Weight" -NetAdapterName "External NIC" -MinimumBandwidthMode Weight
```

```powershell
New-VMSwitch "QoS Switch by BPS" -NetAdapterName "External NIC" -MinimumBandwidthMode Absolute
```

For more information, see the PowerShell reference topic `New-VMSwitch`.

## Minimum Bandwidth and Data Center Bridging (DCB)

QoS Minimum Bandwidth (enforced by QoS Packet Scheduler in Windows) and Data Center Bridging (DCB, enforced by a capable NIC) both ensure a workload receives its fair share of bandwidth under congestion. They're **not** designed to work together for the same networking stack or NIC.

> [!IMPORTANT]
> Don't enable both Minimum Bandwidth and DCB for workloads that share the same networking stack or NIC.

You can enable both Minimum Bandwidth and DCB on one server only when they apply to separate networking stacks or separate NICs.

## Configuring QoS and NIC Teaming

NIC Teaming provides:

- Bandwidth aggregation (distribution across team members)
- Traffic failover (maintains connectivity on component failure)

NIC Teaming distribution algorithms:

- Hyper-V virtual switch port (hash based on switch port of a VM or management OS virtual NIC)
- Address hashing (hash based on MAC, IP, and transport port fields)

QoS interaction with NIC Teaming:

- **Classification and Tagging** – Works seamlessly; traffic is tagged before hashing.
- **Priority-based Flow Control (PFC)** – Works seamlessly; ensure consistent enablement across all team members.
- **Bandwidth Management** – Details in the following section.

### Maximum Bandwidth

Works seamlessly: QoS Packet Scheduler throttles flows before NIC Teaming hashes them to team members.

### Minimum Bandwidth (weight mode)

QoS Packet Scheduler partitions bandwidth among flows by assigned weights before hashing. A problem can occur when the NIC Teaming algorithm is Hyper-V switch port: each VM (single vNIC) becomes a single flow. Teaming could hash high‑weight VMs to one member and low‑weight VMs to another, resulting in effective equal share rather than proportional share.

This issue is less pronounced when:

- Many VMs share the virtual switch
- The NIC Teaming algorithm is Address hashing (more granular flows – e.g., each TCP connection)

Mitigation: script VM startup order so groups of same-weight VMs are brought up together. NIC Teaming hashes virtual NICs round‑robin; grouping preserves more even weight distribution.

### Hardware enforced Minimum Bandwidth (DCB)

The same uneven distribution issue can arise with multiple DCB-capable NICs if hashing is skewed.

### Absolute (BPS) Minimum Bandwidth with NIC Teaming

If a Hyper-V switch is bound to a two‑member 1 Gb NIC team (aggregate 2 Gb), you can't safely allocate more than 1 Gb to a VM—upon single NIC failure only 1 Gb remains. Weight mode avoids this complexity, as remaining bandwidth is repartitioned proportionally.

> [!TIP]
> Prefer weight mode for most deployments; it gracefully handles migration, teaming, and failure scenarios.

## Summary: QoS and NIC Teaming

| QoS feature | Functionality with NIC Teaming |
|-------------|--------------------------------|
| Maximum Bandwidth | Works seamlessly |
| Minimum Bandwidth (weight) | Potential uneven enforcement if switch‑port algorithm skews distribution |
| Hardware enforced Minimum Bandwidth (DCB) | Potential uneven enforcement if traffic distribution is skewed |
| Classification and Tagging | Works seamlessly |
| Priority-based Flow Control | Works seamlessly |

## See also

- Hyper-V QoS overview (newer versions) *(add link when available)*
- `New-VMSwitch` PowerShell reference
- NIC Teaming overview
