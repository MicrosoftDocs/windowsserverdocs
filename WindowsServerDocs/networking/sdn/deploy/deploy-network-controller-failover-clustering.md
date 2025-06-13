---
title: Deploy Network Controller with Failover Clustering on Windows Server and Azure Local
description: Learn how to deploy Network Controller with Failover Clustering using SDN Express on Windows Server and Azure Local.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 12/06/2024
zone_pivot_groups: windows-os
#CustomerIntent: As a network administrator, I want to deploy Network Controller works with Failover Clustering so that I can create my tenant network configurations.
---

# Deploy Network Controller with Failover Clustering

Beginning with Windows Server 2025 and Azure Local 2311.2, Network Controller (NC) can now be deployed directly as a Failover Clustering service. In this article you learn about the prerequisites required, installing the SDN Express PowerShell module, and how to deploy Network Controller with Failover Clustering. To learn more about how it works with Software Load Balancer and Gateways, and how it differs from Network Controller on Service Fabric, see [Network Controller with Failover Clustering](../technologies/network-controller/network-controller-failover-clustering.md).

## Prerequisites

Before you can deploy Network Controller with Failover Clustering, you must complete the following prerequisites.

:::zone pivot="windows-server"

- You have a failover cluster with at least two nodes running Windows Server 2025 or later.

- (Optional) If you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster, create bootable a VHDX with the Windows Server 2025 image for use later in this article. To learn more about creating a bootable VHDX, follow steps 1 and 2 in [Boot to a virtual hard disk: Add a VHDX or VHD to the boot menu](/windows-hardware/manufacture/desktop/boot-to-vhd--native-boot--add-a-virtual-hard-disk-to-the-boot-menu).

:::zone-end

:::zone pivot="azure-local"

- You have a failover cluster with at least two nodes running Azure Local 2311.2 or later.

- (Optional) If you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster, download the Azure Local VHDX image for use later in this article. To learn more about downloading the VHDX, see [/azure/azure-local/deploy/download-23h2-software](Download Azure Local software).

:::zone-end

- You have shared storage available for the failover cluster. We recommend using Cluster Storage Space or S2D. To learn more about the available storage architectures, see [Physical storage architectures for Hyper-V](../../../virtualization/hyper-v/hyper-v-storage-architecture.md).

- All cluster nodes must have Hyper-V enabled.

- All cluster nodes must have the Network Controller server role installed. This must include the Remote Server Administration Tools (RSAT).

    > [!IMPORTANT]
    > You must restart each node after installing the Network Controller server role before you can proceed with the deployment.

- All cluster nodes must be joined to Active Directory.

- A virtual switch must be created on each cluster node.

- The physical network must be configured for the subnets and VLANs that you intend to use and must be consistent across all cluster nodes.

- If you're planning to use Windows Admin Center to deploy Network Controller with Failover Clustering, you must have Windows Admin Center version 2410 or later. You also need to the Windows Admin Center SDN extension installed and updated to 3.6.0 or later.

- (Optional) If you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster, you must have a location to store the VHDX and configuration files. The location must be reachable from the node on which the SDN Express script is run.

## Deployment

To deploy Network Controller with Failover Clustering, select your preferred deployment method.

### [Windows Admin Center](#tab/windows-admin-center)

To deploy Network Controller with Failover Clustering using Windows Admin Center, follow these steps:

1. Sign into Windows Admin Center as an administrator.

1. In Windows Admin Center, under **All connections** select the cluster that you want to manage, then select **Connect**.

1. In the **Cluster Manager** view, from the **Tools** pane on the left, select **SDN Infrastructure**.

1. Select **Get started** to begin the deployment process.

1. On the **Infrastructure type** tab, Select **Native SDN**, then select **Next: Cluster settings**.

