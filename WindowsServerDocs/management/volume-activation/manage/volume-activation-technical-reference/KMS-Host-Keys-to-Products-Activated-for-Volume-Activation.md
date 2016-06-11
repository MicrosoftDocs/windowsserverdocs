---
title: KMS Host Keys to Products Activated for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7a95bcc-24f2-4f46-86ac-7ac44d5c0a42
---
# KMS Host Keys to Products Activated for Volume Activation
Table 7 describes the products that each KMS host can activate.

**Table 7. KMS host keys matched to products they activate**

|**A KMS server running this operating system**...|**can activate these Windows products**:|**On the KMS server in Column 1, this key type**...|can activate these specific Windows editions:|
|-----------------------------------------------------|--------------------------------------------|-------------------------------------------------------|-------------------------------------------------|
|*Client operating systems:*||||
|Windows 10|Windows 7<br /><br />Windows 8<br /><br />Windows 8.1<br /><br />Windows 10|KMS|Windows 10 Enterprise<br /><br />Windows 10 Education<br /><br />Windows 10 Pro<br /><br />Windows 8.1 Enterprise<br /><br />Windows 8.1 Pro<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise|
|Windows 8.1, Windows 8|Windows Vista<br /><br />Windows 7<br /><br />Windows 8<br /><br />Windows 8.1<br /><br />Windows 10 \(once you install the update in the note below this table\)|KMS|Windows 8.1 Enterprise<br /><br />Windows 8.1 Pro<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|
| Windows 7 |Windows 7 Professional<br /><br />Windows 7 Enterprise|KMS|Windows Vista Business<br /><br />Windows Vista Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise|
|Windows Vista|Windows Vista Business<br /><br />Windows Vista Enterprise|KMS|Windows Vista Business<br /><br />Windows Vista Enterprise|
|*Server operating systems:*||||
| Windows Server 2012 R2 | Windows Server 2012 <br /><br />Windows Server 2008 R2<br /><br />Windows Server 2008<br /><br />Windows 7<br /><br />Windows 8<br /><br />Windows 8.1<br /><br />Windows 10 \(once you install the update in the note below this table\)|KMS|Windows Server 2012 R2 Server Standard<br /><br />Windows Server 2012 R2 Datacenter<br /><br />Windows Server 2012 R2 Essentials|
| Windows Server 2012 |Windows Server 2008 R2<br /><br />Windows 7<br /><br />Windows 8<br /><br />Windows 8.1<br /><br />Windows 10 \(once you install the update in the note below this table\)|KMS|Windows Server 2012<br /><br />Windows Server 2012 N<br /><br />Windows Server 2012 Single Language<br /><br />Windows Server 2012 Country Specific<br /><br />Windows Server 2012 Server Standard<br /><br />Windows Server 2012 MultiPoint Standard<br /><br />Windows Server 2012 MultiPoint Premium<br /><br />Windows Server 2012 Datacenter|
| Windows Server 2008 R2 <br /><br />Server Group A:|Windows® Web Server 2008 R2<br /><br />Windows Server 2008 R2 HPC Edition<br /><br />Windows HPC Server 2008 R2|KMS\_A| Windows Server 2008 R2  Group A<br /><br /> Windows Server 2008  Group A<br /><br />Windows Vista Volume Editions<br /><br />Windows 7 Volume Editions|
| Windows Server 2008 R2 <br /><br />Server Group B| Windows Server 2008 R2 Standard <br /><br /> Windows Server 2008 R2 Enterprise |KMS\_B| Windows Server 2008 R2  Group A<br /><br /> Windows Server 2008  Group A<br /><br /> Windows Server 2008 R2  Group B<br /><br /> Windows Server 2008  Group B<br /><br />Windows Vista Volume Editions<br /><br />Windows 7 Volume Editions|
| Windows Server 2008 R2 <br /><br />Server Group C| Windows Server 2008 R2 Datacenter <br /><br /> Windows Server 2008 R2 for Itanium\-Based Systems |KMS\_C| Windows Server 2008 R2  Group A<br /><br /> Windows Server 2008  Group A<br /><br /> Windows Server 2008 R2  Group B<br /><br /> Windows Server 2008  Group B<br /><br /> Windows Server 2008 R2  Group C<br /><br /> Windows Server 2008  Group C<br /><br />Windows Vista Volume Editions<br /><br />Windows 7 Volume Editions|

> [!NOTE]
> Installations of KMS on Windows Vista, Windows 7, Windows 8, Windows 8.1, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 must be updated in order to support activation of clients running Windows 10 or newer client or server operating systems. For more information, see [Update that enables Windows 8.1 and Windows 8 KMS hosts to activate a later version of Windows](http://support.microsoft.com/kb/3058168). Installations of KMS On Windows Server 2003 cannot be updated to support activation of clients running Windows 8,  Windows Server 2012 , or newer operating systems.

 Windows Server 2008 R2  KMS keys follow the same hierarchy \(groups A, B, C\) as  Windows Server 2008  with the addition of the Windows Server 2008 Datacenter without Hyper\-V™, Windows Server 2008 Enterprise without Hyper\-V, and Windows Server 2008 Standard without Hyper\-V. The primary difference to note is that  Windows Server 2008 R2  KMS keys can be used to activate a KMS host that will in turn activate  Windows Server 2008 ,  Windows 7 , and Windows Vista.

 Windows Server 2008  and Windows Vista keys cannot activate  Windows 7  or  Windows Server 2008 R2  systems.

Windows Vista and Windows Server 2008 cannot activate Windows 10 or Windows Server 2012 R2 operating systems.

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview]()

-   For actual KMS Client Setup keys, see [Appendix A: KMS Client Setup Keys](../../plan/plan-for-volume-activation/Appendix-A--KMS-Client-Setup-Keys.md)


