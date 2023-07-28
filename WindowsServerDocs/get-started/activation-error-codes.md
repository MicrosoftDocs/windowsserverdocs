---
title: Resolve Windows activation error codes
description: Learn how to troubleshoot activation error codes
ms.topic: troubleshooting
ms.date: 9/18/2019
author: kaushika-msft
ms.author: kaushika
ms.custom:
  - CI ID 116803
  - CSSTroubleshoot
manager: dcscontentpm
---

# Resolve Windows activation error codes

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=winact" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common issues related to KMS and MAK activation</span>

<!--No inline markdown, so I'll eventually need to take this out, but is there a better template to include this agent button link?-->

> [!NOTE]
> This article is intended for technical support agents and IT professionals. If you're looking for more information about Windows activation error messages, see [Get help with Windows activation errors](https://support.microsoft.com/help/10738/windows-10-get-help-with-activation-errors).

This article provides troubleshooting information to help you respond to error messages that you may receive when you try to use a Multiple Activation Key (MAK) or the Key Management Service (KMS) to perform Volume Activation on one or more Windows-based computers. Look for the error code in the following tables, then select the link to see more information about that error code and how to resolve it.

For more information about volume activation, see [Plan for volume activation](/windows/deployment/volume-activation/plan-for-volume-activation-client).

For more information about volume activation for current and recent versions of Windows, see [Volume Activation [client]](/windows/deployment/volume-activation/volume-activation-windows-10).

For more information about volume activation for older versions of Windows, see [Volume Activation information for Windows Vista, Windows Server 2008, Windows Server 2008 R2 and Windows 7](https://support.microsoft.com/help/929712/volume-activation-information-for-windows-vista-windows-server-2008-wi).

## Diagnostic tool

> [!NOTE]
> This tool is intended to resolve Windows activation issues on computers that run Enterprise, Professional, or Server editions of Windows.

Microsoft Support and Recovery Assistant (SaRA) simplifies Windows KMS Activation troubleshooting.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-WindowsActivation)

The SaRA tool troubleshoots by attempting to start up Windows. If Windows returns an activation error code, the tool then displays targeted solutions for the following known error codes:

- 0xC004F038
- 0xC004F039
- 0xC004F041
- 0xC004F074
- 0xC004C008
- 0x8007007b
- 0xC004C003
- 0x8007232B

## Summary of error codes

The following table lists known error codes for Windows Activation, and includes links to relevant sections later in this article that can help you resolve related issues.

<!--This article may need to be split in two: one article for error code lists and one article for actual troubleshooting instructions. The article as-is is quite long.-->

