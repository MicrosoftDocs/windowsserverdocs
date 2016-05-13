---
title: Deploy SMB Direct with Ethernet (iWARP) Network Adapters
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad08f159-9433-4a27-81ab-02b8c030939a
---
# Deploy SMB Direct with Ethernet (iWARP) Network Adapters
This topic explains how to deploy SMB Direct with an Ethernet \(iWARP\) network adapter.

## Overview
When you deploy SMB Direct with an RDMA\-capable network adapter, the network adapter functions at full speed with very low latency, while using very little CPU. You can use the Ethernet \(iWARP\) series of networks adapters to take full advantage of the capabilities of SMB Direct.

**Hardware and software requirements**

Use the following requirements to implement and test this deployment:

-   Two or more computers running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]

-   For each server running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], use one or more iWARP network adapters

-   One or more 10 gigabit or 40 gigabit Ethernet switches

-   Two or more network cables as required for the iWARP network adapters that you select. These are typically enhanced small form\-factor pluggable \(SFP\+\) connectors for 10 gigabit Ethernet switches, and QSPF connectors for 40 gigabit Ethernet switches.

For detailed information about the iWARP network adapters that support SMB Direct, see the following blog post: [Deploying Windows Server 2012 with SMB Direct \(SMB over RDMA\) and the Chelsio T4 Cards Using iWARP – Step\-by\-Step](http://blogs.technet.com/b/josebda/archive/2012/07/31/deploying-windows-server-2012-with-smb-direct-smb-over-rdma-and-the-chelsio-t4-cards-using-iwarp-step-by-step.aspx).

**Download and update the latest drivers**

Although [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] might include drivers for the network adapter, you should always verify that you have the latest version of the driver from the manufacturer of the network adapter. Follow the manufacturer's installation instructions to install the driver.

## <a name="BKMK_IWARP_configIP"></a>Configure the IP addresses
After you have the latest version of the drivers installed, you should configure the IP address for the network adapters. If you are using DHCP, network adapters are automatically configured, and you can move ahead to the following section.

To assign an IP address to your network adapter, you can use either **IP Address Management**  or the Net TCP\/IP cmdlets in Windows PowerShell. For more information, see [Net TCP\/IP Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh826123.aspx).

The following Windows PowerShell example shows how to assign an IP address to a network adapter called `RDMA1`, with an IP address of `192.168.1.10`, a default gateway at `192.168.1.1`, and a DNS server at `192.168.1.2`.

```
Set-NetIPInterface -InterfaceAlias RDMA1 -DHCP Disabled 
Remove-NetIPAddress -InterfaceAlias RDMA1 -AddressFamily IPv4 -Confirm:$false 
New-NetIPAddress -InterfaceAlias RDMA1 -IPAddress 192.168.1.10 -PrefixLength 24 -Type Unicast -DefaultGateway 192.168.1.1
Set-DnsClientServerAddress -InterfaceAlias RDMA1 -ServerAddresses 192.168.1.2
```

## <a name="BKMK_config_firewall"></a>Configure Windows Firewall
Because iWARP uses TCP\/IP to communicate, you need to configure Windows Firewall to allow TCP\/IP traffic. Basically, you need to configure a firewall rule for the SMB server that allows incoming traffic from the SMB Direct clients. In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], when SMB Direct is used with iWARP, it uses TCP port 5445, in addition to TCP port 445, which is used for SMB.

The following example shows how to configure the firewall rule by using Windows PowerShell. To allow access by the clients on the SMB server, type the following in Windows PowerShell:

```
Enable-NetFirewallRule FPSSMBD-iWARP-In-TCP
```

You should note that FPSSMBD\-iWARP\-In\-TCP is preconfigured for [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], and it allows incoming traffic on port 5445. You should enable it only with iWARP network adapters that have the appropriate drivers for use with SMB Direct. If you have multiple SMB servers, you need to enable this firewall rule on every server that uses SMB Direct with iWARP.

## <a name="BKMK_cross_subnets"></a>Allow access across multiple subnets
One key advantage of iWARP RDMA\-capable network adapters is their ability to be routed across different subnets. Although the most common configuration is a single subnet deployment, you can use iWARP network adapters to connect computers across subnets. In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], this capability is disabled by default because it is not always required.

To enable **Network Direct** support, and therefore SMB Direct, you need to configure all SMB servers and SMB clients to allow RDMA to be routed across subnets. To do this, type the following in Windows PowerShell:

```
Set-NetOffloadGlobalSetting -NetworkDirectAcrossIPSubnets Allow 
Disable-NetAdapter -InterfaceAlias RDMA1 
Enable-NetAdapter -InterfaceAlias RDMA1
```

