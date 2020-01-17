---
ms.assetid: e3d55565-ad45-4504-ad73-8103d1a92170
title: Install a New Windows Server 2012 Active Directory Child or Tree Domain (Level 200)
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Install a New Windows Server 2012 Active Directory Child or Tree Domain (Level 200)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains how to add child and tree domains to an existing Windows Server 2012 forest, using Server Manager or Windows PowerShell.  
  
-   [Child and Tree Domain Workflow](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md#BKMK_Workflow)  
  
-   [Child and Tree Domain Windows PowerShell](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md#BKMK_PS)  
  
-   [Deployment](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md#BKMK_Deployment)  
  
## <a name="BKMK_Workflow"></a>Child and Tree Domain Workflow  
The following diagram illustrates the Active Directory Domain Services configuration process when you previously installed the AD DS role and you have started the Active Directory Domain Services Configuration Wizard using Server Manager to create a new domain in an existing forest.  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/adds_childtreedeploy_beta1.png)  
  
## <a name="BKMK_PS"></a>Child and Tree Domain Windows PowerShell  
  
|||  
|-|-|  
|**ADDSDeployment Cmdlet**|Arguments (**Bold** arguments are required. *Italicized* arguments can be specified by using Windows PowerShell or the AD DS Configuration Wizard.)|  
|**Install-AddsDomain**|-SkipPreChecks<br /><br />***-NewDomainName***<br /><br />***-ParentDomainName***<br /><br />***-SafeModeAdministratorPassword***<br /><br />*-ADPrepCredential*<br /><br />-AllowDomainReinstall<br /><br />-Confirm<br /><br />*-CreateDNSDelegation*<br /><br />***-Credential***<br /><br />*-DatabasePath*<br /><br />*-DNSDelegationCredential*<br /><br />-NoDNSOnNetwork<br /><br />*-DomainMode*<br /><br />***-DomainType***<br /><br />-Force<br /><br />*-InstallDNS*<br /><br />*-LogPath*<br /><br />*-NewDomainNetBIOSName*<br /><br />*-NoGlobalCatalog*<br /><br />-NoNorebootoncompletion<br /><br />*-ReplicationSourceDC*<br /><br />*-SiteName*<br /><br />-SkipAutoConfigureDNS<br /><br />*-SYSVOLPath*<br /><br />*-Whatif*|  
  
> [!NOTE]  
> The **-credential** argument is only required when you are not currently logged on as a member of the Enterprise Admins group.The **-NewDomainNetBIOSName** argument is required if you want to change the automatically generated 15-character name based on the DNS domain name prefix or if the name exceeds 15 characters.  
  
## <a name="BKMK_Deployment"></a>Deployment  
  
### Deployment Configuration  
The following screenshot shows the options for adding a child domain:  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildDeployConfig.png)  
  
The following screenshot shows the options for adding a tree domain:  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_TreeDeployConfig.png)  
  
Server Manager begins every domain controller promotion with the **Deployment Configuration** page. The remaining options and required fields change on this page and subsequent pages, depending on which deployment operation you select.  
  
This topic combines two discrete operations: child domain promotion and tree domain promotion. The only difference between the two operations is the domain type that you choose to create. All of the other steps are identical between the two operations.  
  
-   To create a new child domain, click **Add a domain to an existing Forest** and choose **Child Domain**. For **Parent domain name**, type or select the name of the parent domain. Then type the name of the new domain in the **New domain name** box. Provide a valid, single-label child domain name; the name must use DNS domain name requirements.  
  
-   To create a tree domain within an existing forest, click **Add a domain to an existing Forest** and choose **Tree Domain**. Type the name of the forest root domain, and then type the name of the new domain. Provide a valid, fully qualified root domain name; the name cannot be single-labeled and must use DNS domain name requirements.  
  
