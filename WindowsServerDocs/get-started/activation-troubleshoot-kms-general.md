---
title: Guidelines for troubleshooting KMS
description: Provides information about the KMS service, and suggests tools and approaches for troubleshooting activation issues
ms.topic: troubleshooting
ms.date: 9/24/2019
author: Teresa-Motiv
ms.author: wscontent
manager: dcscontentpm
---

# Guidelines for troubleshooting the Key Management Service (KMS)

<!--This intro part feels more like a conceptual article. The information about what each item means feels conceptual, too. Is this necessarily troubleshooting?-->

Enterprise customers set up Key Management Service (KMS) as part of their deployment process because it lets them use a simple, straightforward process to activate Windows in their environments. Usually, once you set up the KMS host, the KMS clients connect to the host automatically and activate on their own. However, sometimes the process doesn't work as expected. This article walks you through how to troubleshoot any issues you may encounter.

For more information about event log entries and the Slmgr.vbs script, see [Volume Activation Technical Reference](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn502529(v=ws.11)).

## KMS overview

Let’s start with a quick refresher on KMS activation. KMS is a client-server model that has some similarities to Dynamic Host Configuration Protocol (DHCP). However, instead of handing out IP addresses to clients on their request, KMS enables product activation. KMS is also a renewal model, in which the clients try to reactivate on a regular interval. There are two roles: the *KMS host* and the *KMS client*.

- The KMS host runs the activation service and enables activation in the environment. To configure a KMS host, you must install KMS key from the Volume License Service Center (VLSC) and then activate the service.
- The KMS client is the Windows operating system that you deploy in the environment and need to activate. KMS clients can run any edition of Windows that uses volume activation. The KMS clients come with a pre-installed key, called the *Generic Volume License Key (GVLK)* or *KMS Client Setup Key*. The presence of the GVLK is what makes a system a KMS client. The KMS clients use DNS SRV records (_vlmcs._tcp) to identify the KMS host. Next, the clients automatically try to discover and use this service to activate themselves. During the 30-day out-of-the-box grace period, they try to activate every two hours. After activating, the KMS clients try to renew their activation every seven days.

From a troubleshooting perspective, you may have to look at both the host and client sides to figure out why an issue is happening.

## Troubleshooting on the KMS host

When you're examining the KMS host during troubleshooting, there are two areas you should look at:

- Check the status of the host software license service using the **slmgr.vbs** command in a command-line prompt.
- Check the Event Viewer for events related to licensing or activation.

### Check the Software Licensing service using the slmgr.vbs command

To see verbose output from the Software Licensing service, open an elevated command prompt window and enter `slmgr.vbs /dlv`. The following screenshot shows the results of running this command on one of our KMS hosts within Microsoft.

:::image type="content" source="./media/ee939272.kms_slmgr_output(en-us,technet.10).png" alt-text="KMS host Slmgr output.":::

<!--This image is pretty complicated, but it's got useful info on it. Not sure how to write the alt text with the limited space I've got in a way that gets everything across.-->

Here are some variables you should pay attention to in the output while troubleshooting:

- The *Version Information* is at the top of the **slmgr.vbs /dlv** output. The version information is useful for determining whether the service is up-to-date. Making sure everything's up to date is important because updates to the KMS service on Windows Server 2003 support different KMS host keys. You can use this data to evaluate whether or not the version you're currently using supports the KMS host key you're trying to install. For more information about updates, see [An update is available for Windows Vista and for Windows Server 2008 to extend KMS activation support for Windows 7 and for Windows Server 2008 R2](https://support.microsoft.com/help/968912/an-update-is-available-for-windows-vista-and-for-windows-server-2008-t).
- The *Name* indicates which edition of Windows is running on the KMS host system. You can use this information to troubleshoot issues that involve adding or changing the KMS host key. For example, you can use this information to verify if the OS edition supports the key you're trying to use.
- The *Description* shows you which key is currently installed. Use this field to verify whether the key that first activated the service was the correct one for the KMS clients you've deployed.
- The *License Status* shows the status of the KMS host system. The value should be **Licensed**. Any other value means you should reactivate the host.
- The *Current Count* displays a count between **0** and **50**. The count is cumulative between operating systems and indicates the number of valid systems that have tried to activate within a 30-day period.

  If the count is **0**, either the service was recently activated or no valid clients have connected to the KMS host.

  The count doesn't increase above **50**, no matter how many valid systems exist in the environment. The count is set to cache only twice the maximum license policy returned by a KMS client. The maximum policy set by the Windows client OS requires a count of **25** or higher from the KMS host to activate itself. Therefore, the highest count the KMS host can have is 2 x 25, or 50. In environments that contain only Windows Server KMS clients, the maximum count on the KMS host will be **10**. This limit is because the threshold for Windows Server editions is **5** (2 x 5, or 10).

  A common issue related to the count happens when the environment has an activated KMS host and enough clients, but the count doesn't increase beyond one. When this issue happens, it means the deployed client image wasn't configured correctly, so the systems don't have unique Client Machine IDs (CMIDs). For more information, see [KMS client](#kms-client) and [The KMS current count doesn't increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista). One of our Support Escalation Engineers has also blogged about this issue at [KMS Host Client Count not Increasing Due to Duplicate CMIDs](/archive/blogs/askcore/kms-host-client-count-not-increasing-due-to-duplicate-cmids).

  Another reason why the count may not be increasing is that there are too many KMS hosts in the environment and the count is distributed over all of them.