1. On the **Cluster settings** tab, provide the following information, then select **Next: Deploy**:

   | Parameter name | Value |
   |--|--|
   | **Host** | |
   | Network Controller REST Name | DNS name used by management clients (such as Windows Admin Center) to communicate with NC |
   | Network Controller REST IP Address/subnet | Static IP address for your REST API, which is allocated from your management network. It can be used for DNS resolution or REST IP-based deployments. The IP address must use the IP CIDR notation as a way to represent the IP address and it's network prefix. For example, The IP address `10.10.10.10` with a subnet mask of `255.255.255.0` would be write as `10.10.10.10/25`. |
   | VLAN ID | VLAN ID for the management network |
   | **Credentials** | |
   | Username | Administrator username. The username should be in the following format: `domainname\username`. For example, if the domain is `contoso.com`, enter the username as `contoso\<username>`. Don't use formats like `contoso.com\<username>` or `username@contoso.com` |
   | Password | Password for administrator account |
   | **Advanced** | |
   | Database path | File path to the FCNC database. This file path can be any SMB share, but we recommend using either CSV or S2D |
   | MAC address pool start | Beginning MAC pool address for client workload VMs |
   | MAC address pool end | End MAC pool address for client workload VMs |

1. Once you enter configuration details, you are taken to the deployment page. Review the progress of the deployment, when complete, select **Finish**.

You can now begin to deploy and manage your tenant networks.

### [PowerShell](#tab/powershell)

### Install SDN Express

To deploy Network Controller with Failover Clustering using PowerShell, you must first install the SDN Express script. The SDN Express script is a PowerShell script that automates the deployment of the Software Defined Networking (SDN) infrastructure. To install SDN express, follow these steps:

1. Sign on to the first cluster node as an administrator.

1. Open an elevated PowerShell session.

1. Run the following command to download the SDN Express script:

    ```powershell
    Install-Module -Name SDNExpress
    ```

1. Confirm the file `SDNExpress.ps1` can found by running the following command.

    ```powershell
    cd $env:PROGRAMFILES\WindowsPowerShell\Modules\SdnExpress
    ```

1. If your command ran successfully, you should see a directory with the current version of the SDN Express module. Check the version number is 1.1.231 or later by running the following command:

You're now ready to begin configuring your configuration files.

### Prepare SDN Express configuration files

The SDN Express script requires a configuration file to deploy Network Controller with Failover Clustering. The configuration file is a PSD1 file that contains the variables for your Network Controller deployment. To create the configuration file, follow these steps:

The PowerShell `Sample - Virtualized Networks Native SDN.psd1` configuration data file (located in the previously mentioned install path) contains all the parameters and settings that are needed for the SDN Express script as input for the various parameters and configuration settings. This file has specific information about what needs to be filled out. The information required depends on whether you're deploying only the network controller component, or the software load balancer and gateway components as well. For detailed information, see [Plan a Software Defined Network infrastructure](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure).

1. Navigate to the **C:\Program Files\WindowsPowerShell\Modules\SdnExpress** folder and open the **Sample - Virtualized Networks Native SDN.psd1** file in a text editor.

