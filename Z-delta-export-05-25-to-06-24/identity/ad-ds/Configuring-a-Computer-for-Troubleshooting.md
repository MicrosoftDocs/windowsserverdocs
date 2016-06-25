---
title: Configuring a Computer for Troubleshooting
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: dcf023ca-4e29-4893-a699-8a5c3e1f4980
---
# Configuring a Computer for Troubleshooting
Before you use advanced troubleshooting techniques to identify and fix Active Directory problems, configure your computers for troubleshooting. You should also have a basic understanding of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] troubleshooting concepts, procedures, and tools.  
  
 For information about monitoring tools for Windows Server 2008, see the Step\-by\-Step Guide for Performance and Reliability Monitoring in Windows Server 2008 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=123737](http://go.microsoft.com/fwlink/?LinkId=123737)\).  
  
## Configuration tasks for troubleshooting  
 To configure your computer for troubleshooting Active Directory Domain Services \(AD DS\), perform the following tasks:  
  
 [Install Remote Server Administration Tools for AD DS](#BKMK_2)  
  
 [Configure Reliability and Performance Monitor](#BKMK_3)  
  
 [Set logging levels](#BKMK_4)  
  
###  <a name="BKMK_2"></a> Install Remote Server Administration Tools for AD DS  
 When you install AD DS to create a domain controller, the administrative tools that you use to manage AD DS are installed automatically. If you want to manage domain controllers remotely from a computer that is not a domain controller, you can install the administrative tools on a member server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or on a computer that is running Windows Vista with Service Pack 1 \(SP1\). On member servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you use the Remote Server Administration Tools \(RSAT\) feature in Server Manager to install Active Directory Domain Services Tools. RSAT replaces Windows Support Tools in Windows Server 2003. You can also install Active Directory Domain Services Tools on a computer that is running Windows Vista with Service Pack 1 \(SP1\) by downloading the tools to that computer.  
  
 For information about installing RSAT, see [Installing Remote Server Administration Tools for AD DS](../Topic/Installing%20Remote%20Server%20Administration%20Tools%20for%20AD%20DS.md).  
  
###  <a name="BKMK_3"></a> Configure Reliability and Performance Monitor  
 Windows Server 2008 includes the Windows Reliability and Performance Monitor, which is a Microsoft Management Console \(MMC\) snap\-in that combines the functionality of previous stand\-alone tools, including Performance Logs and Alerts, Server Performance Advisor, and System Monitor. This snap\-in provides a graphical user interface \(GUI\) for customizing Data Collector Sets and Event Trace Sessions.  
  
 Reliability and Performance Monitor also includes Reliability Monitor, an MMC snap\-in that tracks changes to the system and compares them to changes in system stability, providing a graphical view of their relationship.  
  
###  <a name="BKMK_4"></a> Set logging levels  
 If the information that you receive in the Directory Service log in Event Viewer is not sufficient for troubleshooting, raise the logging levels by using the appropriate registry entry in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Diagnostics**.  
  
 By default, the logging levels for all entries are set to **0**, which provides the minimum amount of information. The highest logging level is **5**. Increasing the level for an entry causes additional events to be logged in the Directory Service event log.  
  
 You can use the following procedure to change the logging level for a diagnostic entry.  
  
> [!CAUTION]  
>  We recommend that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as MMC snap\-ins, to accomplish tasks, rather than editing the registry directly. If you must edit the registry, use extreme caution.  
  
 **Requirements**  
  
-   Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   Tools: Regedit.exe  
  
##### To change the logging level for a diagnostic entry  
  
1.  Click **Start**, click **Run**, type **regedit**, and then click **OK**.  
  
2.  Navigate to the entry for which you want to set logging in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Diagnostics**.  
  
3.  Double\-click the entry, and in **Base**, click **Decimal**.  
  
4.  In **Value**, type an integer from **0** through **5**, and then click **OK**.