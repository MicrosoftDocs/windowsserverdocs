---
title: Key Management Services (KMS) client activation and product keys for Windows Server and Windows
description: Get the product keys needed for setup and activation of Windows Server and other Windows products from a KMS host server.
ms.topic: conceptual
author: dknappettmsft
ms.author: alalve
ms.date: 09/05/2023
ms.prod: windows-server
---

# Key Management Services (KMS) client activation and product keys

To use KMS, you need to have a KMS host available on your local network. Computers that activate with a KMS host need to have a specific product key. This key is sometimes referred to as the KMS client key, but it's formally known as a Microsoft Generic Volume License Key (GVLK). Computers that are running volume licensing editions of Windows Server and Windows client are, by default, KMS clients with no extra configuration needed as the relevant GVLK is already there.

There are some scenarios, however, where you'll need to add the GVLK to the computer you wish to activate against a KMS host, such as:

- Converting a computer from using a Multiple Activation Key (MAK)
- Converting a retail license of Windows to a KMS client
- If the computer was previously a KMS host

> [!IMPORTANT]
> To use the keys listed here (which are GVLKs), you must first have a KMS host available on your local network. If you don't already have a KMS host, please see how to [create a KMS host](kms-create-host.md) to learn more.
>
> If you want to activate Windows without a KMS host available and outside of a volume-activation scenario (for example, you're trying to activate a retail version of Windows client), **these keys will not work**. You will need to use another method of activating Windows, such as using a MAK, or purchasing a retail license. Get help to [find your Windows product key](https://support.microsoft.com/help/10749/windows-product-key) and learn about [genuine versions of Windows](https://support.microsoft.com/help/15087/windows-genuine).

## Install a product key

If you're converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, install the applicable product key (GVLK) from the list below. To install a client product key, open an administrative command prompt on the client, and run the following command and then press `Enter`:

```
slmgr /ipk <product key>
```

For example, to install the product key for Windows Server 2022 Datacenter edition, run the following command and then press `Enter`:

```
slmgr /ipk WX4NM-KYWYW-QJJR4-XV3QB-6VM33
```

## Generic Volume License Keys (GVLK)

In the tables that follow, you'll find the GVLKs for each version and edition of Windows. LTSC is *Long-Term Servicing Channel*, while LTSB is *Long-Term Servicing Branch*.

### Windows Server (LTSC versions)

#### Windows Server 2022

| Operating system edition       | KMS Client Product Key        |
|--------------------------------|-------------------------------|
| Windows Server 2022 Datacenter | WX4NM-KYWYW-QJJR4-XV3QB-6VM33 |
| Windows Server 2022 Datacenter<br/>Azure Edition | NTBV8-9K7Q8-V27C6-M2BTV-KHMXV |
| Windows Server 2022 Standard   | VDYBN-27WPP-V4HQT-9VMD4-VMK7H |

#### Windows Server 2019

| Operating system edition       | KMS Client Product Key        |
|--------------------------------|-------------------------------|
| Windows Server 2019 Datacenter | WMDGN-G9PQG-XVVXX-R3X43-63DFG |
| Windows Server 2019 Standard   | N69G4-B89J2-4G8F4-WWYCC-J464C |
| Windows Server 2019 Essentials | WVDHN-86M7X-466P6-VHXV7-YY726 |

#### Windows Server 2016

| Operating system edition       | KMS Client Product Key        |
|--------------------------------|-------------------------------|
| Windows Server 2016 Datacenter | CB7KF-BWN84-R7R2Y-793K2-8XDDG |
| Windows Server 2016 Standard   | WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY |
| Windows Server 2016 Essentials | JCKRF-N37P4-C2D82-9YXRT-4M63B |

### Windows Server (Semi-Annual Channel versions)

#### Windows Server, versions 20H2, 2004, 1909, 1903, and 1809

| Operating system edition  | KMS Client Product Key        |
|---------------------------|-------------------------------|
| Windows Server Datacenter | 6NMRW-2C8FM-D24W7-TQWMY-CWH2D |
| Windows Server Standard   | N2KJX-J94YW-TQVFB-DG9YT-724CC |

> [!IMPORTANT]
> Windows Server, version 20H2 reached end of service on August 9, 2022 and is no longer receiving security updates. This includes the retirement of Windows Server Semi-Annual Channel (SAC) with no future releases.
>
> Customers using Windows Server SAC should move to **[Azure Stack HCI](/azure-stack/hci/)**. Alternatively, customers may use the Long-Term Servicing Channel of Windows Server.

### Windows 11 and Windows 10 (Semi-Annual Channel versions)

See the [Windows lifecycle fact sheet](https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet) for information about supported versions and end of service dates.

| Operating system edition          | KMS Client Product Key        |
|-----------------------------------|-------------------------------|
| Windows 11 Pro<br/>Windows 10 Pro | W269N-WFGWX-YVC9B-4J6C9-T83GX |
| Windows 11 Pro N<br/>Windows 10 Pro N | MH37W-N47XK-V7XM9-C7227-GCQG9 |
| Windows 11 Pro for Workstations<br/>Windows 10 Pro for Workstations | NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J |
| Windows 11 Pro for Workstations N<br/>Windows 10 Pro for Workstations N | 9FNHH-K3HBT-3W4TD-6383H-6XYWF |
| Windows 11 Pro Education<br/>Windows 10 Pro Education | 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y |
| Windows 11 Pro Education N<br/>Windows 10 Pro Education N | YVWGF-BXNMC-HTQYQ-CPQ99-66QFC |
| Windows 11 Education<br/>Windows 10 Education | NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 |
| Windows 11 Education N<br/>Windows 10 Education N | 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ |
| Windows 11 Enterprise<br/>Windows 10 Enterprise | NPPR9-FWDCX-D2C8J-H872K-2YT43 |
| Windows 11 Enterprise N<br/>Windows 10 Enterprise N | DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 |
| Windows 11 Enterprise G<br/>Windows 10 Enterprise G | YYVX9-NTFWV-6MDM3-9PT4T-4M68B |
| Windows 11 Enterprise G N<br/>Windows 10 Enterprise G N | 44RPN-FTY23-9VTTB-MP9BX-T84FV |

### Windows 10 (LTSC/LTSB versions)

#### Windows 10 LTSC 2021 and 2019

| Operating system edition          | KMS Client Product Key        |
|-----------------------------------|-------------------------------|
| Windows 10 Enterprise LTSC 2021<br/>Windows 10 Enterprise LTSC 2019   | M7XTQ-FN8P6-TTKYV-9D4CC-J462D |
| Windows 10 Enterprise N LTSC 2021<br/>Windows 10 Enterprise N LTSC 2019 | 92NFX-8DJQP-P6BBQ-THF9C-7CG2H |

#### Windows 10 LTSB 2016

| Operating system edition          | KMS Client Product Key        |
|-----------------------------------|-------------------------------|
| Windows 10 Enterprise LTSB 2016   | DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ |
| Windows 10 Enterprise N LTSB 2016 | QFFDN-GRT3P-VKWWX-X7T3R-8B639 |

#### Windows 10 LTSB 2015

| Operating system edition          | KMS Client Product Key        |
|-----------------------------------|-------------------------------|
| Windows 10 Enterprise 2015 LTSB   | WNMTR-4C88C-JK8YV-HQ7T2-76DF9 |
| Windows 10 Enterprise 2015 LTSB N | 2F77B-TNFGY-69QQF-B8YKP-D69TJ |

### Earlier versions of Windows Server

#### Windows Server, version 1803

| Operating system edition  | KMS Client Product Key        |
|---------------------------|-------------------------------|
| Windows Server Datacenter | 2HXDN-KRXHB-GPYC7-YCKFJ-7FVDG |
| Windows Server Standard   | PTXN8-JFHJM-4WC78-MPCBR-9W4KR |

#### Windows Server, version 1709

| Operating system edition  | KMS Client Product Key        |
|---------------------------|-------------------------------|
| Windows Server Datacenter | 6Y6KB-N82V8-D8CQV-23MJW-BWTG6 |
| Windows Server Standard   | DPCNP-XQFKJ-BJF7R-FRC8D-GF6G4 |

#### Windows Server 2012 R2

| Operating system edition               | KMS Client Product Key        |
|----------------------------------------|-------------------------------|
| Windows Server 2012 R2 Standard        | D2N9P-3P6X9-2R39C-7RTCD-MDVJX |
| Windows Server 2012 R2 Datacenter      | W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9 |
| Windows Server 2012 R2 Essentials      | KNC87-3J2TX-XB4WP-VCPJV-M4FWM |

#### Windows Server 2012

| Operating system edition                | KMS Client Product Key        |
|-----------------------------------------|-------------------------------|
| Windows Server 2012                     | BN3D2-R7TKB-3YPBD-8DRP2-27GG4 |
| Windows Server 2012 N                   | 8N2M2-HWPGY-7PGT9-HGDD8-GVGGY |
| Windows Server 2012 Single Language     | 2WN2H-YGCQR-KFX6K-CD6TF-84YXQ |
| Windows Server 2012 Country Specific    | 4K36P-JN4VD-GDC6V-KDT89-DYFKP |
| Windows Server 2012 Standard            | XC9B7-NBPP2-83J2H-RHMBY-92BT4 |
| Windows Server 2012 MultiPoint Standard | HM7DN-YVMH3-46JC3-XYTG7-CYQJJ |
| Windows Server 2012 MultiPoint Premium  | XNH6W-2V9GX-RGJ4K-Y8X6F-QGJ2G |
| Windows Server 2012 Datacenter          | 48HP8-DN98B-MYWDG-T2DCC-8W83P |
| Windows Server 2012 Essentials          | HTDQM-NBMMG-KGYDT-2DTKT-J2MPV |

#### Windows Server 2008 R2

| Operating system edition                         | KMS Client Product Key        |
|--------------------------------------------------|-------------------------------|
| Windows Server 2008 R2 Web                       | 6TPJF-RBVHG-WBW2R-86QPH-6RTM4 |
| Windows Server 2008 R2 HPC edition               | TT8MH-CG224-D3D7Q-498W2-9QCTX |
| Windows Server 2008 R2 Standard                  | YC6KT-GKW9T-YTKYR-T4X34-R7VHC |
| Windows Server 2008 R2 Enterprise                | 489J6-VHDMP-X63PK-3K798-CPX3Y |
| Windows Server 2008 R2 Datacenter                | 74YFP-3QFB3-KQT8W-PMXWJ-7M648 |
| Windows Server 2008 R2 for Itanium-based Systems | GT63C-RJFQ3-4GMB6-BRFB9-CB83V |

#### Windows Server 2008

| Operating system edition                       | KMS Client Product Key        |
|------------------------------------------------|-------------------------------|
| Windows Web Server 2008                        | WYR28-R7TFJ-3X2YQ-YCY4H-M249D |
| Windows Server 2008 Standard                   | TM24T-X9RMF-VWXK6-X8JC9-BFGM2 |
| Windows Server 2008 Standard without Hyper-V   | W7VD6-7JFBR-RX26B-YKQ3Y-6FFFJ |
| Windows Server 2008 Enterprise                 | YQGMW-MPWTJ-34KDK-48M3W-X4Q6V |
| Windows Server 2008 Enterprise without Hyper-V | 39BXF-X8Q23-P2WWT-38T2F-G3FPG |
| Windows Server 2008 HPC                        | RCTX3-KWVHP-BR6TB-RB6DM-6X7HP |
| Windows Server 2008 Datacenter                 | 7M67G-PC374-GR742-YH8V4-TCBY3 |
| Windows Server 2008 Datacenter without Hyper-V | 22XQ2-VRXRG-P8D42-K34TD-G3QQC |
| Windows Server 2008 for Itanium-Based Systems  | 4DWFP-JF3DJ-B7DTH-78FJB-PDRHK |

### Earlier versions of Windows

#### Windows 8.1

| Operating system edition | KMS Client Product Key        |
|--------------------------|-------------------------------|
| Windows 8.1 Pro          | GCRJD-8NW9H-F2CDX-CCM8D-9D6T9 |
| Windows 8.1 Pro N        | HMCNV-VVBFX-7HMBH-CTY9B-B4FXY |
| Windows 8.1 Enterprise   | MHF9N-XY6XB-WVXMC-BTDCT-MKKG7 |
| Windows 8.1 Enterprise N | TT4HM-HN7YT-62K67-RGRQJ-JFFXW |

#### Windows 8

| Operating system edition | KMS Client Product Key        |
|--------------------------|-------------------------------|
| Windows 8 Pro            | NG4HW-VH26C-733KW-K6F98-J8CK4 |
| Windows 8 Pro N          | XCVCF-2NXM9-723PB-MHCB7-2RYQQ |
| Windows 8 Enterprise     | 32JNW-9KQ84-P47T8-D8GGY-CWCK7 |
| Windows 8 Enterprise N   | JMNMF-RHW7P-DMY6X-RF3DR-X2BQT |

#### Windows 7

| Operating system edition | KMS Client Product Key        |
|--------------------------|-------------------------------|
| Windows 7 Professional   | FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4 |
| Windows 7 Professional N | MRPKT-YTG23-K7D7T-X2JMM-QY7MG |
| Windows 7 Professional E | W82YF-2Q76Y-63HXB-FGJG9-GF7QX |
| Windows 7 Enterprise     | 33PXH-7Y6KF-2VJC9-XBBR8-HVTHH |
| Windows 7 Enterprise N   | YDRBP-3D83W-TY26F-D46B2-XCKRJ |
| Windows 7 Enterprise E   | C29WB-22CC8-VJ326-GHFJW-H9DH4 |

#### Windows Vista

| Operating system edition | KMS Client Product Key        |
|--------------------------|-------------------------------|
|Windows Vista Business | YFKBB-PQJJV-G996G-VWGXY-2V3X8 |
|Windows Vista Business N | HMBQG-8H2RH-C77VX-27R82-VMQBT |
|Windows Vista Enterprise | VKK3X-68KWM-X2YGT-QR4M6-4BWMV |
|Windows Vista Enterprise N | VTC42-BM838-43QHV-84HX6-XJXKV |