> [!NOTE]
> If you disable and then re\-enable the network adapter, the settings take effect without requiring you to restart the server.

We recommend that you apply the previous settings before you create any file shares. If you apply the settings \(or make any other major network configuration changes\) after you create a file share, the SMB client re\-evaluates its connections when the new network adapters are detected \(or every 10 minutes\). You can also configure SMB to immediately update its connections by typing the following in Windows PowerShell on the SMB clients:

```
Update-SmbMultichannelConnection
```

## <a name="BKMK_verify_config"></a>Verify the configuration
You should use the following information to verify that the configuration is working correctly.

### Verify the network adapter configuration
You can use the Net TCP\/IP cmdlets in Windows PowerShell to verify that **Network Direct** is globally enabled and that you have RDMA\-capable network adapters. In Windows PowerShell, type the following on both the SMB server and the SMB client:

```
Get-NetOffloadGlobalSetting | Select NetworkDirect 
Get-NetAdapterRDMA
Get-NetAdapterHardwareInfo
```

### Verify the SMB configuration
You can use the SMB Share cmdlets in Windows PowerShell to verify that SMB Multichannel is enabled, that the network adapters are properly recognized by SMB, and that the RDMA capability of the network adapters is properly identified. For more information, see [SMB Share Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj635726.aspx).

On the SMB client, type the following in Windows PowerShell:

```
Get-SmbClientConfiguration | Select EnableMultichannel 
Get-SmbClientNetworkInterface
```

On the SMB server, type the following in Windows PowerShell:

```
Get-SmbServerConfiguration | Select EnableMultichannel 
Get-SmbServerNetworkInterface 
netstat.exe -xan | ? {$_ -match "445"}
```

> [!NOTE]
> The **Netstat** command confirms if the file server is listening on the RDMA\-capable network adapters.

### Verify the SMB connection
To verify that the SMB connection is working, on the SMB client, start an ongoing file copy to create a lasting session with the SMB server. While the file copy is ongoing, use the SMB Share cmdlets in Windows PowerShell to verify that the connection is using the correct SMB dialect and that SMB Direct is working. To do this, type the following in Windows PowerShell:

```
Get-SmbConnection 
Get-SmbMultichannelConnection 
netstat.exe -xan | ? {$_ -match "445"}
```

> [!NOTE]
> You must run the script above while a workload is running on that specific client. If you have no activity while the script is running, the script might return nothing. This is because your SMB session has expired, and there are no current connections.

## <a name="BKMK_SMBperfcounters"></a>Review the performance counters
There are several performance counters that you can use to verify that the RDMA\-capable network adapters are being used and that the SMB Direct connections are being established. You can also use the specific performance counters for the SMB server and the SMB client to verify the performance of SMB, including:

-   I\/O processors \(to verify data requests per second\)

-   Latency \(to verify average seconds per request\)

-   Throughput \(to verify data bytes per second\)

Following is a list of the relevant performance counters.

For SMB client:

-   **RDMA activity**: One instance for each RDMA network adapter.

-   **SMB Direct connection**: One instance for each SMB Direct connection.

-   **SMB client shares**: One instance for each SMB file share that the client is currently using.

For SMB server:

-   **RDMA activity**: One instance for each RDMA network adapter.

-   **SMB Direct connection**: One instance for each SMB Direct connection.

-   **SMB server shares**: One instance for each SMB file share that the server is currently sharing.

-   **SMB server session**: One instance for each client SMB session that is established with the server.

## <a name="BKMK_eventsRDMA"></a>Review the event logs for RDMA network adapters
You can use several events in the Windows event log to verify that the RDMA\-capable network adapters are operational, and the SMB Direct connections are accessible.

To view all events associated with the RDMA\-capable network adapters, type the following in Windows PowerShell:

```
Get-WinEvent -ListLog "*SMB*" | Get-WinEvent | ? Message -like "*RDMA*" | FL LogName, Id, TimeCreated, Level, Message
```

To view only the critical events associated with the RDMA\-capable network adapters, type the following in Windows PowerShell:

```
Get-WinEvent -ListLog "*SMB*" | Get-WinEvent | ? { $_.Level -lt 4 -and $_. Message -like "*RDMA*" } | FL LogName, Id, TimeCreated, Level, Message
```

## See also

-   [Improve Performance of a File Server with SMB Direct](Improve-Performance-of-a-File-Server-with-SMB-Direct.md)

-   [Deploy SMB Direct with InfiniBand Network Adapters](Deploy-SMB-Direct-with-InfiniBand-Network-Adapters.md)

-   [Deploy SMB Direct with RoCE Network Adapters](Deploy-SMB-Direct-with-RoCE-Network-Adapters.md)

-   [Server Message Block Overview](Server-Message-Block-Overview.md)

-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)

-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)


