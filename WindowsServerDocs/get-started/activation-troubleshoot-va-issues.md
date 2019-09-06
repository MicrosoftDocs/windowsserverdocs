---
title: Troubleshooting volume activation issues
description: 
ms.topic: troubleshooting
ms.date: 09/03/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 
author: Teresa-Motiv
ms.author: v-tea
manager: kausika
ms.localizationpriority: medium
---

# Troubleshooting volume activation issues

Except for KMS events that have event ID 12290, Windows logs all activation events to the Application event log with the event provider name Microsoft-Windows-Security-SPP. Windows logs KMS events to the Key Management Service log in the Applications and Services folder. IT pros can use Slui.exe to display a description of most activation-related error codes. The general syntax for this command is:

```cmd
slui.exe 0x2a ErrorCode
```

For example, if event ID 12293 contains error code 0x8007267C, a description of that error can be displayed by running the following command:

```cmd
slui.exe 0x2a 0x8007267C
```

## KMS Activation Troubleshooting Steps

Table 1 describes common issues that can occur during KMS activations as well as steps for resolving them.

**Table 1. Troubleshooting Steps for Common KMS Activation Issues**

|Issue |Resolution |
| - | - |
|Is&nbsp;the&nbsp;KMS&nbsp;client computer&nbsp;activated? |Look for “Windows is activated” in the Control Panel System item. Alternatively, run Slmgr.vbs with the **/dli** command-line option. |
|The KMS client computer will not activate. |Verify that the KMS activation threshold is met. Run Slmgr.vbs with the **/dli** command-line option on the KMS host to determine the host’s current count. Until the KMS host has a count of 25, Windows 7 client computers cannot be activated. Windows Server 2008 R2 KMS clients require a KMS count of 5 for activation. For more information about KMS requirements, see the [Volume Activation Planning Guide](http://go.microsoft.com/fwlink/?linkid=155926). On the KMS client, look in the Application event log for event ID 12289. Check this event for the following:<ul><li>Is the result code 0? Anything else is an error.</li><li>Is the KMS host name in the event correct?</li><li>Is the KMS port correct?</li><li>Is the KMS host accessible?</li><li>If the client is running a non-Microsoft firewall, does the outbound port need to be configured?</li></ul>On the KMS host, look in the KMS event log for event ID 12290. Check this event for the following:<ul><li>Did the KMS host log a request from the client computer? Verify that the name of the KMS client is listed. Verify that the client and KMS host can communicate. Did the client receive the response?</li><li>If no event is logged from the KMS client, the request did not reach the KMS host or the KMS host was unable to process it. Ensure that routers do not block traffic using TCP port 1688 (if the default port is used) and that stateful traffic to the KMS client is allowed.</li></ul> |
|Error 0xC004F035 |This error code equates to “The software Licensing Service reported that the computer could not be activated with a Volume license product key…” This error text can be incorrect.<br />If the proper Windows edition is installed with a GVLK, this error my also indicate that the computer is missing a Windows marker in the BIOS, which is required for KMS client activation. The proper error text should read:<br />   **Error:** Invalid Volume License Key<br />In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source.<br />ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW. |
|What does this error code mean? |If Slmgr.vbs returns a hexadecimal error code or event ID 12288 contains a result code other than 0, determine the corresponding error message by running the following command: **slui.exe 0x2a ErrorCode** |
|Clients are not adding to the KMS count. |Run **sysprep /generalize** or **slmgr /rearm** to reset the client computer ID (CMID) and other product-activation information. Otherwise, each client computer looks identical, and the KMS host does not count them as separate KMS clients. |
|KMS hosts are unable to create SRV records. |Domain Name System (DNS) may restrict Write access or may not support dynamic DNS (DDNS). In this case, give the KMS host Write access to the DNS database, or create the service (SRV) resource record (RR) manually. For more information about this issue, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083). |
|Only the first KMS host is able to create SRV records. |If the organization has more than one KMS host, the other hosts might not able to update the SRV RR unless the SRV default permissions are changed. For more information about this issue, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083). |
|I installed a KMS key on the KMS client. |KMS keys should only be installed on KMS hosts, not on KMS clients. Run **slmgr.vbs -ipk &lt;SetupKey&gt;**. The [Volume Activation Technical Reference Guide](http://go.microsoft.com/fwlink/?linkid=152550) contains a table of setup keys that can be used to restore the computer to a KMS client. These keys are publicly known and are edition-specific. Remember to delete any unnecessary SRV RRs from DNS and restart the computers. |

### MAK Activation Troubleshooting Steps

Table 2 presents common issues that can occur during MAK activations and steps for resolving them.

**Table 2. Troubleshooting Steps for Common MAK Activation Issues**

|Issue |Resolution |
| - | - |
|How&nbsp;can&nbsp;I&nbsp;tell&nbsp;if&nbsp;my computer&nbsp;is&nbsp;activated? |Look for “Windows is activated” in the Control Panel System item. Alternatively, run Slmgr.vbs with the **/dli** command-line option. |
|The computer will not activate over the Internet. |Ensure the required ports are open in the firewall. For a list of ports, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083). |
|Internet and telephone activation fail. |Contact a local Microsoft Activation Center. For phone numbers of Microsoft Activation Centers worldwide, go to <http://go.microsoft.com/fwlink/?LinkID=107418>. Be sure to provide the Volume License agreement information and proof of purchase when calling. |
|Slmgr.vbs /ato returns an error code. |If Slmgr.vbs returns a hexadecimal error code, determine the corresponding error message by running the following script: **slui.exe 0x2a 0x ErrorCode** |

