---
title: Configure and View VLAN Settings on Hyper-V Virtual Switch Ports
description: You can use this topic to learn best practices for configuring and viewing virtual Local Area Network (VLAN) settings on a Hyper-V Virtual Switch port in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-hv-switch
ms.topic: article
ms.assetid: 69e0e28a-98ae-4ade-bd27-ce2ad7eb310f
ms.author: lizross
author: eross-msft
---
# Configure and View VLAN Settings on Hyper-V Virtual Switch Ports

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn best practices for configuring and viewing virtual Local Area Network (VLAN) settings on a Hyper-V Virtual Switch port.

When you want to configure VLAN settings on Hyper-V Virtual Switch ports, you can use either Windows&reg; Server 2016 Hyper-V Manager or System Center Virtual Machine Manager (VMM).

If you are using VMM, VMM uses the following Windows PowerShell command to configure the switch port.

```
Set-VMNetworkAdapterIsolation <VM-name|-managementOS> -IsolationMode VLAN -DefaultIsolationID <vlan-value> -AllowUntaggedTraffic $True
```
If you are not using VMM and are configuring the switch port in Windows Server, you can use the Hyper-V Manager console or the following Windows PowerShell command.
```
Set-VMNetworkAdapterVlan <VM-name|-managementOS> -Access -VlanID <vlan-value>
```

Because of these two methods for configuring VLAN settings on Hyper-V Virtual Switch ports, it is possible that when you attempt to view the switch port settings, it appears to you that the VLAN settings are not configured - even when they are configured.

## Use the same method to configure and view switch port VLAN settings

To ensure that you do not encounter these issues, you must use the same method to view your switch port VLAN settings that you used to configure the switch port VLAN settings.

To configure and view VLAN switch port settings, you must do the following:

- If you are using VMM or Network Controller to set up and manage your network, and you have deployed Software Defined Networking (SDN), you must use the **VMNetworkAdapterIsolation** cmdlets. 
- If you are using Windows Server 2016 Hyper-V Manager or Windows PowerShell cmdlets, and you have not deployed Software Defined Networking (SDN), you must use the **VMNetworkAdapterVlan** cmdlets.

### Possible issues

If you do not follow these guidelines you might encounter the following issues.

- In circumstances where you have deployed SDN and use VMM, Network Controller, or the **VMNetworkAdapterIsolation** cmdlets to configure VLAN settings on a Hyper-V Virtual Switch port: If you use Hyper-V Manager or **Get VMNetworkAdapterVlan** to view the configuration settings, the command output will not display your VLAN settings. Instead you must use the **Get-VMNetworkIsolation** cmdlet to view the VLAN settings.
- In circumstances where you have not deployed SDN, and instead use Hyper-V Manager or the **VMNetworkAdapterVlan** cmdlets to configure VLAN settings on a Hyper-V Virtual Switch port: If you use the **Get-VMNetworkIsolation** cmdlet to view the configuration settings, the command output will not display your VLAN settings. Instead you must use the **Get VMNetworkAdapterVlan** cmdlet to view the VLAN settings.

It is also important not to attempt to configure the same switch port VLAN settings by using both of these configuration methods. If you do this, the switch port is incorrectly configured, and the result might be a failure in network communication.

### Resources

For more information on the Windows PowerShell commands that are mentioned in this topic, see the following:

- [Set-VmNetworkAdapterIsolation](https://technet.microsoft.com/library/dn464283.aspx)
- [Get-VmNetworkAdapterIsolation](https://technet.microsoft.com/library/dn464277.aspx)
- [Set-VMNetworkAdapterVlan](https://technet.microsoft.com/library/hh848475.aspx)
- [Get-VMNetworkAdapterVlan](https://technet.microsoft.com/library/hh848516.aspx)





