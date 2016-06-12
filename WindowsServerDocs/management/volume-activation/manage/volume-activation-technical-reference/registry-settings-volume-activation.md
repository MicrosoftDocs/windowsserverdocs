---
title: registry Settings for volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a214599d-ab2f-410b-b6b2-0a00a6e88468
---
# registry Settings for volume Activation

## registry settings
Table 3 describes the registry settings that volume Activation supports.

**Table 3. registry settings**

**registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\Currentversion\\SoftwareProtectionPlatform**

|Value|type|Description|Scope|
|---------|--------|---------------|---------|
|**Activation\\AlternateURL**|**reg\_SZ**|Optionally contains an administrator\-provided URL. if this key is populated, some activation dialog boxes will include a new link — **Learn About Activation online** — that opens in the default browser.|All|
|**DisableDnsPublishing**|**reg\_DWOrd**|Set this to a non\-zero value to block auto\-publishing to DNS by the KMS host.|KMS|
|**DnsDomainPublishlist**|**reg\_MULTI\_SZ**|**format:***domain\_name, <priority>, <weight>*<br /><br />Optionally contains a list of fully qualified domains that KMS uses to auto\-publish its DNS service \(SRV\) record. The KMS home domain is always used, so it is not necessary to include it here. This depends on the **DisableDnsPublishing** value.<br /><br />The **priority** and **weight** parameters are optional. if not supplied, these are set to **0** in the SRV record.|KMS|
|**EnableKmsLowPriority**|**reg\_DWOrd**|Set this to a non\-zero value to minimize contention from KMS in a co\-hosted environment. Note that on a busy system, this can prevent the KMS host from maintaining a sufficient count.|KMS|
|**KeymanagementServicelisteningPort**|**reg\_SZ**|Set this on the KMS host to force KMS to listen on the TCP port specified. The host uses TCP port 1688 if this value is not specified.|KMS|
|**KeymanagementServiceName**|**reg\_SZ**|Set this value to force the use of a specific KMS host by the KMS client. No default.<br /><br />if you specify both App\-ID and SKU\-ID, this is created in a subkey under which the value is stored:..\\SoftwareProtectionPlatform\\APPID\_GUID\\SKUID\_GUID\\ KeymanagementServiceName<br /><br />if you specify only App\-ID, SKU\-ID is not allowed, and the resulting key is: ..\\SoftwareProtection\\APPID\_GUID\\ KeymanagementServiceName<br /><br />if you specify neither App\-ID nor SKU\-ID, the resulting key is: ..\\SoftwareProtectionPlatform|KMS client|
|**KeymanagementServicePort**|**reg\_SZ**|Set this to force the use of a specific TCP port by the KMS client when it communicates with a KMS. The client uses port 1688 if this value is not specified.|KMS client|
|**KeymanagementServiceversion**|**reg\_SZ**|Set this for Microsoft Operations manager \(MOM\) 2005 automatic discovery of the KMS. delete this value if the KMS is no longer functional on the computer.|KMS|
|**UserOperations**|**reg\_DWOrd**|This value does not exist by default, and the default is **0**, which requires elevation. create this value and set it to **1** to enable standard users to install product keys and activate and rearm computers without requiring elevation.<br /><br />This setting can also be configured by GPOs, which are stored under the **\\policies** registry subkey.|All \(not just KMS\)|
|**VLActivationInterval**|**reg\_DWOrd**|This is set initially on both KMS server and client sides. The default is 120 minutes \(2 hours\). The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response. The minimum value is 15 minutes, and the maximum is 43,200 minutes \(30 days\).|KMS Client and Server|
|**VLrenewalInterval**|**reg\_DWOrd**|This is set initially on both KMS server and client sides. The default is 10,080 minutes \(7 days\). The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response. As a result, the client\-side setting will never be used. The minimum value is 15 minutes, and the maximum is 43,200 minutes \(30 days\).|KMS Client and Server|
|**\\\(APP\-ID\)\\\(SKU\-ID\)\\VLActivationtype**|**reg\_DWOrd**|Limits the type of activation to a single type.<br /><br />**1** \= active directory activation only<br /><br />**2** \= KMS activation only<br /><br />**3** \= Token activation only<br /><br />**0, blank, or values other than 1\-3** \= all activation types allowed \(default value\)|\[???\]|

**registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\Currentversion\\SoftwareProtectionPlatform\\Activation**

|**Value**|**type**|**Description**|**Scope**|
|-------------|------------|-------------------|-------------|
|**Manual**|**reg\_DWOrd**|**0** \= Allow automatic online activation \(default\)<br /><br />**1** \= Disable auto\-activation|MAK and KMS host but not KMS client|

**registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Classes\\AppID\\slui.exe\\**

|Value|type|Description|Scope|
|---------|--------|---------------|---------|
|**NoGenTicket**|**reg\_DWOrd**|Turns off online Client Activation Validation Telemetry<br /><br />**0** \= Allow automatic  activation validation telemetry \(default\)<br /><br />**1** \= Disable validation telemetry||

## See also

-   [volume Activation Technical Reference](../volume-activation-technical-reference.md)

-   [volume Activation Overview]()


