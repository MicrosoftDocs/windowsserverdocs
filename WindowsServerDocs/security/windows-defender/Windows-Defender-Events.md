---
title: Windows Defender Events
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69b2f433-7f56-4496-bf3a-49549ce237ef
manager: dongill
author: coreyp-at-msft
---
# Windows Defender Events
Windows Defender Events

|EventID|Symbol|Description|
|-----------|----------|---------------|
|2000|MALWAREPROTECTION\_SIGNATURE\_UPDATED|The antimalware definitions updated successfully.|
|2001|MALWAREPROTECTION\_SIGNATURE\_UPDATE\_FAILED|The antimalware definition update failed.|
|2002|MALWAREPROTECTION\_ENGINE\_UPDATED|The antimalware engine updated successfully.|
|2003|MALWAREPROTECTION\_ENGINE\_UPDATE\_FAILED|The antimalware engine update failed.|
|2004|MALWAREPROTECTION\_SIGNATURE\_REVERSION|There was a problem loading antimalware definitions. The antimalware engine will attempt to load the last\-known good set of definitions.|
|2005|MALWAREPROTECTION\_ENGINE\_UPDATE\_PLATFORMOUTOFDATE|The antimalware engine failed to load because the antimalware platform is out of date. The antimalware platform will load the last\-known good antimalware engine and attempt to update.|
|2006|MALWAREPROTECTION\_PLATFORM\_UPDATE\_FAILED|The platform update failed.|
|2007|MALWAREPROTECTION\_PLATFORM\_ALMOSTOUTOFDATE|The platform will soon be out of date. Download the latest platform to maintain up\-to\-date protection.|
|2010|MALWAREPROTECTION\_SIGNATURE\_FASTPATH\_UPDATED|The antimalware engine used the Dynamic Signature Service to get additional definitions.|
|2011|MALWAREPROTECTION\_SIGNATURE\_FASTPATH\_DELETED|The Dynamic Signature Service deleted the out\-of\-date dynamic definitions.|
|2012|MALWAREPROTECTION\_SIGNATURE\_FASTPATH\_UPDATE\_FAILED|The antimalware engine encountered an error when trying to use the Dynamic Signature Service.|
|2013|MALWAREPROTECTION\_SIGNATURE\_FASTPATH\_DELETED\_ALL|The Dynamic Signature Service deleted all dynamic definitions.|
|2020|MALWAREPROTECTION\_CLOUD\_CLEAN\_RESTORE\_FILE\_DOWNLOADED|The antimalware engine downloaded a clean file.|
|2021|MALWAREPROTECTION\_CLOUD\_CLEAN\_RESTORE\_FILE\_DOWNLOAD\_FAILED|The antimalware engine failed to download a clean file.|
|2030|MALWAREPROTECTION\_OFFLINE\_SCAN\_INSTALLED|The antimalware engine was downloaded and is configured to run offline on the next system restart.|
|2031|MALWAREPROTECTION\_OFFLINE\_SCAN\_INSTALL\_FAILED|The antimalware engine was unable to download and configure an offline scan.|
|2040|MALWAREPROTECTION\_OS\_EXPIRING|Antimalware support for this operating system version will soon end.|
|2041|MALWAREPROTECTION\_OS\_EOL|Antimalware support for this operating system has ended. You must upgrade the operating system for continued support.|
|2042|MALWAREPROTECTION\_PROTECTION\_EOL|The antimalware engine no longer supports this operating system, and is no longer protecting your system from malware.|
|1000|MALWAREPROTECTION\_SCAN\_STARTED|An antimalware scan started.|
|1001|MALWAREPROTECTION\_SCAN\_COMPLETED|An antimalware scan finished.|
|1002|MALWAREPROTECTION\_SCAN\_CANCELLED|An antimalware scan was stopped before it finished.|
|1003|MALWAREPROTECTION\_SCAN\_PAUSED|An antimalware scan was paused.|
|1004|MALWAREPROTECTION\_SCAN\_RESUMED|An antimalware scan was resumed.|
|1005|MALWAREPROTECTION\_SCAN\_FAILED|An antimalware scan failed.|
|1006|MALWAREPROTECTION\_MALWARE\_DETECTED|The antimalware engine found malware or other potentially unwanted software.|
|1007|MALWAREPROTECTION\_MALWARE\_ACTION\_TAKEN|The antimalware platform performed an action to protect your system from malware or other potentially unwanted software.|
|1008|MALWAREPROTECTION\_MALWARE\_ACTION\_FAILED|The antimalware platform attempted to perform an action to protect your system from malware or other potentially unwanted software, but the action failed.|
|1009|MALWAREPROTECTION\_QUARANTINE\_RESTORE|The antimalware platform restored an item from quarantine.|
|1010|MALWAREPROTECTION\_QUARANTINE\_RESTORE\_FAILED|The antimalware platform could not restore an item from quarantine.|
|1011|MALWAREPROTECTION\_QUARANTINE\_DELETE|The antimalware platform deleted an item from quarantine.|
|1012|MALWAREPROTECTION\_QUARANTINE\_DELETE\_FAILED|The antimalware platform could not delete an item from quarantine.|
|1013|MALWAREPROTECTION\_MALWARE\_HISTORY\_DELETE|The antimalware platform deleted history of malware and other potentially unwanted software.|
|1014|MALWAREPROTECTION\_MALWARE\_HISTORY\_DELETE\_FAILED|The antimalware platform could not delete history of malware and other potentially unwanted software.|
|1015|MALWAREPROTECTION\_BEHAVIOR\_DETECTED|The antimalware platform detected suspicious behavior.|
|1116|MALWAREPROTECTION\_STATE\_MALWARE\_DETECTED|The antimalware platform detected malware or other potentially unwanted software.|
|1117|MALWAREPROTECTION\_STATE\_MALWARE\_ACTION\_TAKEN|The antimalware platform performed an action to protect your system from malware or other potentially unwanted software|
|1118|MALWAREPROTECTION\_STATE\_MALWARE\_ACTION\_FAILED|The antimalware platform attempted to perform an action to protect your system from malware or other potentially unwanted software, but the action failed.|
|1119|MALWAREPROTECTION\_STATE\_MALWARE\_ACTION\_CRITICALLY\_FAILED|The antimalware platform encountered a critical error when trying to take action on malware or other potentially unwanted software. There are more details in the event message.|
|1150|MALWAREPROTECTION\_SERVICE\_HEALTHY|If your antimalware platform reports status to a monitoring platform, this event indicates that the antimalware platform is running and in a healthy state.|
|3002|MALWAREPROTECTION\_RTP\_FEATURE\_FAILURE|Real\-time protection encountered an error and failed.|
|3007|MALWAREPROTECTION\_RTP\_FEATURE\_RECOVERED|Real\-time protection recovered from a failure. We recommend running a full system scan when you see this error.|
|5000|MALWAREPROTECTION\_RTP\_ENABLED|Real\-time protection is enabled.|
|5001|MALWAREPROTECTION\_RTP\_DISABLED|Real\-time protection is disabled.|
|5004|MALWAREPROTECTION\_RTP\_FEATURE\_CONFIGURED|The real\-time protection configuration changed.|
|5007|MALWAREPROTECTION\_CONFIG\_CHANGED|The antimalware platform configuration changed.|
|5008|MALWAREPROTECTION\_ENGINE\_FAILURE|The antimalware engine encountered an error and failed.|
|5009|MALWAREPROTECTION\_ANTISPYWARE\_ENABLED|Scanning for malware and other potentially unwanted software is enabled.|
|5010|MALWAREPROTECTION\_ANTISPYWARE\_DISABLED|Scanning for malware and other potentially unwanted software is disabled.|
|5011|MALWAREPROTECTION\_ANTIVIRUS\_ENABLED|Scanning for viruses is enabled.|
|5012|MALWAREPROTECTION\_ANTIVIRUS\_DISABLED|Scanning for viruses is disabled.|
|5100|MALWAREPROTECTION\_EXPIRATION\_WARNING\_STATE|The antimalware platform will expire soon.|
|5101|MALWAREPROTECTION\_DISABLED\_EXPIRED\_STATE|The antimalware platform is expired.|