- **Listening on Port**. Communication with KMS uses anonymous RPC. By default, the clients use the 1688 TCP port to connect to the KMS host. Make sure that this port is open between your KMS clients and the KMS host. You can change or configure the port on the KMS host. During their communication, the KMS host sends the port designation to the KMS clients. If you change the port on a KMS client, the port designation is overwritten when that client contacts the host.

We often get asked about the *cumulative requests* section of the **slmgr.vbs /dlv** output. Generally, this data isn't helpful for troubleshooting. The KMS host keeps an ongoing record of the state of each KMS client that tries to activate or reactivate. Failed requests indicate the KMS host doesn't support certain KMS clients. For example, if a Windows 7 KMS client tries to activate against a KMS host that was activated by using a Windows Vista KMS key, the activation fails.

The *Requests with License Status* lines describe all possible license states, past and present. From a troubleshooting perspective, this data is relevant only if the count isn't increasing as expected. In that case, you should see the number of failed requests increasing. To resolve this issue, you should check the product key that was used to first activate the KMS host system. Also, notice that the cumulative request values reset only if you reinstall the KMS host system.

### Useful KMS host events

<!--There has to be another way to format this. Is this an error code list or a conceptual article?-->

#### Event ID 12290

The KMS host logs Event ID 12290 when a KMS client contacts the host in order to activate. Event ID 12290 provides a significant amount of information that you can use to figure out what kind of client contacted the host and why a failure occurred. The following segment of an event ID 12290 entry comes from the Key Management Service event log of our KMS host.

![KMS 12290 Event](./media/ee939272.kms_12290_event(en-us,technet.10).png)

The event details include the following information:

- **Minimum count needed to activate**. The KMS client is reporting that the count from the KMS host must be **5** in order to activate. That means that this is a Windows Server OS, although it does not indicate a specific edition. If your clients are not activating, make sure that the count is sufficient on the host.
- **Client Machine ID (CMID)**. This is a unique value on each system. If this value is not unique, it is because an image was not prepared correctly for distribution (**sysprep /generalize**). This issue manifests on the KMS host as a count that will not increase, even though there are enough clients in the environment. For more information, see [The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista).
- **License State and Time to State Expiration**. This is the current license state of the client. It can help you differentiate a client that is trying to activate for the first time from one that is trying to reactivate. The time entry tells you how much longer the client will remain in that state, if nothing changes.

If you are troubleshooting a client and cannot find a corresponding event ID 12290 on the KMS host, that client is not connecting to the KMS host. Some reasons why an event ID 12290 entry may not exist are as follows:

- A network outage has occurred.
- The host is not resolving or is not registered in DNS.
- The firewall is blocking TCP 1688.
   The port could be blocked in many places within the environment, including on the KMS host system itself. By default, the KMS host has a firewall exception for KMS, but it is not automatically enabled. You have to turn on the exception.
- The event log is full.

