---
title: Protecting the System Volume with Disk Protection
description: Provides information about disk protection for MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 18694665-ed65-4d84-8505-f460cf3df907
author: evaseydl
manager: scotman
ms.author: evas
---
# Protecting the System Volume with Disk Protection
MultiPoint Services provides the option to instantly erase any changes to the system volume each time the computer is started. If you enable the Disk Protection feature, any modifications to the drive, such as configuration corruption or the introduction of malware, are undone the next time the computer restarts. This is a convenient feature for administrators who want to ensure that a known “good” or “golden” software image is loaded every time. Automatic updates or software patching can be scheduled, for example, in the middle of the night. The planning consideration is whether you want to have end users be able to make changes, such as installing software, from the Internet. With this feature enabled, if you want users to be able to store files, the file share will need to be outside of the system volume.  
  
