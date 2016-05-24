---
title: Installing an Additional Domain Controller by Using Unattend Parameters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2d70aed3-05fa-456f-9053-94979abe7b72
author: Femila
---
# Installing an Additional Domain Controller by Using Unattend Parameters
  You can use unattend parameters to specify configuration settings for installing Active Directory Domain Services \(AD DS\) to create an additional domain controller in an existing domain. Specifically, you can use the **dcpromo \/unattend** command to install AD DS.  
  
 You can use unattend parameters in the following ways:  
  
-   In an answer file: You can manually create an answer file that contains unattend parameters to specify the settings for a domain controller, including such values as its name, domain, site, and whether it is a writable domain controller or read\-only domain controller \(RODC\). You can also create an answer file automatically by exporting installation settings to a file during an Active Directory Domain Services Installation Wizard installation.  
  
    > [!NOTE]  
    >  For information about installing RODCs, see Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\) and Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
-   From the command line: You can type the parameters and values manually at the command line.  
  
 Running an unattended installation simplifies the process of installing and configuring Active Directory Domain Services \(AD DS\) on multiple computers. When you use Dcpromo to reference the answer file, the installation proceeds from start to completion without user intervention. This method is most useful when you want to install AD DS with identical options on many computers.  
  
 **Task requirements**  
  
 The following tools are required to complete this task:  
  
-   Text editor application  
  
-   Dcpromo.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Create an Answer File for Unattended Domain Controller Installation](../Topic/Create-an-Answer-File-for-Unattended-Domain-Controller-Installation.md)  
  
2.  [Install an Additional Domain Controller by Using an Answer File](../Topic/Install-an-Additional-Domain-Controller-by-Using-an-Answer-File.md)  
  
3.  [Install an Additional Domain Controller by Using Unattend Parameters from the Command Line](../Topic/Install-an-Additional-Domain-Controller-by-Using-Unattend-Parameters-from-the-Command-Line.md)  
  
## See Also  
 [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md)   
 [Installing an Additional Domain Controller by Using the Windows Interface](../Topic/Installing-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md)  
  
  