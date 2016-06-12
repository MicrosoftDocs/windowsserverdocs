---
title: Force a Remote Group Policy Refresh (GPUpdate)
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 70b16238-3d4f-4b13-ac68-4ebb45e58087
---
# Force a Remote Group Policy Refresh (GPUpdate)
Group Policy is a complicated infrastructure that enables you to apply policy settings to remotely configure a computer and user experience within a domain. When the Resultant Set of Policy settings does not conform to your expectations, a best practice is to first verify that the computer or user has received the latest policy settings. In previous versions of Windows, this was accomplished by having the user run **GPUpdate.exe** on their computer.

With  Windows Server 2012  and Windows 8, you can remotely refresh Group Policy settings for all computers in an organizational unit \(OU\) from one central location by using the Group Policy Management Console \(GPMC\). Or you can use the **Invoke\-GPUpdate** Windows PowerShell cmdlet to refresh Group Policy for a set of computers, including computers that are not within the OU structure—for example, if the computers are located in the default computers container.

The remote Group Policy refresh updates all Group Policy settings, including security settings that are set on a group of remote computers, by using the functionality that is added to the context menu for an OU in the Group Policy Management Console \(GPMC\). When you select an OU to remotely refresh the Group Policy settings on all the computers in that OU, the following operations happen:

1.  An Active Directory query returns a list of all computers that belong to that OU.

2.  For each computer that belongs to the selected OU, a WMI call retrieves the list of signed in users.

3.  A remote scheduled task is created to run **GPUpdate.exe \/force** for each signed in user and once for the computer Group Policy refresh. The task is scheduled to run with a random delay of up to 10 minutes to decrease the load on the network traffic. This random delay cannot be configured when you use the GPMC, but you can configure the random delay for the scheduled task or set the scheduled task to run immediately when you use the **Invoke\-GPUpdate** cmdlet.

This document describes a method to force a remote Group Policy refresh to all computers in an OU and all OUs that are contained within the selected OU by using the GPMC. An equivalent Windows PowerShell method is also presented for each procedure.

**In this document**

