---
title: Networking
description: This topic provides an overview of the Software Defined Networking and Network Platform technologies that are available in Windows Server 2016.
ms.prod: windows-server-threshold
layout: LandingPage
ms.technology: networking
ms.topic: landing-page
ms.assetid: daaf6b61-5953-4c2d-b6b8-7c885b552646
manager: dougkim
ms.author: pashort
author: shortpatti
ms.localizationpriority: medium
---

# Networking

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<HR />

Networking is a foundational part of the Software Defined Datacenter \(SDDC\) platform, and Windows Server 2016 provides new and improved Software Defined Networking \(SDN\) technologies to help you move to a fully realized SDDC solution for your organization.

When you manage networks as a software defined resource, you can describe an application’s infrastructure requirements one time, and then choose where the application runs - on premises or in the cloud. 

This consistency means that your applications are now easier to scale, and you can seamlessly run applications - anywhere - with equal confidence about security, performance, quality of service, and availability.

<HR />

<ul class="cardsF panelContent">
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-whats-new.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h2><a href="../networking/What-s-New-in-Networking.md">What&#39;s new in Networking</a></h2>
                                        </div>
                                    </div>
                                </div>
                             </div>
                          </a>
                        </li>
                     </ul>
<HR />

<h2>Software Defined Networking</h2>

<ul class="cardsF panelContent">
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="https://docs.microsoft.com/windows-server/networking/sdn/">Software Defined Networking (SDN)</a><hr /></h3>You can use this topic to learn about the SDN technologies that are provided in Windows Server, System Center, and Microsoft Azure.</p>
                        
                                        <p><b>Note:</b> For Hyper-V hosts and virtual machines (VMs) that run SDN infrastructure servers, such as Network Controller and Software Load Balancing nodes, you must install Windows Server Datacenter edition. For Hyper-V hosts that contain only tenant workload VMs that are connected to SDN-controlled networks, you can run Windows Server Standard edition.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/deploy/Deploy-a-Software-Defined-Network-infrastructure-using-scripts.md">Deploy a Software Defined Network infrastructure using scripts</a><hr /></h3>This guide provides instructions on how to deploy Network Controller with virtual networks and gateways in a test lab environment.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/network-controller/Network-Controller.md">Network Controller</a><hr /></h3>Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/network-function-virtualization/software-load-balancing-for-sdn.md">Software Load Balancing &#40;SLB&#41; for SDN</a><hr /></h3>Cloud Service Providers (CSPs) and Enterprises that are deploying Software Defined Networking (SDN) in Windows Server 2016 can use Software Load Balancing (SLB) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/network-function-virtualization/RAS-Gateway-for-SDN.md">RAS Gateway for SDN</a><hr /></h3>RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in Windows Server 2016, is designed for Cloud Service Providers (CSPs) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/network-function-virtualization/Network-Function-Virtualization.md">Network Function Virtualization</a><hr /></h3>In software defined datacenters, network functions that are being performed by hardware appliances (such as load balancers, firewalls, routers, switches, and so on) are increasingly being virtualized as virtual appliances. This &quot;network function virtualization&quot; is a natural progression of server virtualization and network virtualization.</p>                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/network-function-virtualization/Datacenter-Firewall-Overview.md">Datacenter Firewall Overview</a><hr /></h3>Datacenter Firewall is a network layer, 5-tuple (protocol, source and destination port numbers, source and destination IP addresses), stateful, multitenant firewall.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
</ul>

<HR />

## <a name="bkmk_networking"></a>Networking Technologies

