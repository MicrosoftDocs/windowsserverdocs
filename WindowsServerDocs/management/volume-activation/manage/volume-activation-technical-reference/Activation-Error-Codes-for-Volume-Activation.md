---
title: Activation Error Codes for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 732c1a7e-db8b-40c5-a218-1916138b6cb3
---
# Activation Error Codes for Volume Activation
Table 10 provides troubleshooting help for problems that occur when activating volume editions of  Windows 7  and  Windows Server 2008 R2  operating systems.

**Table 10. Error codes and descriptions**

|**Error code**|**Error message**|**Activation type**|**Possible cause**|**Troubleshooting steps**|
|------------------|---------------------|-----------------------|----------------------|-----------------------------|
|0xC004C001|The activation server determined the specified product key is invalid|MAK|An invalid MAK was entered.|Verify that the key is the MAK provided by Microsoft.<br /><br />Contact the [Microsoft Activation Call Center](http://www.microsoft.com/licensing/resources/vol/numbers.mspx) to verify that the MAK is valid.|
|0xC004C003|The activation server determined the specified product key has been blocked|MAK|The MAK is blocked on the activation server.|Contact the [Microsoft Activation Call Center](http://www.microsoft.com/licensing/resources/vol/numbers.mspx) to obtain a new MAK and install\/activate the system.|
|0xC004C008|The activation server reported that the product key has exceeded its unlock limit.|KMS|The KMS key has exceeded the activation limit.|KMS host keys will activate up to 10 times on six different computers. If more activations are necessary, contact the [Microsoft Activation Call Center](http://www.microsoft.com/licensing/resources/vol/numbers.mspx).|
|0xC004C020|The activation server reported that the Multiple Activation Key has exceeded its limit.|MAK|The MAK has exceeded the activation limit.|MAKs by design have a limited number of activations. Contact the [Microsoft Activation Call Center](http://www.microsoft.com/licensing/resources/vol/numbers.mspx).|
|0xC004C021|The activation server reported that the Multiple Activation Key extension limit has been exceeded.|MAK|The MAK has exceeded the activation limit.|MAKs by design have a limited number of activations. Contact the [Microsoft Activation Call Center](http://www.microsoft.com/licensing/resources/vol/numbers.mspx).|
|0xC004F009|The Software Protection Service reported that the grace period expired.|MAK|The grace period expired before the system was activated. Now, the system is in the Notifications state.|See the section “User Experience.”|
|0xC004F00F|The Software Licensing Server reported that the hardware ID binding is beyond level the of tolerance.|MAK\/KMS client\/KMS host|The hardware has changed or the drivers were updated on the system.|MAK: Reactivate the system during the OOT grace period using either online or phone activation.<br /><br />KMS: Restart, or run slmgr.vbs \/ato.|
|0xC004F014|The Software Protection Service reported that the product key is not available|MAK\/KMS client|No product keys are installed on the system.|Install a MAK product key, or install a KMS Setup key found in \\sources\\Product.ini on the installation media.|
|0xC004F02C|The Software Protection Service reported that the format for the offline activation data is incorrect.|MAK\/KMS client|The system has detected that the data entered during phone activation is not valid.|Verify that the CID is correctly entered.|
|0xC004F038|The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service \(KMS\) is insufficient. Please contact your system administrator.|KMS client|The count on the KMS host is not high enough. The KMS count must be ≥5 for Windows Server or ≥25 for Windows client.|More computers are needed in the KMS pool for KMS clients to activate. Run Slmgr.vbs \/dli to get the current count on the KMS host.|
|0xC004F039|The Software Protection Service reported that the computer could not be activated. The Key Management Service \(KMS\) is not enabled.|KMS client|This error occurs when a KMS request is not answered.|Troubleshoot the network connection between the KMS host and the client. Make sure that TCP port 1688 \(default\) is not blocked by a firewall or otherwise filtered.|
|0xC004F041|The Software Licensing Service determined that the Key Management Service \(KMS\) is not activated. KMS needs to be activated. Please contact system administrator.|KMS client|The KMS host is not activated.|Activate the KMS host with either online or phone activation.|
|0xC004F042|The Software Protection Service determined that the specified Key Management Service \(KMS\) cannot be used.|KMS client|Mismatch between the KMS client and the KMS host.|This error occurs when a KMS client contacts a KMS host that cannot activate the client software. This can be common in mixed environments that contain application and operating system\-specific KMS hosts, for example.|
|0xC004F050|The Software Protection Service reported that the product key is invalid.|KMS, KMS client, MAK|This can be caused by a typo in the KMS key or by typing in a Beta key on a Released version of the operating system.|Install the appropriate KMS key on the corresponding version of Windows. Check the spelling. If the key is being copied and pasted, make sure that em dashes have not been substituted for the dashes in the key.|
|0xC004F051|The Software Protection Service reported that the product key is blocked.|MAK\/KMS|The product key on the activation server is blocked by Microsoft.|Obtain a new MAK\/KMS key, install it on the system, and activate.|
|0xC004F074|The Software Protection Service reported that the computer could not be activated. No Key Management Service \(KMS\) could be contacted. Please see the Application Event Log for additional information.|KMS Client|All KMS host systems  returned an error.|Troubleshoot errors from each event ID 12288 associated with the activation attempt.|
||||||
|0xC004F06C|The Software Protection Service reported that the computer could not be activated. The Key Management Service \(KMS\) determined that the request timestamp is invalid.|KMS client|The system time on the client computer is too different from the time on the KMS host.|Time sync is important to system and network security for a variety of reasons. Fix this issue by changing the system time on the client to sync with the KMS. Use of a Network Time Protocol \(NTP\) time source or Active Directory Domain Services for time synchronization is recommended. This issue uses UTP time and is independent of Time Zone selection.|
|0x80070005|Access denied. The requested action requires elevated privileges.|KMS client\/MAK\/KMS host|User Account Control \(UAC\) prohibits activation processes from running in a non\-elevated command prompt.|Run slmgr.vbs from an elevated command prompt. Right\-click cmd.exe, and then click Run as Administrator.|
|0x8007232A|DNS server failure.|KMS host|The system has network or DNS issues.|Troubleshoot network and DNS.|
|0x8007232B|DNS name does not exist.|KMS client|The KMS client cannot find KMS SRV RRs in DNS.<br /><br />If a KMS host does not exist on the network, a MAK should be installed.|Confirm that a KMS host has been installed and DNS publishing is enabled \(default\).<br /><br />If DNS is unavailable, point the KMS client to the KMS host by using slmgr.vbs \/skms <kms\_host\_name>.<br /><br />Optionally, obtain and install a MAK; then, activate the system.<br /><br />Finally, troubleshoot DNS.|
|0x800706BA|The RPC server is unavailable.|KMS client|Firewall settings are not configured on the KMS host, or DNS SRV records are stale.|Ensure the Key Management Service firewall exception is enabled on the KMS host computer.<br /><br />Ensure that SRV records point to a valid KMS host.<br /><br />Troubleshoot network connections.|
|0x8007251D|No records found for given DNS query.|KMS client|The KMS client cannot find KMS SRV RRs in DNS.|Troubleshoot network connections and DNS.|

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)


