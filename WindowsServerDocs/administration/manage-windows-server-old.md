---
title: Manage Windows Server
description: Learns about tools, recommendations and guidance on managing Windows Server
ms.prod: windows-server-threshold
ms.technology: manage
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 03/16/2018
ms.localizationpriority: medium
---
# Manage Windows Server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

 <ul class="cardse panelContent cols cols3">
    <li>
        <a href="https://docs.microsoft.com/windows-insider/at-work-pro/wip-4-biz-feedback-hub">
        <div class="cardSize">
            <div class="cardPadding">
                <div class="card">
                    <div class="cardImageOuter">
                        <div class="cardImage">
                            <img src="../media/i-manage.svg" alt="" />
                        </div>
                    </div>
                    <div class="cardText">
                        <h2>Manage</h2>
                <p>Once you have deployed Windows Server into your environment, including the specific roles for the features and functions you need, the next step is managing those servers. Windows Server includes a number of tools to help you understand your Windows Server environment, manage specific servers, fine-tune performance, and eventually automate many management tasks. </p>
                    </div>
                </div>
            </div>
        </div>
        </a>
    </li> 
</ul> 

## Manage Windows Server systems and environments
The tools you use to manage Windows Server instances depend, in large amount, on the types of systems you have deployed (Windows Server with Desktop Experience vs Server Core), physical versus virtual machines, and where your servers are located. Use the following information to perform basic management tasks on Windows Server.

Use the following table to determine which tools to use when.

| I am   | Install & run Windows Admin Center | Run Server Manager on Windows Server | Run Server Manager in RSAT on Windows 10 |
|--------|----------------------|--------------------------------------|------------------------------------------|
| Sitting at a Windows 10 PC | X  |                                      | X                                        |
| Sitting at a Windows Server system running the desktop experience | X | X | X |
| Sitting at a Windows Server system running Server Core |X (install on Windows 10, use to manage Server Core) | | X |
| Sitting far away from my Windows Server system |X | | X |
| Sitting far away from my Windows Server system but it DOES have desktop experience |X | Use RDS to remote into the server, then use Server Manager | X |

In addition to the tools mentioned below, you can also use [Remote Desktop Services](../remote/remote-desktop-services/welcome-to-rds.md) to access on-premises, remote, and virtual servers. Then you can use Server Manager to perform management tasks.

### Manage on-premises systems, remote systems, and systems without UI with Windows Admin Center
[Windows Admin Center](../manage/windows-admin-center/overview.md) is a browser-based management app that enables on-premises administration of Windows Servers with no Azure or cloud dependency. Windows Admin Center gives you full control over all aspects of your server infrastructure and is particularly useful for management on private networks that are not connected to the Internet. You can install Windows Admin Center on Windows 10, on a gateway server, or directly on the Windows Server system that you want to manage.

>[!NOTE]
>Windows Admin Center is the official name of what we used to call "Project Honolulu."

### Manage on-premises systems with Server Manager
[Server Manager](server-manager/server-manager.md) is a management console included in the full installation of Windows Server. (It is not available for installs that don't have UI - Server Core doesn't include Server Manager.) Use Server Manager to install and remove server roles, add and remove remote servers, start and stop services, and view data gathered about your environment.

### Manage remote systems and systems without UI with Remote Server Administration Tools (RSAT)
If your environment includes installations of Server Core or remote servers (either on-premises or virtual machines), you can use the [Remote Server Administration tools (RSAT)](../remote/remote-server-administration-tools.md) to manage those systems. RSAT includes Server Manager, so you can use it to manage all of your servers.

> [!IMPORTANT]
> RSAT runs on Windows 10. You can't install RSAT on Windows Server Core.

You can also manage Server Core installations from the command line. See [Basic administration tasks in Server Core](server-core/server-core-administer.md).

### Manage updates to Windows Server systems
You can use [Windows Server Update Services (WSUS)](windows-server-update-services/get-started/windows-server-update-services-wsus.md) to manage and deploy updates to the systems in your Windows Server environment.

## Gather information about your environment
Many of the decisions you make as an administrator depend on data about the systems and users in your environment. Use the following information and tools to gather that data.

Start with [Configure Windows diagnostic data in your organization](/windows/configuration/configure-windows-diagnostic-data-in-your-organization) for information about the diagnostic data that can be gathered from Windows 10 and Windows Server.

### [Setup and Boot Event Collection](get-started-with-setup-and-boot-event-collection.md)
Setup and Boot Event Collection lets you designate a "collector" computer that can gather a variety of important events that occur on other computers when they boot or go through the setup process. You can then later analyze the collected events with Event Viewer, Message Analyzer, Wevtutil, or Windows PowerShell cmdlets. 

### [Software Inventory Logging (SIL)](software-inventory-logging/get-started-with-software-inventory-logging.md)

Software Inventory Logging in Windows Server is a feature with a simple set of PowerShell cmdlets that help server administrators retrieve a list of the Microsoft software that is installed on their servers. It also provides the capability to collect and forward this data periodically over the network to a target web server, using the HTTPS protocol, for aggregation. Managing the feature, primarily for hourly collection and forwarding, is also done with PowerShell commands.

### [User Access Logging (UAL)](user-access-logging/get-started-with-user-access-logging.md)

User Access Logging aggregates unique client device and user request events that are logged on a computer running Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 into a local database. These records are then made available (through a query by a server administrator) to retrieve quantities and instances by server role, by user, by device, by the local server, and by date. In addition, UAL also enables non-Microsoft software developers to instrument their UAL events to be aggregated. 

## Tune your Windows Server environment for performance
Use the following information to help tune your environment for performance.

### [Performance tuning guidelines](performance-tuning/index.md)
Review a set of guidelines that you can use to tune the server settings in Windows Server 2016 and obtain incremental performance or energy efficiency gains, especially when the nature of the workload varies little over time.

### [Microsoft Server Performance Advisor](server-performance-advisor/microsoft-server-performance-advisor.md)

With Microsoft Server Performance Advisor (SPA), you can collect metrics to diagnose performance issues on Windows servers unobtrusively without adding software agents or reconfiguring production servers. SPA generates comprehensive performance reports and historical charts with recommendations.


## Automate Windows Server management

Windows Server includes a set of commands and Windows PowerShell modules that you can use to automate management tasks.

### [Windows PowerShell](/powershell/scripting/powershell-scripting?view=powershell-5.1)
Winows PowerShell is a command-line shell and scripting language designed to let you rapidly automate administrative tasks. 

### [Windows Commands](windows-commands/windows-commands.md)

The Windows command-line tools are used to perform administrative tasks in Windows. You can use the command reference to familiarize yourself with the command-line tools, to learn about the command shell, and to automate command-line tasks by using batch files or scripting tools.

## Windows Server Insider Preview
### [System Insights](../manage/system-insights/overview.md)
System Insights is a new feature that introduces predictive analytics natively to Windows Server. These predictive capabilities locally analyze Windows Server system data, such as performance counters or ETW events, helping IT administrators proactively detect and address problematic behavior in their deployments. 
