---
title: Windows Defender Events
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-defender
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69b2f433-7f56-4496-bf3a-49549ce237ef
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Defender Events

>Applies To: Windows Server&reg; 2016

Windows Defender Events

|EventID|Symbol|Description|
|------|-----|--------|
|2000|MALWAREPROTECTION_SIGNATURE_UPDATED|The antimalware definitions updated successfully.|
|2001|MALWAREPROTECTION_SIGNATURE_UPDATE_FAILED|The antimalware definition update failed.|
|2002|MALWAREPROTECTION_ENGINE_UPDATED|The antimalware engine updated successfully.|
|2003|MALWAREPROTECTION_ENGINE_UPDATE_FAILED|The antimalware engine update failed.|
|2004|MALWAREPROTECTION_SIGNATURE_REVERSION|There was a problem loading antimalware definitions. The antimalware engine will attempt to load the last-known good set of definitions.|
|2005|MALWAREPROTECTION_ENGINE_UPDATE_PLATFORMOUTOFDATE|The antimalware engine failed to load because the antimalware platform is out of date. The antimalware platform will load the last-known good antimalware engine and attempt to update.|
|2006|MALWAREPROTECTION_PLATFORM_UPDATE_FAILED|The platform update failed.|
|2007|MALWAREPROTECTION_PLATFORM_ALMOSTOUTOFDATE|The platform will soon be out of date. Download the latest platform to maintain up-to-date protection.|
|2010|MALWAREPROTECTION_SIGNATURE_FASTPATH_UPDATED|The antimalware engine used the Dynamic Signature Service to get additional definitions.|
|2011|MALWAREPROTECTION_SIGNATURE_FASTPATH_DELETED|The Dynamic Signature Service deleted the out-of-date dynamic definitions.|
|2012|MALWAREPROTECTION_SIGNATURE_FASTPATH_UPDATE_FAILED|The antimalware engine encountered an error when trying to use the Dynamic Signature Service.|
|2013|MALWAREPROTECTION_SIGNATURE_FASTPATH_DELETED_ALL|The Dynamic Signature Service deleted all dynamic definitions.|
|2020|MALWAREPROTECTION_CLOUD_CLEAN_RESTORE_FILE_DOWNLOADED|The antimalware engine downloaded a clean file.|
|2021|MALWAREPROTECTION_CLOUD_CLEAN_RESTORE_FILE_DOWNLOAD_FAILED|The antimalware engine failed to download a clean file.|
|2030|MALWAREPROTECTION_OFFLINE_SCAN_INSTALLED|The antimalware engine was downloaded and is configured to run offline on the next system restart.|
|2031|MALWAREPROTECTION_OFFLINE_SCAN_INSTALL_FAILED|The antimalware engine was unable to download and configure an offline scan.|
|2040|MALWAREPROTECTION_OS_EXPIRING|Antimalware support for this operating system version will soon end.|
|2041|MALWAREPROTECTION_OS_EOL|Antimalware support for this operating system has ended. You must upgrade the operating system for continued support.|
|2042|MALWAREPROTECTION_PROTECTION_EOL|The antimalware engine no longer supports this operating system, and is no longer protecting your system from malware.|
|1000|MALWAREPROTECTION_SCAN_STARTED|An antimalware scan started.|
|1001|MALWAREPROTECTION_SCAN_COMPLETED|An antimalware scan finished.|
|1002|MALWAREPROTECTION_SCAN_CANCELLED|An antimalware scan was stopped before it finished.|
|1003|MALWAREPROTECTION_SCAN_PAUSED|An antimalware scan was paused.|
|1004|MALWAREPROTECTION_SCAN_RESUMED|An antimalware scan was resumed.|
|1005|MALWAREPROTECTION_SCAN_FAILED|An antimalware scan failed.|
|1006|MALWAREPROTECTION_MALWARE_DETECTED|The antimalware engine found malware or other potentially unwanted software.|
|1007|MALWAREPROTECTION_MALWARE_ACTION_TAKEN|The antimalware platform performed an action to protect your system from malware or other potentially unwanted software.|
|1008|MALWAREPROTECTION_MALWARE_ACTION_FAILED|The antimalware platform attempted to perform an action to protect your system from malware or other potentially unwanted software, but the action failed.|
|1009|MALWAREPROTECTION_QUARANTINE_RESTORE|The antimalware platform restored an item from quarantine.|
|1010|MALWAREPROTECTION_QUARANTINE_RESTORE_FAILED|The antimalware platform could not restore an item from quarantine.|
|1011|MALWAREPROTECTION_QUARANTINE_DELETE|The antimalware platform deleted an item from quarantine.|
|1012|MALWAREPROTECTION_QUARANTINE_DELETE_FAILED|The antimalware platform could not delete an item from quarantine.|
|1013|MALWAREPROTECTION_MALWARE_HISTORY_DELETE|The antimalware platform deleted history of malware and other potentially unwanted software.|
|1014|MALWAREPROTECTION_MALWARE_HISTORY_DELETE_FAILED|The antimalware platform could not delete history of malware and other potentially unwanted software.|
|1015|MALWAREPROTECTION_BEHAVIOR_DETECTED|The antimalware platform detected suspicious behavior.|
|1116|MALWAREPROTECTION_STATE_MALWARE_DETECTED|The antimalware platform detected malware or other potentially unwanted software.|
|1117|MALWAREPROTECTION_STATE_MALWARE_ACTION_TAKEN|The antimalware platform performed an action to protect your system from malware or other potentially unwanted software|
|1118|MALWAREPROTECTION_STATE_MALWARE_ACTION_FAILED|The antimalware platform attempted to perform an action to protect your system from malware or other potentially unwanted software, but the action failed.|
|1119|MALWAREPROTECTION_STATE_MALWARE_ACTION_CRITICALLY_FAILED|The antimalware platform encountered a critical error when trying to take action on malware or other potentially unwanted software. There are more details in the event message.|
|1150|MALWAREPROTECTION_SERVICE_HEALTHY|If your antimalware platform reports status to a monitoring platform, this event indicates that the antimalware platform is running and in a healthy state.|
|3002|MALWAREPROTECTION_RTP_FEATURE_FAILURE|Real-time protection encountered an error and failed.|
|3007|MALWAREPROTECTION_RTP_FEATURE_RECOVERED|Real-time protection recovered from a failure. We recommend running a full system scan when you see this error.|
|5000|MALWAREPROTECTION_RTP_ENABLED|Real-time protection is enabled.|
|5001|MALWAREPROTECTION_RTP_DISABLED|Real-time protection is disabled.|
|5004|MALWAREPROTECTION_RTP_FEATURE_CONFIGURED|The real-time protection configuration changed.|
|5007|MALWAREPROTECTION_CONFIG_CHANGED|The antimalware platform configuration changed.|
|5008|MALWAREPROTECTION_ENGINE_FAILURE|The antimalware engine encountered an error and failed.|
|5009|MALWAREPROTECTION_ANTISPYWARE_ENABLED|Scanning for malware and other potentially unwanted software is enabled.|
|5010|MALWAREPROTECTION_ANTISPYWARE_DISABLED|Scanning for malware and other potentially unwanted software is disabled.|
|5011|MALWAREPROTECTION_ANTIVIRUS_ENABLED|Scanning for viruses is enabled.|
|5012|MALWAREPROTECTION_ANTIVIRUS_DISABLED|Scanning for viruses is disabled.|
|5100|MALWAREPROTECTION_EXPIRATION_WARNING_STATE|The antimalware platform will expire soon.|
|5101|MALWAREPROTECTION_DISABLED_EXPIRED_STATE|The antimalware platform is expired.|



