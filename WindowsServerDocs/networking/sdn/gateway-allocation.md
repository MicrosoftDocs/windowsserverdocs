---
title: Gateway bandwidth allocation
description: 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 
ms.author: lizross
author: eross-msft
ms.date: 08/22/2018
---

# Gateway bandwidth allocation

>Applies to: Windows Server

In Windows Server 2016, the individual tunnel bandwidth for IPsec, GRE, and L3 was a ratio of the total gateway capacity. Therefore, customers would provide the gateway capacity based on the standard TCP bandwidth expecting this out of the gateway VM.

Also, maximum IPsec tunnel bandwidth on the gateway was limited to (3/20)\*Gateway Capacity provided by the customer. So, for example, if you set the gateway capacity to 100 Mbps, then the IPsec tunnel capacity would be 150 Mbps. The equivalent ratios for GRE and L3 tunnels are 1/5 and 1/2, respectively.

Although this worked for the majority of the deployments, the fixed ratio model was not appropriate for high throughput environments. Even when the data transfer rates were high (say, higher than 40 Gbps), the maximum throughput of SDN gateway tunnels capped due to internal factors.

In Windows Server 2019, for a tunnel type, the maximum throughput is fixed:

-   IPsec = 5 Gbps

-   GRE = 15 Gbps

-   L3 = 5 Gbps

So, even if your gateway host/VM supports NICs with much higher throughput, the maximum available tunnel throughput is fixed. Another issue this takes care of is arbitrarily over-provisioning gateways, which happens when providing a very high
number for the gateway capacity.

## Gateway capacity calculation

Ideally, you set the gateway throughput capacity to the throughput available to the gateway VM. So, for example, if you have a single gateway VM and the underlying host NIC throughput is 25 Gbps, the gateway throughput can be set to 25 Gbps as well.

If using a gateway only for IPsec connections, the maximum available fixed capacity is 5 Gbps. So, for example, if you provision IPsec connections on the gateway, you can only provision to an aggregate bandwidth (incoming + outgoing) as 5 Gbps.

If using the gateway for both IPsec and GRE connectivity, you can provision maximum 5 Gbps of IPsec throughput or maximum 15 Gbps of GRE throughput. So, for example, if you provision 2 Gbps of IPsec throughput, you have 3 Gbps of IPsec throughput left to provision on the gateway or 9 Gbps of GRE throughput left.

To put this in more mathematical terms:

- Total capacity of the gateway = 25 Gbps

- Total available IPsec capacity = 5 Gbps (fixed)

- Total available GRE capacity = 15 Gbps (fixed)

- IPsec throughput ratio for this gateway = 25/5 = 5 Gbps

- GRE throughput ratio for this gateway = 25/15 = 5/3 Gbps

For example, if you allocate 2 Gbps of IPsec throughput to a customer:

Remaining available capacity on the gateway = Total capacity of the gateway – IPsec throughput ratio*IPsec throughput allocated (used capacity)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;25–5*2 = 15 Gbps

Remaining IPsec throughput that you can allocate on the gateway 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5-2 = 3 Gbps

Remaining GRE throughput that you can allocate on the gateway = Remaining
capacity of gateway/GRE throughput ratio 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15*3/5 = 9 Gbps

The throughput ratio varies depending on the total capacity of the gateway. One thing to note is that you should set the total capacity to the TCP bandwidth available to the gateway VM. If you have multiple VMs hosted on the
gateway, you must adjust the total capacity of the gateway accordingly.

Also, if the gateway capacity is less than the total available tunnel capacity, the total available tunnel capacity is set to the gateway capacity. For example, if you set the gateway capacity to 4 Gbps, the total available capacity for
IPsec, L3, and GRE is set to 4 Gbps, leaving the throughput ratio for each tunnel to 1 Gbps.

## Windows Server 2016 behavior

The gateway capacity calculation algorithm for Windows Server 2016 remains unchanged. In Windows Server 2016, Maximum IPsec tunnel bandwidth was limited to (3/20)\*gateway capacity on a gateway. The equivalent ratios for GRE and L3
tunnels were 1/5 and 1/2, respectively.

If you are upgrading from Windows Server 2016 to Windows Server 2019:

1.  **GRE and L3 tunnels:** The Windows Server 2019 allocation logic takes effect once Network Controller nodes get updated to Windows Server 2019

2.  **IPSec tunnels:** The Windows Server 2016 gateway allocation logic continues to function until all the gateways in the gateway pool get upgraded to Windows Server 2019. For all gateways in the gateway pool, you must set the Azure gateway service to **Automatic**.

>[!NOTE]
>It is possible that after upgrading to Windows Server 2019, a gateway becomes over-provisioned (as the allocation logic changes from Windows Server 2016 to Windows Server 2019). In this case, the existing connections on the gateway continue to exist. The REST resource for the Gateway throws a warning that the gateway is over-provisioned. In this case, you should move some connections to another gateway.

---