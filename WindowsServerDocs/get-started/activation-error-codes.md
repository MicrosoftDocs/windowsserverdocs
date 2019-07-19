---
title: Troubleshooting Activation Error Codes
description: Learn how to troubleshoot activation error codes
ms.topic: troubleshooting
ms.date: 03/21/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: kaushika-msft
ms.author: kaushika-msft; v-tea
ms.localizationpriority: medium
---

# Troubleshooting Activation Error Codes

> **Home users**  
> This article is intended for use by support agents and IT professionals. If you're looking for more information about Windows activation error messages, see [Get help with Windows activation errors](https://support.microsoft.com/help/10738/windows-10-get-help-with-activation-errors).  

This article provides troubleshooting information to help you respond to error messages that you may receive when you try to use a Multiple Activation Key (MAK) or the Key Management Service (KMS) to perform Volume Activation on one or more Windows-based computers. Look for the error code in the following table, and then select the link to see more information about that error code and how to resolve it.

**Error codes and descriptions**

|Error code |Error message |Activation type |
|-----------|--------------|----------------|
|[0xC004C001](#0xc004c001-the-activation-server-determined-the-specified-product-key-is-invalid) |The activation server determined the specified product key is invalid |MAK|
|[0xC004C003](#0xc004c003-the-activation-server-determined-the-specified-product-key-is-blocked) |The activation server determined the specified product key is blocked |MAK |
|[0xC004C008](#0xc004c008-the-activation-server-determined-that-the-specified-product-key-could-not-be-used) |The activation server determined that the specified product key could not be used. |KMS |
|[0xC004B100](#0xc004b100-the-activation-server-determined-that-the-computer-could-not-be-activated) |The activation server determined that the computer could not be activated. |MAK |
|[0xC004C020](#0xc004c020-the-activation-server-reported-that-the-multiple-activation-key-has-exceeded-its-limit) |The activation server reported that the Multiple Activation Key has exceeded its limit. |MAK |
|[0xC004C021](#0xc004c021-the-activation-server-reported-that-the-multiple-activation-key-extension-limit-has-been-exceeded) |The activation server reported that the Multiple Activation Key extension limit has been exceeded. |MAK |
|[0xC004F009](#0xc004f009-the-software-protection-service-reported-that-the-grace-period-expired) |The Software Protection Service reported that the grace period expired. |MAK |
|[0xC004F00F](#0xc004f00f-the-software-licensing-server-reported-that-the-hardware-id-binding-is-beyond-level-of-tolerance) |The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance. |MAK/KMS client/KMS host |
|[0xC004F014](#0xc004f014-the-software-protection-service-reported-that-the-product-key-is-not-available) |The Software Protection Service reported that the product key is not available |MAK/KMS client |
|[0xC004F02C](#0xc004f02c-the-software-protection-service-reported-that-the-format-for-the-offline-activation-data-is-incorrect) |The Software Protection Service reported that the format for the offline activation data is incorrect. |MAK/KMS client |
|[0xC004F035](#0xc004f035-invalid-volume-license-key) |This error code equates to “The Software Protection Service reported that the computer could not be activated with a Volume license product key...” The error text is correct, but is ambiguous. This error indicates that the computer is missing a Windows marker in the BIOS – provided on OEM systems to indicate computers shipping with qualifying editions of Windows, which is a requirement for KMS client activation. Error: Invalid Volume License Key In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source. ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW. |KMS client/KMS host |
|[0xC004F038](#0xc004f038-the-count-reported-by-your-key-management-service-kms-is-insufficient) |The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator. |KMS client |
|[0xC004F039](#0xc004f039-the-key-management-service-kms-is-not-enabled) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled. |KMS client |
|[0xC004F041](#0xc004f041-the-software-protection-service-determined-that-the-key-management-server-kms-is-not-activated) |The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.  |KMS client |
|[0xC004F042](#0xc004f042-the-software-protection-service-determined-that-the-specified-key-management-service-kms-cannot-be-used) |The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used. |KMS client |
|[0xC004F050](#0xc004f050-the-software-protection-service-reported-that-the-product-key-is-invalid) |The Software Protection Service reported that the product key is invalid. |KMS, KMS client, MAK |
|[0xC004F051](#0xc004f051-the-software-protection-service-reported-that-the-product-key-is-blocked) |The Software Protection Service reported that the product key is blocked. |MAK/KMS |
|[0xC004F064](#0xc004f064-the-software-protection-service-reported-that-the-non-genuine-grace-period-expired) |The Software Protection Service reported that the non-genuine grace period expired. |MAK |
|[0xC004F065](#0xc004f065-the-software-protection-service-reported-that-the-application-is-running-within-the-valid-non-genuine-period) |The Software Protection Service reported that the application is running within the valid non-genuine period. |MAK/KMS client |
|[0xC004F06C](#0xc004f06c-the-request-timestamp-is-invalid) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.  |KMS client |
|[0x80070005](#0x80070005-access-denied) |Access denied. The requested action requires elevated privileges. |KMS client/MAK/KMS host |
|[0x8007232A](#0x8007232a-dns-server-failure) |DNS server failure.  |KMS host  |
|[0x8007232B](#0x8007232b-dns-name-does-not-exist) |DNS name does not exist. |KMS client |
|[0x800706BA](#0x800706ba-the-rpc-server-is-unavailable) |The RPC server is unavailable. |KMS client |
|[0x8007251D](#0x8007251d-no-records-found-for-dns-query) |No records found for DNS query. |KMS client |
|[0xC004F074](#0xc004f074-no-key-management-service-kms-could-be-contacted) |The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.  |KMS Client |
|[0x8004FE21](#0x8004fe21-this-computer-is-not-running-genuine-windows) |This computer is not running genuine Windows.  |MAK/KMS client |
|[0x80092328](#0x80092328-dns-name-does-not-exist) |0x80092328 DNS name does not exist.  |KMS client |
|[0x8007007b](#0x8007007b-dns-name-does-not-exist) |0x8007007b DNS name does not exist. |KMS client |
|[0x80070490](#0x80070490-the-product-key-you-entered-didnt-work) |The product key you entered didn't work. Check the product key and try again, or enter a different one. |MAK |

## 0xC004C001 The activation server determined the specified product key is invalid

### Possible cause

The MAK that you entered was not valid.

### Resolution

Verify that the key is the MAK provided by Microsoft. For additional assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004C003 The activation server determined the specified product key is blocked

### Possible cause

The MAK is blocked on the activation server.

### Resolution

To obtain a new MAK, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers). After you obtain a new MAK, try installing and activating Windows again.  

## 0xC004C008 The activation server determined that the specified product key could not be used

### Possible cause

The KMS key has exceeded its activation limit. A KMS host key activates up to 10 times, on up to six different computers.  

### Resolution

If you need additional activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).  

## 0xC004B100 The activation server determined that the computer could not be activated

### Possible cause

The MAK is not supported.  

### Resolution

To troubleshoot this issue, verify that the MAK that you are using is the MAK that was provided by Microsoft. To verify that the MAK is valid, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004C020 The activation server reported that the Multiple Activation Key has exceeded its limit

### Possible cause

The MAK has exceeded its activation limit. By design, MAKs activate a limited number of times.

### Resolution

If you need additional activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004C021 The activation server reported that the Multiple Activation Key extension limit has been exceeded

### Possible cause

The MAK has exceeded its activation limit. By design, MAKs activate a limited number of times.

### Resolution

If you need additional activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004F009 The Software Protection Service reported that the grace period expired

### Possible cause

The grace period expired before the system was activated. Now, the system is in the Notifications state.  

### Resolution

See the section “User Experience.”  For assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004F00F The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance

### Possible cause

The hardware has changed or the drivers were updated on the system.  

### Resolution

If you are using MAK activation, use either online or phone activation to reactivate the system during the OOT grace period.  

If you are using KMS activation, restart Windows or run **slmgr.vbs /ato**.

## 0xC004F014 The Software Protection Service reported that the product key is not available

### Possible cause

No product keys are installed on the system.  

### Resolution

If you are using MAK activation, install a MAK product key, 

If you are using KMS activation, check the pid.txt file (located on the installation media in the \sources folder) for a KMS Setup key. Install the key.

## 0xC004F02C The Software Protection Service reported that the format for the offline activation data is incorrect

### Possible cause

The system has detected that the data entered during phone activation is not valid.  

### Resolution

Verify that the CID is correctly entered.  

## 0xC004F035 Invalid Volume License Key

The full text of this error resembles the following:

> Error: Invalid Volume License Key. In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source. ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW.  

### Possible cause

Windows 7 Volume editions are only licensed for upgrade. Microsoft does not support installing a Volume operating system on a computer that does not have a qualifying operating system installed.  

This error code equates to “The Software Protection Service reported that the computer could not be activated with a Volume license product key...” The error text is correct, but is ambiguous. This error indicates that the computer is missing a Windows marker in the BIOS. This marker appears on OEM systems to indicate computers that ship with qualifying editions of Windows. The marker is required for KMS client activation.  

### Resolution

Install a qualifying version of a Microsoft operating system, and then activate by using a MAK.  

## 0xC004F038 The count reported by your Key Management Service (KMS) is insufficient

The full text of this error resembles the following:

> The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.  

### Possible cause

The count on the KMS host is not high enough. For Windows Server, the KMS count must be greater than or equal to 5. For Windows (client), the KMS count must be greater than or equal to 25.  

### Resolution
Before you can use KMS to activate Windows, you need more computers in the KMS pool. To obtain the current count on the KMS host, run **Slmgr.vbs /dli**.  

## 0xC004F039 The Key Management Service (KMS) is not enabled

The full text of this error resembles the following:

> The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled.  

### Possible cause

KMS did not respond to the KMS request.

### Resolution

Troubleshoot the network connection between the KMS host and the client. Make sure that TCP port 1688 (default) is not blocked by a firewall or otherwise filtered.  

## 0xC004F041 The Software Protection Service determined that the Key Management Server (KMS) is not activated

The full text of this error resembles the following:

> The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.  

### Possible cause

The KMS host is not activated.  

### Resolution

Activate the KMS host by using either online or phone activation.  

## 0xC004F042 The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used

### Possible cause

This error occurs when the KMS client contacted KMS host that could not activate the client software. This can be common in mixed environments that contain application- and operating system-specific KMS hosts, for example.  

### Resolution

Make sure that if you use specific KMS hosts to activate specific applications or operating systems, the KMS clients connect to the correct hosts.

## 0xC004F050 The Software Protection Service reported that the product key is invalid

### Possible cause

This can be caused by a typo in the KMS key or by typing in a Beta key on a Released version of the operating system.  

### Resolution

Install the appropriate KMS key on the corresponding version of Windows. Check the spelling. If the key is being copied and pasted, make sure that em-dashes have not been substituted for the dashes in the key.  

## 0xC004F051 The Software Protection Service reported that the product key is blocked

### Possible cause

The activation server determined that Microsoft has blocked the product key.  

### Resolution

Obtain a new MAK/KMS key, install it on the system, and activate.

## 0xC004F064 The Software Protection Service reported that the non-genuine grace period expired

### Possible cause

Windows Activation Tools (WAT) has determined the system is not genuine.  

### Resolution

For assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/en-us/Licensing/existing-customer/activation-centers).

## 0xC004F065 The Software Protection Service reported that the application is running within the valid non-genuine period

### Possible cause

Windows Activation Tools has determined that the system is not genuine. The system will continue to run during the Non-Genuine grace period.  

### Resolution

Obtain and install a genuine product key, and activate the system during the grace period. Otherwise, the system will go into the Notifications state at the end of the grace period.

## 0xC004F06C The request timestamp is invalid

The full text of this error resembles the following:

> The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.  

### Possible cause

The system time on the client computer is too different from the time on the KMS host. Time sync is important to system and network security for a variety of reasons.  

### Resolution

Fix this issue by changing the system time on the client to sync with the KMS host. We recommend that you use a Network Time Protocol (NTP) time source or Active Directory Domain Services for time synchronization. This issue uses UTP time and does not depend on Time Zone selection.  

## 0x80070005 Access denied

The full text of this error resembles the following:

> Access denied. The requested action requires elevated privileges.

### Possible cause

User Account Control (UAC) prohibits activation processes from running in a non-elevated command prompt.  

### Resolution

Run **slmgr.vbs** from an elevated command prompt. To do this, on the **Start menu**, right-click **cmd.exe**, and then select **Run as administrator**.  

## 0x8007232A DNS server failure

### Possible cause

The system has network or DNS issues.

### Resolution

Troubleshoot network and DNS.  

## 0x8007232B DNS name does not exist

### Possible cause

The KMS client cannot find KMS server resource records (SRV RRs) in DNS.  

### Resolution

Confirm that a KMS host has been installed and DNS publishing is enabled (default). If DNS is unavailable, point the KMS client to the KMS host by using **slmgr.vbs /skms <*kms_host_name*>**.  

If you do not have a KMS host, obtain and install a MAK. Then activate the system. 

If these approaches to don resolve the problem, troubleshoot DNS.  

## 0x800706BA The RPC server is unavailable

### Possible cause

Firewall settings are not configured on the KMS host, or DNS SRV records are stale.  

### Resolution

On the KMS host, make sure that a firewall exception is enabled for the Key Management Service.

Make sure that the DNS SRV records point to a valid KMS host. 

Troubleshoot network connections.  

## 0x8007251D No records found for DNS query

### Possible cause

The KMS client cannot find KMS SRV records in DNS.  

### Resolution

Troubleshoot network connections and DNS.  

## 0xC004F074 No Key Management Service (KMS) could be contacted

The full text of this error resembles the following:

> The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.  

### Possible cause

All of the KMS host systems returned an error.  

### Resolution

In the Application Event Log, identify each event that has Event ID 12288 and is associated with the activation attempt. Troubleshoot the errors from these events.

## 0x8004FE21 This computer is not running genuine Windows  

### Possible cause

This issue may occur for several reasons. The most likely reason is that language packs (MUI) have been installed on computers that are running Windows editions that are not licensed for additional language packs.  

> [!NOTE]
> This issue is not necessarily an indication of tampering. Some applications can install multi-lingual support even when that edition of Windows is not licensed for those language packs.)  

This issue may also occur if Windows has been modified by malware to allow additional features to be installed. This issue may also occur if certain system files are corrupted.  

### Resolution

To resolve this issue, you must reinstall the operating system.  

## 0x80092328 DNS name does not exist

### Possible cause

This issue may occur if the KMS client cannot find the KMS SRV resource records in DNS. 

### Resolution

To work around this issue, follow the steps in [KB929712, Error message when you try to activate Windows Vista Enterprise, Windows Vista Business, Windows 7, or Windows Server 2008: "Code 0x8007232b](https://support.microsoft.com/en-us/help/929712/volume-activation-information-for-windows-vista-windows-server-2008-wi).  

## 0x8007007b DNS name does not exist

### Possible cause

This issue may occur if the KMS client cannot find the KMS SRV resource records in DNS.  

### Resolution

To work around this issue, follow the steps in [KB929712, Error message when you try to activate Windows Vista Enterprise, Windows Vista Business, Windows 7, or Windows Server 2008: "Code 0x8007232b](https://support.microsoft.com/en-us/help/929712/volume-activation-information-for-windows-vista-windows-server-2008-wi).  

## 0x80070490 The product key you entered didn't work

The full text of this error resembles the following:
> The product key you entered didn't work. Check the product key and try again, or enter a different one.  

### Possible cause

This issue occurs because the MAK that was entered was not valid, or because of a known issue in Windows Server 2019.  

### Resolution

To work around this issue and activate the computer, run **slmgr -ipk <5x5 key>** at an elevated command prompt.  

## Appendix: Common troubleshooting procedures

- [Method 1: Change the product key to an MAK](#method-1-change-the-product-key-to-an-mak)
- [Method 2: Configure a KMS host server for the clients to activate against](#method-2-configure-a-kms-host-server-for-the-clients-to-activate-against)
- [Method 3: Manually create a KMS SRV record](#method-3-manually-create-a-kms-srv-record)
- [Method 4: Manually assign a KMS server](#method-4-manually-assign-a-kms-server)
- [Method 5: Automatically publish KMS in multiple DNS domains](#method-5-automatically-publish-kms-in-multiple-dns-domains)

### Method 1: Change the product key to an MAK

If KMS activation will not be used, and if there is no KMS server, the product key should be changed to an MAK. For Microsoft Developer Network (MSDN), or for TechNet, the stock-keeping units (SKUs) that are listed below the media are generally volume licensed-media, and the product key that's provided is an MAK key.

To change the product key to an MAK, follow these steps:

1. Open an elevated command prompt. To do this, press the Windows logo key+X, and then right-click&nbsp;<strong class="uiterm">Command Prompt</strong>, and then select <strong>Run as administrator</strong>. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. At the command prompt, run the following command:
   ```cmd
    slmgr -ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
   ```
   > [!NOTE]
   > The **xxxxx-xxxxx-xxxxx-xxxxx-xxxxx** placeholder represents your MAK product key.  

### Method 2: Configure a KMS host server for the clients to activate against

KMS activation requires that a KMS host server be configured for the clients to activate against. If there are no KMS host servers configured in your environment, install and activate one by using an appropriate KMS host server key. After you configure a computer on the network to host the KMS software, publish the Domain Name System (DNS) settings.

For information about the KMS host server configuration process, see [Activate using Key Managment Service](https://docs.microsoft.com/windows/deployment/volume-activation/activate-using-key-management-service-vamt).

For more information about volume activation, see [Plan for volume activation](https://docs.microsoft.com/en-us/windows/deployment/volume-activation/plan-for-volume-activation-client).

### Method 3: Manually create a KMS SRV record

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756) in case problems occur.

If your network has a KMS host computer set up, and if the client cannot locate a KMS host on the network for activation, follow these steps:

1. Verify that the computer that has the KMS host installed and is activated by using a KMS key that&#39;s registered in DNS. To do this, follow these steps:  
   1. Open an elevated command prompt. To do this, press the Windows logo key+X, and then right-click **Command Prompt**, and then select **Run as administrator**. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
   1. At the command prompt, run the following command:
      ```cmd
      nslookup -type=all _vlmcs._tcp&gt;kms.txt
      ```
   1. Open the KMS.txt file that the command generates. This file should contain one or more entries that resemble the following entry:
      ```cmd
      _vlmcs._tcp.contoso.com         SRV service location:          priority   = 0          weight   = 0         port   = 1688         svr hostname   = kms-server.contoso.com 
      ```
   1. If these **_vlmcs** entries are present, and if they contain the expected KMS host names, go to [Method 4: Manually assign a KMS server](#method-4-manually-assign-a-kms-server).
1. Check the registry of the KMS host server to determine whether it is registering with DNS. By default, a KMS host server dynamically registers a DNS SRV record one time every 24 hours. To check this setting, follow these steps:
   1. Start Registry Editor. To do this, right-click **Start**, select **Run**, type **regedit**, and then press Enter.
   1. Locate the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SL** subkey, and check the value of the **DisableDnsPublishing** entry. This entry has the following possible values:
      - **0** or undefined (default): The KMS host server registers a SRV record once every 24 hours.
      - **1**: The KMS host server does not automatically register SRV records. If your implementation does not support dynamic updates, see [To manually create a SRV record for a KMS host](#to-manually-create-a-srv-record-for-a-kms-host).  
      If the **DisableDnsPublishing** entry is missing, create it (the type is DWORD). If dynamic registration is acceptable, leave the value undefined or set it to **0**.

#### To manually create a SRV record for a KMS host

To manually create a&nbsp;SRV record for a KMS host that uses a Microsoft DNS server, follow these steps:

1. On the DNS server, open DNS Manager. To open DNS Manager, select **Start**, select **Administrative Tools**, and then select **DNS**.
1. Select the DNS server on which you have to create the SRV resource record.
1. In the console tree, expand **Forward Lookup Zones**, right-click the domain, and then select **Other New Records**.
1. Scroll down the list, select **Service Location (SRV)**, and then select **Create Record**.
1. Type the following information:
   - Service: **_VLMCS**
   - Protocol: **_TCP**
   - Port number: **1688**
   - Host offering the service: **&lt;*FQDN of the KMS host*</em>*&gt;**
1. When you are finished, select **OK**, and then select **Done**.

To manually create a SRV record for a KMS host that uses a BIND 9.x-compliant DNS server, follow the instructions for that DNS server and provide the following information for the SRV record:

- Name:&nbsp;**_vlmcs._TCP**
- Type:&nbsp;**SRV**
- Priority: **0**
- Weight: **0**
- Port: **1688**
- Hostname: **&lt;*FQDN or A-Name of the KMS host*&gt;**

> [!NOTE]
> KMS does not use the **Priority** or **Weight** values. However, the record must include them.

To configure a BIND 9.x-compatible DNS server to support KMS auto-publishing, configure the DNS server to enable resource record updates from KMS hosts. For example, add the following line to the zone definition in Named.conf or in Named.conf.local:

```cmd
allow-update { any; };
```
### Method 4: Manually assign a KMS server



### Method 5: Automatically publish KMS in multiple DNS domains