## KMS Host Failover

If a KMS host fails, a KMS host key must be installed on a new host and activated. Ensure that the new KMS host has an SRV RR in the DNS database. If installing the new KMS host with the same computer name and IP address as the failed KMS host, the new KMS host can use the DNS SRV record of the failed host. If the new host has a different computer name, organizations can manually remove the DNS SRV RR of the failed host or allow DNS to remove it automatically if scavenging is enabled in DNS. If the network is using DDNS, the new KMS host automatically creates a new SRV RR on the DNS server. The new KMS host then starts collecting client renewal requests and begins activating clients as soon as the KMS activation threshold is met.

If configuring KMS clients to use auto-discovery, they automatically choose another KMS host if the original KMS host does not respond to renewal requests. If not using auto-discovery, update the KMS client computers that were assigned to the failed KMS host by running **slmgr.vbs /skms**. To avoid this scenario, configure KMS clients to use auto-discovery. For more information, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?linkid=150083).

## Disabling Windows Anytime Upgrade for Windows 7</h3>

The Windows Anytime Upgrade (WAU) program allows Windows 7 Professional users to purchase an upgrade directly from Microsoft by clicking the **Windows Anytime Upgrade** link in the Extras and Upgrades subfolder of the All Programs menu. This link and the program are only in Windows 7 Professional editions available through retail channels.

Administrators can disable WAU for users by adding the **DWORD** value **Disabled** to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU** registry subkey. Set this value to **1**. If needed, create the **Explorer** and **WAU** keys.

> [!NOTE]
> This guide describes procedures that run scripts and make changes to the registry. These rights can be delegated to selected IT implementers. The rights to change product keys and perform activations can even be assigned to users, although Microsoft does not recommend doing so.  

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

### Backup Requirements

Backup is not required for KMS hosts. However, if the event log is used to track or document KMS activations, periodically export the Key Management Service event log from the Applications and Services Logs folder. If using a tool to perform routine cleanup of event logs, the activation history stored in the logs can be lost. If using System Center Operations Manager, the event log data is collected and stored in the System Center Data Warehouse database for reporting, so no backups of the event log are necessary.
