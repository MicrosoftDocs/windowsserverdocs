---
title: Deploy KMS Activation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8fe2a076-e250-46f7-925f-f834e1333b2d
author: jaimeo
---
# Deploy KMS Activation
If your network environment supports the DNS dynamic update protocol and allows computers to publish services automatically, deploying a KMS host can require very little effort. If the organization has more than one KMS host or the network does not support dynamic update, additional configuration tasks may be necessary.  
  
> [!CAUTION]  
> Some procedures in this section require changing the registry. Problems can occur if the registry is modified incorrectly by using Registry Editor or another method, and these problems might require reinstalling the operating system. Microsoft cannot guarantee that these problems can be resolved. IT pros modify the registry at their own risk.  
  
The remainder of this section describes the following key tasks:  
  
-   **Configuring KMS hosts**  
  
-   **Configuring DNS**  
  
-   **Installing KMS hosts**  
  
-   **Configuring KMS clients**  
  
## Configuring KMS hosts  
See [Configuring KMS hosts](http://technet.microsoft.com/library/ff793407.aspx).  
  
## Configuring DNS  
The following sections describe concepts for configuring DNS to work with Volume Activation:  
  
If more than one KMS host is used, see the section “Change the Default DNS Permissions for SRV Records.”  
  
To enable KMS clients using different DNS servers to find KMS hosts, see the section “Publish to Multiple DNS Domains.”  
  
To manually add SRV resource records for KMS hosts, see the sections “Manually Create SRV Records in DNS,” “Manually Create SRV Records in a BIND 8.2 or Higher DNS Server,” and “Disable Publishing of KMS SRV Records to DNS.”  
  
> [!NOTE]  
> DNS changes might not be reflected until all DNS servers have been replicated.  
  
### Change the Default DNS Permissions for SRV Records  
If you are using only one KMS host, you might not need to configure permissions in DNS. The default behavior is to allow a computer to create an SRV resource record and then update it. However, if you have more than one KMS host \(the usual case\), the other hosts will be unable to update the SRV resource record unless SRV default permissions are changed.  
  
The following high\-level procedure is an example from Microsoft’s own environment. It does not give detailed steps, which might be different from one organization to another, and it is not the only way to achieve the desired result  
  
Create a global security group in Active Directory® that will be used for your KMS hosts. An example is Key Management Service Group.Add each of your KMS hosts to this group. They must all be joined to the same domain.  
  
Once the first KMS host is created, it will create the original SRV record. If the first KMS host is unable to create the SRV resource record, it may be because your organization has changed the default permissions. In this case, manually create the SRV resource record as the section “Manually Create SRV Records in DNS” describes.  
  
Set the permissions for the SRV group to allow updates by members of the global security group.  
  
> [!NOTE]  
> A domain administrator can delegate the ability to carry out the preceding steps to administrators in the organization. To do so, create a security group in Active Directory, give that group permission to change the SRV records, and then add the delegates.  
  
### Publish to Multiple DNS Domains  
By default, the KMS host is registered only in the DNS domain to which the host belongs. If the network environment has only one DNS domain, no further action is required.  
  
If there is more than one DNS domain name, a list of DNS domains can be created for a KMS host to use when publishing its SRV RR. Setting this registry value suspends the KMS host’s default behavior of publishing only in the domain specified as the Primary DNS Suffix.Optionally, add priority and weight parameters to the **DnsDomainPublishList** registry value for KMS. This feature enables an administrator to establish KMS host priority groupings and weighting within each group to define which KMS host to try first and balance traffic among multiple KMS hosts.  
  
> [!NOTE]  
> DNS changes might not be reflected until all DNS servers have been replicated. Changes made too frequently \(time < replication time\) can leave older records if the change is performed on a server that has not been replicated.  
  
To automatically publish KMS in multiple DNS domains, add each DNS domain suffix to whichever KMS should publish to the multi\-string registry value **DnsDomainPublishList** in **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform**. After changing the value, restart the Software Licensing Service to create the SRV RRs.  
  
> [!NOTE]  
> This key has changed from the Windows Vista location of **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SL**  
  
After configuring a KMS host to publish to multiple domains, export the registry key, and then import it in to the registry on additional KMS hosts. To verify that this procedure was successful, check the Application event log on each KMS host. Event ID 12294 indicates that the KMS host successfully created the SRV RRs. Event ID 12293 indicates that the attempt to create the SRV RRs was unsuccessful. For a complete list of error codes, see the Volume Activation Operations Guide.  
  
### Manually Create SRV Records in DNS  
If the environment does not support dynamic update, the SRV RRs must be manually created to publish the KMS host. Environments that do not support dynamic update should disable publishing on all KMS hosts to prevent event logs from collecting failed DNS publishing events. To disable auto\-publishing, use the Slmgr.vbs script with the **\/cdns** command\-line option. See the “Configuring KMS” section for more information about the Slmgr.vbs script.  
  
> [!NOTE]  
> Manually created SRV RRs can coexist with SRV RRs that KMS hosts automatically publish in other domains as long as all records are maintained to prevent conflicts.  
  
Using DNS Manager, in the appropriate forwarding lookup zone, create a new SRV RR using the appropriate information for the location. By default, KMS listens on TCP port 1688, and the service is \_VLMCS. Table 2 contains example settings for a SRV RR.  
  
|Name|Setting|  
|--------|-----------|  
|Service|\_VLMCS|  
|Protocol|\_TCP|  
|Port number|1688|  
|Host offering the service|FQDN of the KMS host|  
  
**Manually Create SRV Records in a BIND 8.2 or higher DNS Server**  
  
If the organization uses a non\-Microsoft DNS server, the needed SRV RRs can be created as long as the DNS server is compliant with Berkeley Internet Name Domain \(BIND\) 8.2 or higher. When creating the record, include the information shown in Table 3. The Priority and Weight settings shown in Table 3 are only used by Windows 7 and Windows Server 2008 R2.  
  
|Name|Setting|  
|--------|-----------|  
|Name|\_vlmcs.\_tcp|  
|Type|SRV|  
|Priority|0|  
|Weight|0|  
|Port|1688|  
|Host name|FQDN of the KMS host|  
  
To configure a BIND 8.2 or higher DNS server to support KMS auto\-publishing, configure the BIND server to enable RR updates from KMS hosts. For example, add the following line to the zone definition in named.conf:`allow-update { any; };`  
  
> [!NOTE]  
> An `allow-update` statement can also be added in named.conf options to allow dynamic update for all zones hosted on this server.  
  
**Disable Publishing of KMS SRV Records to DNS**  
  
KMS hosts automatically publish their existence by creating SRV RRs in DNS. To disable automatic DNS publishing by a KMS host, use the Slmgr.vbs script with the **\/cdns** command\-line option.  
  
Using the Slmgr.vbs script to disable automatic DNS publishing is preferred, but you can also perform this task by creating a new DWORD value called **DisableDnsPublishing** in the registry, and set its value to 1. This value is at **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform** in the registry. To re\-enable the default behavior for publishing of KMS SRV records to DNS, set the value to 0.  
  
## Installing KMS hosts  
To enable KMS functionality, a KMS key is installed on a KMS host; then, the host is activated over the Internet or by phone using Microsoft’s activation services. Computers running Windows 7 or Windows Server 2008 R2 can both serve as KMS hosts.Windows Vista, Windows Server 2003, and Windows Server 2008 can also serve as KMS hosts. The KMS clients that a KMS host can activate are dependent on the host key used to activate the KMS host. For more information about KMS host keys, see the Volume Activation Planning Guide.  
  
Install and activate a KMS key on a Windows 7 or Windows Server 2008 R2 computer by using an elevated command prompt:  
  
-   To install a KMS key, type **slmgr.vbs \/ipk <KmsKey>** at a command prompt.  
  
-   To activate online, type **slmgr.vbs \/ato** at a command prompt.  
  
-   To activate by using the telephone, type **slui.exe 4** at a command prompt.  
  
After activating the KMS key, restart the Software Protection Service.  
  
Windows 7 and Windows Server 2008 R2 display the warning shown in \[Figure 1\] any time administrators install a KMS host key by using the UI \(Users will not see this warning if they install a KMS host key by using the Slmgr.vbs script\). This message prevents accidentally installing a KMS key on computers that administrators do not intend to be KMS hosts.  
  
To verify that the KMS host is configured correctly, check the KMS count to see whether it is increasing. In the Command Prompt window on the KMS host, type slmgr.vbs \/dli to display the current KMS count. Administrators can also check the Key Management Service log in the Applications and Services Logs folder for event ID 12290. The Key Management Service log records activation requests from KMS clients. Each event displays the name of the computer and the time stamp of each activation request.  
  
## Configuring KMS clients  
This section describes concepts for installing and configuring computers as KMS clients. By default, Volume License editions of Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2 are KMS clients. If the computers the organization wants to activate by using KMS are using either of these operating systems and the network allows DNS auto\-discovery, no further configuration is needed.  
  
If a KMS client is configured to search for a KMS host using DNS but does not receive SRV records from DNS, Windows 7 and Windows Server 2008 R2 log the error in the event log.  
  
**Manually Specifying a KMS Host**  
  
Administrators can manually assign a KMS host to KMS clients by using KMS host caching. Manually assigning a KMS host disables auto\-discovery of KMS on the KMS client. A KMS host is manually assigned to a KMS client by running:**\/skms <Name\[:Port\] | : port> \[Activation ID\]** where <**Name**> is either the KMS\_FQDN, IPv4Address, or NetbiosName of the KMS host and port is TCP port on the KMS host.  
  
If the KMS host uses Internet Protocol version 6 \(IPv6\) only, the address must be specified in the format \[hostname\]:port \(using the square brackets\). IPv6 addresses contain colons \(:\), which will be parsed incorrectly by the Slmgr.vbs script.  
  
**Enable Auto\-discovery for a KMS Client**  
  
By default, KMS clients automatically attempt to discover KMS hosts. Auto\-discovery can be disabled by manually assigning a KMS host to a KMS client. This action also clears the KMS host name from the KMS client’s cache. If auto\-discovery is disabled, it can be re\-enabled by running **slmgr.vbs \/ckms** at a command prompt.  
  
**Adding Suffixed Entries to KMS Clients**  
  
By adding the address of a DNS server containing the SRV RR as a suffixed entry on KMS clients, administrators can advertise KMS hosts on one DNS server and allow KMS clients with other primary DNS servers to find it. For more information about configuring a domain suffix search list on KMS clients, see [How to configure a domain suffix search list on the Domain Name System clients](http://support.microsoft.com/kb/275553).  
  
**Deploy KMS Clients**  
  
The information in this section is for Volume Licensing customers using the Windows Automated Installation Kit \(Windows AIK\) to deploy and activate a Windows operating system. Prepare KMS clients for deployment by using the System Preparation Tool \(Sysprep.exe\).  
  
Before capturing an image, run Sysprep.exe with the **\/generalize** command\-line option to reset the activation timer, security identifier \(SID\), and other important settings. Resetting the activation timer prevents the image’s grace period from expiring before the image is deployed. Running Sysprep.exe does not remove the installed product key, and administrators are not prompted for a new key during mini\-setup. If no rearms are left, the Sysprep.exe operation completes but the activation timers are not changed and an error is returned that explains the situation.  
  
When building demo virtual machines for internal use \(e.g., building virtual machines for the organization’s sales department or to set up a temporary training environment\), running the Slmgr.vbs script with the **\/rearm** command\-line option extends the grace period another 30 days, which in turn resets the activation timer but makes no other changes to the computer. The activation timer can be reset three times for computers running Windows 7 or Windows Server 2008 R2.  
  
**Manually Activate a KMS Client**  
  
By default, KMS clients automatically attempt to activate themselves at preset intervals. To manually activate KMS clients \(for example, disconnected clients\) before distributing them to users, use the Control Panel System item, or run **slmgr.vbs \/ato** at an elevated command prompt. The Slmgr.vbs script reports activation success or failure and provides a result code. To perform activation, the KMS client must have access to a KMS host on the organization’s network.  
  

