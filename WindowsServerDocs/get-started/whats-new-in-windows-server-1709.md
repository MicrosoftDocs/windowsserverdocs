---
title: What's New in Windows Server, version 1709
description: "What are the new features in compute, identity, management, automation, networking, security, storage."
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
ms.localizationpriority: medium
ms.date: 06/03/2019
---
# What's New in Windows Server version 1709

>Applies To: Windows Server (Semi-Annual Channel)

<img src="../media/landing-icons/new.png" style='float:left; padding:.5em;' alt="Icon showing a newspaper">&nbsp;To learn about the latest features in Windows, see [What's New in Windows Server](whats-new-in-windows-server.md). The content in this section describes what's new and changed in Windows Server, version 1709. The new features and changes listed here are the ones most likely to have the greatest impact as you work with this release. Also see [Windows Server, version 1709](https://blogs.technet.microsoft.com/windowsserver/2017/08/24/sneak-peek-1-windows-server-version-1709/).

> [!IMPORTANT]
> Windows Server, version 1709 is out of support as of April 9, 2019.


## New cadence of releases

Starting with this release, you have two options for receiving Windows Server feature updates:
- **Long-Term Servicing Channel (LTSC)**: This is business as usual with 5 years of mainstream support and 5 years of extended support. You have the option to upgrade to the next LTSC release every 2-3 years in the same way that has been supported for the last 20 years.
- **Semi-Annual Channel (SAC)**: This is a Software Assurance benefit and is fully supported in production. The difference is that it is supported for 18 months and there will be a new version every six months.

Release channels are summarized in the following table.

|   | Semi-Annual Channel | Long Term Servicing Channel |
| ------------- | ------------- | ------------ |
| Release cadence  | Twice a year (spring and fall)  | Every 2-3 years |
| Support schedule  | 18 months mainstream production support  | 5 years mainstream support + 5 years extended support |
| Availability  | Software Assurance or Azure (cloud hosted)  | All channels |
| Naming convention  | Windows Server, version YYMM  | Windows Server YYYY |

For more information, see [Comparison of servicing channels](https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview).

## Application containers and micro-services

- The Server Core container image has been further optimized for lift-and-shift scenarios where you can migrate existing code bases or applications into containers with minimal changes, and it’s also 60% smaller. 
- The Nano Server container image is nearly 80% smaller.
    - In the Windows Server Semi-Annual Channel, Nano Server as a container base OS image is decreased from 390 MB to 80 MB.
- Linux containers with Hyper-V isolation 

For more information, see [Changes to Nano Server in the next release of Windows Server](https://docs.microsoft.com/windows-server/get-started/nano-in-semi-annual-channel) and [Windows Server, version 1709 for developers](https://blogs.technet.microsoft.com/windowsserver/2017/09/13/sneak-peek-3-windows-server-version-1709-for-developers/).

## Modern management

Check out [Project Honolulu](https://docs.microsoft.com/windows-server/manage/honolulu/honolulu) for a simplified, integrated, secure experience to help IT administrators manage core troubleshooting, configuration, and maintenance scenarios.  Project Honolulu includes next generation tooling with a simplified, integrated, secure, and extensible interface.
Project Honolulu includes an intuitive all-new management experience for managing PCs, Windows servers, Failover Clusters, as well as hyper-converged infrastructure based on Storage Spaces Direct, reducing operational costs.

## Compute

**Nano Container and Server Core Container**: First and foremost, this release is about driving application innovation. Nano Server, or Nano as Host is deprecated and replaced by Nano Container, which is Nano running as a container image. 

For more information about containers, see [Container Networking Overview](https://docs.microsoft.com/windows-server/networking/sdn/technologies/containers/container-networking-overview).

**Server Core as a container** (and infrastructure) host, provides better flexibility, density and performance for existing applications under a modernization process and brands new apps developed already using the cloud model.

**VM Start Ordering** is also improved with OS and Application awareness, bringing enhanced triggers for when a VM is considered started before starting the next.

**Storage-class memory support for VMs** enables NTFS-formatted direct access volumes to be created on non-volatile DIMMs and exposed to Hyper-V VMs. This enables Hyper-V VMs to leverage the low-latency performance benefits of storage-class memory devices.

**Virtualized Persistent Memory (vPMEM)** is enabled by creating a VHD file (.vhdpmem) on a direct access volume on a host, adding a vPMEM Controller to a VM, and adding the created device (.vhdpmem) to a VM. Using vhdpmem files on direct access volumes on a host to back vPMEM enables allocation flexibility and leverages a familiar management model for adding disks to VMs.

**Container storage – persistent data volumes on cluster shared volumes (CSV)**. In Windows Server, version 1709 as well as Windows Server 2016 with the latest updates, we’ve added support for containers to access persistent data volumes located on CSVs, including CSVs on Storage Spaces Direct. This gives the application container persistent access to the volume no matter which cluster node the container instance is running on. For more info, see [Container Storage Support with Cluster Shared Volumes (CSV), Storage Spaces Direct (S2D), SMB Global Mapping](https://blogs.msdn.microsoft.com/clustering/2017/08/10/container-storage-support-with-cluster-shared-volumes-csv-storage-spaces-direct-s2d-smb-global-mapping/).

**Container storage – persistent data volumes with SMB global mapping**. In Windows Server, version 1709 we’ve added support for mapping an SMB file share to a drive letter inside a container – this is called SMB global mapping. This mapped drive is then accessible to all users on the local server so that container I/O on the data volume can go through the mounted drive to the underlying file share. For more info, see [Container Storage Support with Cluster Shared Volumes (CSV), Storage Spaces Direct (S2D), SMB Global Mapping](https://blogs.msdn.microsoft.com/clustering/2017/08/10/container-storage-support-with-cluster-shared-volumes-csv-storage-spaces-direct-s2d-smb-global-mapping/).

**Virtual machine configuration file format (updated)**. An additional file (.vmgs) has been added for virtual machines with a configuration version of 8.2 and higher. VMGS stands for VM guest state and is a new internal file which includes device state that was previously part of the VM runtime state file.

## Security and Assurance

**Network encryption** enables you to quickly encrypt network segments on software-defined networking infrastructure to meet security and compliance needs.

**Host Guardian Service (HGS)** as a shielded VM is enabled. Prior to this release, the recommendation was to deploy a 3-node physical cluster. While this ensures the HGS environment is not compromised by an administrator, it was often cost prohibitive.

**Linux as a shielded VM** is now supported.

For more information, see [Guarded fabric and shielded VMs overview](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms).

**SMBLoris vulnerability**
An issue, known as “SMBLoris”, which could result in denial of service, has been addressed.

## Storage

**Storage Replica**: The disaster recovery protection added by Storage Replica in Windows Server 2016 is now expanded to include:
- **Test failover**: the option to mount the destination storage is now possible through the test failover feature. You can mount a snapshot of the replicated storage on destination nodes temporarily for testing or backup purposes.  For more information, see [Frequently Asked Questions about Storage Replica](https://aka.ms/srfaq). 
- **Project Honolulu support**: Support for graphical management of server to server replication is now available in Project Honolulu. This removes the requirement to use PowerShell to manage a common disaster protection workload.

**SMB**: 
- **SMB1 and guest authentication removal**: Windows Server, version 1709 no longer installs the SMB1 client and server by default. Additionally, the ability to authenticate as a guest in SMB2 and later is off by default. For more information, review [SMBv1 is not installed by default in Windows 10, version 1709 and Windows Server, version 1709](https://support.microsoft.com/help/4034314/smbv1-is-not-installed-by-default-in-windows-10-rs3-and-windows-server). 

- **SMB2/SMB3 security and compatibility**: Additional options for security and application compatibility were added, including the ability to disable oplocks in SMB2+ for legacy applications, as well as require signing or encryption on per-connection basis from a client. For more information, review the SMBShare PowerShell module help.

**Data Deduplication**: 
- **Data Deduplication now supports ReFS**: You no longer must choose between the advantages of a modern file system with ReFS and the Data Deduplication: now, you can enable Data Deduplication wherever you can enable ReFS. Increase storage efficiency by upwards of 95% with ReFS.
- **DataPort API for optimized ingress/egress to deduplicated volumes**: Developers can now take advantage of the knowledge Data Deduplication has about how to store data efficiently to move data between volumes, servers, and clusters efficiently.

## Remote Desktop Services (RDS)

**RDS is integrated with Azure AD**, so customers can leverage Conditional Access policies, Multifactor Authentication, Integrated authentication with other SaaS Apps using Azure AD, and many more. For more information, see [Integrate Azure AD Domain Services with your RDS deployment](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/rds-azure-adds).

>[!TIP]
>For a sneak peek at other exciting changes coming to RDS, see [Remote Desktop Services: Updates & upcoming innovations](https://blogs.technet.microsoft.com/enterprisemobility/2017/09/20/first-look-at-updates-coming-to-remote-desktop-services/)

## Networking

**Docker's Routing Mesh** is supported. Ingress routing mesh is part of [swarm mode](https://docs.docker.com/engine/swarm/), Docker’s built-in orchestration solution for containers. For more information, see [Docker's routing mesh available with Windows Server version 1709](https://blogs.technet.microsoft.com/virtualization/2017/09/26/dockers-ingress-routing-mesh-available-with-windows-server-version-1709/).

**New features for Docker** are available. For more information, see [Exciting new things for Docker with Windows Server 1709](https://blog.docker.com/2017/09/docker-windows-server-1709/).

**Windows Networking at Parity with Linux for Kubernetes**: Windows is now on par with Linux in terms of networking. Customers can deploy mixed-OS, Kubernetes clusters in any environment including Azure, on-premises, and on 3rd-party cloud stacks with the same network primitives and topologies supported on Linux without the need for any workarounds or switch extensions.

**Core network stack**: Several features of the core network stack are improved. For more information about these features, see [Core Network Stack Features in the Creators Update for Windows 10](https://blogs.technet.microsoft.com/networking/2017/07/13/core-network-stack-features-in-the-creators-update-for-windows-10/).
- **TCP Fast Open (TFO)**: Support for TFO has been added to optimize the TCP 3-way handshake process. TFO establishes a secure TFO cookie in the first connection using a standard 3-way handshake.  Subsequent connections to the same server use the TFO cookie instead of a 3-way handshake to connect with zero round trip time.
- **CUBIC**: Experimental Windows native implementation of CUBIC, a TCP congestion control algorithm is available. The following commands enable or disable CUBIC, respectively.

    ```
    netsh int tcp set supplemental template=internet congestionprovider=cubic
    netsh int tcp set supplemental template=internet congestionprovider=compound
    ```

- **Receive Window Autotuning**: TCP autotuning logic computes the “receive window” parameter of a TCP connection.  High speed and/or long delay connections need this algorithm to achieve good performance characteristics.  In this release, the algorithm is modified to use a step function to converge on the maximum receive window value for a given connection.
- **TCP stats API**: A new API is introduced called SIO_TCP_INFO.  SIO_TCP_INFO allows developers to query rich information on individual TCP connections using a socket option.
- **IPv6**: There are multiple improvements in IPv6 in this release.
  - **RFC 6106** support: RFC 6106 which allows for DNS configuration through router advertisements (RAs). You can use the following command to enable or disable RFC 6106 support:

    ```
    netsh int ipv6 set interface <ifindex> rabaseddnsconfig=<enabled | disabled>
    ```

  - **Flow Labels**: Beginning with the Creators Update, outbound TCP and UDP packets over IPv6 have this field set to a hash of the 5-tuple (Src IP, Dst IP, Src Port, Dst Port).  This will make IPv6 only datacenters doing load balancing or flow classification more efficient. To enable flowlabels:

    ```
    netsh int ipv6 set flowlabel=[disabled|enabled] (enabled by default)
    netsh int ipv6 set global flowlabel=<enabled | disabled>
    ```

  - **ISATAP and 6to4**: As a step towards future deprecation, the Creators Update will have these technologies disabled by default.
- **Dead Gateway Detection (DGD)**: The DGD algorithm automatically transitions connections over to another gateway when the current gateway is unreachable. In this release, the algorithm is improved to periodically re-probe the network environment.
- [Test-NetConnection](https://technet.microsoft.com/itpro/powershell/windows/nettcpip/test-netconnection) is a built-in cmdlet in Windows PowerShell that performs a variety of network diagnostics.  In this release we have enhanced the cmdlet to provide detailed information about both route selection as well as source address selection.

**Software Defined Networking**

- **Virtual Network Encryption** is a new feature that provides the ability for the virtual network traffic to be encrypted between Virtual Machines that communicate with each other within subnets that are marked as "Encryption Enabled". This feature utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt the packets.  DTLS provides protection against eavesdropping, tampering and forgery by anyone with access to the physical network.
 
**Windows 10 VPN**

- **Pre-Logon Infrastructure Tunnels**. By default, Windows 10 VPN does not automatically create Infrastructure Tunnels when users are not logged on to their computer or device. You can configure Windows 10 VPN to automatically create Pre-Logon Infrastructure Tunnels by using the Device Tunnel (prelogon) feature in the VPN profile.
- **Management of Remote Computers and Devices**.  You can manage Windows 10 VPN clients by configuring the Device Tunnel (prelogon) feature in the VPN profile. In addition, you must configure the VPN connection to dynamically register the IP addresses that are assigned to the VPN interface with internal DNS services.
- **Specify Pre-Logon Gateways**. You can specify Pre-Logon Gateways with the Device Tunnel (prelogon) feature in the VPN profile, combined with traffic filters to control which management systems on the corporate network are accessible via the device tunnel.

