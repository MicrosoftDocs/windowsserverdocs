---
title: Set Up the Control Station
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: cfffbbe1-7f8f-4585-badf-2090486e998f
author: Femila
---
# Set Up the Control Station
  You can use this procedure to set up the control station for a domain rename operation. To perform an Active Directory domain rename operation, you must set up a single computer as the administrative control station for the entire domain rename operation. All the domain rename procedures are performed and controlled from this computer. You copy all the required tools to perform the domain rename operation to a directory on the local disk of the control station and run the tools from that control station. Although the domain rename operation involves contacting each domain controller in the forest, the domain controllers are contacted remotely by the domain rename tools from the control station.  
  
 **Prerequisites**  
  
-   Computer: Use a computer that is a member of a domain in the forest in which domain rename operation is to be performed to serve as the control station.  
  
-   Operating system: The computer must be a member computer \(not a domain controller\) that is running Windows Server 2003 Standard Edition or Windows Server 2008 Standard, Windows Server 2003 Enterprise Edition or Windows Server 2008 Enterprise, or Windows Server 2003 Datacenter Edition or Windows Server 2008 Datacenter.  
  
    > [!IMPORTANT]  
    >  Do not use a domain controller to act as the control station for the domain rename operation.  
  
-   Operating system CD: You must have the Windows Server 2003 Standard Edition, Windows Server 2003 Enterprise Edition, or Windows Server 2003 Datacenter Edition operating system CD.  
  
 Membership in the **Local Administrators** group \(or a write access to a local disk drive\) on the computer that is the control station is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To set up the control station on a Windows Server 2003 member server  
  
1.  On a local disk drive of the selected control station computer, create a working directory for the domain rename tools, for example, C:\\domren  
  
    > [!NOTE]  
    >  Each time that you use the tools in this procedure, run them from this directory.  
  
2.  Insert the Windows Server 2003 Standard Edition, Windows Server 2003 Enterprise Edition, or Windows Server 2003 Datacenter Edition operating system CD into the CDROM drive and copy the files from the valueadd directory into your working directory as follows:  
  
    ```  
    copy D:\valueadd\msft\mgmt\domren\*.* C:\domren  
    ```  
  
     In particular, verify that the two tools Rendom.exe and Gpfixup.exe have been copied into the working directory on the control station.  
  
3.  Install the Support Tools from the Support\\Tools folder on the Windows Server 2003 Standard Edition, Windows Server 2003 Enterprise Edition, or Windows Server 2003 Datacenter Edition operating system CD. \(To install Support Tools, run Suptools.msi in the Support\\Tools directory.\) In particular, verify that the tools Rendom.exe, Repadmin.exe, Dfsutil.exe, and Gpfixup.exe are installed on the control station.  
  
### To set up the control station on a Windows Server 2008 member server  
  
1.  On a local disk drive of the selected control station computer, create a working directory for the domain rename tools, for example, C:\\domren.  
  
    > [!NOTE]  
    >  Each time that you use the tools in this procedure, run them from this directory.  
  
2.  To obtain the necessary tools for the domain rename operation, install the Remote Server Administration Tools Pack. For more information, see Installing or Removing the Remote Server Administration Tools Pack \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124111](http://go.microsoft.com/fwlink/?LinkId=124111)\).  
  
     Verify that the tools Rendom.exe, Repadmin.exe, Dfsutil.exe, and Gpfixup.exe are installed on the control station in the %\\Windows\\System32 directory.  
  
3.  Copy Rendom.exe, Repadmin.exe, Dfsutil.exe, and Gpfixup.exe tools from the %\\Windows\\System32 directory into your working directory as follows:  
  
    ```  
    robocopy %:\Windows\System32 C:\domren rendom.exe repadmin.exe dfsutil.exe gpfixup.exe  
    ```  
  
  