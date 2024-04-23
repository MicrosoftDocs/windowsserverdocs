---
title: How to raise Active Directory domain and forest functional levels
description: Describes how to raise Active Directory domain and forest functional levels.
ms.topic: troubleshooting
ms.author: robinharwood
author: gswashington
ms.date: 12/26/2023
---
# How to raise Active Directory domain and forest functional levels

This article describes how to raise Active Directory domain and forest functional levels.

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

This article discusses raising the domain and forest functional levels that are supported by Microsoft Windows Server domain controllers. There are multiple releases of Active Directory. Level changes are referenced by using the newer, current, or older versions of your domain controller operating system, the domain, or your forest functional level.

Functional levels are an extension of the mixed mode and the native mode concepts in Windows Server that activate Active Directory features. Additional Active Directory features are available when all the domain controllers are running the latest Windows Server version in a domain or in a forest, and when the administrator activates the corresponding functional level in the domain or in the forest.

To activate the newest domain features, all domain controllers must be running the newest Windows Server operating system version in the domain. If this requirement is met, the administrator can raise the domain functional level.

To activate the newest forest-wide features, all the domain controllers in the forest must be running the Windows Server operating system version that corresponds to the desired forest functional level. Additionally, the current domain functional level must already be at the newest level. If these requirements are met, the administrator can raise the forest functional level.

Generally, changes to the domain and forest functional levels are irreversible. If the change can be undone, a forest recovery must be used. Possible rollback of changes to domain and forest functional levels are described for specific scenarios in [Active Directory functional levels](/previous-versions/windows/it-pro/windows-server-2003/cc787290(v=ws.10)).

> [!NOTE]
> The newest domain functional levels and the newest forest functional levels affect only the way that the domain controllers operate together as a group. The clients that interact with the domain or with the forest are unaffected. Additionally, applications are unaffected by changes to the domain functional levels or to the forest functional levels. However, applications can take advantage of the newest domain features and of the newest forest features.
>
> For more information, see [Features associated with the various functional levels](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771294(v=ws.11)).

## Raising Active Directory domain and forest functional levels in Windows Server 2016

The following requirements apply to Active Directory domain and functional levels for Windows Server 2016.

Prerequisites:

- For newly created Active Directory forests under Windows Server 2025 (preview), the minimum functional level must be set to Server 2016

- If promoting Windows Server 2025 (preview) to a domain controller in an existing domain, that domain must also be at least at the Windows Server 2016 functional level.

- Promotion of an Active Directory or Active Directory Lightweight Directory Services replica requires that the existing domain or config set is already running with a functional level of Windows Server 2016 or greater.

### Upgrade options

Microsoft recommends upgrading Active Directory and Active Directory Lightweight Directory Services servers to Windows Server 2022 in preparation for the next release. When setting up a new domain function level and forest function level for a brand new forest and domain, specify these levels when promoting a server to a Domain controller. Install Active Directory Domain Services on  Windows Server 2025 (preview) which automatically runs adprep on the earlier version forest and domain.

> [!NOTE] 
> Ensure all domain controllers in the existing domain are at least at the 2016 functional level before promoting a Windows Server 2025 to a domain controller.

> [!NOTE] 
> Improved algorithms for Name/Sid Lookups in Windows Server 2025 (preview) no longer use the legacy Netlogon secure channel and instead use Kerberos authentication and DC Locator algorithm.

Review the latest documentation and release notes for Windows Server 2025 (preview) as they become available.

> [!IMPORTANT]
> Do not raise the functional level if the domain has or will have a domain controller that is of an earlier version than the version that is cited for that level. For example, a Windows Server 2016 functional level requires that all domain controllers have Windows Server 2016 or a later operating system installed in the domain or in the forest. After the domain functional level is raised to a higher level, it can only be changed back to an older level by using a forest recovery. This restriction exists because the features often change the communication between the domain controllers, or because the features change the storage of the Active Directory data in the database.

The most common method to enable the domain and forest functional levels is to use the graphical user interface (GUI) administration tools. See [Windows Server Active Directory functional levels](/previous-versions/windows/it-pro/windows-server-2003/cc759280(v=ws.10)). This article discusses Windows Server 2003. However, the steps are the same in later versions. Additionally, the functional level can be manually configured or can be configured by using Windows PowerShell scripts. For more information about how to manually configure the functional level, see the [](View and set the functional level).

