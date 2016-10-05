---
title: Configure Firewall Port Requirements for Group Policy
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 91ce6c1e-98e4-4b9d-9f6c-b73a5faa49dd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/04/2016
---


# Configure Firewall Port Requirements for Group Policy
You can use the information in this topic to configure the firewall port requirements for Group Policy. Group Policy requires that firewall ports are opened on client computers for an administrator to perform these two remote operations:

-   [Remote Resultant Set of Policy (RSoP) Group Policy results: ports that require firewall rules](Configure-Firewall-Port-Requirements-for-Group-Policy.md#BKMK_RemoteRSoP)

-   [Remote Group Policy refresh: ports that require firewall rules](Configure-Firewall-Port-Requirements-for-Group-Policy.md#BKMK_RemoteRefresh)

By default, Windows Firewall enables all outbound network traffic,and it allows only inbound traffic that is enabled by firewall rules. This topic identifies the TCP and UDP ports for which you must have active firewall rules to allow the inbound traffic. This allows Group Policy to perform remote Group Policy Results reporting from client computers and to perform remote Group Policy refresh to client-based computers. You can use the information in this topic to configure non-Microsoft firewall products and to create a GPO to configure a client computer with the required firewall rules. This topic also presents two new starter Group Policy Objects (GPOs) that configure the proper firewall rules on client computers.

> [!NOTE]
> If you have configured client computers by using Group Policy, the Group Policy settings override any manual configuration of client computers to which the policies are applied. If you want to review these rules, from the Group Policy Management Console (GPMC), you can run a Group Policy Results report or Group Policy Planning report. Or from a client computer, open the Windows Firewall with Advanced Security MMC snap-in and click **Inbound Rules**.
> 
> Membership in the Administrators group or equivalent is the minimum permissions required to make these configuration changes.

If you use a non-Microsoft firewall product, check your firewall product documentation for instructions about how to open these ports to allow network traffic as required by Group Policy.

## <a name="BKMK_RemoteRSoP"></a>Remote Resultant Set of Policy (RSoP) Group Policy results: ports that require firewall rules
You can use the RSoP feature of the GPMC to create detailed reports about the policy settings that are applied to computers or users who have signed in. When RSoP reporting targets remote computers, all connections are direct to each remote client from the computer running the GPMC (that is, not transitively through a domain controller).

To use RSoP reporting for remotely targeted computers through the firewall, you must have firewall rules that allow inbound network traffic on the ports listed in the following table. This allows remote WMI and event log traffic to flow between the computer running the GPMC and the remotely targeted computer.

|Server port|Type of network traffic|
|---------------|---------------------------|
|TCP SMB 445, all services and programs|Remote Event Log Management (NP-in)|
|TCP RPC dynamic ports, EventLog (Windows Event Log service)|Remote Event Log Management (RPC)|
|TCP port 135, RPCSS (Remote Procedure Call service)|Remote Event Log Management (RPC-EPMAP)|
|TCP all ports, Winmgmt (Windows Management Instrumentation service)|Windows Management Instrumentation (WMI-in)|

## <a name="BKMK_RemoteRsopConfig"></a>Configure firewall rules by creating a GPO from the Group Policy Reporting Firewall Ports Starter GPO and linking to the domain
In  Windows Server 2012 , Group Policy adds a new Starter GPO called, **Group Policy Reporting Firewall Ports**. This Starter GPO includes policy settings to configure the firewall rules that are specified in the previous table. This enables inbound network traffic on the ports, which is necessary to allow the GPMC to gather the Group Policy results RSoP information from a remote computer. It is a best practice to create a new GPO from this Starter GPO, and then link the new GPO to your domain with a higher precedence than the Default Domain GPO, so that you can configure all computers in the domain for remote Group Policy results reporting.

### <a name="BKMK_remoteProc1"></a>To create a GPO from the Group Policy Reporting Firewall Ports Starter GPO and link to the domain

1.  In the GPMC console tree, right-click the domain for which you want to configure all computers to enable a remote Group Policy refresh, and then click **Create a GPO in this domain, and Link it hereâ€¦**

2.  In the **New GPO** dialog box, type the name of the new Group Policy Object in the **Name** box.

3.  Select the **Group Policy Reporting Firewall Ports** Starter GPO from the **Source Starter GPO** list that you want to use to create a new Group Policy Object.

    > [!NOTE]
    > If you do not see any Starter GPOs listed, cancel creating a GPO and do the following before you return to Step 1:
    > 
    > 1.  Navigate to **Starter GPOs**.
    > 2.  In the results pane, click **Create Starter GPOs Folder**.

4.  Click **OK**.

5.  In the results pane, click the **Linked Group Policy Objects** tab.

6.  Select the GPO that you just created. Click the Up arrow until the GPO you just created is located above the Default Domain Policy. The new GPO will then have a smaller link-order value than the Default Domain Policy.

![](../../media/Configure-Firewall-Port-Requirements-for-Group-Policy/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

You can use the **New-GPO** cmdlet with the **â€“StarterGpoName** parameter to create a new GPO. You can then pipe the output from the **New-GPO** cmdlet to the **New-GPLink** cmdlet.

For example, to create a new GPO, called *Configure firewall rules for remote reporting*, based on the **Group Policy Reporting Firewall Ports** Starter GPO, and link the GPO to the Contoso.com domain, type the following:

```
New-GPO â€“Name "Configure firewall rules for remote reporting" â€“StarterGpoName "Group Policy Reporting Firewall Ports" | New-GPLink â€“target "dc=Contoso,dc=com" â€“LinkEnabled yes
```

For more information about the **New-GPO** cmdlet and the **New-GPLink** cmdlet, see:

-   [New-GPO](http://technet.microsoft.com/library/hh967472.aspx)

-   [New-GPLink](http://technet.microsoft.com/library/hh967457.aspx)

## <a name="BKMK_RemoteRefresh"></a>Remote Group Policy refresh: ports that require firewall rules
To schedule a remote Group Policy refresh for domain-joined computers you must have firewall rules that enable inbound network traffic on the ports listed in the following table.

|Server port|Type of network traffic|
|---------------|---------------------------|
|TCP RPC dynamic ports, Schedule (Task Scheduler service)|Remote Scheduled Tasks Management (RPC)|
|TCP port 135, RPCSS (Remote Procedure Call service)|Remote Scheduled Tasks Management (RPC-EPMAP)|
|TCP all ports, Winmgmt (Windows Management Instrumentation service)|Windows Management Instrumentation (WMI-in)|

## <a name="BKMK_RemoteConfig2"></a>Configure firewall rules by creating a GPO from the Group Policy Remote Update Firewall Ports Starter GPO and linking to the domain
In  Windows Server 2012 , Group Policy adds a new Starter GPO called **Group Policy Remote Update Firewall Ports**. This Starter GPO includes policy settings to configure the firewall rules that are specified in the previous table. This enables inbound network traffic on the ports, which is necessary to allow the remote Group Policy refresh to run. It is a best practice to create a new GPO from this Starter GPO, and then link the new GPO to your domain with a higher precedence than the Default Domain GPO, so that you can configure all computers in the domain to enable a remote Group Policy refresh.

### <a name="BKMK_remoteProc2"></a>To create a GPO from the Group Policy Remote Update Firewall Ports Starter GPO and link to the domain

1.  In the GPMC console tree, right-click the domain for which you want to configure all computers to enable a remote Group Policy refresh, and then click **Create a GPO in this domain, and Link it hereâ€¦**

2.  In the **New GPO** dialog box, type the name of the new Group Policy Object in the **Name** box.

3.  Select the **Group Policy Remote Update Firewall Ports** Starter GPO from the **Source Starter GPO** list.

    > [!NOTE]
    > If you do not see any Starter GPOs listed, cancel creating a GPO and do the following before you return to the Step 1:
    > 
    > 1.  Navigate to **Starter GPOs**
    > 2.  In the results pane, click **Create Starter GPOs Folder**

4.  Click **OK**.

5.  In the results pane, click the **Linked Group Policy Objects** tab.

6.  Select the GPO that you just created. Click the up arrow until the GPO you just created is above the Default Domain Policy in link order. The new GPO will then have a smaller link order value than the Default Domain Policy.

![](../../media/Configure-Firewall-Port-Requirements-for-Group-Policy/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

You can use the **New-GPO** cmdlet with the **â€“StarterGpoName** parameter to create a new GPO. You can then pipe the output from the **New-GPO** cmdlet to the **New-GPLink** cmdlet.

For example, to create a new GPO, called *Configure firewall rules for remote gpupdate*, which is based on the **Group Policy Remote Update Firewall Ports** Starter GPO, and link the GPO to the Contoso.com domain, type the following:

```
New-GPO â€“Name "Configure firewall rules for remote gpupdate" â€“StarterGpoName "Group Policy Remote Update Firewall Ports" | New-GPLink â€“target "dc=Contoso,dc=com" â€“LinkEnabled yes
```

For more information about the **New-GPO** cmdlet and the **New-GPLink** cmdlet, see:

-   [New-GPO](http://technet.microsoft.com/library/hh967472.aspx)

-   [New-GPLink](http://technet.microsoft.com/library/hh967457.aspx)


