---
title: Change the SYSVOL Netlogon Parameters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a0d8ea44-4054-4264-a3ff-bf1bcd1a1b15
author: Femila
---
# Change the SYSVOL Netlogon Parameters
  When you are relocating the SYSVOL tree, you can use this procedure to update the registry parameter that the Netlogon service uses to discover the path to the SYSVOL\\sysvol shared folder. Netlogon advertises the shared folder location based on this registry entry. The default value in this entry is *Drive*:\\%systemroot%\\SYSVOL\\sysvol. If you move the SYSVOL tree to a different folder or drive, or both, or if only the drive letter changes as a result of hardware updates, you must update this Netlogon parameter.  
  
 When you update the SysVol Netlogon parameter in the registry, you must also change the SysvolReady Netlogon parameter so that SYSVOL is not advertised until all new path values have been initialized.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the SYSVOL  Netlogon parameters  
  
1.  Click **Start**, click **Run**, type **regedit**, and then press ENTER.  
  
2.  Navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**.  
  
3.  Right\-click **SysVol**, and then click **Modify**.  
  
4.  In the **Value data** box, type the new path, including the drive letter, and then click **OK**.  
  
5.  Right\-click **SysvolReady**, and then click **Modify**.  
  
6.  In the **Value data** box, type **0**, and then click **OK**.  
  
7.  Close Registry Editor.  
  
    > [!NOTE]  
    >  The path in the SysVol registry entry points to the sysvol shared folder, which is located inside the parent SYSVOL folder that is under the root \(by default, *Drive*:\\%systemroot%\\SYSVOL\\sysvol\). When you update the path, ensure that it still identifies the sysvol shared folder within the parent SYSVOL folder. If you have moved the SYSVOL tree, the root folder will change. Be sure to also change the drive letter to its new value if this has changed.  
  
  