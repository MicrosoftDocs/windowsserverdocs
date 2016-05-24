---
title: Deploy Active-Directory-based Activation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c51c15d6-3074-4795-82d0-513149ac0149
author: jaimeo
---
# Deploy Active-Directory-based Activation
Starting with [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], you can avoid designating and configuring an activation server altogether and use Active Directory for activation instead. Whenever you activate a computer running these or later operating systems that is joined to a domain that is using the Windows 8 \(or later\) schema, an activation object is created and stored in Active Directory, instead of on the local computer. You can accomplish the initial activation of the first computer with Volume Activation Services in Server Manager or Slmgr.vbs Active Directory activation commands \(see [Slmgr.vbs Options for Volume Activation](../Topic/Slmgr.vbs-Options-for-Volume-Activation.md)\).  
  
When any [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] \(or later operating system\) computers that are volume licensed join the domain, they access the activation object present in Active Directory and become activated automatically. They remain activated as long as they remain joined to the domain and in contact with it. At each renewal interval, any Key Management Service \(KMS\) clients, upon connection to the domain, will attempt to use Active Directory activation; if that is not available, they will continue to use KMS activation.  
  
## Using Active Directory\-based activation  
To use Active Directory\-based activation, access any computer joined to the domain that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] \(or later\) operating system and activate the computer with a volume product key \(CSVLK\) by using the UI or other activation methods.  
  
## Managing the activation object  
You can use a one\-time script \(Appendix A in this topic\) that runs at the Enterprise Administrator level, creates a Security Group, and designates an owner for it. Members that you add to that Security Group are authorized to create activation objects, allowing you to delegate licensing support. You cannot edit the activation objects, but you can use Volume Activation Services to control and view them.  
  
#### To prepare Active Directory  
  
1.  If the forest is not already based on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] schema, run the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] \(or later\) version of Adprep.exe to update the schema.  
  
2.  Optionally, using an account with administrative access to the Domain Root Directory \(such as Enterprise Administrator\), run the script available in Appendix A of this topic. This creates the Licensing Security Group.  
  
3.  Optionally, the Enterprise Administrator can add accounts to the Licensing Security Group to delegate the ability to store activation objects.  
  
#### To activate the Active Directory forest  
  
1.  Obtain a customer\-specific volume license key \(CSVLK\).  
  
2.  Log into any computer joined to the domain that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] \(or later operating system\) with an account that is in the Licensing Security Group.  
  
3.  In the Volume Activation Tools of the Volume Activation service, start the CSVLK Installation wizard and complete the steps to install the CSVLK, choose **Activate AD**, and \(optionally\) create a friendly name for the activation object.  
  
    > [!NOTE]  
    > If online activation is not possible, you can use phone activation to obtain a CID from the CSVLK. Then enter the CID in the CSVLK Installation wizard.  
  
4.  Alternately, instead of using the wizard, you can install the CSVLK with the command **slmgr \/ad\-activation\-online <Product Key> \[Activation Object name\]**. \(See [Slmgr.vbs Options for Volume Activation](../Topic/Slmgr.vbs-Options-for-Volume-Activation.md).\) You can also install the CSVLK with the phone activation option.  
  
**To activate Windows on other computers in the domain**  
  
Once the activation object has been created as in the previous procedure, any computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] \(or later operating system\) that joins the domain becomes activated automatically.  
  
#### To manage the activation object  
  
1.  From an account in the Licensing Security Group, start ADSI Edit.  
  
2.  Using ADSI Edit, you can view the following properties of the activation object:  
  
    -   Partial product key  
  
    -   The KMS product ID  
  
    -   Supported editions  
  
    -   Creation date of the activation object  
  
    -   ACLs applied to the activation object  
  
3.  Alternately, from the command line, you can install, view, or delete activation objects with the Active Directory\-based activation configuration options of Slmgr.vbs. See [Slmgr.vbs Options for Volume Activation](../Topic/Slmgr.vbs-Options-for-Volume-Activation.md).  
  
4.  To delete activation objects, use Volume Activation Services or Slmgr.vbs.  
  
## Appendix A: Administration delegation script  
This script runs at the Enterprise Administrator level, creates the Licensing Security Group, and designates an owner for it. You can use it to delegate accounts the authority to view and manage the activation objects.  
  
```  
# Delegate activation script  
# user_name  
  
#.......................................  
# relax execution policy  
#.......................................  
set-executionpolicy Unrestricted  
  
#.......................................  
# import AD module  
#.......................................  
import-module ActiveDirectory  
  
#.......................................  
# Query domain Name  
#.......................................  
$domain = get-addomain  
  
#.......................................  
# Get the licensing admin  
#.......................................  
$Licensing_admin = Get-ADUser $args[0]  
$licensing_admin_sid = New-Object System.Security.Principal.SecurityIdentifier $Licensing_admin.SID   
$licensing_admin_dn = $licensing_admin.DistinguishedName  
  
#.......................................  
# Get domain DN  
#.......................................  
$dn=$domain.DistinguishedName  
  
#..................................................................................  
# Create a new AD-Group: "ms-SPP-Licensing-Administrators" and let admin manage it  
#..................................................................................  
New-ADGroup -Name "MS SPP Licensing Administrators" -SamAccountName msSPPLicensing -GroupCategory Security -GroupScope Universal -DisplayName "MS SPP Licensing Administrators"  
#Could possibly add error checking and warning if groups wasn't created and bail.  
  
$licensing_group = Get-ADGroup -Identity msSPPLicensing  
$licensing_group_sid = New-Object System.Security.Principal.SecurityIdentifier $licensing_group.SID   
$licensing_group_dn = $licensing_group.DistinguishedName  
  
$grp_acl = Get-Acl -Path:("AD:\" + $licensing_group_dn)  
  
#create ACE for write property (members)  
$guid = New-Object System.Guid "bf9679c0-0de6-11d0-a285-00aa003049e2"  
$grp_ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $licensing_admin_sid, "WriteProperty", "Allow", $guid  
$grp_acl.AddAccessRule($grp_ace)  
  
#create ACE for read property (members)  
$grp_ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $licensing_admin_sid, "ReadProperty", "Allow", $guid  
$grp_acl.AddAccessRule($grp_ace)  
  
Set-Acl -ACLObject:$grp_acl -Path:("AD:\" + $licensing_group_dn)  
  
#......................................................................  
# Get Activation container and make the licensing admin group in charge  
#......................................................................  
  
# Path to the Activation Container  
$Path_A="CN=Activation Objects,CN=Microsoft SPP,CN=Services,CN=Configuration,"+$dn  
#Could possibly add error checking and warning if container wasn't found.  
  
$grp_acl = Get-Acl -Path:("AD:\" + $Path_A)  
  
#create ACE for FC  
$grp_ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $licensing_group_sid, "GenericAll", "Allow"  
$grp_acl.AddAccessRule($grp_ace)  
  
Set-Acl -ACLObject:$grp_acl -Path:("AD:\" + $Path_A)  
  
#........................................................................  
# Add the licensing admin to the "ms-SPP-Licensing-Administrators" group  
#........................................................................  
  
Add-ADGroupMember $licensing_group -Members $licensing_admin_dn  
  
```  
  
