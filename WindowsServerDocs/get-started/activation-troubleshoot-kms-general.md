---
title: Guidelines for troubleshooting KMS
description: 
ms.topic: troubleshooting
ms.date: 9/4/2019
ms.technology: server-general
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
---

# Guidelines for troubleshooting the Key Management Service (KMS)

As part of deployment, many enterprise customers set up the Key Management Service (KMS) to enable activation of Windows in their environment. It is a simple process to set up the KMS host…and the KMS clients discover and attempt to activate on their own. But what happens if it doesn’t work? What do you do next? This article walks you through the resources you need to troubleshoot. For more information about event log entries and the Slmgr.vbs script, see [Volume Activation Technical Reference](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn502529(v=ws.11)).

## KMS overview

Let’s start with a quick refresher on KMS activation. KMS is a client-server model. It is conceptually similar to DHCP. Instead of handing out IP addresses to clients on their request, KMS enables product activation. KMS is also a renewal model, with the clients attempting to reactivate on a regular interval. There are two roles: the *KMS host* and the *KMS client*.

- The **KMS host** runs the activation service and enables activation in the environment. To configure a KMS host, you have to install a  KMS key from the Volume License Service Center (VLSC) and then activate the service.
- The **KMS client** is the Windows operating system that is deployed in the environment and needs to activate. KMS clients can be running any edition of Windows that uses volume activation. The KMS clients come with a pre-installed key, called the Generic Volume License Key (GVLK) or KMS Client Setup Key. The presence of the GVLK is what makes a system a KMS client. The KMS clients use DNS SRV records (_vlmcs._tcp) to identify the KMS host and then automatically attempt to discover and use this service to activate themselves. During the 30 day Out-of-the-box grace period, they will try to activate every two hours. After activating, the KMS clients attempt to renew their activation every seven days.

From a troubleshooting perspective, you may need to look at both sides (host and client) to determine what is going on.

## KMS host

There are two areas to check on the KMS host. First, check the status of the host's software license service. Second, check the Event Viewer for events that are related to licensing or activation.

### Slmgr.vbs and the Software Licensing service

To see verbose output from the Software Licensing service, open an elevated command prompt and enter **slmgr.vbs /dlv**. The following screenshot shows the results of this command on one of our KMS hosts within Microsoft.

![KMS host Slmgr output](./media/ee939272.kms_slmgr_output(en-us,technet.10).png)

The most important fields for troubleshooting are listed below. What you are looking for may be different, depending on the issue to be solved.

