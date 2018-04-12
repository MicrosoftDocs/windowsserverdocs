---
title: Configuring user access control and permissions
description: Learn how to configure user access control and permissions using Active Directory or Azure AD (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Configure User Access Control and Permissions

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

> [!NOTE] 
> Access management only applies when you are running Windows Admin Center as a service on Windows Server.

If you haven't already, familiarize yourself with the [user access control options in Windows Admin Center](../plan/user-access-options.md).

## Gateway access role definitions

There are two roles for access to the Windows Admin Center gateway service:

**Gateway users** can connect to the Windows Admin Center gateway service to manage servers through that gateway, but they can't change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users authenticate to the gateway. Only gateway administrators can view and configure the Access settings in Windows Admin Center. Local administrators on the gateway machine are always administrators of the Windows Admin Center gateway service.

> [!NOTE] 
> Access to the gateway doesn't imply access to managed servers visible by the gateway. To manage a target server, the connecting user must use credentials (either through their passed-through Windows credential or through credentials provided in the Windows Admin Center session using the **Manage as** action) that have administrative access to that target server.

## Choose the identity provider

By default, any user that navigates to the gateway URL has access to the Windows Admin Center service. Only local administrators on the gateway computer have administrator access to the Windows Admin Center service.

Gateway administrators can choose which identity provider to use for gateway access in the Window Admin Center general settings, on the **Access** tab. Windows Admin Center supports using either Active Directory/local groups or Azure Active Directory (Azure AD). By choosing Azure AD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by Azure AD. 

## Active Directory or local machine groups

When you choose Active Directory or local machine groups as your identity provider for gateway access, you can manage gateway user and administrator access from within the Windows Admin Center interface.

On the **Users** tab you can control who can access Windows Admin Center as a gateway user. By default, and if you don't specify a security group, any user that accesses the gateway URL has access. Once you add one or more security groups to the users list, access is restricted to the members of those groups.


### Smartcard authentication
You can enforce **smartcard authentication** by specifying an additional _required_ group for smartcard-based security groups. Once you have added a smartcard-based security group, a user can only access the Windows Admin Center service if they are a member of any security group AND a smartcard group included in the users list.

On the **Administrators** tab you can control who can access Windows Admin Center as a gateway administrator. The local administrators group on the computer will always have full administrator access and cannot be removed from the list. By adding security groups, you give members of those groups privileges to change Windows Admin Center gateway settings. The administrators list supports smartcard authentication in the same way as the users list: with the AND condition for a security group and a smartcard group.

## Azure Active Directory

If you choose Azure Active Directory (Azure AD) as your identity provider, you'll manage user and administrator access from the Azure Portal, rather from within the Windows Admin Center UI.

[To set up Azure AD, you must first connect your gateway to Azure](azure-integration.md#connect-your-gateway-to-azure) (you only need to do this once for your Windows Admin Center gateway). This step creates an Azure AD application from which you can manage gateway user and gateway administrator access.

By default, all members of the Azure AD tenant have user access to the Windows Admin Center gateway service. Only local administrators on the gateway machine have administrator access to the Windows Admin Center gateway.

If you want to give specific Azure AD users or groups gateway user or gateway administrator access to the Windows Admin Center service, you must do the following:

1.	Go to your SME Azure AD application in the Azure portal. 
    -	When you click **Change access control** and then select **Azure Active Directory** from the Windows Admin Center Access settings, you can use the hyperlink provided in the UI to access your Azure AD application in the Azure portal. This hyperlink is also available in the Access settings after you click save and have selected Azure AD as your access control identity provider.
    -	You can also find your application in the Azure portal by going to **Azure Active Directory** > **Enterprise applications** > **All applications** and searching **SME** (the Azure AD app will be named SME-<gateway>). If you don't get any search results, ensure **Show** is set to **all applications**, **application status** is set to **any** and click Apply, then try your search. Once you've found the application, go to **Users and groups**
2.	In the Properties tab, set **User assignment required** to Yes.
    Once you've done this, only members listed in the **Users and groups** tab will be able to access the Windows Admin Center gateway.
3.	In the Users and groups tab, select **Add user**. You must assign a gateway user or gateway administrator role for each user/group added.

Once you save the Azure AD access control in the **Change access control** pane, the gateway service restarts and you must refresh your browser. You can update user access for the SME Azure AD application in the Azure portal at any time. 

Users will be prompted to sign in using their Azure Active Directory identity when they attempt to access the Windows Admin Center gateway URL. On the **Azure** tab of Windows Admin Center general settings, users and administrators can view their currently logged-in account and as well as sign-out of this Azure AD account.

### Conditional access and multi-factor authentication

One of the benefits of using Azure AD as your identity provider to control access to the Windows Admin Center gateway is that you can leverage Azure AD's powerful security features like conditional access and multi-factor authentication. 

[Learn more about configuring conditional access with Azure Active Directory.](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started)

## Configure single sign-on

**Single sign-on when deployed as a Service on Windows Server**

When you install Windows Admin Center on Windows 10, it's ready to use single sign-on. If you're going to use Windows Admin Center on Windows Server, however, you need to set up some form of Kerberos delegation in your environment before you can use single sign-on. The delegation configures the gateway computer as trusted to delegate to the target node. 

To configure [Resource-based constrained delegation](http://windowsitpro.com/security/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-1) in your environment, run the following PowerShell cmdlets. (Be aware that this requires a domain controller running Windows Server 2012 or later).

```powershell
     $gateway = "WindowsAdminCenterGW"
     $node = "ManagedNode"
     $gatewayObject = Get-ADComputer -Identity $gateway
     $nodeObject = Get-ADComputer -Identity $node
     Set-ADComputer -Identity $nodeObject -PrincipalsAllowedToDelegateToAccount $gatewayObject
```

In this example, the Windows Admin Center gateway is installed on server **WindowsAdminCenterGW**, and the target
node name is **ManagedNode**.

To remove this relationship, run the following cmdlet:

```powershell
Set-ADComputer -Identity $nodeObject -PrincipalsAllowedToDelegateToAccount $null
```

## Role-based access control

Role-based access control enables you to provide users with limited access to the machine instead of making them full local administrators.
[Read more about role-based access control and the available roles.](../plan/user-access-options.md#role-based-access-control)

Setting up RBAC consists of 2 steps: enabling support on the target computer(s) and assigning users to the relevant roles.

> [!TIP]
> Make sure you have local administrator privileges on the machines where you are configuring support for role-based access control.

### Apply role-based access control to a single machine

The single machine deployment model is ideal for simple environments with only a few computers to manage.
Configuring a machine with support for role-based access control will result in the following changes:
-   PowerShell modules with functions required by Windows Admin Center will be installed on your system drive, under `C:\Program Files\WindowsPowerShell\Modules`. All modules will start with **Microsoft.Sme**
-   Desired State Configuration will run a one-time configuration to configure a Just Enough Administration endpoint on the machine, named **Mirosoft.Sme.PowerShell**. This endpoint defines the 3 roles used by Windows Admin Center and will run as a temporary local administrator when a user connects to it.
-   3 new local groups will be created to control which users are assigned access to which roles:
    -   Windows Admin Center Administrators
    -   Windows Admin Center Hyper-V Administrators
    -   Windows Admin Center Readers

To enable support for role-based access control on a single machine, follow these steps:

1.  Open Windows Admin Center and connect to the machine you wish to configure with role-based access control using an account with local administrator privileges on the target machine.
2.  On the **Overview** tool, click **Settings** > **Role-based access control**.
3.  Click **Apply** at the bottom of the page to enable support for role-based access control on the target computer. The application process involves copying PowerShell scripts and invoking a configuration (using PowerShell Desired State Configuration) on the target machine. It may take up to 10 minutes to complete, and will result in WinRM restarting. This will temporarily disconnect Windows Admin Center, PowerShell, and WMI users.
4.  Refresh the page to check the status of role-based access control. When it is ready for use, the status will change to **Applied**.

Once the configuration is applied, you can assign users to the roles:

1.  Open the **Local Users and Groups** tool and navigate to the **Groups** tab.
2.  Select the **Windows Admin Center Readers** group.
3.  In the *Details* pane at the bottom, click **Add User** and enter the name of a user or security group which should have read-only access to the server through Windows Admin Center. The users and groups can come from the local machine or your Active Directory domain.
4.  Repeat steps 2-3 for the **Windows Admin Center Hyper-V Administrators** and **Windows Admin Center Administrators** groups.

You can also fill these groups consistently across your domain by configuring a Group Policy Object with the [Restricted Groups Policy Setting](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc756802%28v=ws.10%29).

### Apply role-based access control to multiple machines

In a large enterprise deployment, you can use your existing automation tools to push out the role-based access control feature to your computers by downloading the configuration package from the Windows Admin Center gateway.
The configuration package is designed to be used with PowerShell Desired State Configuration, but you can adapt it to work with your preferred automation solution.

#### Download the role-based access control configuration

To download the role-based access control configuration package, you'll need to have access to Windows Admin Center and a PowerShell prompt.

If you're running the Windows Admin Center gateway in service mode on Windows Server, use the following command to download the configuration package.
Be sure to update the gateway address with the correct one for your environment.

```powershell
$WindowsAdminCenterGateway = 'https://windowsadmincenter.contoso.com:6516'
Invoke-RestMethod -Uri "$WindowsAdminCenterGateway/api/nodes/all/features/jea/endpoint/export" -Method POST -UseDefaultCredentials -OutFile "~\Desktop\WindowsAdminCenter_RBAC.zip"
```

If you're running the Windows Admin Center gateway on your Windows 10 machine, run the following command instead:

```powershell
$cert = Get-ChildItem Cert:\CurrentUser\My | Where-Object Subject -eq 'CN=Windows Admin Center Client' | Select-Object -First 1
Invoke-RestMethod -Uri "https://localhost:6516/api/nodes/all/features/jea/endpoint/export" -Method POST -Certificate $cert -OutFile "~\Desktop\WindowsAdminCenter_RBAC.zip"
```

When you expand the zip archive, you'll see the following folder structure:
- InstallJeaFeatures.ps1
- JustEnoughAdministration (directory)
- Modules (directory)
    - Microsoft.SME.\* (directories)
    - WindowsAdminCenter.Jea (directory)

To configure support for role-based access control on a node, you need to perform the following actions:
1.  Copy the JustEnoughAdministration, Microsoft.SME.\*, and WindowsAdminCenter.Jea modules to the PowerShell module directory on the target machine. Typically, this is located at `C:\Program Files\WindowsPowerShell\Modules`.
2.  Update **InstallJeaFeature.ps1** file to match your desired configuration for the RBAC endpoint.
3.  Run InstallJeaFeature.ps1 to compile the DSC resource.
4.  Deploy your DSC configuration to all of your machines to apply the configuration.

The following section explains how to do this using PowerShell Remoting.

#### Deploy on multiple machines

To deploy the configuration you downloaded onto multiple machines, you'll need to update the **InstallJeaFeatures.ps1** script to include the appropriate security groups for your environment, copy the files to each of your computers, and invoke the configuration scripts.
You can use your preferred automation tooling to accomplish this, however this article will focus on a pure PowerShell-based approach.

By default, the configuration script will create local security groups on the machine to control access to each of the roles.
This is suitable for workgroup and domain joined machines, but if you're deploying in a domain-only environment you may wish to directly associate a domain security group with each role.
To update the configuration to use domain security groups, open **InstallJeaFeatures.ps1** and make the following changes:

1.  Remove the 3 **Group** resources from the file:
    1.  "Group MS-Readers-Group"
    2.  "Group MS-Hyper-V-Administrators-Group"
    3.  "Group MS-Administrators-Group"
2.  Remove the 3 Group resources from the JeaEndpoint **DependsOn** property
    1.  "[Group]MS-Readers-Group"
    2.  "[Group]MS-Hyper-V-Administrators-Group"
    3.  "[Group]MS-Administrators-Group"
3.  Change the group names in the JeaEndpoint **RoleDefinitions** property to your desired security groups. For example, if you have a security group *CONTOSO\MyTrustedAdmins* that should be assigned access to the Windows Admin Center Administrators role, change `'$env:COMPUTERNAME\Windows Admin Center Administrators'` to `'CONTOSO\MyTrustedAdmins'`. The three strings you need to update are:
    1.  '$env:COMPUTERNAME\Windows Admin Center Administrators'
    2.  '$env:COMPUTERNAME\Windows Admin Center Hyper-V Administrators'
    3.  '$env:COMPUTERNAME\Windows Admin Center Readers'

> [!NOTE]
> Be sure to use unique security groups for each role. Configuration will fail if the same security group is assigned to multiple roles.

Next, at the end of the **InstallJeaFeatures.ps1** file, add the following lines of PowerShell to the bottom of the script:

```powershell
Copy-Item "$PSScriptRoot\JustEnoughAdministration" "$env:ProgramFiles\WindowsPowerShell\Modules" -Recurse -Force
$ConfigData = @{
    AllNodes = @()
    ModuleBasePath = @{
        Source = "$PSScriptRoot\Modules"
        Destination = "$env:ProgramFiles\WindowsPowerShell\Modules"
    }
}
InstallJeaFeature -ConfigurationData $ConfigData | Out-Null
Start-DscConfiguration -Path "$PSScriptRoot\InstallJeaFeature" -JobName "Installing JEA for Windows Admin Center" -Force
```

Finally, you can copy the folder containing the modules, DSC resource and configuration to each target node and run the **InstallJeaFeature.ps1** script.
To do this remotely from your admin workstation, you can run the following commands:

```powershell
$ComputersToConfigure = 'MyServer01', 'MyServer02'

$ComputersToConfigure | ForEach-Object {
    $session = New-PSSession -ComputerName $_ -ErrorAction Stop
    Copy-Item -Path "~\Desktop\WindowsAdminCenter_RBAC\JustEnoughAdministration\" -Destination "$env:ProgramFiles\WindowsPowerShell\Modules\" -ToSession $session -Recurse -Force
    Copy-Item -Path "~\Desktop\WindowsAdminCenter_RBAC" -Destination "$env:TEMP\WindowsAdminCenter_RBAC" -ToSession $session -Recurse -Force
    Invoke-Command -Session $session -ScriptBlock { Import-Module JustEnoughAdministration; & "$env:TEMP\WindowsAdminCenter_RBAC\InstallJeaFeature.ps1" } -AsJob
    Disconnect-PSSession $session
}
```