For more information about how to use Windows PowerShell script to configure the functional level, view [Raise the Forest Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11)).

### View and set the functional level manually

Lightweight Directory Access Protocol (LDAP) tools such as Ldp.exe and Adsiedit.msc can be used to view and to modify the current domain and forest functional level settings. When you change the functional level attributes manually, the best practice is to make attribute changes on the Flexible Single Master Operations (FSMO) domain controller that is normally targeted by the Microsoft administrative tools.

#### Domain functional level settings

The msDS-Behavior-Version attribute is on the naming context (NC) head for the domain, that is, DC=corp, DC=contoso, DC=com.

You can set the following values for this attribute:

- Value of 0 or not set=mixed level domain
- Value of 1=Windows Server 2003 domain level
- Value of 2=Windows Server 2003 domain level
- Value of 3=Windows Server 2008 domain level
- Value of 4=Windows Server 2008 R2 domain level

#### Mixed mode and native mode settings

The ntMixedDomain  attribute is on the naming context (NC) head for the domain, that is, DC=corp, DC=contoso, DC=com.

You can set the following values for this attribute:

- Value of 0=Native level domain
- Value of 1=Mixed level domain

#### Forest level setting

The msDS-Behavior-Version attribute is on the CN=Partitions object in the Configuration naming context (NC), that is, CN=Partitions, CN=Configuration, DC= ForestRootDomain.  

You can set the following values for this attribute:

- Value of 0 or not set=mixed level forest
- Value of 1=Windows Server 2003 interim forest level
- Value of 2=Windows Server 2003 forest level

    > [!NOTE]
    > When you increase the msDS-Behavior-Version attribute from the 0 value to the 1 value by usingAdsiedit.msc, you receive the following error message:  
    Illegal modify operation. Some aspect of the modification is not permitted.

- Value of 3=Windows Server 2008 domain level
- Value of 4=Windows Server 2008 R2 domain level

After you use the Lightweight Directory Access Protocol (LDAP) tools to edit the functional level, click OK to continue. The attributes on the partitions container and on the domain head are correctly increased. If an error message is report by the Ldp.exe file, you can safely ignore the error message. To verify that the level increase was successful, refresh the attribute list, and then check the current setting. This error message may also occur after you have performed the level increase on the authoritative FSMO if the change has not yet replicated to the local domain controller.

#### Quickly view the current settings by using the Ldp.exe file

1. Start the Ldp.exe file.
2. On the **Connection** menu, click **Connect**.
3. Specify the domain controller that you want to query, or leave the space blank to connect to any domain controller.

After you connect to a domain controller, the RootDSE information for the domain controller appears. This information includes information on the forest, domain, and domain controllers. The following is an example of a Windows Server 2003-based domain controller. In the following example, assume that the domain mode is Windows Server 2003 and that the forest mode is Windows 2000 Server.

> [!NOTE]
> The domain controller functionality represents the highest possible functional level for this domain controller.
>
> - 1> domainFunctionality: 2=(DS_BEHAVIOR_WIN2003)
> - 1> forestFunctionality: 0=(DS_BEHAVIOR_WIN2000)
> - 1> domainControllerFunctionality: 2=(DS_BEHAVIOR_WIN2003)

### Requirements when you manually change the functional level

- You must change the domain mode to native mode before you raise the domain level if one of the following conditions is true:
  - The domain functional level is programmatically raised to the second functional level by directly modifying the value of the msdsBehaviorVersion attribute on the domainDNS object.
  - The domain functional level is raised to the second functional level by using the Ldp.exe utility or the Adsiedit.msc utility.

  If you do not change the domain mode to native mode before you raise the domain level, the operation is not completed successfully, and you receive the following error messages:
    > SV_PROBLEM_WILL_NOT_PERFORM
    >
    > ERROR_DS_ILLEGAL_MOD_OPERATION

    Additionally, the following message is logged in the Directory Services log:

    ```output
    Active Directory could not update the functional level of the following domain because the domain is in mixed mode.
    ```

    In this scenario, you can change the domain mode to native mode by using the Active Directory Users & Computers snap-in, by using the Active Directory Domains & Trusts UI MMC snap-in, or by programmatically changing the value of the ntMixedDomain attribute to 0 on the domainDNS object. When this process is used to raise the domain functional level to 2 (Windows Server 2003), the domain mode is automatically changed to native mode.