<ul class="cardsF panelContent">
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="branchcache/BranchCache.md">BranchCache</a><hr /></h3>
                                        <p>BranchCache is a wide area network (WAN) bandwidth optimization technology. To optimize WAN bandwidth when users access content on remote servers, BranchCache fetches content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="core-network-guide/core-network-guide-windows-server.md">Core Network Guide</a><hr /></h3>
                                        <p>Learn how to deploy a Windows Server network with the Core Network Guide, as well as add features to your network deployment with Core Network Companion Guides.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="../remote/remote-access/directaccess/DirectAccess.md">DirectAccess</a><hr /></h3>
                                        <p>DirectAccess allows connectivity for remote users to organization network resources. </p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="dns/dns-top.md">Domain Name System (DNS)&quot;&gt;</a><hr /></h3>
                                        <p>Domain Name System (DNS) is one of the industry-standard suite of protocols that comprise TCP/IP, and together the DNS Client and DNS Server provide computer name-to-IP address mapping name resolution services to computers and users.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/dhcp/dhcp-top.md">Dynamic Host Configuration Protocol &#40;DHCP&#41;</a><hr /></h3>
                                        <p>Dynamic Host Configuration Protocol (DHCP) is a client/server protocol that automatically provides an Internet Protocol (IP) host with its IP address and other related configuration information, such as the subnet mask and default gateway.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="sdn/technologies/hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md">Hyper-V Network Virtualization</a><hr /></h3>
                                        <p>Hyper-V Network Virtualization (HNV) enables virtualization of customer networks on top of a shared physical network infrastructure.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md">Hyper-V Virtual Switch</a><hr /></h3>
                                        <p>The Hyper-V Virtual Switch is a software-based layer-2 Ethernet network switch that is available in Hyper-V Manager when you install the Hyper-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. In addition, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels. </p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/ipam/ipam-top.md">IP Address Management &#40;IPAM&#41;</a><hr /></h3>
                                        <p>IP Address Management (IPAM) is an integrated suite of tools to enable end-to-end planning, deploying, managing and monitoring of your IP address infrastructure, with a rich user experience. IPAM automatically discovers IP address infrastructure servers and Domain Name System (DNS) servers on your network and enables you to manage them from a central interface. </p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/Network-Load-Balancing.md">Network Load Balancing</a><hr /></h3>
                                        <p>Network Load Balancing (NLB) distributes traffic across several servers using the TCP/IP networking protocol. For non-SDN deployments, NLB ensures that stateless applications, such as Web servers running Internet Information Services (IIS), are scalable by adding more servers as the load increases.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/hpn/hpn-top.md">High-Performance Networking</a><hr /></h3>
                                        <p>Network offload and optimization technologies in Windows Server 2016 include Software Only (SO) features and technologies, Software and Hardware (SH) integrated features and technologies, and Hardware Only (HO) features and technologies.</p>

                                        <p>The following offload and optimization technology documentation is also available:<p>
                                        <hr />
                                        <a href="technologies/conv-nic/cnic-top.md">High-Performance Networking</a><hr />
                                        <a href="technologies/dcb/dcb-top.md">Data Center Bridging (DCB)</a><hr />
                                        <a href="technologies/vrss/vrss-top.md">Virtual Receive Side Scaling (vRSS)</a>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/nps/nps-top.md">Network Policy Server</a><hr /></h3>
                                        <p>
                                        Network Policy Server (NPS) allows you to create and enforce organization-wide network access policies for connection request authentication and authorization.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/netsh/netsh.md">Network Shell (Netsh)</a><hr /></h3>
                                        <p>
                                        You can use the Network Shell (netsh) networking utility to manage networking technologies in Windows Server 2016 and Windows 10.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/network-subsystem/net-sub-performance-top.md">Network Subsystem Performance Tuning</a><hr /></h3>
                                        <p>
                                        This topic provides information about choosing the right network adapter for your server workload, ordering network interfaces, network related performance counters, and performance tuning network adapters and related networking technologies, such as Receive Side Scaling (RSS), Receive Side Coalescing (RSC), and others.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/nic-teaming/NIC-Teaming.md">NIC Teaming</a><hr /></h3>
                                        <p>
                                        NIC Teaming allows you to group physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/qos/qos-policy-top.md">Quality of Service (QoS) Policy</a><hr /></h3>
                                        <p>
                                        You can use QoS Policy as a central point of network bandwidth management across your entire Active Directory infrastructure by creating QoS profiles, whose settings are distributed with Group Policy.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="technologies/wins/wins-top.md">Windows Internet Name Service (WINS)</a><hr /></h3>
                                        <p>
                                        Windows Internet Name Service (WINS) is a legacy computer name registration and resolution service that maps computer NetBIOS names to IP addresses. Using DNS is recommended over using WINS.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="../remote/remote-access/remote-access.md">Remote Access</a><hr /></h3>
                                        <p>
                                        You can use Remote Access technologies, such as DirectAccess and Virtual Private Networking (VPN) to provide remote workers with connectivity to internal network resources. In addition, you can use Remote Access for local area network (LAN) routing, and for Web Application Proxy. which provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network.</p>

                                        <p>For more information about Web Application Proxy, which is a role service of the Remote Access server role, see <a href="https://docs.microsoft.com/windows-server/remote/remote-access/web-application-proxy/web-application-proxy-windows-server">Web Application Proxy in Windows Server 2016</a></p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="https://docs.microsoft.com/virtualization/windowscontainers/container-networking/architecture">Windows Container Networking</a><hr /></h3>
                                        <p>
                                        Windows Container Networking allows you to create and manage networks for connecting container endpoints on both Windows 10 and Windows Server hosts by using standard industry tools and workflows. Windows container networks support multiple topologies, including private, flat-L2, and routed-L3.</p>

                                        <p>Also supported are overlays that you can create locally on the host by using Docker, Kubernetes, or Windows PowerShell through plugins that communicate with the Windows Host Networking Service (HNS). You can create and manage multi-node cluster networks through higher level orchestration systems by communicating through a local agent to each node’s HNS.</p>
                    </div>
                </div>
            </div>
        </div>
    </li>
<HR />
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-network.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3><a href="../remote/remote-access/vpn/vpn-top.md">Virtual Private Networking (VPN)</a><hr /></h3>
                                        <p>
                                        DirectAccess and VPN is a role service of the Remote Accessserver role.</p>

                                        <p>When you install Remote Access as a VPN server, you can use Virtual Private Networking (VPN) to provide your remote employees with connections to your organization network across the Internet - while also maintaining information privacy with encrypted connections.</p>

                                       <p> With Windows Server Remote Access VPN - and Windows 10 client computers - you can deploy Always On VPN. Always On VPN gives you the ability to manage remote VPN clients that are always connected, while also providing convenience for remote workers, who no longer need to manually connect to and disconnect from VPN to your organization network.</p>

                                       <p>For more information, see <a href="https://docs.microsoft.com/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy">Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10</a></p>
                    </div>
                </div>
            </div>
        </div>
    </li>
</ul>

## Additional Resources

Networking resources for operating systems earlier than Windows Server 2016 are available at the following locations.

- Windows Server 2012 and Windows Server 2012 R2 [Networking Overview](https://technet.microsoft.com/library/hh831357.aspx)
- Windows Server 2008 and Windows Server 2008 R2 [Networking](https://technet.microsoft.com/library/cc753940)
- Windows Server 2003 [Windows Server 2003/2003 R2 Retired Content](https://www.microsoft.com/download/details.aspx?id=53314)
