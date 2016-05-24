---
title: Detect the Version of WSUS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f922746-6a64-4ba4-827f-e0cafa57fba1
author: britw
---
# Detect the Version of WSUS
In [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2, the WSUS version persists in the registry to support installer technologies. You can use the instructions in this topic to verify the version of WSUS that is running on a computer.  
  
WSUS 3.0 SP2 has two registry values that identify the WSUS version:  
  
-   **InstallType**, which supports two installation types:  
  
    -   1 \= Install  
  
    -   2 \= Console\-only install  
  
-   **VersionString**, which is a string of the form **Major.Minor.Build.Revision**  
  
### To detect the WSUS version  
  
1.  Open the registry editor and locate the registry key **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Update Services\\Server\\Setup**.  
  
2.  Check the **InstallType** value.   
    WSUS 3.0 SP2 has a value of 1 or 2  
  
3.  Check the **VersionString** values.  
  
