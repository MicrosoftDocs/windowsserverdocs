---
title: QoS Policy Error and Event Messages
description: This topic provides a list of error and event messages for Quality of Service (QoS) Policy in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 76974e10-6a57-4533-83be-cfd5a0d364a3
manager: brianlic
ms.author: lizross
author: eross-msft
---

# QoS Policy Error and Event Messages

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Following are the error and event messages that are associated with QoS Policy.  
  
## Informational Messages  

Following is a list of QoS Policy informational messages.

|||  
|-|-|  
|**MessageId**|16500|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_MACHINE_POLICY_REFRESH_NO_CHANGE|  
|**Language**|English|  
|**Message**|Computer QoS policies successfully refreshed. No changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16501|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_MACHINE_POLICY_REFRESH_WITH_CHANGE|  
|**Language**|English|  
|**Message**|Computer QoS policies successfully refreshed. Policy changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16502|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_USER_POLICY_REFRESH_NO_CHANGE|  
|**Language**|English|  
|**Message**|User QoS policies successfully refreshed. No changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16503|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_USER_POLICY_REFRESH_WITH_CHANGE|  
|**Language**|English|  
|**Message**|User QoS policies successfully refreshed. Policy changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16504|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_TCP_AUTOTUNING_NOT_CONFIGURED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is not specified by any QoS policy. Local computer default will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16505|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_TCP_AUTOTUNING_OFF|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 0 (minimum throughput).|  
  
|||  
|-|-|  
|**MessageId**|16506|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_TCP_AUTOTUNING_HIGHLY_RESTRICTED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 1.|  
  
|||  
|-|-|  
|**MessageId**|16507|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_TCP_AUTOTUNING_RESTRICTED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 2.|  
  
|||  
|-|-|  
|**MessageId**|16508|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_TCP_AUTOTUNING_NORMAL|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 3 (maximum throughput).|  
  
|||  
|-|-|  
|**MessageId**|16509|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_APP_MARKING_NOT_CONFIGURED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Setting value is not specified. Applications can set DSCP values independently of QoS policies.|  
  
|||  
|-|-|  
|**MessageId**|16510|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_APP_MARKING_IGNORED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Application DSCP marking requests will be ignored. Only QoS policies can set DSCP values.|  
  
|||  
|-|-|  
|**MessageId**|16511|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_APP_MARKING_ALLOWED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Applications can set DSCP values independently of QoS policies.|  
  
|||  
|-|-|  
|**MessageId**|16512|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT_EQOS_INFO_LOCAL_SETTING_DONT_USE_NLA|  
|**Language**|English|  
|**Message**|Selective application of QoS policies based on domain network category has been disabled. QoS policies will be applied to all network interfaces.|  
  
## Warning Messages

Following is a list of QoS Policy warning messages.

|||  
|-|-|  
|**MessageId**|16600|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_TEST_1|  
|**Language**|English|  
|**Message**|EQOS: ***Testing\*\*\*[, with one string] "%2".|  
  
|||  
|-|-|  
|**MessageId**|16601|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_TEST_2|  
|**Language**|English|  
|**Message**|EQOS: ***Testing\*\*\*[, with two strings, string1 is] "%2"[, string2 is] "%3".|  
  
