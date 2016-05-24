---
title: Troubleshooting General Issues_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71fe9fa9-2f9c-4dbd-8a42-ee8152edcfc4
---
# Troubleshooting General Issues_1
This topic contains troubleshooting information for general issues related to Remote Access.  
  
## GPO retrieval error  
**Error received**—DirectAccess server GPO settings cannot be retrieved. Ensure you have edit permissions for the GPO.  
  
The Remote Access management console is unresponsive after receiving this error.  
  
**Cause**  
  
DirectAccess cannot access the GPO of one of the entry points in the deployment and as a result the configuration fails to load.  
  
**Solution**  
  
Make sure that each entry point in the deployment has a corresponding GPO on its domain controller and verify that the logged on user has read and write permissions for all GPOs configured in the Remote Access deployment.  
  
As a workaround, use the configuration cmdlets instead of using the Remote Access management console; for example, using `Get-RemoteAccess` and `Get-DAEntryPoint`.  
  
> [!NOTE]  
> This scenario does not occur when the server GPO of the current entry point isn’t available.  
  
You can use the `Get-DAEntryPointDC` cmdlet to list all domain controllers that store server GPOs and `Get-DAMultiSite` in conjunction with `Get-RemoteAccess` to retrieve a complete list of the server GPOs in the deployment. For example:  
  
```  
$ServerGpos = Get-DAEntryPointDC | ForEach-Object {   
   @{   
       GpoName = (Get-RemoteAccess -EntryPoint $_.EntryPointName).ServerGpoName;   
        DC = $_.DomainControllerName }   
}  
$ServerGpos | ForEach-Object { $GpoName = $_['GpoName'] ; $DC = $_['DC'] ; Write-Host "Server GPO '$GpoName' on DC '$DC'" }  
```  
  
## Windows 7 to Windows 8 client upgrade  
**Symptom**—After a [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client upgrades to [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] in a multisite deployment, the DirectAccess connection is not visible in the Networks list.  
  
**Cause**  
  
The [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] GPOs in a multisite deployment do not contain the [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] Network Connectivity Assistant configuration.  
  
[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] clients should use DirectAccess Connectivity Assistant to monitor their DirectAccess connectivity status which requires a separate manual configuration in the [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client GPOs. When [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] clients are upgraded to [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], the Network Connectivity Assistant will not function if the [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client GPO is still applied.  
  
**Solution**  
  
If DirectAccess Connectivity Assistant settings are configured in the [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] GPOs, you can resolve this issue before upgrading client computers by modifying the [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] GPOs using the following PowerShell cmdlets:  
  
```  
Set-GPRegistryValue -Name <Windows7GpoName> -Domain <DomainName> -Key "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityAssistant" -ValueName "TemporaryValue" -Type Dword -Value 1  
Remove-GPRegistryValue -Name <Windows7GpoName> -Domain <DomainName> -Key "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityAssistant"  
```  
  
If a client has already been upgraded or the DCA is not configured, move the client computer to the [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] security group.  
  
## General cmdlet errors  
  
-   **Issue 1**  
  
    **Error received**—Domain controller <domain\_controller> cannot be reached for <server\_name or entry\_point\_name>.  
  
    **Cause**  
  
    To maintain the configuration consistency in a multisite deployment, it is important to make sure that each GPO is managed by a single domain controller. When the domain controller that manages an entry point’s server GPO is not available, Remote Access configuration settings cannot be read or modified.  
  
    **Solution**  
  
    Follow the procedure “To change the domain controller that manages server GPOs” described in [2.4. Configure GPOs](../Topic/Step-2--Configure-the-Multisite-Infrastructure.md#ConfigGPOs).  
  
-   **Issue 2**  
  
    **Error received**—The primary domain controller in domain <domain\_name> cannot be reached.  
  
    **Cause**  
  
    To maintain the configuration consistency in a multisite deployment, it is important to make sure that each GPO is managed by a single domain controller. Client GPOs are managed on the primary domain controller. If the primary domain controller is not available, Remote Access configuration settings cannot be read or modified.  
  
    **Solution**  
  
    Follow the procedure “To transfer the PDC emulator role” described in [2.4. Configure GPOs](../Topic/Step-2--Configure-the-Multisite-Infrastructure.md#ConfigGPOs).  
  
