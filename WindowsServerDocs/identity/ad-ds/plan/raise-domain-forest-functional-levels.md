---
title: How to raise Active Directory domain and forest functional levels
description: Learn how to raise Active Directory domain and forest functional levels
ms.topic: troubleshooting
ms.author: robinharwood
author: gswashington
ms.date: 05/15/2024
---
# How to raise Active Directory domain and forest functional levels

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

This article describes how to raise Active Directory domain and forest functional levels in Microsoft Windows Server domain controllers. Functional levels are the release of Active Directory that your domain controller operating system uses. Level changes happen when you use later or earlier versions of your domain controller operating system, the domain, or your forest functional level.

Functional levels are an extension of the mixed mode and native mode concepts in Windows Server that activate Active Directory features. Active Directory features become available when all domain controllers run the latest version of Windows Server in a domain or forest and the administrator activates the corresponding functional level.

To activate the latest domain features, all domain controllers in the domain must run the latest version of Windows Server. If they don't meet this requirement, the administrator can raise the domain functional level.

To activate the latest forest-wide features, all domain controllers in the forest must run the Windows Server operating system version that matches the desired forest functional level. The current domain functional level must also already be at the latest level. If the forest meets these requirements, the administrator can raise the forest functional level.

Changes to the domain and forest functional levels are usually irreversible. In order to undo the change, you must use a forest recovery to revert to an earlier version of your forest. You can find a more detailed look at rollback scenarios when you need to undo changes to a domain or forest functional level in [Active Directory functional levels](/previous-versions/windows/it-pro/windows-server-2003/cc787290(v=ws.10)).

> [!NOTE]
> The latest domain and forest functional levels only affect how the domain controllers operate together as a group. The clients that interact with the domain or with the forest are unaffected by the changes. Applications are also unaffected by these changes. However, applications can use new features they can access in later versions of Windows Server once the administrator raises the domain level.For more information, see [Features associated with the various functional levels](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771294(v=ws.11)).

## Raising Active Directory domain and forest functional levels in Windows Server

The following requirements apply to Active Directory domain and functional levels for Windows Server 2016 and later versions.

Prerequisites for Windows Server 2016:

- Promoting an Active Directory or Active Directory Lightweight Directory Services replica requires that the existing domain or config set is already running with a functional level of Windows Server 2016 or greater.

Prerequisites for later versions of Windows Server

- For newly created Active Directory forests under Windows Server 2025 (preview), you must set the minimum functional level to Windows Server 2016.
- ...

> [!NOTE]
> If you're promoting Windows Server 2025 (preview) to a domain controller in an existing domain, that domain must also be at least at the Windows Server 2016 functional level.

### Upgrade options

We recommend you upgrade Active Directory and Active Directory Lightweight Directory Services servers to Windows Server 2022 to prepare for the Windows Server 2025 (preview) release. When setting up a new domain function level and forest function level for a new forest and domain, specify these levels when promoting a server to a domain controller. When you install Active Directory Domain Services on Windows Server 2025 (preview), it automatically runs adprep on any forest or domain running earlier versions of Windows Server.

> [!NOTE] 
> Before you can promote a machine running Windows Server 2025 to a domain controller, you must make sure all domain controllers in the existing domain are running Windows Server 2016 or later. Earlier versions of Windows Server don't support Windows Server 2025 domain controllers.

> [!NOTE] 
> Improved algorithms for Name/Sid Lookups in Windows Server 2025 (preview) no longer use the legacy Netlogon secure channel and instead use Kerberos authentication and the DC Locator algorithm.

