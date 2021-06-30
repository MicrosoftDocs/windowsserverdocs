---
title: SMB Compression
description: Describes the SMB compression feature in Windows Server 2022, Windows Insider Dev Channel client 
ms.product: windows-server
ms.topic: article
author: NedPyle
ms.author: inhenkel
ms.date: 06/25/2021
ms.localizationpriority: medium
---

# SMB compression (PREVIEW)

> Applies to: Windows Server 2022, Windows Insider Dev Channel preview client

SMB compression allows an administrator, user, or application to request compression of files as they transfer over the network. This removes the need to first manually deflate a file with an application, copy it, then inflate on the destination computer. Compressed files will consume less network bandwidth and take less time to transfer, at the cost of slightly increased CPU usage during transfers. SMB compression is most effective on networks with less bandwidth, such as a client's 1Gbps ethernet or Wi-Fi network; a file transfer over an uncongested 100Gbps ethernet network between two servers with flash storage may be just as fast without SMB compression in practice, but will still create less congestion for other applications.

SMB compression in Windows has the following characteristics

- Supports compression algorithms XPRESS (LZ77), XPRESS Huffman (LZ77+Huffman), LZNT1, or PATTERN_V1*. XPRESS is used automatically
- Supports SMB signing and SMB encryption
- Supports SMB over QUIC
- Supports SMB Multichannel
- Doesn't support SMB Direct over RDMA

For a demonstration of SMB compression, watch this video:

> [!VIDEO https://www.youtube.com/embed/zpMS6w33H7U]

## Requirements

To use SMB compression in a traditional client-file server workload, you need the following:

- A file server running Windows Server 2022 [on-premises](https://aka.ms/WS2022Preview) or [in Azure](https://aka.ms/ws2022azurepreview)
- A Windows Insider Dev Channel client - ([Windows Insider Dev Channel Preview Downloads](https://www.microsoft.com/software-download/windowsinsiderpreviewiso))
- Windows Admin Center - ([Homepage](https://aka.ms/windowsadmincenter))

## Configuring SMB compression

You can configure SMB compression from both a client and server perspective. Client and server don't refer to a particular edition like Windows Server 2022 or Windows Insider Dev Channel but instead to the architecture of a file transfer between two computers. Both Windows Server 2022 and Windows Insider Dev Channel support being a client or server of SMB compression.

### Requesting SMB compression on file shares

You can configure shares to always request compression when connected to by clients. You can use Windows Admin Center or PowerShell.

#### Using Windows Admin Center

1. Install Windows Admin Center and connect to a Windows Server 2022 file server.
1. Click on the **Files and File Sharing** menu item.
1. Click on **File Sharing**.
1. Edit an existing share or create a new share.
1. Select **Compress data** and then click **Add** or **Edit**

:::image type="content" source="./media/smb-compression/fileservercompress.png" alt-text="file server compression":::

#### Using PowerShell

1. Open an elevated PowerShell command prompt as an administrator.
1. Create a new share with compression using `New-SMBShare` with the `-CompressData $true` parameter and argument. For example:

    `New-SmbShare -Name "Sales" -Path "C:\sales" -CompressData $true`

1. Edit an existing share with compression using `Set-SMBShare` with the `-CompressData $true` parameter and argument. For example:

   `Set-SmbShare -Name "Sales" -CompressData $true`

### Requesting SMB compression on mapped drives

You can request that all data copied over a mapped drive to be compressed. This can be done as part of a logon script or when run manually.

#### Using PowerShell

1. Open a PowerShell command prompt
1. Map a drive using `New-SMBMapping` with the `-CompressNetworkTraffic $true` parameter and argument. For example:

    `New-SmbMapping -LocalPath "Z:" -RemotePath "\\fs1.corp.contoso.com\sales" -CompressNetworkTraffic $true`

#### Using NET USE

1. Open a CMD prompt.
1. Map a drive using `NET USE` with the `/REQUESTCOMPRESSION:YES` parameter and argument. For example:

    `NET USE * \\fs1.corp.contoso.com\sales /REQUESTCOMPRESSION:YES`

### Requesting SMB compression with copy tools

You can request that SMB compression is attempted for particular files using robocopy or xcopy.

> [!NOTE]
> If you want File Explorer, third party copy tools, or applications to use compression, map drives with compression, enable compression on shares, or set SMB clients to always compress.

#### Using Robocopy.exe

1. Open a CMD prompt or PowerShell command prompt
1. Copy with the /COMPRESS flag. For example:

    `ROBOCOPY c:\hypervdisks \\hypervcluster21.corp.contoso.com\disks$ *.vhdx /COMPRESS`  

#### Using Xcopy.exe

1. Open a CMD prompt or PowerShell command prompt
1. Copy with the /COMPRESS flag. For example:

    `XCOPY c:\hypervdisks\*.vhdx \\hypervcluster21.corp.contoso.com\disks$\* /COMPRESS`  

### Always require or always reject compression requests

You can configure an SMB client to always request compression and to always reject requests for compression. You can configure an SMB server to always reject requests for compression.

#### Always compress

1. On SMB client computer, start Regedit.exe.
1. Navigate to the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation`

1. Create a new REG_DWORD value name:

    `EnableCompressedTraffic`

1. Set to a value of:

    `1`

1. Close regedit. This setting takes effect immediately, no reboot is required.

#### Never compress (SMB client)

1. Open an elevated PowerShell command prompt as an administrator.
1. Ignore all requests for compression from any mapped drive, tool, or server with:

    `Set-SMbClientConfiguration -DisableCompression $true`

     This sets

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation`

    `DisableCompression [dword] = 1`

#### Never compress (SMB server)

1. On SMB server computer, start Regedit.exe.
1. Navigate to the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer`

1. Create a new REG_DWORD value name:

    `DisableCompression`

1. Set to a value of:

    `1`

1. Close regedit. This setting takes effect immediately, no reboot is required.

## Understanding and controlling compression behaviors

SMB compression in Windows Server 2022 preview and Windows Insider Dev Channel clients uses a default algorithm where it attempts to compress the first 524,288,000 bytes (500MiB) of a file during transfer and tracks that at least 104,857,600 bytes (100MiB) compressed within that 500-MB range. If fewer than 100 MiB is compressible, SMB compression stops trying to compress the rest of the file. If at least 100 MiB compresses, SMB compression attempts to compress the rest of the file. This means that very large files with compressible data - for instance, a multi-gigabyte virtual machine disk - are likely to compress but a relatively small file - even a very compressible one - will not compress.

> [!NOTE]
> This behavior will not remain the default in non-Preview Windows Server 2022 and Windows.

If you want SMB compression to aggressively compress no matter what the file size is, you can override the defaults:

1. On SMB client computer, start Regedit.exe.
1. Navigate to the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation`

1. Create a new REG_DWORD value name:

    `CompressibilitySamplingSize`

1. Set to a decimal value of:

    `4294967295`

1. Create a new REG_DWORD value name:

    `CompressibleThreshold`

1. Set to a value of:

    `0`

1. Close regedit. This setting takes effect immediately, no reboot is required.

These settings mean that SMB compression will try to compress the first 4 GiB of a file and if it compresses at least 1 byte, it will attempt to compress the rest of the file.

## Testing SMB compression

### Testing

A simple way to test your compression configuration is using VHDX files. You can create and mount a VHDX, add some files to it, then dismount the VHDX and copy it as a file. Alternatively, you can just copy an existing dismounted virtual machine VHDX file, as much of its file contents will compress. For an example of creating a VHDX test file:

1. Start Diskmgmt.msc.
1. Select **Local Disk (C:)** by clicking on it.
1. Click **Action** then **Create VHD**.
1. In Diskmgmt, right-click your VHDX now shown as "Not initialized" and click **Initialize disk** and click **OK**. Right-click the "unallocated" disk area and click **New simple volume**.
1. Specify a file path, set the size to "25 GB", select **VHDX** and **Fixed Size**, then click **OK**. Right-click on the disks "Unallocated" section and click **New Simple Volume**, then **Next** for all menu prompts, then click **Finish**.

   :::image type="content" source="./media/smb-compression/diskmgmt.png" alt-text="disk management":::

1. Right-click on the disk and click **Detach VHD**, then click **OK**.
1. In File Explorer, double-click that VHDX file to mount it. Copy a few MB of uncompressible files, such as JPG format, then right-click the mounted disk and click **Eject**.

You now have a large test file with very compressible contents.

Testing SMB compression between a pair of VMs running on the same Hyper-V host may not show time savings because the virtual switch is 10Gbps and has no congestion, plus modern hypervisors often use flash storage. Test your compression over the real networks you plan to use. You can also reduce the network bandwidth on Hyper-V VMs for testing purposes using [Set-VMNetworkAdapter](/powershell/module/hyper-v/set-vmnetworkadapter) with `-MaximumBandwidth` set to `1Gb`, for example.

To see how well compression is working, you can robocopy the same file to a server twice, once with the `/compress` flag and again without compression, deleting the server file between each test. If the file is compressing, you should see less network utilization in Task Manager and a lower copy time. You can also observe the SMB server's Performance Monitor object "SMB Server Shares" for its "Compressed requests/sec" and "Compressed receives/sec" counters.
