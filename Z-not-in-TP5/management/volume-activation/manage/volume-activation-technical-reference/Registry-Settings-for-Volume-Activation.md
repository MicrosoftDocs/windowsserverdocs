---
title: Registry Settings for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a214599d-ab2f-410b-b6b2-0a00a6e88468
---
# Registry Settings for Volume Activation

## Registry settings
Table 3 describes the registry settings that Volume Activation supports.

**Table 3. Registry settings**

**Registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform**

|Value|Type|Description|Scope|
|---------|--------|---------------|---------|
|**Activation\\AlternateURL**|**REG\_SZ**|Optionally contains an administrator\-provided URL. If this key is populated, some activation dialog boxes will include a new link — **Learn About Activation Online** — that opens in the default browser.|All|
|**DisableDnsPublishing**|**REG\_DWORD**|Set this to a non\-zero value to block auto\-publishing to DNS by the KMS host.|KMS|
|**DnsDomainPublishList**|**REG\_MULTI\_SZ**|**Format:***domain\_name, <priority>, <weight>*<br /><br />Optionally contains a list of fully qualified domains that KMS uses to auto\-publish its DNS service \(SRV\) record. The KMS home domain is always used, so it is not necessary to include it here. This depends on the **DisableDnsPublishing** value.<br /><br />The **priority** and **weight** parameters are optional. If not supplied, these are set to **0** in the SRV record.|KMS|
|**EnableKmsLowPriority**|**REG\_DWORD**|Set this to a non\-zero value to minimize contention from KMS in a co\-hosted environment. Note that on a busy system, this can prevent the KMS host from maintaining a sufficient count.|KMS|
|**KeyManagementServiceListeningPort**|**REG\_SZ**|Set this on the KMS host to force KMS to listen on the TCP port specified. The host uses TCP port 1688 if this value is not specified.|KMS|
|**KeyManagementServiceName**|**REG\_SZ**|Set this value to force the use of a specific KMS host by the KMS client. No default.<br /><br />If you specify both App\-ID and SKU\-ID, this is created in a subkey under which the value is stored:..\\SoftwareProtectionPlatform\\APPID\_GUID\\SKUID\_GUID\\ KeyManagementServiceName<br /><br />If you specify only App\-ID, SKU\-ID is not allowed, and the resulting key is: ..\\SoftwareProtection\\APPID\_GUID\\ KeyManagementServiceName<br /><br />If you specify neither App\-ID nor SKU\-ID, the resulting key is: ..\\SoftwareProtectionPlatform|KMS client|
|**KeyManagementServicePort**|**REG\_SZ**|Set this to force the use of a specific TCP port by the KMS client when it communicates with a KMS. The client uses port 1688 if this value is not specified.|KMS client|
|**KeyManagementServiceVersion**|**REG\_SZ**|Set this for Microsoft Operations Manager \(MOM\) 2005 automatic discovery of the KMS. Delete this value if the KMS is no longer functional on the computer.|KMS|
|**UserOperations**|**REG\_DWORD**|This value does not exist by default, and the default is **0**, which requires elevation. Create this value and set it to **1** to enable standard users to install product keys and activate and rearm computers without requiring elevation.<br /><br />This setting can also be configured by GPOs, which are stored under the **\\policies** registry subkey.|All \(not just KMS\)|
|**VLActivationInterval**|**REG\_DWORD**|This is set initially on both KMS server and client sides. The default is 120 minutes \(2 hours\). The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response. The minimum value is 15 minutes, and the maximum is 43,200 minutes \(30 days\).|KMS Client and Server|
|**VLRenewalInterval**|**REG\_DWORD**|This is set initially on both KMS server and client sides. The default is 10,080 minutes \(7 days\). The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response. As a result, the client\-side setting will never be used. The minimum value is 15 minutes, and the maximum is 43,200 minutes \(30 days\).|KMS Client and Server|
|**\\\(APP\-ID\)\\\(SKU\-ID\)\\VLActivationType**|**REG\_DWORD**|Limits the type of activation to a single type.<br /><br />**1** \= Active Directory activation only<br /><br />**2** \= KMS activation only<br /><br />**3** \= Token activation only<br /><br />**0, blank, or values other than 1\-3** \= all activation types allowed \(default value\)|\[???\]|

**Registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform\\Activation**

|**Value**|**Type**|**Description**|**Scope**|
|-------------|------------|-------------------|-------------|
|**Manual**|**REG\_DWORD**|**0** \= Allow automatic online activation \(default\)<br /><br />**1** \= Disable auto\-activation|MAK and KMS host but not KMS client|

**Registry subkey: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Classes\\AppID\\slui.exe\\**

|Value|Type|Description|Scope|
|---------|--------|---------------|---------|
|**NoGenTicket**|**REG\_DWORD**|Turns off Online Client Activation Validation Telemetry<br /><br />**0** \= Allow automatic  activation validation telemetry \(default\)<br /><br />**1** \= Disable validation telemetry||

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)