1. Change specific general parameter values to fit your infrastructure and deployment, as described in the following table.

   These settings and parameters are used by SDN for all deployments. To learn about the configuration options available in more detail, see [SDN infrastructure VM role requirements](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure#sdn-infrastructure-vm-role-requirements).

   | Parameter name         | Value                                                                                                                                                                                                 |
   |------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | **VHDPath**            | Optional, only use this parameter if you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster. VHD file path used by all SDN infrastructure VMs (NC, SLB, GW)                                                                                                                                               |
   | **VHDFile**            | Optional, only use this parameter if you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster. VHDX file name used by all SDN infrastructure VMs                                                                                                                                                            |
   | **VMLocation**         | Optional, only use this parameter if you intend to deploy the Software Load Balancer and Gateway Services as VMs using Failover Cluster. File path to SDN infrastructure VMs. Universal Naming Convention (UNC) paths aren't supported. For cluster storage-based paths, use a format like `C:\ClusterStorage\...`                           |
   | **JoinDomain**         | Domain to which SDN infrastructure VMs are joined to                                                                                                                                                         |
   | **SDNMacPoolStart**    | Beginning MAC pool address for client workload VMs                                                                                                                                                           |
   | **SDNMacPoolEnd**      | End MAC pool address for client workload VMs                                                                                                                                                                 |
   | **ManagementSubnet**   | Management network subnet used by NC to manage Hyper-V hosts, SLB, and GW components                                                                                                                          |
   | **ManagementGateway**  | Gateway address for the management network                                                                                                                                                                   |
   | **ManagementDNS**      | DNS server for the management network                                                                                                                                                                        |
   | **ManagementVLANID**   | VLAN ID for the management network                                                                                                                                                                           |
   | **DomainJoinUsername** | Administrator username. The username should be in the following format: `domainname\username`. For example, if the domain is `contoso.com`, enter the username as `contoso\<username>`. Don't use formats like `contoso.com\<username>` or `username@contoso.com` |
   | **LocalAdminDomainUser** | Local administrator username. The username should be in the following format: `domainname\username`. For example, if the domain is `contoso.com`, enter the username as `contoso\<username>`. Don't use formats like `contoso.com\<username>` or `username@contoso.com` |
   | **RestName**           | DNS name used by management clients (such as Windows Admin Center) to communicate with NC                                                                                                                     |
   | **RestIpAddress**      | Static IP address for your REST API, which is allocated from your management network. It can be used for DNS resolution or REST IP-based deployments. The IP address must be allocated from your management network.                                                          |
   | **HyperVHosts**        | Host servers to be managed with Network Controller                                                                                                                                                             |
   | **NCUsername**         | Network Controller account username                                                                                                                                                                          |
   | **ProductKey**         | Product key for SDN infrastructure VMs                                                                                                                                                                       |
   | **SwitchName**         | Only required if more than one virtual switch exists on the Hyper-V hosts                                                                                                                                     |
   | **VMMemory**           | Memory (in GB) assigned to infrastructure VMs. Default is 4 GB                                                                                                                                               |
   | **VMProcessorCount**   | Number of processors assigned to infrastructure VMs. Default is 8                                                                                                                                            |
   | **Locale**             | If not specified, locale of deployment computer is used                                                                                                                                                      |
   | **TimeZone**           | If not specified, local time zone of deployment computer is used                                                                                                                                             |

1. Fill the Network Controller on Failover Cluster parameters using the following table as a guide.

   | Parameter name   | Value                                                                                                     |
   |------------------|-----------------------------------------------------------------------------------------------------------|
   | **UseFCNC**      | Set to `1` to enable Failover Clustering Network Controller (FCNC)                                        |
   | **FCNCBin**      | Path to the FCNC binary used by SDN to deploy the SDN NC Service. We recommend storing your FCNC binaries on a Cluster Storage Space and S2D location. However, you can also use any external share between cluster nodes if necessary.                                          |
   | **FCNCDBs**      | File path to the FCNC database. This file path can be any SMB share, but we recommend using either CSV or S2D. |
   | **UseCertBySubject** | Leave this value set to `1` to use a certificate by subject name. |

You're now ready to deploy Network Controller with Failover Clustering.

### Deploy Network Controller with Failover Clustering using SDN Express

To deploy Network Controller with Failover Clustering, follow these steps:

1. Open an elevated PowerShell session from the first cluster node.

1. Prepare a variable to store your credentials by running the following command.

    ```powershell
    $credential = Get-Credential
    ```

1. Deploy SDN using the configuration file by running the following commands. Replace the `<version>` placeholder with the version number of the SDN Express module and the `<pathtoconfigfile>` placeholder with the path to the configuration file.

    ```powershell
    cd $env:PROGRAMFILES\WindowsPowerShell\Modules\SdnExpress\<version>

    .\SDNExpress.ps1 -ConfigurationDataFile <pathtoconfigfile> -DomainJoinCredential $credential -NCCredential $credential -LocalAdminCredential $credential -verbose
    ```

    > [!TIP]
    > If you want to use specific credentials for the domain join, Network Controller, or local administrator, you'll need to store the credentials in separate variables and pass them to the relevant parameters in the **Sample - Virtualized Networks Native SDN.psd1** script.

You can now begin to deploy and manage your tenant networks.

---

## Related content

- [Network Controller with Failover Clustering](../technologies/network-controller/network-controller-failover-clustering.md)
