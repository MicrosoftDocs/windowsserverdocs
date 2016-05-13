---
title: KMS Activation Timing and Discovery for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7ad47bc5-1560-4b97-a75a-73a1a3aaf5fa
---
# KMS Activation Timing and Discovery for Volume Activation

## On this page

-   [KMS Activation Timing](#KMSActivationTiming)

-   [KMS Discovery Search Order](#KMSDiscoverySearchOrder)

### <a name="KMSActivationTiming"></a>KMS activation timing
KMS activation timing is controlled by two settings: the Activation and Renewal timers:

-   The *KMS Activation Interval* determines how often the KMS client attempts activation before it is activated. This value is set on the client by running **slmgr.vbs \/sai** . See the sections “Slmgr.vbs Options” and “Registry Settings” for more information. Once a system contacts a KMS host, the KMS host setting will override the local client setting.

-   The *KMS Renewal Interval* determines how often the KMS client attempts reactivation with KMS, once it has been activated. This value can be set using **slmgr \/sri interval**. The interval is set in minutes. The default value is 10,080 minutes \(7 days\). This value can be set on the client but will be overridden by the value that the KMS host provides.

In operation, the KMS client attempts to contact a KMS host on startup and again every Activation Interval minutes upon failure. By default, this happens every two hours. When KMS activation succeeds, the client receives and stores the KMS host’s Renewal Interval, and Windows activates for 180 days. Activation renewal operates as a sliding window, similar to a Dynamic Host Configuration Protocol \(DHCP\) lease. The client is activated for 180 days but still attempts reactivation every Renewal Interval minutes—by default, 7 days. If it succeeds, the 180\-day period is reset. If it fails, the system will watch for network changes or other qualifying events to trigger another attempt. After 15 minutes, the system stops monitoring for qualifying events but still attempts every Activation Interval minutes.

### <a name="KMSDiscoverySearchOrder"></a>KMS discovery search order
When KMS auto\-discovery is enabled \(default\) and KMS host caching is not disabled, KMS clients will use the following order to determine which KMS to use \(they will try each step until an activated KMS host with the correct key responds\):

-   SKU\-specific value in the HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform\\AppID\\SKUID\\KeyManagementServiceName REG\_SZ registry value

-   AppID\-specific value in the HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform\\AppID\\KeyManagementServiceName REG\_SZ registry value

-   Global value in the HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform\\KeyManagementServiceName REG\_SZ registry value

-   SKU\-specific cached KMS host \(This is the cached identity of the host used in the last successful KMS activation.\)

-   DNS auto\-discovery \(**weight** and **priority** honored\)

If a cached KMS does not respond, discovery is performed.

## See also

-   [Volume Activation Technical Reference](Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)