- **Version Information**. At the top of the **slmgr.vbs /dlv** output is the Software Licensing Service Version. This may be useful to determine if the current version of the service is installed. For example, updates to the KMS service on Windows Server 2003 support different KMS host keys. This data can be used to evaluate whether or not the version is current and supports the KMS host key that you are attempting to install. For more information about these updates, see [An update is available for Windows Vista and for Windows Server 2008 to extend KMS activation support for Windows 7 and for Windows Server 2008 R2](https://support.microsoft.com/help/968912/an-update-is-available-for-windows-vista-and-for-windows-server-2008-t).
- **Name**. This will tell you the edition of Windows that is installed on the KMS host system. This can be important when troubleshooting if you are having trouble adding or changing the KMS host key (for example, to confirm the key is supported on that OS edition).
- **Description**. This is where you will see the key that is installed. Use this field to confirm which key was used to activate the service and whether or not it is the right one for the KMS clients that you have deployed.
- **License Status**. This is the status of the KMS host system. The value should be **Licensed**. Any other value means something is wrong and you may need to reactivate the host.
- **Current Count**. The count displayed will be between 0 and 50. The count is cumulative (between operating systems) and indicates the number of valid systems that have attempted to activate within a 30 day period.  
  
  If the count is **0**, either the service has recently been activated or no valid clients have connected to the KMS host.  
  
  The count will not increase above **50**, no matter how many valid systems exist in the environment. This is because they count is set to cache only twice the maximum license policy that is returned by a KMS client. The maximum policy today is set by the Windows client OS, which requires a count of **25** or higher from the KMS host to activate itself. Therefore, the highest count on the KMS host is *2 x 25*, or 50. Note that in environments that contain only Windows Server KMS clients, the maximum count on the KMS host will be 10, as the threshold for Windows Server editions is **5** (*2 x 5*, or 10).  
  
  A common issue related to the count is where the environment has an activated KMS host and a sufficient number of clients, but the count does not increase beyond one. The core problem is that the deployed client image was not configured correctly (**sysprep /generalize**) and the systems do not have unique Client Machine IDs (CMIDs). For for more information, see [KMS client](#kms-client) and [The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista). One of our Support Escalation Engineers has also blogged about this issue, in [KMS Host Client Count not Increasing Due to Duplicate CMID’S](https://blogs.technet.microsoft.com/askcore/2009/10/16/kms-host-client-count-not-increasing-due-to-duplicate-cmids/).  
  
  Another reason why the count may not be increasing is that there are too many KMS hosts in the environment and the count is distributed over all of them.
- **Listening on Port**. Communication with KMS uses anonymous RPC. By default, the clients use the 1688 TCP port to connect to the KMS host. Make sure that this port is open between your KMS clients and the KMS host. You can change or configure the port on the KMS host. During their communication, the KMS host sends the port designation to the KMS clients. If you change the port on a KMS client, it will be overwritten when that client contacts the host.

We often get asked about the “cumulative requests” section of the **slmgr.vbs /dlv** output. Generally speaking, this data is not all that helpful when it comes to troubleshooting. The KMS host keeps an ongoing record of the state of each KMS client that attempts to (re)activate. Failed requests indicate KMS clients that the KMS host does not support. For example, if a Windows 7 KMS client attempted to activate against a KMS host that was activated by using a Windows Vista KMS key, the activation would fail. The “Requests with License Status” lines describe all of the possible license states, past and present. From a troubleshooting perspective, this data is only relevant if the count is not increasing as expected. In that case, you should see the number of failed requests increasing&mdash;which indicates that you should check the product key that was used to activate the KMS host system. Note also that the cumulative request values only reset if you reinstall the KMS host system.

### Useful KMS host events

#### Event ID 12290

The KMS host logs Event ID 12290 when a KMS client contacts the host in order to activate. Event ID 12290 provides a significant amount of information that you can use to figure out what kind of client contacted the host…and why a failure occurred. The following segment of an event ID 12290 entry comes from the Key Management Service event log of our KMS host.  

![KMS 12290 Event](./media/ee939272.kms_12290_event(en-us,technet.10).png)

The event details include the following information:

- **Minimum count needed to activate**. The KMS client is reporting that the count from the KMS host must be **5** in order to activate. That means this is a Windows Server OS, although it does not indicate a specific edition. If your clients are not activating, make sure that the count is sufficient on the host.
- **Client Machine ID (CMID)**. This is a unique value on each system. If this value is not unique, it is because an image was not properly prepared for distribution (**sysprep /generalize**). This issue manifests on the KMS host as a count that will not increase, despite a sufficient number of clients existing in the environment. For more information, see [The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista).
- **License State and Time to State Expiration**. This is the current license state of the client. It can help you differentiate a client that is trying to activate for the first time versus one that is attempting to reactivate. The time entry tells you how much longer the client will be in that state, if nothing changes.

If you are troubleshooting a client and cannot find a corresponding event ID 12290 on the KMS host, that client is not connecting to the KMS host. Some of the reasons why an event ID 12290 entry may not exist include the following:

- Network outage
- Host not resolving/registered in DNS
- Firewall blocking TCP 1688  
   The port could be blocked in many places within the environment, including on the KMS host system itself. By default, the KMS host has a firewall exception for KMS, but it is not automatically enabled. You have to turn on the exception.
- The event log is full

KMS clients log two corresponding events, event ID 12288 and event ID 12289. For information about these events, see [KMS client](#kms-client) section.

#### Event ID 12293

Another relevant event to look for on your KMS host is event ID 12293. This event indicates that the host failed to publish the required records in DNS. That failure definitely causes failures and is something you should confirm *after* you set up your host and *before* you deploy clients. For more information about DNS issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

## KMS client

On the clients you use the same tools (Slmgr and Event Viewer) to troubleshoot activation.

### Slmgr.vbs and the Software Licensing service

To see verbose output from the Software Licensing service, open an elevated command prompt and enter **slmgr.vbs /dlv**. The following screenshot shows the results of this command on one of our KMS hosts within Microsoft.

![KMS client Slmgr output](./media/ee939272.kms_client_slmgr_output(en-us,technet.10).png)

The following list includes the most important fields for troubleshooting. What you are looking for may be different, depending on the issue to be solved.

- **Name**. This value is the edition of Windows that is installed on the KMS client system. Use this to confirm that the version of Windows you are attempting to activate can use KMS. For example, our help desk has seen incidents where customers are attempting to install the KMS Client Setup Key on an edition of Windows that does not use volume activation, such as Windows Vista Ultimate.
- **Description**. This value shows the key that is installed. VOLUME_KMSCLIENT indicates that the KMS Client Setup Key (or GVLK) is installed (the default configuration for volume license media) and that this system automatically tries to activate by using a KMS host. If you see something else here, such as MAK, then you’ll need to reinstall the GVLK to configure this system as a KMS client. You can manually install the key by using **slmgr.vbs /ipk &lt;*GVLK*&gt;** (as described in [KMS client setup keys](kmsclientkeys.md)) or use the Volume Activation Management Tool (VAMT). For information about obtaining and using VAMT, see [Volume Activation Management Tool (VAMT) Technical Reference](https://docs.microsoft.com/windows/deployment/volume-activation/volume-activation-management-tool).
- **Partial Product Key**. As with the **Name** field above, you can use this information to determine that the correct KMS Client Setup Key is installed on this computer (in other words, the key matches the operating system that is installed on the KMS client). By default, the correct key will be present on systems that are built by using media from the Volume License Service Center (VLSC) portal. In some cases, customers may use Multiple Activation Key (MAK) activation until there are a sufficient number of systems in the environment to support KMS activation. The KMS Client Setup key has to be installed on these systems to transition them from MAK to KMS. Use VAMT to install this key and ensure that the correct key is applied.
- **License Status**. This value shows the status of the KMS client system. For a system that has been activated by using KMS, this value should be **Licensed**. Any other value may indicate that there is a problem. For example, if the KMS host is functioning properly and the KMS client does not activate (for example, it remains in a **Grace** state), something may be preventing the client from reaching the host system (such as a firewall issue, network outage, or something similar).
- **Client Machine ID (CMID)**. Each KMS client should have a unique CMID. As mentioned in the [KMS host](#kms-host) section, a common issue related to count is where the environment has an activated KMS host and a sufficient number of clients, but the count does not increase beyond **1**. For more information, see [The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista).
- **KMS Machine Name from DNS**. This value shows the FQDN of the KMS host that the client successfully used for activation, and the TCP port used for the communication.
- **KMS Host Caching**. The final value shows whether or not caching is enabled. It is enabled by default. What this means is that the KMS client caches the name KMS host that it used for activation, and it will communicate directly with this host when it is time to reactivate (instead of querying DNS). If the client cannot contact the cached KMS host, it queries DNS to discover a new KMS host.

### Useful KMS client events

#### Event ID 12288 and Event ID 12289

When a KMS client successfully activates or reactivates, the client logs two events: event ID 12288 and event ID 12289. The following segment of an event ID 12288 entry comes from the Key Management Service event log of our KMS client.

![KMS client event ID 12288](./media/ee939272.client_12288(en-us,technet.10).png)

If you only see event ID 12288 (without a corresponding event ID 12289), the KMS client was not able to reach the KMS host, the KMS host did not respond, or the client did not receive the response. In such a case, confirm that the KMS host is discoverable that the KMS clients can contact it.  

The most relevant information in event ID 12288 is the data in the Info section. For example, this section shows the current state of the client as well as the FQDN and TCP port that the client used when it tried to activate. You can use the FQDN to troubleshoot cases in which the count on a KMS host is not increasing. For example, if there are too many KMS hosts available to the clients (either legitimate or rogue systems) then the count may be distributed over all of them.

An unsuccessful activation does not always mean that the client has 12288 and not 12289. A failed activation/reactivation may also have both events. In such a case, you need to examine the second event to confirm the reason for the failure.

![KMS client event ID 12289](./media/ee939272.client_12289(en-us,technet.10).png)

The Info section of event ID 12289 provides the following information:

- **Activation Flag**. This value indicates whether the activation succeeded(**1**) or failed (**0**).
- **Current Count on the KMS Host**. This value reflects the count value on the KMS host when the client tried to activate. If activation fails, it may be because the count is not sufficient for this client OS or that there are not enough systems in the environment to build the count.

## What does support ask for?

If you have to to call support to troubleshoot activation, they will typically ask for the following information:

- **Slmgr.vbs /dlv** output from the KMS host and KMS client systems. Whether you use wscript or cscript to run the command, you can use *ctrl-C* to copy the output, and then paste it into Notepad to send it to the support contact.
- Event logs from both the KMS host (Key Management Service log) and KMS client systems (Application log)

## See also
- [Ask the Core Team: #Activation](https://blogs.technet.microsoft.com/askcore/tag/Activation/)