For more information about DNS names, see [Naming conventions in Active Directory for computers, domains, sites, and OUs](https://support.microsoft.com/kb/909264).  
  
The Server Manager Active Directory Domain Services Configuration Wizard prompts you for domain credentials if your current credentials are not from the domain. Click **Change** to provide domain credentials for the promotion operation.  
  
The Deployment Configuration ADDSDeployment cmdlet and arguments are:  
  
```  
Install-AddsDomain  
-domaintype <{childdomain | treedomain}>  
-parentdomainname <string>  
-newdomainname <string>  
-credential <pscredential>  
```  
  
### Domain Controller Options  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_DCOptions_Child.gif)  
  
The **Domain Controller Options** page specifies the domain controller options for the new domain controller. The configurable domain controller options include **DNS server** and **Global Catalog**; you cannot configure read-only domain controller as the first domain controller in a new domain.  
  
Microsoft recommends that all domain controllers provide DNS and GC services for high availability in distributed environments. GC is always selected by default and DNS is selected by default if the current domain hosts DNS already on its DCs, based on a Start-of-Authority query. You must also specify a **Domain functional level**. The default functional level is Windows Server 2012, and you can choose any other value that is equal to or greater than the current forest functional level.  
  
The **Domain Controller Options** page also enables you to choose the appropriate Active Directory logical **site name** from the forest configuration. By default, the site with the most correct subnet is selected. If there is only one site, it is selected automatically.  
  
> [!IMPORTANT]  
> If the server does not belong to an Active Directory subnet and there is more than one Active Directory site, nothing is selected and the **Next** button is unavailable until you choose a site from the list.  
  
The specified **Directory Services Restore Mode Password** must adhere to the password policy applied to the server. Always choose a strong, complex password or preferably, a passphrase.  
  
The **Domain Controller Options** ADDSDeployment cmdlet arguments are:  
  
```  
-InstallDNS <{$false | $true}>  
-NoGlobalCatalog <{$false | $true}>  
-DomainMode <{Win2003 | Win2008 | Win2008R2 | Win2012 | Default}>  
-Sitename <string>  
-SafeModeAdministratorPassword <secure string>  
-Credential <pscredential>  
```  
  
> [!IMPORTANT]  
> The site name must already exist when provided as a value to the **sitename** argument. The **install-AddsDomainController** cmdlet does not create site names. You can use the **new-adreplicationsite** cmdlet to create new sites.  
  
The **Install-ADDSDomainController** cmdlet arguments follow the same defaults as Server Manager if not specified.  
  
The **SafeModeAdministratorPassword** argument's operation is special:  
  
-   If *not specified* as an argument, the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when running the cmdlet interactively.  
  
    For example, to create a new child domain named NorthAmerica in the Contoso.com forest and be prompted to enter and confirm a masked password:  
  
    ```  
    Install-ADDSDomain "NewDomainName NorthAmerica "ParentDomainName Contoso.com "DomainType Child  
    ```  
  
-   If specified *with a value*, the value must be a secure string. This is not the preferred usage when running the cmdlet interactively.  
  
For example, you can manually prompt for a password by using the **Read-Host** cmdlet to prompt the user for a secure string:  
  
```  
-safemodeadministratorpassword (read-host -prompt "Password:" -assecurestring)  
  
```  
  
> [!WARNING]  
> As the previous option does not confirm the password, use extreme caution: the password is not visible.  
  
You can also provide a secure string as a converted clear-text variable, although this is highly discouraged.  
  
```  
-safemodeadministratorpassword (convertto-securestring "Password1" -asplaintext -force)  
  
```  
  
Finally, you could store the obfuscated password in a file, and then reuse it later, without the clear text password ever appearing. For example:  
  
```  
$file = "c:\pw.txt"  
$pw = read-host -prompt "Password:" -assecurestring  
$pw | ConvertFrom-SecureString | Set-Content $file  
  
-safemodeadministratorpassword (Get-Content $File | ConvertTo-SecureString)  
  
```  
  
> [!WARNING]  
> Providing or storing a clear or obfuscated text password is not recommended. Anyone running this command in a script or looking over your shoulder knows the DSRM password of that domain controller.  Anyone with access to the file could reverse that obfuscated password. With that knowledge, they can logon to a DC started in DSRM and eventually impersonate the domain controller itself, elevating their privileges to the highest level in an AD forest. An additional set of steps using **System.Security.Cryptography** to encrypt the text file data is advisable but out of scope. The best practice is to totally avoid password storage.  
  
The ADDSDeployment module offers an additional option to skip automatic configuration of DNS client settings, forwarders, and root hints. This is not configurable when using Server Manager. This argument matters only if you already installed the DNS Server service prior to configuring the domain controller:  
  
```  
-SkipAutoConfigureDNS  
  
```  
  
### DNS Options and DNS Delegation Credentials  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildDNSOptions.png)  
  
The **DNS Options** page enables you to provide alternate DNS Admin credentials for delegation.  
  
When installing a new domain in an existing forest - where you selected DNS installation on the **Domain Controller Options** page - you cannot configure any options; the delegation happens automatically and irrevocably. You have the option to provide alternate DNS administrative credentials with rights to update that structure.  
  
The **DNS Options** ADDSDeployment Windows PowerShell arguments are:  
  
```  
-creatednsdelegation   
-dnsdelegationcredential <pscredential>  
```  
  
For more information about DNS delegation, see [Understanding Zone Delegation](https://technet.microsoft.com/library/cc771640.aspx).  
  
### Additional Options  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildAdditionalOptions.png)  
  
The **Additional Options** page shows the NetBIOS name of the domain and enables you to override it. By default, the NetBIOS domain name matches the left-most label of the fully qualified domain name provided on the **Deployment Configuration** page. For example, if you provided the fully qualified domain name of corp.contoso.com, the default NetBIOS domain name is CORP.  
  
If the name is 15 characters or less and does not conflict with another NetBIOS name, it is unaltered. If it does conflict with another NetBIOS name, a number is appended to the name. If the name is more than 15 characters, the wizard provides a unique, truncated suggestion. In either case, the wizard first validates the name is not already in use via a WINS lookup and NetBIOS broadcast.  
  
For more information about DNS names, see [Naming conventions in Active Directory for computers, domains, sites, and OUs](https://support.microsoft.com/kb/909264).  
  
The **Install-AddsDomain** arguments follow the same defaults as Server Manager if not specified. The **DomainNetBIOSName** operation is special:  
  
1.  If the **NewDomainNetBIOSName** argument is not specified with a NetBIOS domain name and the single-label prefix domain name in the **DomainName** argument is 15 characters or fewer, then promotion continues with an automatically generated name.  
  
2.  If the **NewDomainNetBIOSName** argument is not specified with a NetBIOS domain name and the single-label prefix domain name in the **DomainName** argument is 16 characters or more, then promotion fails.  
  
3.  If the **NewDomainNetBIOSName** argument is specified with a NetBIOS domain name of 15 characters or fewer, then promotion continues with that specified name.  
  
4.  If the **NewDomainNetBIOSName** argument is specified with a NetBIOS domain name of 16 characters or more, then promotion fails.  
  
The **Additional Options** ADDSDeployment cmdlet argument is:  
  
```  
-newdomainnetbiosname <string>  
```  
  
### Paths  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_UpgradePaths.png)  
  
The **Paths** page enables you to override the default folder locations of the AD DS database, the data base transaction logs, and the SYSVOL share. The default locations are always in subdirectories of %systemroot%.  
  
The **Paths** ADDSDeployment cmdlet arguments are:  
  
```  
-databasepath <string>  
-logpath <string>  
-sysvolpath <string>  
```  
  
### Review Options and View Script  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildReviewOptions.png)  
  
The **Review Options** page enables you to validate your settings and ensure they meet your requirements before you start the installation. This is not the last opportunity to stop the installation when using Server Manager. This is simply an option to confirm your settings before continuing the configuration  
  
The **Review Options** page in Server Manager also offers an optional **View Script** button to create a Unicode text file that contains the current ADDSDeployment configuration as a single Windows PowerShell script. This enables you to use the Server Manager graphical interface as a Windows PowerShell deployment studio. Use the Active Directory Domain Services Configuration Wizard to configure options, export the configuration, and then cancel the wizard.  This process creates a valid and syntactically correct sample for further modification or direct use. For example:  
  
```  
#  
# Windows PowerShell Script for AD DS Deployment  
#  
  
Import-Module ADDSDeployment  
Install-ADDSDomain `  
-NoGlobalCatalog:$false `  
-CreateDNSDelegation `  
-Credential (Get-Credential) `  
-DatabasePath "C:\Windows\NTDS" `  
-DomainMode "Win2012" `  
-DomainType "ChildDomain" `  
-InstallDNS:$true `  
-LogPath "C:\Windows\NTDS" `  
-NewDomainName "research" `  
-NewDomainNetBIOSName "RESEARCH" `  
-ParentDomainName "corp.contoso.com" `  
-Norebootoncompletion:$false `  
-SiteName "Default-First-Site-Name" `  
-SYSVOLPath "C:\Windows\SYSVOL"  
-Force:$true  
  
```  
  
> [!NOTE]  
> Server Manager generally fills in all arguments with values when promoting and does not rely on defaults (as they may change between future versions of Windows or service packs). The one exception to this is the **-safemodeadministratorpassword** argument (which is deliberately omitted from the script). To force a confirmation prompt, omit the value when running cmdlet interactively.  
  
Use the optional **Whatif** argument with the **Install-ADDSForest** cmdlet to review configuration information. This enables you to see the explicit and implicit values of the arguments for a cmdlet.  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildWhatIf.png)  
  
### Prerequisites Check  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildPrereqCheck.png)  
  
The **Prerequisites Check** is a new feature in AD DS domain configuration. This new phase validates that the server configuration is capable of supporting a new AD DS domain.  
  
When installing a new forest root domain, the Server Manager Active Directory Domain Services Configuration Wizard invokes a series of serialized modular tests. These tests alert you with suggested repair options. You can run the tests as many times as required. The domain controller process cannot continue until all prerequisite tests pass.  
  
The **Prerequisites Check** also surfaces relevant information such as security changes that affect older operating systems.  
  
For more information on the specific prerequisite checks, see [Prerequisite Checking](../../ad-ds/manage/AD-DS-Simplified-Administration.md#BKMK_PrereuisiteChecking).  
  
You cannot bypass the **Prerequisite Check** when using Server Manager, but you can skip the process when using the AD DS Deployment cmdlet using the following argument:  
  
```  
-skipprechecks  
```  
  
> [!WARNING]  
> Microsoft discourages skipping the prerequisite check as it can lead to a partial domain controller promotion or damaged AD DS forest.  
  
Click **Install** to begin the domain controller promotion process. This is last opportunity to cancel the installation. You cannot cancel the promotion process once it begins. The computer will reboot automatically at the end of promotion, regardless of the promotion results.  
  
### Installation  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ChildInstallation.png)  
  
When the **Installation** page displays, the domain controller configuration begins and cannot be halted or canceled. Detailed operations display on this page and are written to logs:  
  
-   %systemroot%\debug\dcpromo.log  
  
-   %systemroot%\debug\dcpromoui.log  
  
To install a new Active Directory domain using the ADDSDeployment module, use the following cmdlet:  
  
```  
Install-addsdomain  
```  
  
See [Child and Tree Domain Windows PowerShell](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md#BKMK_PS) for required and optional arguments.The **Install-addsdomain** cmdlet only has two phases (prerequisite checking and installation). The two figures below show the installation phase with the minimum required arguments of **-domaintype**, **-newdomainname**, **-parentdomainname**, and **-credential**. Note how, just like Server Manager, **Install-ADDSDomain** reminds you that promotion will reboot the server automatically.  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_PSInstallADDSDomain.png)  
  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_PSInstallADDSDomainProgress.png)  
  
To accept the reboot prompt automatically, use the **-force** or **-confirm:$false** arguments with any ADDSDeployment Windows PowerShell cmdlet. To prevent the server from automatically rebooting at the end of promotion, use the **-norebootoncompletion** argument.  
  
> [!WARNING]  
> Overriding the reboot is not recommended. The domain controller must reboot to function correctly  
  
### Results  
![Install a new AD Child](media/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-/ADDS_SMI_TR_ForestSignOff.png)  
  
The **Results** page shows the success or failure of the promotion and any important administrative information. The domain controller will automatically reboot after 10 seconds.  
  