The most common method to enable the domain and forest functional levels is to use the graphical user interface (GUI) administration tools. You can learn more about how the GUI tools work at [Windows Server Active Directory functional levels](/previous-versions/windows/it-pro/windows-server-2003/cc759280(v=ws.10)). You can either manually configure the functional level or use PowerShell cmdlets. For more information about how to manually configure the functional level, see [View and set the functional level manually](#view-and-set-the-functional-level-manually). For more information about how to use Windows PowerShell script to configure the functional level, view [Raise the Forest Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11)).

### View and set the functional level manually

You can use Lightweight Directory Access Protocol (LDAP) tools such as Ldp.exe and Adsiedit.msc to view and modify the current domain and forest functional level settings. When you change the functional level attributes manually, you should make attribute changes on the Flexible Single Master Operations (FSMO) domain controller that's targeted by the Microsoft administrative tools.

#### Domain functional level settings

The msDS-Behavior-Version attribute is on the naming context (NC) head for the domain.

You can set the following values for this attribute:

- 0 or no setting = mixed level domain
- 1 = Windows Server 2003 domain level
- 2 = Windows Server 2003 domain level
- 3 = Windows Server 2008 domain level
- 4 = Windows Server 2008 R2 domain level

#### Mixed mode and native mode settings

The ntMixedDomain attribute is on the naming context (NC) head for the domain, that is, DC=corp, DC=contoso, DC=com.

You can set the following values for this attribute:

- 0 = Native level domain
- 1 = Mixed level domain

#### Forest level setting

The msDS-Behavior-Version attribute is on the CN=Partitions object in the Configuration naming context (NC), that is, CN=Partitions, CN=Configuration, DC= ForestRootDomain.  

You can set the following values for this attribute:

- 0 or not set = mixed level forest
- 1 = Windows Server 2003 interim forest level
- 2 = Windows Server 2003 forest level

    > [!NOTE]
    > When you increase the msDS-Behavior-Version attribute value from 0 to 1 using Adsiedit.msc, an error message appears that says "Illegal modify operation. Some aspect of the modification is not permitted."

- 3 = Windows Server 2008 domain level
- 4 = Windows Server 2008 R2 domain level

After you use the Lightweight Directory Access Protocol (LDAP) tools to edit the functional level, select **OK** to continue. The attributes on the partitions container and on the domain head automatically increase to the correct levels. If the Ldp.exe file displays an error message, you can safely ignore it. To verify that the level increase was successful, refresh the attribute list, then check the current settings. This error message may also appear after you increase the level on the authoritative FSMO if the change hasn't replicated to the local domain controller yet.

To use the Ldp.exe file to view the current settings:

1. Open the Ldp.exe file.
2. On the **Connection** menu, select **Connect**.
3. Specify the domain controller that you want to query, or leave the space blank to connect to any domain controller.

After you connect to a domain controller, the RootDSE information for the domain controller appears. This information includes information on the forest, domain, and domain controllers. The following example shows a Windows Server 2003-based domain controller. In the following example, assume that the domain mode is Windows Server 2003 and that the forest mode is Windows 2000 Server.

> [!NOTE]
> The domain controller functionality represents the highest possible functional level for this domain controller.
>
> `1> domainFunctionality: 2=(DS_BEHAVIOR_WIN2003)`
> `1> forestFunctionality: 0=(DS_BEHAVIOR_WIN2000)`
> `1> domainControllerFunctionality: 2=(DS_BEHAVIOR_WIN2003)`

### Requirements when you manually change the functional level

- You must change the domain mode to native mode before you raise the domain level if one of the following conditions is true:
  - The domain functional level is programmatically raised to the second functional level by directly modifying the value of the msdsBehaviorVersion attribute on the domainDNS object.
  - The domain functional level is raised to the second functional level by using the Ldp.exe utility or the Adsiedit.msc utility.

  If you don't change the domain mode to native mode before you raise the domain level, the operation can't finish successfully, and you receive the following error messages:

  `SV_PROBLEM_WILL_NOT_PERFORM`
  `ERROR_DS_ILLEGAL_MOD_OPERATION`

  The following message also appears in the Directory Services log:

    ```output
    Active Directory could not update the functional level of the following domain because the domain is in mixed mode.
    ```

 In this scenario, you can change the domain mode to native mode by using the Active Directory Users & Computers snap-in, the Active Directory Domains & Trusts UI MMC snap-in, or by programmatically changing the value of the ntMixedDomain attribute to 0 on the domainDNS object. When you use this process to raise the domain functional level to 2 (Windows Server 2003), the domain mode automatically changes to native mode.

- The transition from mixed mode to native mode changes the scope of the Schema Administrators security group and the Enterprise Administrators security group to universal groups. When you change these groups to universal groups, the following message appears in the System log:

    ```output
    Event Type: Information  
    Event Source: SAM  
    Event ID: 16408  
    Computer:Server Name  
    Description: "Domain operation mode has been changed to Native Mode. The change cannot be reversed."
    ```

When you use the Windows Server 2003 administrative tools to invoke the domain functional level, both the ntmixedmode attribute and the msdsBehaviorVersion attribute are modified in the correct order. However, this modification doesn't always occur. In the following scenario, the native mode is implicitly set to a value of 0 without changing the scope for the Schema Administrators security group and the Enterprise Administrators security group to universal:

- The value of the msdsBehaviorVersion attribute that controls the domain functional mode is manually or programmatically set to 2.
- The forest functional level is set to 2 by using any method. In this scenario, the Domain controllers block the transition to the forest functional level until all of the domains that are in the local area network are configured to native mode and the required attribute change is made in the security group scopes.

### Functional levels relevant to Windows Server 2016, Windows Server 2022, and Windows Server 2025 (preview) 

There are many considerations when raising the operating system level of the domain controller. These considerations are caused by the storage and replication limitations of the linked attributes in Windows Server modes.

## Increasing functional levels

The following section discusses the method for increasing functional levels. The section is broken into two parts. "Preparation Tasks" discusses the work that you must do before the increase and "Optimal Paths Increase" discusses the motivations and methods for different level increase scenarios.

### Example: Preparation tasks before the level increase

In this example, the environment is raised from Windows Server 2000 mixed mode to Windows Server 2003 forest mode. This example assumes that an accurate server list is not available and that you have performed an inventory of the forest for earlier versions of domain controllers.

1. To discover mixed level domains, Windows Server 2000 domain controllers, or domain controllers with damaged or missing objects, use Active Directory domains and the Trusts MMC snap-in.
2. In the snap-in, select **Raise Forest Functionality**, and then select **Save As** to generate a detailed report.
3. If no problems were found, the option to increase to Windows Server 2003 forest level is available from the **"Available Forest Functional Levels"** drop-down list. When you try to raise the forest level, the domain controller objects in the configuration containers are searched for any domain controllers that do not have **msds-behavior-version** set to the desired target level. These are assumed to be either Windows Server 2000 domain controllers or newer Windows Server domain controller objects that are damaged.
4. If earlier version domain controllers or domain controllers that have damaged or missing computer objects were found, they are included in the report. The status of these domain controllers must be investigated, and the domain controller representation in Active Directory must be repaired or removed by using the Ntdsutil file.

For more information, see [KB 216498](https://support.microsoft.com/help/216498).

### Verify end-to-end replication is working in the forest

To verify that end-to-end replication is working in the forest, use the Windows Server 2003 or newer version of Repadmin against the Windows Server or the Windows Server domain controllers:

- `Repadmin/Replsum * /Sort:Delta[/Errorsonly]` for initial inventory.
- `Repadmin/Showrepl * /CSV>showrepl.csv`. Import to Excel, and then use the Data->Autofilter to identify replication features.

Use replication tools such as Repadmin to verify that forest-wide replication is working correctly.

Verify the compatibility of all programs or services with the newer Windows Server domain controllers and with the higher Windows Server domain and forest mode. Use a lab environment to thoroughly test production programs and services for compatibility issues. If you're unsure if a program is compatible, contact the vendors.

Prepare a back-out plan that includes of one of the following actions:

- Disconnect at least two domain controllers from each domain in the forest.
- Create a system state backup of at least two domain controllers from each domain in the forest.

Before the back-out plan can be used, all domain controllers in the forest must be decommissioned before the recovery process.

> [!NOTE]
> You can't authoritatively restore level increases. You must decommission all domain controllers that replicated the level increase.

After you decommission all previous domain controllers, bring up the disconnected domain controllers or restore the domain controllers from the backup. Remove the metadata from all the other domain controllers, then repromote them. 

## Related content

- [What's new in Active Directory Domain Services for Windows Server 2016](/windows-server/identity/whats-new-active-directory-domain-services).