KMS clients log two corresponding events, event ID 12288 and event ID 12289. For information about these events, see the [KMS client](#kms-client) section.

#### Event ID 12293

Another relevant event to look for on your KMS host is event ID 12293. This event indicates that the host did not publish the required records in DNS. This situation is known to cause failures, and it is something that you should verify *after* you set up your host and *before* you deploy clients. For more information about DNS issues, see [Common troubleshooting procedures for KMS and DNS issues](common-troubleshooting-procedures-kms-dns.md).

## KMS client

On the clients you use the same tools (Slmgr and Event Viewer) to troubleshoot activation.

### Slmgr.vbs and the Software Licensing service

To see verbose output from the Software Licensing service, open an elevated Command Prompt window and enter **slmgr.vbs /dlv** at the command prompt. The following screenshot shows the results of this command on one of our KMS hosts within Microsoft.

![KMS client Slmgr output](./media/ee939272.kms_client_slmgr_output(en-us,technet.10).png)

The following list includes the most important fields for troubleshooting. What you are looking for may differ, depending on the issue to be solved.

- **Name**. This value is the edition of Windows that is installed on the KMS client system. Use this to verify that the version of Windows you are trying to activate can use KMS. For example, our Help desk has seen incidents in which customers try to install the KMS Client Setup Key on an edition of Windows that does not use volume activation, such as Windows Vista Ultimate.
- **Description**. This value shows the key that is installed. VOLUME_KMSCLIENT indicates that the KMS Client Setup Key (or GVLK) is installed (the default configuration for volume license media) and that this system automatically tries to activate by using a KMS host. If you see something else here, such as MAK, you’ll have to reinstall the GVLK to configure this system as a KMS client. You can manually install the key by using **slmgr.vbs /ipk &lt;*GVLK*&gt;** (as described in [KMS client setup keys](kmsclientkeys.md)) or use the Volume Activation Management Tool (VAMT). For information about obtaining and using VAMT, see [Volume Activation Management Tool (VAMT) Technical Reference](/windows/deployment/volume-activation/volume-activation-management-tool).
- **Partial Product Key**. As the **Name** field, you can use this information to determine whether the correct KMS Client Setup Key is installed on this computer (in other words, the key matches the operating system that is installed on the KMS client). By default, the correct key is present on systems that are built by using media from the Volume License Service Center (VLSC) portal. In some cases, customers may use Multiple Activation Key (MAK) activation until there are enough systems in the environment to support KMS activation. The KMS Client Setup key has to be installed on these systems to transition them from MAK to KMS. Use VAMT to install this key and make sure that the correct key is applied.
- **License Status**. This value shows the status of the KMS client system. For a system that was activated by using KMS, this value should be **Licensed**. Any other value may indicate that there is a problem. For example, if the KMS host is functioning correctly and the KMS client does not activate (for example, it remains in a **Grace** state), something may be preventing the client from reaching the host system (such as a firewall issue, network outage, or something similar).
- **Client Machine ID (CMID)**. Each KMS client should have a unique CMID. As mentioned in the [KMS host](#kms-host) section, a common issue related to count is if the environment has an activated KMS host and enough clients, but the count does not increase beyond **1**. For more information, see [The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network](https://support.microsoft.com/help/929829/the-kms-current-count-does-not-increase-when-you-add-new-windows-vista).
- **KMS Machine Name from DNS**. This value shows the FQDN of the KMS host that the client successfully used for activation, and the TCP port used for the communication.
- **KMS Host Caching**. The final value shows whether or not caching is enabled. By default, it is enabled. What this means is that the KMS client caches the name KMS host that it used for activation, and it communicates directly with this host (instead of querying DNS) when it is time to reactivate. If the client cannot contact the cached KMS host, it queries DNS to discover a new KMS host.

### Useful KMS client events

#### Event ID 12288 and Event ID 12289

When a KMS client successfully activates or reactivates, the client logs two events: event ID 12288 and event ID 12289. The following segment of an event ID 12288 entry comes from the Key Management Service event log of our KMS client.

![KMS client event ID 12288](./media/ee939272.client_12288(en-us,technet.10).png)

If you see only event ID 12288 (without a corresponding event ID 12289), this means that the KMS client was not able to reach the KMS host, the KMS host did not respond, or the client did not receive the response. In this case, verify that the KMS host is discoverable and that the KMS clients can contact it.

The most relevant information in event ID 12288 is the data in the Info section. For example, this section shows the current state of the client plus the FQDN and TCP port that the client used when it tried to activate. You can use the FQDN to troubleshoot cases in which the count on a KMS host is not increasing. For example, if there are too many KMS hosts available to the clients (either legitimate or rogue systems) then the count may be distributed over all of them.

An unsuccessful activation does not always mean that the client has 12288 and not 12289. A failed activation or reactivation may also have both events. In this case, you have to examine the second event to verify the reason for the failure.

![KMS client event ID 12289](./media/ee939272.client_12289(en-us,technet.10).png)

The Info section of event ID 12289 provides the following information:

- **Activation Flag**. This value indicates whether the activation succeeded(**1**) or failed (**0**).
- **Current Count on the KMS Host**. This value reflects the count value on the KMS host when the client tries to activate. If activation fails, it may be because the count is insufficient for this client OS or that there are not enough systems in the environment to build the count.

## What does support ask for?

If you have to call Support to troubleshoot activation, the Support Engineer typically asks for the following information:

- **Slmgr.vbs /dlv** output from the KMS host and KMS client systems. Whether you use wscript or cscript to run the command, you can use Ctrl+C to copy the output, and then paste it into Notepad to send it to the support contact.
- Event logs from both the KMS host (Key Management Service log) and KMS client systems (Application log)

## Additional References
- [Ask the Core Team: #Activation](/archive/blogs/askcore/kms-host-client-count-not-increasing-due-to-duplicate-cmids)
