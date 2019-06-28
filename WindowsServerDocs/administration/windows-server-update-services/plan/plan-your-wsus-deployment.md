---
title: Plan Your WSUS Deployment
description: "Windows Server Update Service (WSUS) topic - An overview of the deployment planning process with links to the related topics"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.technology: manage-wsus
ms.topic: article
ms.assetid: 35865398-b011-447a-b781-1c52bc0c9e3a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 05/24/2018
---
# Plan your WSUS deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The first step in the deployment of Windows Server Update Services (WSUS) is to make important decisions, such as deciding the WSUS deployment scenario, choosing a network topology, and understanding the system requirements. The following checklist summarizes the steps that are involved in preparing for your deployment.

|Task|Description|
|----|--------|
|[1.1. Review considerations and system requirements](#11-review-considerations-and-system-requirements)|Review the list of considerations and system requirements to ensure that you have all the necessary hardware and software to deploy WSUS.|
|[1.2. Choose a WSUS deployment scenario](#12-choose-a-wsus-deployment-scenario)|Decide which WSUS deployment scenario will be used.|
|[1.3. Choose a WSUS storage strategy](#13-choose-a-wsus-storage-strategy)|Decide which WSUS storage strategy best fits your deployment.|
|[1.4. Choose WSUS update languages](#14-choose-wsus-update-languages)|Decide which WSUS update languages will be installed.|
|[1.5. Plan WSUS computer groups](#15-plan-wsus-computer-groups)|Plan the WSUS computer group approach that you will use for your deployment.|
|[1.6. Plan WSUS Performance Considerations: Background Intelligent Transfer Service](#16-plan-wsus-performance-considerations)|Plan a WSUS design for optimized performance.|
|[1.7. Plan Automatic Updates settings](#17-plan-automatic-updates-settings)|Plan how you will configure the automatic updates settings for your scenario.|

## 1.1. Review considerations and system requirements

### System Requirements

Before you enable the WSUS server role, confirm that the server meets the system requirements and confirm that you have the necessary permissions to complete the installation by adhering with the following guidelines:

-   Server hardware requirements to enable WSUS role are bound to hardware requirements. The minimum hardware requirements for WSUS are:

    -   **Processor:** 1.4 gigahertz (GHz) x64 processor (2 Ghz or faster is recommended)

    -   **Memory:** WSUS requires an additional 2 GB of RAM more than what is required by the server and all other services or software.

    -   **Available disk space:** 10 GB (40 GB or greater is recommended)

    -   **Network adapter:** 100 megabits per second (Mbps) or greater

-   Software Requirements:

    -   For viewing reports, WSUS requires the [Microsoft Report Viewer Redistributable 2008](https://www.microsoft.com/download/details.aspx?id=6576). On Windows Server 2016, WSUS requires [Microsoft Report Viewer Runtime 2012](https://www.microsoft.com/download/details.aspx?id=35747)

-   If you install roles or software updates that require you to restart the server when installation is complete, restart the server before you enable the WSUS server role.

-   Microsoft .NET Framework 4.0 must be installed on the server where the WSUS server role will be installed.

-   The NT Authority\Network Service account must have Full Control permissions for the following folders so that the WSUS Administration snap-in displays correctly:

    -   %windir%\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files

        > [!NOTE]
        > This path might not exist prior to install Web Server Role that contains Internet Information Services (IIS).

    -   %windir%\Temp

-   Confirm that the account you plan to use to install WSUS is a member of the Local Administrators group.

### Installation Considerations

During the installation process, WSUS will install the following by default:

-   .NET API and Windows PowerShell cmdlets

-   Windows Internal Database (WID), which is used by WSUS

-   Services used by WSUS, which are:

    -   Update Service

    -   Reporting Web Service

    -   Client Web Service

    -   Simple Web Authentication Web Service

    -   Server Synchronization Service

    -   DSS Authentication Web Service

### Features on Demand Considerations

Be aware that configuring client computers (including servers) to update by using WSUS will result in the following limitations:

1. Server roles that have had their payloads removed using Features on Demand cannot be installed on demand from Microsoft Update. You must either provide an installation source at the time you try to install such server roles, or configure a source for Features on Demand in Group Policy.

2. Windows client editions will not be able to install .NET 3.5 on demand from the web. The same considerations as server roles apply to .NET 3.5.

   > [!NOTE]
   > Configuring a Features on Demand installation source does not involve WSUS. For information on how to configure Features, see [Configure Features on Demand in Windows Server](https://technet.microsoft.com/library/jj127275.aspx).

3. Enterprise devices running Windows 10, version 1709 or version 1803, cannot install any Features on Demand directly from WSUS. To install Features on Demand, [create a feature file (side-by-side store)](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj127275%28v=ws.11%29#create-a-feature-file-or-side-by-side-store) or obtain the Feature on Demand package from one of the following sources:
   - [Volume Licensing Service Center](https://www.microsoft.com/licensing/servicecenter) (VLSC) - VL access is required
   - OEM Portal - OEM access is required
   - MSDN Download - MSDN subscription is required

     Individually-obtained Feature on Demand packages can be installed using [DISM command-line options](https://docs.microsoft.com/windows-hardware/manufacture/desktop/dism-operating-system-package-servicing-command-line-options).

### WSUS database requirements
WSUS requires one of the following databases:

-   Windows Internal Database (WID)

-   Microsoft SQL Server 2017

-   Microsoft SQL Server 2016

-   Microsoft SQL Server 2014

-   Microsoft SQL Server 2012

-   Microsoft SQL Server 2008 R2

The following editions of SQL Server are supported by WSUS:

-   Standard

-   Enterprise

-   Express

> [!NOTE]
> SQL Server Express 2008 R2 has a database size limitation of 10 GB. This database size is likely to be sufficient for WSUS, although there is no appreciable benefit to using this database instead of WID. WID database has a minimum RAM memory requirement of 2 GB beyond the standard Windows Server system requirements.

You can install the WSUS role on a computer that is separate from the database server computer. In this case, the following additional criteria apply:

1.  The database server cannot be configured as a domain controller.

2.  The WSUS server cannot run Remote Desktop Services.

3.  The database server must be in the same active directory domain as the WSUS server, or it must have a trust relationship with the active directory domain of the WSUS server.

4.  The WSUS server and the database server must be in the same time zone or be synchronized to the same Coordinated Universal time (Greenwich Mean time) source.

## 1.2. Choose a WSUS deployment scenario
This section describes the basic features of all WSUS deployments. Use this section to familiarize yourself with a simple deployment with a single WSUS server, in addition to more complex scenarios, such as a WSUS server hierarchy or a WSUS server on an isolated network segment.

### Simple WSUS deployment
The most basic WSUS deployment consists of a server inside the corporate firewall that serves client computers on a private intranet. The WSUS server connects to Microsoft Update to download updates. This is known as *synchronization*. During synchronization, WSUS determines if any new updates have been made available since the last time you synchronized. If it is your first time synchronizing WSUS, all updates are made available for download.

> [!NOTE]
> Initial synchronization can take over an hour. All synchronizations after that should be significantly quicker.

By default, the WSUS server uses port 80 for HTTP protocol and port 443 for HTTPS protocol to obtain updates from Microsoft. If there is a corporate firewall between your network and the Internet, you will have to open these ports on the server that communicates directly to Microsoft Update. If you are planning to use custom ports for this communication, you must open those ports instead. You can configure multiple WSUS servers to synchronize with a parent WSUS server. By default, the WSUS server uses port 8530 for HTTP protocol and port 8531 for HTTPS protocol to provide updates to client workstations.

### Multiple WSUS servers
Administrators can deploy multiple servers running WSUS that synchronize all content within their organization's intranet. You might expose only one server to the Internet, which would be the only server that downloads updates from Microsoft Update. This server is set up as the upstream server the source to which the downstream servers synchronize. When applicable, servers can be located throughout a geographically dispersed network to provide the best connectivity to all client computers.

### Disconnected WSUS server
If corporate policy or other conditions limit computer access to the Internet, administrators can set up an internal server to run WSUS. An example of this is a server that is connected to the intranet but is isolated from the Internet. After downloading, testing, and approving the updates on this server, an administrator would export the update metadata and content to a DVD. The update metadata and content is imported from the DVD to servers running WSUS within the intranet.

### WSUS server hierarchies
You can create complex hierarchies of WSUS servers. Because you can synchronize one WSUS server with another WSUS server instead of with Microsoft Update, you need to have only a single WSUS server that is connected to Microsoft Update. When you link WSUS servers together, there is an upstream WSUS server and a downstream WSUS server. A WSUS server hierarchy deployment offers the following benefits:

-   You can download updates one time from the Internet and then distribute the updates to client computers by using downstream servers. This method saves bandwidth on the corporate Internet connection.

-   You can download updates to a WSUS server that is physically closer to the client computers, for example, in branch offices.

-   You can set up separate WSUS servers to serve client computers that use different languages of Microsoft products.

-   You can scale WSUS for a large organization that has more client computers than one WSUS server can effectively manage.

> [!NOTE] 
> We recommend that you do not create a WSUS server hierarchy that is more than three levels deep. Each level adds time to propagate updates throughout the connected servers. Although there is no theoretical limit to a hierarchy, only deployments that have a hierarchy of five levels deep have been tested by Microsoft.
>
> Also, downstream servers must be at the same version or an earlier version of WSUS as the upstream server synchronization source.

You can connect WSUS servers in Autonomous mode (to achieve distributed administration) or in Replica mode (to achieve centralized administration). You do not have to deploy a server hierarchy that uses only one mode: you can deploy a WSUS solution that uses both autonomous and replica WSUS servers.

#### Autonomous mode
The Autonomous mode, also called distributed administration, is the default installation option for WSUS. In Autonomous mode, an upstream WSUS server shares updates with downstream servers during synchronization. Downstream WSUS servers are administered separately, and they do not receive update approval status or computer group information from the upstream server. By using the distributed management model, each WSUS server administrator selects update languages, creates computer groups, assigns computers to groups, tests and approves updates, and makes sure that the correct updates are installed to the appropriate computer groups. The following image shows how you might deploy autonomous WSUS servers in a branch office environment:

#### Replica mode
The Replica mode, also called centralized administration, works by having an upstream WSUS server that shares updates, approval status, and computer groups with downstream servers. Replica servers inherit update approvals and are not administered separately from the upstream WSUS server. The following image shows how you might deploy replica WSUS servers in a branch office environment.

> [!NOTE]
> If you set up several replica servers to connect to a single upstream WSUS server, do not schedule synchronization to run at the same time on each replica server. This practice will avoid sudden surges in bandwidth usage.

### Branch offices
You can leverage the Branch Office feature in Windows to optimize WSUS deployment. This type of deployment offers the following advantages:

1.  helps reduce WAN link utilization and improves application responsiveness. To enable BranchCache acceleration of content that is served by the WSUS server, install the BranchCache feature on the server and the clients, and ensure that the BranchCache service has started. No other steps are necessary.

2.  In branch offices that have low-bandwidth connections to the central office but high-bandwidth connections to the Internet, the Branch Office feature can also be used. In this case you may want to configure downstream WSUS servers to get information about which updates to install from the central WSUS server, but download the updates from Microsoft Update.

### Network Load Balancing
Network Load Balancing (NLB) increases the reliability and performance of your WSUS network. You can set up multiple WSUS servers that share a single failover cluster running SQL Server such as SQL Server 2008 R2 SP1. In this configuration you must use a full SQL Server installation, not the Windows Internal Database installation that is provided by WSUS, and the database role must be installed on all WSUS front-end servers. You can also have all the WSUS servers use a distributed file system (DFS) to store their content.

**WSUS setup for NLB:** compared to WSUS 3.2 setup for NLB, a special setup call and parameters are no longer required to configure WSUS for NLB. You need only setup each WSUS server, keeping the following considerations in mind.

-   WSUS must be setup using the SQL database option instead of WID.

-   If storing updates locally, the same Content folder must be shared between the WSUS servers that are sharing the same SQL database.

-   WSUS setup must be done in serial. Postinstall tasks cannot be run on more than one server at the same time when sharing the same SQL database.

### WSUS deployment with roaming client computers
If the network includes mobile users who log on to the network from different locations, you can configure WSUS to let roaming users update their client computers from the WSUS server that is closest to them geographically. For example, you might deploy one WSUS server each region and use a different DNS subnet for each region. All client computers could be directed to the same WSUS server, which resolves in each subnet to the nearest physical WSUS server.

## 1.3. Choose a WSUS storage strategy
Windows Server Update Services (WSUS) uses two types of storage systems: a database to store WSUS configuration and update metadata, and an optional local file system to store update files. Before you install WSUS, you should decide how you want to implement storage.

Updates are composed of two parts: metadata that describes the update, and the files that are required to install the update. Update metadata is typically much smaller than the actual update, and it is stored in the WSUS database. Update files are stored on a local WSUS server or on a Microsoft Update Web server.

### WSUS database
WSUS requires a database for each WSUS server. WSUS supports the use of a database that resides on a different computer than the WSUS server, with some restrictions. For a list of supported databases and remote database limitations, see section "1.1 Review initial considerations and system requirements," in this guide.

The WSUS database stores the following information:

-   WSUS server configuration information

-   Metadata that describes each update

-   Information about client computers, updates, and interactions

If you install multiple WSUS servers, you must maintain a separate database for each WSUS server, whether it is an autonomous or a replica server. You cannot store multiple WSUS databases on a single instance of SQL Server, except in Network Load Balancing (NLB) clusters that use SQL Server failover.

SQL Server, SQL Server Express, and Windows Internal Database provide the same performance characteristics for a single-server configuration, where the database and the WSUS service are located on the same computer. A single-server configuration can support several thousand WSUS client computers.

> [!NOTE]
> Do not attempt to manage WSUS by accessing the database directly. directly manipulating the database can cause database corruption. The corruption might not be immediately obvious, but it can prevent upgrades to the next version of the product. You can manage WSUS by using the WSUS console or WSUS application programming interfaces (APIs).

#### WSUS with Windows Internal Database
By default, the installation wizard creates and uses a Windows Internal Database that is named SUSDB.mdf. This database is located in the %windir%\wid\data\ folder, where %windir% is the local drive on which the WSUS server software is installed.

> [!NOTE]
> Windows Internal Database (WID) was introduced in Windows Server 2008 .

WSUS supports Windows authentication only for the database. You cannot use SQL Server authentication with WSUS. If you use Windows Internal Database for the WSUS database, WSUS Setup creates an instance of SQL Server that is named server\Microsoft##WID, where server is the name of the computer. With either database option, WSUS Setup creates a database named SUSDB. The name of this database is not configurable.

We recommend that you use Windows Internal Database in the following cases:

-   The organization has not already purchased and does not require a SQL Server product for any other application.

-   The organization does not require an NLB WSUS solution.

-   You intend to deploy multiple WSUS servers (for example, in branch offices). In this case, you should consider using Windows Internal Database on the secondary servers, even if you will use SQL Server for the root WSUS server. Because each WSUS server requires a separate instance of SQL Server, you will quickly experience database performance issues if only one instance of SQL Server handles multiple WSUS servers.

Windows Internal Database does not provide a user interface or any database management tools. If you select this database for WSUS, you must use external tools to manage the database. For more information, see:

-   [Backup and Restore WSUS Data and Backing Up Your Server](https://technet.microsoft.com/library/dd939904(WS.10).aspx)

-   [Reindex the WSUS database](https://technet.microsoft.com/library/dd939795(WS.10).aspx)

#### WSUS with SQL Server
We recommend that you use SQL Server with WSUS in the following cases:

1.  You require an NLB WSUS solution.

2.  You already have at least one instance of SQL Server installed.

3.  You cannot run the SQL Server service under a local non-system account or by using SQL Server authentication. WSUS supports Windows authentication only.

### WSUS update storage
When updates are synchronized to your WSUS server, the metadata and update files are stored in two separate locations. Metadata is stored in the WSUS database. Update files can be stored on your WSUS server or on Microsoft Update servers, depending on how you have configured your synchronization options. If you choose to store update files on your WSUS server, client computers will download approved updates from the local WSUS server. If not, client computers will download approved updates directly from Microsoft Update. The option that makes the most sense for your organization will depend on network bandwidth to the Internet, network bandwidth on the intranet, and local storage availability.

You can select a different update storage solution for each WSUS server that you deploy.

#### Local WSUS server storage
Local storage of update files is the default option when you install and configure WSUS. This option can save bandwidth on the corporate connection to the Internet because client computers download updates directly from the local WSUS server.

This option requires that the server have sufficient disk space to store all needed updates. at a minimum, WSUS requires 20 GB to store updates locally; however, we recommend 30 GB based on tested variables.

#### Remote storage on Microsoft Update servers
You can store updates remotely on Microsoft Update servers. This option is useful if most client computers connect to the WSUS server over a slow WAN connection, but they connect to the Internet over a high-bandwidth connection.

In this case, the root WSUS server synchronizes with Microsoft Update and receives the update metadata. After you approve the updates, the client computers download the approved updates from Microsoft Update servers.

## 1.4. Choose WSUS update languages
When you deploy a WSUS server hierarchy, you should determine which language updates are required throughout the organization. You should configure the root WSUS server to download updates in all languages that are used throughout the entire organization.

For example, the main office might require English and French language updates, but one branch office requires English, French, and German language updates, and another branch office requires English and Spanish language updates. In this situation, you would configure the root WSUS server to download updates in English, French, German, and Spanish. You would then configure the first branch office WSUS server to download updates in English, French, and German only, and configure the second branch office to download updates in English and Spanish only.

The **Choose Languages** page of the WSUS Configuration Wizard allows you to get updates from all languages or from a subset of languages. selecting a subset of languages saves disk space, but it is IMPORTANT to choose all the languages that are needed by all the downstream servers and client computers of a WSUS server.

Following are some IMPORTANT notes about the update language that you should keep in mind before configure this option:

-   Always include English in addition to any other languages that are required throughout your organization. All updates are based on English language packs.

-   Downstream servers and client computers will not receive all the updates they need if you have not selected all the necessary languages for the upstream server. Make sure you select all the languages that will be needed by all the client computers that are associated with all the downstream servers.

-   You should generally download updates in all languages on the root WSUS server that synchronizes to Microsoft Update. This selection guarantees that all downstream servers and client computers will receive updates in the languages that they require.

If you are storing updates locally, and you have set up a WSUS server to download updates in a limited number of languages, you may notice that there are updates in languages other than the ones you specified. Many update files are bundles of several different languages, which include at least one of the languages specified on the server.

**Upstream servers**

> [!NOTE]
> Configure upstream servers to synchronize updates in all languages that are required by downstream replica servers. You will not be notified of needed updates in the unsynchronized languages.

Updates will appear as **Not Applicable** on client computers that require the language. To avoid this, make sure all operating system languages are included in your WSUS server's synchronization options. You can see all the operating system languages by going to the **computers** view of the WSUS Administration Console and sorting the computers by operating system language. However, you may want to include more languages if there are Microsoft applications in more than one language (for example, if the French version of Microsoft Word is installed on some computers that use the English version of Windows 8.

Choosing languages for an upstream server is not the same as choosing languages for a downstream server. The following procedures explain the differences.

#### To choose update languages for a server synchronizing from Microsoft Update

1.  In the WSUS Configuration Wizard:

    -   To get updates in all languages, click **Download updates in all languages, including new languages**.

    -   To get updates only for specific languages, click **Download updates only in these languages**, and then select the languages for which you want updates.

#### To choose update languages for a downstream server

1.  If the upstream server has been configured to download update files in a subset of languages: In the WSUS Configuration Wizard, click **Download updates only in these languages (only languages marked with an asterisk are supported by the upstream server)**, and then select the languages for which you want updates.

> [!NOTE]
> You should do this even though you want the downstream server to download the same languages as the upstream server.

2. If the upstream server has been configured to download update files in all languages: In the WSUS Configuration Wizard, click **Download updates in all languages supported by the upstream server**.

> [!NOTE]
> You should do this even though you want the downstream server to download the same languages as the upstream server. This setting causes the upstream server to download updates in all languages, including languages that were not originally configured for the upstream server. If you add languages to the upstream server, you should copy the new updates to its replica servers.
>
> Changing language options on the upstream server alone might cause a mismatch between the number of updates that are approved on the central server and the number of updates approved on the replica servers.

## 1.5. Plan WSUS computer groups
WSUS allows you to target updates to groups of client computers, so you can ensure that specific computers always get the right updates at the most convenient times. For example, if all the computers in one department (such as the Accounting team) have a specific configuration, you can set up a group for that team, decide which updates their computers need and what time they should be installed, and then use WSUS reports to evaluate the updates for the team.

> [!NOTE]
> If a WSUS server is running in replica mode, computer groups cannot be created on that server. All the computer groups that are needed for client computers of the replica server must be created on the WSUS server that is the root of the WSUS server hierarchy. For more information about replica mode, see Manage WSUS Replica Servers [Manage WSUS Replica Servers](https://technet.microsoft.com/library/dd939893(WS.10).aspx) in the WSUS 3.0 SP2 Operations Guide.

Computers are always assigned to the **All computers** group, and they remain assigned to the **Unassigned computers** group until you assign them to another group. Computers can belong to more than one group.

Computer groups can be set up in hierarchies (for example, the Payroll group and the Accounts Payable group below the Accounting group). Updates that are approved for a higher group will automatically be deployed to lower groups, in addition to the higher group. In this example, if you approve Update1 for the Accounting group, the update will be deployed to all the computers in the Accounting group, all the computers in the Payroll group, and all the computers in the Accounts Payable group.

Because computers can be assigned to multiple groups, it is possible for a single update to be approved more than once for the same computer. However, the update will be deployed only once, and any conflicts will be resolved by the WSUS server. To continue with the previous example, if computerA is assigned to the Payroll group and the Accounts Payable group, and Update1 is approved for both groups, it will be deployed only once.

You can assign computers to computer groups by using one of two methods, server-side targeting or client-side targeting. Following are the definitions for each method:

-   **Server-side targeting**: You manually assign one or more client computers to multiple groups simultaneously.

-   **Client-side targeting**: You use Group Policy or edit the registry settings on client computers to enable those computers to automatically add themselves into the previously created computer groups.

### Conflict Resolution
The server applies the following rules to resolve conflicts and determine the resultant action on clients:

1.  Priority

2.  Install/Uninstall

3.  Deadline

#### Priority
The actions associated with the group of the highest priority override the actions of other groups. The deeper a group appears within the hierarchy of groups, the higher its priority. Priority is assigned only based on depth; all branches have equal priority. For example, a group two levels beneath the Desktops branch has a higher priority than a group one level beneath the Server branch.

In the following text example of the Update Services console hierarchy pane, for a WSUS server named WSUS-01, computer groups named Desktop computers and Server have been added to the default **All computers** group. Both the Desktop computers and Server groups are at the same hierarchical level.

-   **Update Services**

    -   **WSUS-01**

        -   **Updates**

        -   **computers**

            -   **All computers**

                -   **Unassigned computers**

                -   **Desktop computers**

                    -   **Desktops-L1**

                        -   **Desktops-L2**

                -   **Servers**

                    -   **Servers-L1**

        -   **Downstream Servers**

        -   **Synchronizations**

        -   **Reports**

        -   **Options**

In this example, the group two levels beneath the Desktop computers branch (Desktops L2) has a higher priority than the group one level beneath the Server branch (Servers L1). Accordingly, for a computer that has membership in both the Desktops-L2 and the Servers-L1 groups, all actions for the Desktops-L2 group take priority over actions specified for the Servers-L1 group.

#### Priority of Install and Uninstall
Install actions override uninstall actions. Required installs override optional installs (optional installs are only available through the API and changing an approval for an update using the WSUS Administration Console will clear all optional approval.)

#### Priority of Deadlines
Actions that have a deadline override those with no deadline.  Actions with earlier deadlines override those with later deadlines.

## 1.6. Plan WSUS performance considerations
There are some areas that you should carefully plan before deploying WSUS so that you can have optimized performance. The key areas are:

-   Network setup

-   Deferred download

-   Filters

-   Installation

-   Large update deployments

-   Background Intelligent Transfer Service (BITS)

### Network setup
To optimize performance in WSUS networks, consider the following suggestions:

1.  Set up WSUS networks in a hub-and-spoke topology rather than in a hierarchical topology.

2.  Use DNS netmask ordering for roaming client computers, and configure roaming client computers to obtain updates from the local WSUS server.

### Deferred download
You can approve updates, and download the update metadata before you download the update files, this method is called *deferred downloads*. When you defer downloads, an update is downloaded only after it is approved. We recommend that you defer downloads because it optimizes network bandwidth and disk space.

In a hierarchy of WSUS servers, WSUS automatically sets all downstream servers to use the deferred download setting of the root WSUS server. You can change this default setting. For example, you can configure an upstream server to perform full, immediate synchronizations, and then configure a downstream server to defer the downloads.

If you deploy a hierarchy of connected WSUS servers, we recommend that you do not deeply nest the servers. If you enable deferred downloads and a downstream server requests an update that is not approved on the upstream server, the downstream server's request forces a download on the upstream server. The downstream server then downloads the update on a subsequent synchronization. In a deep hierarchy of WSUS servers, delays can occur as updates are requested, downloaded, and then passed through the server hierarchy. By default, deferred downloads are enabled when you store updates locally. You can change this option manually.

### Filters
WSUS lets you filter update synchronizations by language, product, and classification. In a hierarchy of WSUS servers, WSUS automatically sets all downstream servers to use the update filtering options that are selected on the root WSUS server. You can reconfigure download servers to receive only a subset of the languages.

By default, the products to be updated are Windows and Office, and the default classifications are Critical updates, Security updates, and Definition updates. To conserve bandwidth and disk space, we recommend that you limit languages to those that you actually use.

### Installation
Updates typically consist of new versions of files that already exist on the computer that is being updated. On a binary level, these existing files might not differ very much from updated versions. The express installation files feature identifies the exact bytes between versions, creates and distributes updates of only those differences, and then merges the existing file together with the updated bytes.

Sometimes this feature is called "delta delivery" because it downloads only the delta (difference) between two versions of a file. Express installation files are larger than the updates that are distributed to client computers because the express installation file contains all possible versions of each file that is to be updated.

You can use express installation files to limit the bandwidth that is consumed on the local network, because WSUS transmits only the delta applicable to a particular version of an updated component. However, this comes at the cost of additional bandwidth between your WSUS server, any upstream WSUS servers, and Microsoft Update, and requires additional local disk space. By default, WSUS does not use express installation files.

Not all updates are good candidates for distribution by using express installation files. If you select this option, you obtain express installation files for all updates. If you do not store updates locally, the Windows Update Agent will decide whether to download the express installation files or the full-file update distributions.

### Large update deployment
When you deploy large updates (such as service packs), you can avoid saturating the network by using the following practices:

1.  Use Background Intelligent Transfer Service (BITS) throttling. BITS bandwidth limitations can be controlled by time-of-day, but they apply to all applications that are using BITS. To learn how to control BITS throttling, please see [Group Policies](https://msdn.microsoft.com/library/windows/desktop/aa362844(v=vs.85).aspx).

2.  Use Internet Information Services (IIS) throttling to limit throttling to one or more web services.

3.  Use computer groups to control the rollout. A client computer identifies itself as a member of a particular computer group when it sends information to the WSUS server. The WSUS server uses this information to determine which updates should be deployed to this computer. You can set up multiple computer groups and sequentially approve large service pack downloads for a subset of these groups.

### Background Intelligent Transfer Service
WSUS uses the Background Intelligent Transfer Service (BITS) protocol for all its file transfer tasks. This includes downloads to client computers and server synchronizations. BITS enables programs to download files by using spare bandwidth. BITS maintains file transfers through network disconnections and computer restarts. For more information, see: [Background Intelligent Transfer Service](https://msdn.microsoft.com/library/bb968799.aspx).

## 1.7. Plan Automatic Updates settings
You can specify a deadline to approve updates on the WSUS server. The deadline causes client computers to install the update at a specific time, but there are a number of different situations, depending on whether the deadline has expired, whether there are other updates in the queue for the computer to install, and whether the update (or another update in the queue) requires a restart.

By default, Automatic Updates polls the WSUS server for approved updates every 22 hours minus a random offset. If new updates need to be installed, they are downloaded. The time between each detection cycle can be manipulated from 1 to 22 hours.

You can manipulate the notification options as follows:

1.  If Automatic Updates is configured to notify the user of updates that are ready to be installed, the notification is sent to the System log and to the notification area of the client computer.

2.  When a user with appropriate credentials clicks the notification area icon, Automatic Updates displays the available updates to install. The user must click **Install** to start the installation. A message appears if the update requires the computer to be restarted to complete the update. If a restart is requested, Automatic Updates cannot detect additional updates until the computer is restarted.

If Automatic Updates is configured to install updates on a set schedule, applicable updates are downloaded and marked as ready to install. Automatic Updates notifies users who have appropriate credentials by using a notification area icon, and an event is logged in the System log.

At the scheduled day and time, Automatic Updates installs the update and restarts the computer (if necessary), even if no local administrator is logged on. If a local administrator is logged on and the computer requires a restart, Automatic Updates displays a warning and a countdown for the restart. Otherwise, the installation occurs in the background.

If the computer must be restarted, and any user is logged on, a similar countdown dialog box is displayed, which warns the user about the impending restart. You can manipulate computer restarts with Group Policy.

After the new updates are downloaded, Automatic Updates polls the WSUS server for the list of approved packages to confirm that the packages it downloaded are still valid and approved. This means that, if a WSUS administrator removes updates from the list of approved updates while Automatic Updates is downloading updates, only the updates that are still approved are actually installed.