|||  
|-|-|  
|**MessageId**|16602|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_MACHINE_POLICY_VERSION|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" has an invalid version number. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16603|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_USER_POLICY_VERSION|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" has an invalid version number. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16604|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_MACHINE_POLICY_PROFILE_NOT_SPECIFIED|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" does not specify a DSCP value or throttle rate. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16605|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_USER_POLICY_PROFILE_NOT_SPECIFIED|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" does not specify a DSCP value or throttle rate. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16606|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_MACHINE_POLICY_QUOTA_EXCEEDED|  
|**Language**|English|  
|**Message**|Exceeded the maximum number of computer QoS policies. The QoS policy "%2" and subsequent computer QoS policies will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16607|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_USER_POLICY_QUOTA_EXCEEDED|  
|**Language**|English|  
|**Message**|Exceeded the maximum number of user QoS policies. The QoS policy "%2" and subsequent user QoS policies will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16608|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_MACHINE_POLICY_CONFLICT|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" potentially conflicts with other QoS policies. See documentation for rules about which policy will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16609|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_USER_POLICY_CONFLICT|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" potentially conflicts with other QoS policies. See documentation for rules about which policy will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16610|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_MACHINE_POLICY_NO_FULLPATH_APPNAME|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" was ignored because the application path cannot be processed. The application path may be invalid, contain an invalid drive letter, or contain a network mapped drive.|  
  
|||  
|-|-|  
|**MessageId**|16611|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT_EQOS_WARNING_USER_POLICY_NO_FULLPATH_APPNAME|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" was ignored because the application path cannot be processed. The application path may be invalid, contain an invalid drive letter, or contain a network mapped drive.|  
  
## Error Messages  

Following is a list of QoS Policy error messages.

|||  
|-|-|  
|**MessageId**|16700|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_MACHINE_POLICY_REFERESH|  
|**Language**|English|  
|**Message**|Computer QoS policies failed to refresh. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16701|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_USER_POLICY_REFERESH|  
|**Language**|English|  
|**Message**|User QoS policies failed to refresh. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16702|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_OPENING_MACHINE_POLICY_ROOT_KEY|  
|**Language**|English|  
|**Message**|QoS failed to open the machine-level root key for QoS policies. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16703|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_OPENING_USER_POLICY_ROOT_KEY|  
|**Language**|English|  
|**Message**|QoS failed to open the user-level root key for QoS policies. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16704|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_MACHINE_POLICY_KEYNAME_TOO_LONG|  
|**Language**|English|  
|**Message**|A computer QoS policy exceeds the maximum allowed name length. The offending policy is listed under the machine-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16705|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_USER_POLICY_KEYNAME_TOO_LONG|  
|**Language**|English|  
|**Message**|A user QoS policy exceeds the maximum allowed name length. The offending policy is listed under the user-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16706|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_MACHINE_POLICY_KEYNAME_SIZE_ZERO|  
|**Language**|English|  
|**Message**|A computer QoS policy has a zero length name. The offending policy is listed under the machine-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16707|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_USER_POLICY_KEYNAME_SIZE_ZERO|  
|**Language**|English|  
|**Message**|A user QoS policy has a zero length name. The offending policy is listed under the user-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16708|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_OPENING_MACHINE_POLICY_SUBKEY|  
|**Language**|English|  
|**Message**|QoS failed to open the registry subkey for a computer QoS policy. The policy is listed under the machine-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16709|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_OPENING_USER_POLICY_SUBKEY|  
|**Language**|English|  
|**Message**|QoS failed to open the registry subkey for a user QoS policy. The policy is listed under the user-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16710|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_PROCESSING_MACHINE_POLICY_FIELD|  
|**Language**|English|  
|**Message**|QoS failed to read or validate the "%2" field for the computer QoS policy "%3".|  
  
|||  
|-|-|  
|**MessageId**|16711|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_PROCESSING_USER_POLICY_FIELD|  
|**Language**|English|  
|**Message**|QoS failed to read or validate the "%2" field for the user QoS policy "%3".|  
  
|||  
|-|-|  
|**MessageId**|16712|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_SETTING_TCP_AUTOTUNING|  
|**Language**|English|  
|**Message**|QoS failed to read or set inbound TCP throughput level, error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16713|  
|**Severity**|Error|  
|**SymbolicName**|EVENT_EQOS_ERROR_SETTING_APP_MARKING|  
|**Language**|English|  
|**Message**|QoS failed to read or set the DSCP marking override setting, error code: "%2".|  

For the next topic in this guide, see [QoS Policy Frequently Asked Questions](qos-policy-faq.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).
