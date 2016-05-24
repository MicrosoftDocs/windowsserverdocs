---
title: Upgrade Existing Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: cf0e4301-42cd-44cf-aabf-d18f3b42cb05
author: Femila
---
# Upgrade Existing Domain Controllers
When you upgrade the operating system on domain controllers, the computer immediately assumes the role of domain controller after the final restart of the computer. It is not necessary to install Active Directory Domain Services \(AD DS\) by using the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).  
  
For more information about the process for upgrading domain controllers to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], including known issues and hotfixes you can install, see [Microsoft Support Quick Start for Adding Windows Server 2008 or Windows Server 2008 R2 Domain Controllers to Existing Domains](assetId:///255b83fa-5f20-455a-b6b0-bef198979268).  
  
> [!IMPORTANT]  
> If you want to upgrade the operating system of a Windows 2000 domain controller to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must first perform an in\-place upgrade of a Windows 2000 operating system to a Windows Server 2003 operating system. Then, perform an in\-place upgrade of this Windows Server 2003 operating system to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system. A direct Windows 2000–to–[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system upgrade is not supported.  
  
> [!IMPORTANT]  
> The information in this guide also applies to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. If you want to perform an in\-place upgrade of the existing domain controllers running Windows Server 2003 in the forest to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], remember that [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is an x64\-based operating system. If your server is running an x64\-based version of Windows Server 2003, you can successfully perform an in\-place upgrade of this computer's operating system to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. If your server is running an x86\-based version of Windows Server 2003, you cannot upgrade this computer to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
To initiate the installation of the Windows Server 2003 operating system on a Windows 2000–based domain controller, insert the Windows Server 2003 operating system CD on the domain controller. Or, if the Windows Server 2003 media are shared over the network, run the Winnt32.exe command\-line tool. You can also perform an unattended installation of Windows Server 2003. Instructions for creating an answer file for an Active Directory installation are located in the Deploy.cab file in the Support\\Tools folder on the Windows Server 2003 operating system CD. Inside the Deploy.cab file, open Ref.chm to access the Unattend.txt file. Expand **Unattend.txt** in the left pane, and then click **DCInstall**.  
  
To initiate the installation of the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system on a Windows Server 2003–based domain controller, insert the operating system DVD on the domain controller. Or, if the operating system installation media are shared over the network, run the Setup.exe command\-line tool.  
  
## Unattended upgrade  
You can also perform an unattended upgrade by using an answer file. For more information about how to create a new answer file, see "Step 2: Building an Answer File" in the Windows Vista Deployment Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=66066](http://go.microsoft.com/fwlink/?LinkID=66066)\).  
  
Here is a sample of an answer file that can be used to perform an unattended upgrade to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
```  
<?xml version='1.0' encoding='utf-8'?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">  
<settings pass="specialize" wasPassProcessed="true">  
<component name="Microsoft-Windows-Shell-Setup" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64">  
<ComputerName>Machine Name</ComputerName>  
</component>  
</settings>  
<settings pass="windowsPE" wasPassProcessed="true">  
<component name="Microsoft-Windows-Setup" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64">  
<UserData>  
<ProductKey>Product-Key</ProductKey>  
<AcceptEula>True</AcceptEula>  
<FullName>User Name</FullName>  
<Organization>Organization Name</Organization>  
</UserData>  
<ImageInstall>  
<OSImage>  
<WillShowUI>Never</WillShowUI>  
<InstallTo>  
<DiskID>0</DiskID>  
<PartitionID>1</PartitionID>  
</InstallTo>  
<InstallFrom>  
<MetaData>  
<Key>Image/Name</Key>  
<Value>W2K8S</Value>  
</MetaData>  
</InstallFrom>  
</OSImage>  
</ImageInstall>  
<DiskConfiguration>  
<WillShowUI>Never</WillShowUI>  
<Disk>  
<DiskID>0</DiskID>  
<WillWipeDisk>False</WillWipeDisk>  
<ModifyPartitions>  
<ModifyPartition>  
<Order>1</Order>  
<PartitionID>1</PartitionID>  
<Letter>C</Letter>  
<Active>True</Active>  
</ModifyPartition>  
</ModifyPartitions>  
</Disk>  
</DiskConfiguration>  
<UpgradeData>  
<Upgrade>True</Upgrade>  
</UpgradeData>  
<Diagnostics>  
<OptIn>True</OptIn>  
</Diagnostics>  
</component>  
<component name="Microsoft-Windows-International-Core-WinPE" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64">  
<UILanguage>EN-US</UILanguage>  
</component>  
</settings>  
<settings pass="oobeSystem" wasPassProcessed="true">  
<component name="Microsoft-Windows-Shell-Setup" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64">  
<UserAccounts>  
<DomainAccounts>  
<DomainAccountList>  
<Domain>Domain Name</Domain>  
<DomainAccount>  
<Name>Administrator</Name>  
<Group>Administrators</Group>  
</DomainAccount>  
</DomainAccountList>  
</DomainAccounts>  
</UserAccounts>  
<AutoLogon>  
<Enabled>True</Enabled>  
<Domain>Domain Name</Domain>  
<Username>User Name</Username>  
<Password>User Password</Password>  
<LogonCount>9999</LogonCount>  
</AutoLogon>  
<FirstLogonCommands>  
<SynchronousCommand>  
<Order>1</Order>  
<CommandLine>Command To Execute</CommandLine>  
<Description>"RunOnceItem0"</Description>  
</SynchronousCommand>  
<SynchronousCommand>  
<Order>2</Order>  
<CommandLine>Command To Execute</CommandLine>  
<Description>"Post Install Command Execute"</Description>  
</SynchronousCommand>  
</FirstLogonCommands>  
<OOBE>  
<SkipMachineOOBE>True</SkipMachineOOBE>  
<SkipUserOOBE>True</SkipUserOOBE>  
</OOBE>  
</component>  
</settings>  
</unattend>  
```  
  
After you create the answer file, use the following procedure to perform an unattended upgrade of a Windows Server 2003–based domain controller.  
  
Membership in the local **Administrator** account, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
Depending on the operating system installation options that you selected for the computer, the local Administrator password might be blank or it might not be required. In this case, run the following command at a command prompt before you start to install AD DS:  
  
**net user Administrator** *password***\/passwordreq:yes**  
  
Replace *password* with a strong password.  
  
#### To perform an in\-place domain controller upgrade by using an answer file  
  
1.  At the command prompt, type the following:  
  
    **setup.exe \/unattend:"***path to the answer file***"**  
  
2.  Press ENTER**.**  
  