- The transition from mixed mode to native mode changes the scope of the Schema Administrators security group and the Enterprise Administrators security group to universal groups. When these groups have been changed to universal groups, the following message is logged in the System log:

    ```output
    Event Type: Information  
    Event Source: SAM  
    Event ID: 16408  
    Computer:Server Name  
    Description: "Domain operation mode has been changed to Native Mode. The change cannot be reversed."
    ```

- When the Windows Server 2003 administrative tools are used to invoke the domain functional level, both the ntmixedmode attribute and the msdsBehaviorVersion attribute are modified in the correct order. However, this does not always occur. In the following scenario, the native mode is implicitly set to a value of 0 without changing the scope for the Schema Administrators security group and the Enterprise Administrators security group to universal:
  - The msdsBehaviorVersion attribute that controls the domain functional mode is manually or programmatically set to the value of 2.
  - The forest functional level is set to 2 by using any method. In this scenario, the Domain controllers block the transition to the forest functional level until all of the domains that are in the local area network are configured to native mode and the required attribute change is made in the security group scopes.

### Functional levels relevant to Windows Server 2016, Windows Server 2022, and Windows Server 2025 (preview) 

There are many considerations when raising the operating system level of the domain controller. These considerations are caused by the storage and replication limitations of the linked attributes in Windows Server modes.

## Best practices

The following section discusses the best practices for increasing functional levels. The section is broken into two parts. "Preparation Tasks" discusses the work that you must do before the increase and "Optimal Paths Increase" discusses the motivations and methods for different level increase scenarios.

### Example: Preparation tasks before the level increase

In this example, the environment is raised from Windows Server 2000 mixed mode to Windows Server 2003 forest mode.

Inventory the forest for earlier versions of domain controllers.

If an accurate server list is not available, follow these steps:

1. To discover mixed level domains, Windows Server 2000 domain controllers, or domain controllers with damaged or missing objects, use Active Directory domains and the Trusts MMC snap-in.
2. In the snap-in, click **Raise Forest Functionality**, and then click **Save As** to generate a detailed report.
3. If no problems were found, the option to increase to Windows Server 2003 forest level is available from the **"Available Forest Functional Levels"** drop-down list. When you try to raise the forest level, the domain controller objects in the configuration containers are searched for any domain controllers that do not have **msds-behavior-version** set to the desired target level. These are assumed to be either Windows Server 2000 domain controllers or newer Windows Server domain controller objects that are damaged.
4. If earlier version domain controllers or domain controllers that have damaged or missing computer objects were found, they are included in the report. The status of these domain controllers must be investigated, and the domain controller representation in Active Directory must be repaired or removed by using the Ntdsutil file.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:  
[216498](https://support.microsoft.com/help/216498) How to remove data in active directory after an unsuccessful domain controller demotion

### Verify end-to-end replication is working in the forest

To verify that End to End replication is working in the forest, use the Windows Server 2003 or newer version of Repadmin against the Windows Server or the Windows Server domain controllers:

- `Repadmin/Replsum * /Sort:Delta[/Errorsonly]` for initial inventory.
- `Repadmin/Showrepl * /CSV>showrepl.csv`. Import to Excel, and then use the Data->Autofilter to identify replication features.

Use replication tools such as Repadmin to verify that forest-wide replication is working correctly.

Verify the compatibility of all programs or services with the newer Windows Server domain controllers and with the higher Windows Server domain and forest mode. Use a lab environment to thoroughly test production programs and services for compatibility issues. Contact vendors for confirmation of capability.

Prepare a back-out plan that includes of one of the following actions:

- Disconnect at least two domain controllers from each domain in the forest.
- Create a system state backup of at least two domain controllers from each domain in the forest.

Before the back-out plan can be used, all domain controllers in the forest must be decommissioned before the recovery process.

> [!NOTE]
> Level increases cannot be authoritatively restored. This means that all domain controllers that have replicated the level increase must be decommissioned.

After all the previous domain controllers are decommissioned, bring up the disconnected domain controllers or restore the domain controllers from the backup. Remove the metadata from all the other domain controllers, and then repromote them. This is a difficult process and must be avoided.

## See also

- [What's new in Active Directory Domain Services for Windows Server 2016](/windows-server/identity/whats-new-active-directory-domain-services).
