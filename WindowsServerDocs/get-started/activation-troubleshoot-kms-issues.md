---
title: Troubleshooting common KMS activation issues
description: 
ms.topic: troubleshooting
ms.date: 09/10/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
manager: kausika
ms.localizationpriority: medium
---

# Troubleshooting common KMS activation issues

The following list describes common issues that can occur during Key Management Service (KMS) activations, linked to guidance for addressing the issues.

<a id="list"></a>

- [Should I back up KMS host information?](#should-i-back-up-kms-host-information)
- [Is the KMS client computer activated?](#is-the-kms-client-computer-activated)
- [The KMS client computer will not activate](#the-kms-client-computer-will-not-activate).
- [Error 0xC004F035](#error-0xc004f035).
- [What does this error code mean?](#what-does-this-error-code-mean).
- [Clients are not adding to the KMS count](#clients-are-not-adding-to-the-kms-count).
- [KMS hosts are unable to create SRV records](#kms-hosts-are-unable-to-create-srv-records).
- [Only the first KMS host is able to create SRV records](#only-the-first-kms-host-is-able-to-create-srv-records).
- [I installed a KMS key on the KMS client](#i-installed-a-kms-key-on-the-kms-client).
- [A KMS host failed](#a-kms-host-failed).
- [I need to disable Windows Anytime Upgrade for Windows 7](#i-need-to-disable-windows-anytime-upgrade-for-windows-7).

> [!NOTE]
> If you suspect that your issue is related to DNS, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

## Should I back up KMS host information?

Backup is not required for KMS hosts. However, if you use a tool to routinely clean up event logs, the activation history stored in the logs can be lost. If you use the event log to track or document KMS activations, periodically export the Key Management Service event log from the Applications and Services Logs folder of Event Viewer. 

If you use System Center Operations Manager, the System Center Data Warehouse database stores event log data for reporting, so you do not need to back up the event logs separately.

[Back to list](#list)

## Is the KMS client computer activated?

On the KMS client computer, open the **System** control panel and look for **Windows is activated**. Alternatively, run Slmgr.vbs with the **/dli** command-line option.

[Back to list](#list)

## The KMS client computer will not activate

Verify that the KMS activation threshold is met. On the KMS host computer, run Slmgr.vbs with the **/dli** command-line option to determine the host’s current count. Until the KMS host has a count of 25, Windows 7 client computers cannot be activated. Windows Server 2008 R2 KMS clients require a KMS count of 5 for activation. For more information about KMS requirements, see the [Volume Activation Planning Guide](http://go.microsoft.com/fwlink/?linkid=155926). 

On the KMS client computer, look in the Application event log for event ID 12289. Check this event for the following information:

- Is the result code **0**? Anything else is an error.
- Is the KMS host name in the event correct?
- Is the KMS port correct?
- Is the KMS host accessible?
- If the client is running a non-Microsoft firewall, does the outbound port need to be configured?

On the KMS host computer, look in the KMS event log for event ID 12290. Check this event for the following information:

- Did the KMS host log a request from the client computer? Verify that the name of the KMS client computer is listed. Verify that the client and KMS host can communicate. Did the client receive the response?
- If no event is logged from the KMS client, the request did not reach the KMS host or the KMS host was unable to process it. Ensure that routers do not block traffic using TCP port 1688 (if the default port is used) and that stateful traffic to the KMS client is allowed.

[Back to list](#list)

## Error 0xC004F035

This error code equates to “The software Licensing Service reported that the computer could not be activated with a Volume license product key…” This error text may be incorrect.

If the proper Windows edition is installed with a GVLK, this error my also indicate that the computer is missing a Windows marker in the BIOS, which is required for KMS client activation. The proper error text should read:

> **Error:** Invalid Volume License Key

In order to activate, you have to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source.

ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW.

[Back to list](#list)

## What does this error code mean?

Except for KMS events that have event ID 12290, Windows logs all activation events to the Application event log under the event provider name Microsoft-Windows-Security-SPP. Windows logs KMS events to the Key Management Service log in the Applications and Services folder. IT pros can run Slui.exe to display a description of most activation-related error codes. The general syntax for this command is:

```cmd
slui.exe 0x2a ErrorCode
```

For example, if event ID 12293 contains error code 0x8007267C, you can display a description of that error by running the following command:

```cmd
slui.exe 0x2a 0x8007267C
```

For more information about specific error codes and how to address them, see [Resolving common activation error codes](activation-error-codes.md).

[Back to list](#list)

## Clients are not adding to the KMS count

To reset the client computer ID (CMID) and other product-activation information, un **sysprep /generalize** or **slmgr /rearm**. Otherwise, each client computer looks identical, and the KMS host does not count them as separate KMS clients.

[Back to list](#list)

## KMS hosts are unable to create SRV records

Domain Name System (DNS) may restrict Write access or may not support dynamic DNS (DDNS). In this case, give the KMS host Write access to the DNS database, or create the service (SRV) resource record (RR) manually. For more information about KMS and DNS issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

[Back to list](#list)

## Only the first KMS host is able to create SRV records

If the organization has more than one KMS host, the other hosts might not able to update the SRV RR unless the SRV default permissions are changed. For more information about KMS and DNS issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

[Back to list](#list)

## I installed a KMS key on the KMS client

KMS keys should only be installed on KMS hosts, not on KMS clients. Run **slmgr.vbs -ipk &lt;SetupKey&gt;**. For tables of keys that you can use to configure the computer as a KMS client, see [KMS client setup keys](KMSclientkeys.md). These keys are publicly known and are edition-specific. Remember to delete any unnecessary SRV RRs from DNS, and restart the computers.

[Back to list](#list)

## A KMS host failed

If a KMS host fails, you must install a KMS host key on a new host and then activate the host. Ensure that the new KMS host has an SRV RR in the DNS database. If you install the new KMS host using the same computer name and IP address as the failed KMS host, the new KMS host can use the DNS SRV record of the failed host. If the new host has a different computer name, you can manually remove the DNS SRV RR of the failed host or (if scavenging is enabled in DNS) allow DNS to automatically remove it. If the network is using DDNS, the new KMS host automatically creates a new SRV RR on the DNS server. The new KMS host then starts collecting client renewal requests and begins activating clients as soon as the KMS activation threshold is met.

If your KMS clients use auto-discovery, they automatically choose another KMS host if the original KMS host does not respond to renewal requests. If they do not use auto-discovery, you must manually update the KMS client computers that were assigned to the failed KMS host by running **slmgr.vbs /skms**. To avoid this scenario, configure the KMS clients to use auto-discovery. For more information, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083).

[Back to list](#list)

## I need to disable Windows Anytime Upgrade for Windows 7

The Windows Anytime Upgrade (WAU) program allows Windows 7 Professional users to purchase an upgrade directly from Microsoft by clicking the **Windows Anytime Upgrade** link in the Extras and Upgrades subfolder of the All Programs menu. This link and the program are only in Windows 7 Professional editions available through retail channels.

> [!NOTE]
> This procedure describes procedures that run scripts and make changes to the registry. These rights can be delegated to selected IT implementers. The rights to change product keys and perform activations can even be assigned to users, although Microsoft does not recommend doing so.  

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Administrators can disable WAU for users by adding the **DWORD** value **Disabled** to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU** registry subkey. Set this value to **1**. If needed, create the **Explorer** and **WAU** keys.

[Back to list](#list)