|Error code |Error message |Activation type|
|-----------|--------------|----------------|
|[0x8004FE21](#0x8004fe21-this-computer-is-not-running-genuine-windows) |This computer is not running genuine Windows.  |MAK<br />KMS client |
|[0x80070005](#0x80070005-access-denied) |Access denied. The requested action requires elevated privileges. |MAK<br />KMS client<br />KMS host |
|[0x8007007b](#0x8007007b-dns-name-does-not-exist) |0x8007007b DNS name does not exist. |KMS client |
|[0x80070490](#0x80070490-the-product-key-you-entered-didnt-work) |The product key you entered didn't work. Check the product key and try again, or enter a different one. |MAK |
|[0x800706BA](#0x800706ba-the-rpc-server-is-unavailable) |The RPC server is unavailable. |KMS client |
|[0x8007232A](#0x8007232a-dns-server-failure) |DNS server failure.  |KMS host  |
|[0x8007232B](#0x8007232b-dns-name-does-not-exist) |DNS name does not exist. |KMS client |
|[0x8007251D](#0x8007251d-no-records-found-for-dns-query) |No records found for DNS query. |KMS client |
|[0x80092328](#0x80092328-dns-name-does-not-exist) |DNS name does not exist.  |KMS client |
|[0xC004B100](#0xc004b100-the-activation-server-determined-that-the-computer-could-not-be-activated) |The activation server determined that the computer could not be activated. |MAK |
|[0xC004C001](#0xc004c001-the-activation-server-determined-the-specified-product-key-is-invalid) |The activation server determined the specified product key is invalid |MAK|
|[0xC004C003](#0xc004c003-the-activation-server-determined-the-specified-product-key-is-blocked) |The activation server determined the specified product key is blocked |MAK |
|[0xC004C008](#0xc004c008-the-activation-server-determined-that-the-specified-product-key-could-not-be-used) |The activation server determined that the specified product key could not be used. |KMS |
|[0xC004C020](#0xc004c020-the-activation-server-reported-that-the-multiple-activation-key-has-exceeded-its-limit) |The activation server reported that the Multiple Activation Key has exceeded its limit. |MAK |
|[0xC004C021](#0xc004c021-the-activation-server-reported-that-the-multiple-activation-key-extension-limit-has-been-exceeded) |The activation server reported that the Multiple Activation Key extension limit has been exceeded. |MAK |
|[0xC004F009](#0xc004f009-the-software-protection-service-reported-that-the-grace-period-expired) |The Software Protection Service reported that the grace period expired. |MAK |
|[0xC004F00F](#0xc004f00f-the-software-licensing-server-reported-that-the-hardware-id-binding-is-beyond-level-of-tolerance) |The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance. |MAK<br />KMS client<br />KMS host |
|[0xC004F014](#0xc004f014-the-software-protection-service-reported-that-the-product-key-is-not-available) |The Software Protection Service reported that the product key is not available |MAK<br />KMS client |
|[0xC004F02C](#0xc004f02c-the-software-protection-service-reported-that-the-format-for-the-offline-activation-data-is-incorrect) |The Software Protection Service reported that the format for the offline activation data is incorrect. |MAK<br />KMS client |
|[0xC004F035](#0xc004f035-invalid-volume-license-key) |The Software Protection Service reported that the computer could not be activated with a Volume license product key. |KMS client<br />KMS host |
|[0xC004F038](#0xc004f038-the-count-reported-by-your-key-management-service-kms-is-insufficient) |The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator. |KMS client |
|[0xC004F039](#0xc004f039-the-key-management-service-kms-is-not-enabled) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled. |KMS client |
|[0xC004F041](#0xc004f041-the-software-protection-service-determined-that-the-key-management-server-kms-is-not-activated) |The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.  |KMS client |
|[0xC004F042](#0xc004f042-the-software-protection-service-determined-that-the-specified-key-management-service-kms-cannot-be-used) |The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used. |KMS client |
|[0xC004F050](#0xc004f050-the-software-protection-service-reported-that-the-product-key-is-invalid) |The Software Protection Service reported that the product key is invalid. |MAK<br />KMS<br />KMS client |
|[0xC004F051](#0xc004f051-the-software-protection-service-reported-that-the-product-key-is-blocked) |The Software Protection Service reported that the product key is blocked. |MAK<br />KMS |
|[0xC004F064](#0xc004f064-the-software-protection-service-reported-that-the-non-genuine-grace-period-expired) |The Software Protection Service reported that the non-genuine grace period expired. |MAK |
|[0xC004F065](#0xc004f065-the-software-protection-service-reported-that-the-application-is-running-within-the-valid-non-genuine-period) |The Software Protection Service reported that the application is running within the valid non-genuine period. |MAK<br />KMS client |
|[0xC004F06C](#0xc004f06c-the-request-timestamp-is-invalid) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.  |KMS client |
|[0xC004F074](#0xc004f074-no-key-management-service-kms-could-be-contacted) |The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.  |KMS client |

## Causes and resolutions

### 0x8004FE21 This computer is not running genuine Windows

#### 0x8004FE21 Causes

This issue can occur for several reasons:

- A user or program installed language packs (MUI) on computers running editions of Windows not licensed for extra language packs.

  > [!NOTE]
  > This issue doesn't necessarily indicate tampering. Some applications can install multilingual support even when that edition of Windows isn't licensed for those language packs.

- When malware modifies Windows in order to install additional features.
- Certain system files are corrupted.

#### Solution: reinstall operating system

To resolve this issue, you must reinstall the operating system.

### 0x80070005 Access denied

The full text of this error message says, "Access denied. The requested action requires elevated privileges."

#### 0x80070005 Cause

User Account Control (UAC) prohibits activation processes from running in a non-elevated Command Prompt window.

#### Solution: run slmgr.vbs

To resolve this issue:

1. Open the **Start menu** and search for **Command prompt**.
1. Right-click **Command prompt**.
1. Select **Run as administrator**.
1. In the command prompt, run **slmgr.vbs**.

### 0x8007007b DNS name does not exist

#### 0x8007007b Cause

This issue can occur if the KMS client can't find the KMS SRV resource records in DNS.

#### Resolution: check the documentation

For more information about troubleshooting such DNS-related issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

### 0x80070490 The product key didn't work

When you encounter this issue, you see an error message that says, "The product key that you entered didn't work. Check the product key and try again, or enter a different one."

#### Possible cause

There are two reasons why you may encounter this issue:

- The Multiple Activation Key (MAK) wasn't valid.
- A known issue in Windows Server 2019 interfered with authenticating the product key.

#### Solution: run a command on an elevated command prompt

To work around this issue and activate the computer:

1. Open the **Start menu** and search for **Command prompt**.
1. Right-click **Command prompt**.
1. Select **Run as administrator**.
1. In the command prompt, run the following command:

   ```cmd
   slmgr -ipk <5x5 key>
   ```

### 0x800706BA The RPC server is unavailable

#### 0x800706BA cause

You can encounter this issue because of the following things:

- The KMS host doesn't have configured firewall settings.
- DNS SRV records are stale.

#### Solution 1: inspect the firewall

On the KMS host, make sure you've enabled the firewall exception for the Key Management Service on TCP port 1688.

### Solution 2: inspect DNS SRV records

Check your DNS SRV records and make sure they point to a valid KMS host.

### Solution 3: Troubleshoot network connections

If you still see this error after performing solutions 1 and 2, check your network connections to make sure you can access the server.

You can also follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

### 0x8007232A DNS server failure

#### 0x8007232A cause

You can encounter this issue when the system has network or DNS issues.

#### Solution: troubleshoot network connections and DNS

To resolve this issue, troubleshoot your network connections and DNS.

<!--And how do we do this? Very vague.-->

### 0x8007232B DNS name does not exist

#### 0x8007232B cause

This error message appears when the KMS client can't find KMS server resource records (SRV RRs) in DNS.

#### Solution 1: point the KMS client to the correct KMS host

Make sure you've installed a KMS and the DNS publishing is enabled (default). If the DNS isn't available, point the KMS client to the KMS host by opening an elevated command-prompt and running **slmgr.vbs /skms <*kms_host_name*>**.

#### Solution 2: get a MAK

If you don't have a KMS host, get and install an MAK, then try activating the system again.

If these solutions don't resolve the issue, see the instructions in [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

### 0x8007251D No records found for DNS query

#### 0x8007251D cause

This error message appears when the KMS client can't find the KMS SRV records in the DNS.

#### Solution: troubleshoot network connections and connection with DNS

To resolve this issue, follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md) to troubleshoot your network connections and DNS.

### 0x80092328 DNS name does not exist

#### 0x80092328 cause

You can encounter this issue if the KMS client can't find the KMS SRV resource records in DNS.

#### Solution: troubleshoot connections

To resolve this issue, follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md) to troubleshoot your network connections and DNS.

### 0xC004B100 The activation server determined that the computer could not be activated

#### 0xC004B100 cause

You can encounter this issue when Microsoft doesn't support the MAK you're using.

#### Solution: verify that the MAK is valid

To troubleshoot this issue, verify that the MAK you're using is the same MAK that Microsoft provided to you. To verify that the MAK is valid, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C001 The activation server determined the specified product key is invalid

#### 0xC004C001 cause

You can encounter this issue when the MAK you enter isn't valid.

#### Solution: reenter the MAK key and verify it's valid

You can try reentering the MAK to make sure you entered the correct information. Otherwise, verify the MAK you're using is valid by contacting the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C003 The activation server determined the specified product key is blocked

#### Possible cause

The MAK is blocked on the activation server.

#### Solution: get a new MAK

To obtain a new MAK, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers). After you obtain the new MAK, try installing and activating Windows again.

### 0xC004C008 The activation server determined that the specified product key could not be used

#### 0xC004C008 cause

This error message appears when the KMS key has exceeded its activation limit. You can only activate KMS host keys up to 10 times on no more than six different computers.

#### Solution: request more activations for activation server permission

If you require more activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C020 The activation server reported that the Multiple Activation Key has exceeded its limit

#### 0xC004C020 cause

This error message appears when the MAK exceeds its activation limit. By design, you can only activate a MAK a limited number of times.

#### Solution: request more activations to increase limit

If you require more activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C021 The activation server reported that the Multiple Activation Key extension limit has been exceeded

#### 0xC004C021 cause

This error message appears when the MAK exceeds its activation limit. By design, you can only activate a MAK a limited number of times.

#### Solution: rquest more activations to increase extension limit

If you need additional activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004F009 The Software Protection Service reported that the grace period expired

#### 0xC004F009 cause

This error message appears when the grace period expires before you activate the system. The system is currently in the Notifications state.

#### Solution: contact the Microsoft Licensing Activation Centers

For assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004F00F The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance

#### 0xC004F00F cause

This error message appears when the system hardware changes or its drivers update.

#### Solution 1: reactivate the system during the grace period

If you're using MAK activation, reactivate the system phone by using either online or phone activation during the OOT grace period.

<!--Note to self: look up this acronym.-->

### Solution 2: restart Windows or run a command

If you're using KMS activation, try one of the following things:

- Restart Windows.
- Open an elevated command-prompt and run the following command:
  
   ```cmd
   slmgr.vbs /ato
   ```

### 0xC004F014 The Software Protection Service reported that the product key is not available

#### 0xC004F014 cause

No product keys are installed on the system.

#### Resolution

If you are using MAK activation, install a MAK product key.

If you are using KMS activation, check the Pid.txt file (located on the installation media in the \sources folder) for a KMS Setup key. Install the key.

### 0xC004F02C The Software Protection Service reported that the format for the offline activation data is incorrect

#### Possible cause

The system has detected that the data entered during phone activation is not valid.

#### Resolution

Verify that the CID is entered correctly.

### 0xC004F035 Invalid Volume License Key

The full text of this error message resembles the following:

> Error: Invalid Volume License Key. In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source. ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW.

The error text is correct, but is ambiguous. This error indicates that the computer is missing a Windows marker in its BIOS that identifies it as an OEM system that is running a qualifying edition of Windows. This information is required for KMS client activation. The more specific meaning of this code is "Error: Invalid Volume License Key"

#### Possible cause

Windows 7 Volume editions are licensed only for upgrade. Microsoft does not support installing a Volume operating system on a computer that does not have a qualifying operating system installed.

#### Resolution

In order to activate, you need to do one of the following:

- Change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source.
  > [!NOTE]
  > If you receive error 0x80072ee2 when you attempt to activate, use the phone activation method that follows instead.
- Activate by phone by following these steps:
   1. Run **slmgr /dti** and then record the value of the Installation ID. </li>
   1. Contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) and provide the Installation ID in order to receive a Confirmation ID.</li>
   1. To activate by using the Confirmation ID, run **slmgr /atp &lt;Confirmation ID&gt;**.

### 0xC004F038 The count reported by your Key Management Service (KMS) is insufficient

The full text of this error message resembles the following:

> The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.

#### Possible cause

The count on the KMS host is not high enough. For Windows Server, the KMS count must be greater than or equal to 5. For Windows (client), the KMS count must be greater than or equal to 25.

#### Resolution
Before you can use KMS to activate Windows, you must have more computers in the KMS pool. To obtain the current count on the KMS host, run **Slmgr.vbs /dli**.

### 0xC004F039 The Key Management Service (KMS) is not enabled

The full text of this error message resembles the following:

> The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled.

#### Possible cause

KMS did not respond to the KMS request.

#### Resolution

Troubleshoot the network connection between the KMS host and the client. Make sure that TCP port 1688 (default) is not blocked by a firewall or is otherwise filtered.

### 0xC004F041 The Software Protection Service determined that the Key Management Server (KMS) is not activated

The full text of this error message resembles the following:

> The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.

#### Possible cause

The KMS host is not activated.

#### Resolution

Activate the KMS host by using either online or telephone activation.

### 0xC004F042 The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used

#### Possible cause

This error occurs if the KMS client contacted a KMS host that could not activate the client software. This can be common in mixed environments that contain application-specific and operating system-specific KMS hosts, for example.

#### Resolution

Make sure that if you use specific KMS hosts to activate specific applications or operating systems, the KMS clients connect to the correct hosts.

### 0xC004F050 The Software Protection Service reported that the product key is invalid

#### Possible cause

This can be caused by a typo in the KMS key or by typing in a Beta key on a Released version of the operating system.

#### Resolution

Install the appropriate KMS key on the corresponding version of Windows. Check the spelling. If the key is being copied and pasted, make sure that em-dashes were not substituted for the hyphens in the key.

### 0xC004F051 The Software Protection Service reported that the product key is blocked

#### Possible cause

The activation server determined that Microsoft has blocked the product key.

#### Resolution

Obtain a new MAK or KMS key, install it on the system, and activate.

### 0xC004F064 The Software Protection Service reported that the non-genuine grace period expired

#### Possible cause

Windows Activation Tools (WAT) has determined that the system is not genuine.

#### Resolution

For assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004F065 The Software Protection Service reported that the application is running within the valid non-genuine period

#### Possible cause

Windows Activation Tools has determined that the system is not genuine. The system will continue to run during the Non-Genuine grace period.

#### Resolution

Obtain and install a genuine product key, and activate the system during the grace period. Otherwise, the system will go into the Notifications state at the end of the grace period.

### 0xC004F06C The request timestamp is invalid

The full text of this error message resembles the following:

> The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.

#### Possible cause

The system time on the client computer is too different from the time on the KMS host. Time sync is important to system and network security for a variety of reasons.

#### Resolution

Fix this issue by changing the system time on the client to sync with the KMS host. We recommend that you use a Network Time Protocol (NTP) time source or Active Directory Domain Services for time synchronization. This issue uses UTP time and does not depend on Time Zone selection.

### 0xC004F074 No Key Management Service (KMS) could be contacted

The full text of this error message resembles the following:

> The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.

#### Possible cause

All of the KMS host systems returned an error.

#### Resolution

In the Application Event Log, identify each event that has Event ID 12288 and is associated with the activation attempt. Troubleshoot the errors from these events.

For more information about troubleshooting DNS-related issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).
