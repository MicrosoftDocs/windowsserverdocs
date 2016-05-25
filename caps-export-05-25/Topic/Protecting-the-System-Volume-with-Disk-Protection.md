---
title: Protecting the System Volume with Disk Protection
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 18694665-ed65-4d84-8505-f460cf3df907
author: cfreemanwa
---
# Protecting the System Volume with Disk Protection
New in [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] is the option to instantly erase any changes to the system volume each time the computer is started. If the Disk Protection feature is enabled, any modifications to the drive. such as configuration corruption or the introduction of malware, are undone the next time the computer restarts. This is a convenient feature for administrators who want to ensure that a known “good” or “golden” software image is loaded every time. Automatic updates or software patching can be scheduled, for example, in the middle of the night. The planning consideration is whether you want to have end users be able to make changes, such as installing software, from the Internet. With this feature enabled, if you want users to be able to store files, the file share will need to be outside of the system volume.  
  