-   [Prerequisites](Force-a-Remote-Group-Policy-Refresh--GPUpdate-.md#BKMK_Prereqs)

-   [Step 1: Configure Firewall rules on each client that will be managed with remote Group Policy refresh](Force-a-Remote-Group-Policy-Refresh--GPUpdate-.md#BKMK_Step1)

-   [Step 2: Schedule a remote Group Policy refresh](Force-a-Remote-Group-Policy-Refresh--GPUpdate-.md#BKMK_Step2)

> [!NOTE]
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](http://go.microsoft.com/fwlink/p/?linkid=230693).

## <a name="BKMK_Prereqs"></a>Prerequisites
You can only schedule to force a remote Group Policy update by using the GPMC from domain\-joined computers that are running:

-    Windows Server 2012  or  Windows Server 2012 R2 

-   Windows 8 or Windows 8.1 with Remote Server Administration Tools for Windows 8

You can schedule a remote Group Policy refresh for any computer running:

-    Windows Server 2012 R2 

-    Windows Server 2012 

-   Windows Server 2008 R2

-   Windows Server 2008

-   Windows 8.1

-   Windows 8

-   Windows 7

-   Windows Vista

## <a name="BKMK_Step1"></a>Step 1: Configure firewall rules on each client that will be managed with remote Group Policy refresh
To schedule a Group Policy refresh for domain\-joined computers by using the GPMC or the **Invoke\-GPUpdate** cmdlet, you must have firewall rules that enable inbound network traffic on the ports listed in the following table.

|Server port|Type of network traffic|
|---------------|---------------------------|
|TCP RPC dynamic ports, Schedule<br /><br />\(Task Scheduler service\)|Remote Scheduled Tasks Management \(RPC\)|
|TCP port 135, RPCSS<br /><br />\(Remote Procedure Call service\)|Remote Scheduled Tasks Management \(RPC\-EPMAP\)|
|TCP all ports, Winmgmt<br /><br />\(Windows Management Instrumentation service\)|Windows Management Instrumentation \(WMI\-in\)|

In  Windows Server 2012 , Group Policy added a Starter GPO called, **Group Policy Remote Update Firewall Ports**. This Starter GPO includes policy settings to configure the firewall rules that are specified in the previous table. It is a best practice to create a new GPO from this Starter GPO. Link the GPO to your domain at a higher precedence than the Default Domain GPO, and then use it to configure all the computers in the domain to enable a remote Group Policy refresh.

### <a name="BKMK_Proc1"></a>To create a GPO from the Group Policy Remote Update Firewall Ports Starter GPO and link to the domain

1.  In the GPMC console tree, locate the domain for which you want to configure all the computers to enable a remote Group Policy refresh.

2.  Right\-click the selected domain, and click **Create a GPO in this domain, and link it here…**

3.  In the **New GPO** dialog box, type the name of the new Group Policy object in the **Name** box.

4.  In the **Source Starter GPO** list, select the **Group Policy Remote Update Firewall Ports** Starter GPO that you want to use to create a new Group Policy object, and click **OK**.

5.  In the results pane, click the **Linked Group Policy Objects** tab.

6.  Select the GPO that you just created, and click the Up arrow until the GPO is listed above the Default Domain Policy. The new GPO will have a smaller link order value than the Default Domain Policy.

![](../../media/Force-a-Remote-Group-Policy-Refresh--GPUpdate-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word\-wrapped across several lines here because of formatting constraints.

Use the **New\-GPO** cmdlet with the **–StarterGpoName** parameter, and then pipe the output to the **New\-GPLink** cmdlet.

For example, to create a new GPO called *Configure firewall rules for remote gpupdate* by using the **Group Policy Remote Update Firewall Ports** Starter GPO, then link the  new GPO to the Contoso.com domain, use the following script:

```
New-GPO –Name "Configure firewall rules for remote gpupdate" –StarterGpoName "Group Policy Remote Update Firewall Ports" | New-GPLink –target "dc=Contoso,dc=com" –LinkEnabled yes
```

For more information about the **New\-GPO** cmdlet and the **New\-GPLink** cmdlet, see:

-   [New\-GPO](http://technet.microsoft.com/library/hh967472.aspx)

-   [New\-GPLink](http://technet.microsoft.com/library/hh967457.aspx)

## <a name="BKMK_Step2"></a>Step 2: Schedule a remote Group Policy refresh
You can schedule **gpupdate.exe** to run on multiple computers from the GPMC or from a Windows PowerShell session using the **Invoke\-GPUpdate** cmdlet.

#### To schedule a Group Policy refresh to run on all computers in an OU by using the GPMC

1.  In the GPMC console tree, locate the OU for which you want to refresh Group Policy for all computers.

    > [!NOTE]
    > Group Policy will also be refreshed for all computers that are located in the OUs contained in the selected OU.

2.  Right\-click the selected OU, and click **Group Policy Update…**

3.  Click **Yes** in the **Force Group Policy update** dialog box. This is the equivalent to running **GPUpdate.exe \/force** from the command line.

4.  The **Remote Group Policy update results** window displays only the status of scheduling a Group Policy refresh for each computer located in the selected OU and any OUs contained within the selected OU. This display does not show the success or failure of the actual Group Policy refresh for each computer.

5.  Use Resultant Set of Policy to determine the success of the scheduled Group Policy refresh, [Determine Resultant Set of Policy](http://technet.microsoft.com/library/cc771009.aspx).

    > [!NOTE]
    > You should plan a delay of up to 10 minutes to start a Group Policy refresh when you are verifying the results for each computer.

![](../../media/Force-a-Remote-Group-Policy-Refresh--GPUpdate-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word\-wrapped across several lines here because of formatting constraints.

The **Invoke\-GPUpdate** cmdlet allows you to schedule a remote Group Policy update for a specified computer with all the options that the **GPUpdate.exe** command\-line utility provides. This allows more freedom to determine which set of computers is to be refreshed than if you schedule the refresh through the GPMC. Additionally, you have the freedom to configure the interval of time to wait before a Group Policy refresh is performed by using the **–RandomDelayInMinutes** parameter. If set to a zero \(0\) value, the scheduled task for the Group Policy refresh is configured to start immediately. For more information, see [Invoke\-GPUpdate](http://technet.microsoft.com/library/hh967455.aspx).

You can refresh the changed Group Policy settings for the computer that you are signed in to by running the **Invoke\-GPUpdate** cmdlet without including any parameters, for example:

```
Invoke-GPUpdate
```

You cannot schedule a Group Policy refresh for the **Computers** container by using the GPMC **Group Policy Update…** functionality. The **Computers** container is a default location for computer accounts. It is not implemented as an OU that can be managed by the GPMC. However, by combining the use of the Windows PowerShell cmdlet, **Get\-ADComputer**, with the **Invoke\-GPUpdate** cmdlet, you can schedule a remote refresh for all computers in the **Computers** container. For more information about available Windows PowerShell cmdlets for Active Directory, see [AD DS Administration Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh852274.aspx).

First obtain the list of computers in the **Computers** container by using the **Get\-ADComputer** cmdlet. Then supply the name of each computer that is returned to the **Invoke\-GPUpdate** cmdlet. For example, to force a refresh of all Group Policy settings for all computers in the **Computers** container for the Contoso.com domain, use the following script:

```
Get-ADComputer –filter * -Searchbase "cn=computers, dc=Contoso,dc=com" | foreach{ Invoke-GPUpdate –computer $_.name -force}
```

You can force a Group Policy refresh for all Group Policy settings for all computers in a single OU when you combine the **Get\-ADComputer** with the **Invoke\-GPUpdate** cmdlet. For example, to force a refresh of all Group Policy settings for all computers in the *Accounting* OU of the Contoso.com domain, use the following script:

```
Get-ADComputer –filter * -Searchbase "ou=Accounting, dc=Contoso,dc=com" | foreach{ Invoke-GPUpdate –computer $_.name -force}
```

You can force an immediate Group Policy refresh for all Group Policy settings for all computers in a single OU when you combine the **Get\-ADComputer** with the **Invoke\-GPUpdate** cmdlet and set the **–\-RandomDelayInMinutes** to 0. For example, to force a refresh of all Group Policy settings for all computers in the *Accounting* OU of the Contoso.com domain, use the following script:

```
Get-ADComputer –filter * -Searchbase "ou=Accounting, dc=Contoso,dc=com" | foreach{ Invoke-GPUpdate –computer $_.name –force –-RandomDelayInMinutes 0}
```

## <a name="BKMK_Links"></a>See also

-   [Group Policy Overview](Group-Policy-Overview.md)

-   [Group Policy Analysis and Troubleshooting Overview](Group-Policy-Analysis-and-Troubleshooting-Overview.md)


