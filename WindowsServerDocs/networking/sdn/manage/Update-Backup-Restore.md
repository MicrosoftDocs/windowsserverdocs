---
title: Upgrade, backup, and restore SDN infrastructure
description: In this topic, you learn how to update, backup and restore an SDN infrastructure. 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: e9a8f2fd-48fe-4a90-9250-f6b32488b7a4
ms.author: grcusanz
author: eross-msft
ms.date: 08/27/2018
---

# Upgrade, backup, and restore SDN infrastructure

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, you learn how to update, backup and restore an SDN infrastructure. 

## Upgrade the SDN infrastructure
SDN infrastructure can be upgraded from Windows Server 2016 to Windows Server 2019. For upgrade ordering, follow the same sequence of steps as mentioned in the section “Update the SDN infrastructure”. Before upgrade, it is recommended to take a backup of the Network Controller database.

For Network Controller machines, use the Get-NetworkControllerNode cmdlet to check the status of the node after the upgrade has been completed. Ensure that the node comes back to “Up” status before upgrading the other nodes. Once you have upgraded all of the Network Controller nodes, the Network Controller updates the microservices running within the Network Controller cluster within an hour. You can trigger an immediate update using the update-networkcontroller cmdlet. 

Install the same Windows updates on all of the operating system components of the Software Defined Networking (SDN) system, which includes:

- SDN enabled Hyper-V hosts
- Network Controller VMs
- Software Load Balancer Mux VMs
- RAS Gateway VMs 

>[!IMPORTANT]
>If you use System Center Virtual Manager, you must update it with the latest update rollups.

When you update each component, you can use any of the standard methods for installing Windows updates. However, to ensure minimal downtime for workloads and the integrity of the Network Controller database, follow these steps:

1. Update the management consoles.<p>Install the updates on each of the computers where you use the Network Controller Powershell module.  Including anywhere that you have the RSAT-NetworkController role installed by itself. Excluding the Network Controller VMs themselves; you update them in the next step.

2. On the first Network Controller VM, install all updates and restart.

3. Before proceeding to the next Network Controller VM, use the `get-networkcontrollernode` cmdlet to check the status of the node that you updated and restarted.

4. During the reboot cycle, wait for the Network Controller node to go down and then come back up again.<p>After rebooting the VM, it can take several minutes before it goes back into the **_Up_** status. For an example of the output, see 

5. Install updates on each SLB Mux VM one at a time to ensure continuous availability of the load balancer infrastructure.

6. Update Hyper-V hosts and RAS gateways, starting with the hosts that contain the RAS gateways that are in **Standby** mode.<p>RAS gateway VMs can't be migrated live without losing tenant connections. During the update cycle, you must be careful to minimize the number of times tenant connections failover to a new RAS gateway. By coordinating the update of hosts and RAS gateways, each tenant fails over once, at most.

    a. Evacuate the host of VMs that are capable of live migration.<p>RAS gateway VMs should remain on the host.

    b. Install updates on each Gateway VM on this host.

    c. If the update requires the gateway VM to reboot then reboot the VM.  

    d. Install updates on the host containing the gateway VM that was just Updated.

    e. Reboot the host if required by the updates.

    f. Repeat for each additional host containing a standby gateway.<p>If no standby gateways remain, then follow these same steps for all remaining hosts.


### Example: Use the get-networkcontrollernode cmdlet 

In this example, you see the output for the `get-networkcontrollernode` cmdlet run from within one of the Network Controller VMs.  

The status of the nodes that you see in the example output is:

- NCNode1.contoso.com = Down
- NCNode2.contoso.com = Up
- NCNode3.contoso.com = Up

>[!IMPORTANT]
>You must wait several minutes until the status for the node changes to _**Up**_ before you update any additional nodes, one at a time.

Once you have updated all of the Network Controller nodes, the Network Controller updates the microservices running within the Network Controller cluster within an hour. 

>[!TIP]
>You can trigger an immediate update using the `update-networkcontroller` cmdlet.


```Powershell
PS C:\> get-networkcontrollernode
Name            : NCNode1.contoso.com
Server          : NCNode1.Contoso.com
FaultDomain     : fd:/NCNode1.Contoso.com
RestInterface   : Ethernet
NodeCertificate :
Status          : Down

Name            : NCNode2.Contoso.com
Server          : NCNode2.contoso.com
FaultDomain     : fd:/ NCNode2.Contoso.com
RestInterface   : Ethernet
NodeCertificate :
Status          : Up

Name            : NCNode3.Contoso.com
Server          : NCNode3.Contoso.com
FaultDomain     : fd:/ NCNode3.Contoso.com
RestInterface   : Ethernet
NodeCertificate :
Status          : Up
```

### Example: Use the update-networkcontroller cmdlet
In this example, you see the output for the `update-networkcontroller` cmdlet to force Network Controller to update. 

>[!IMPORTANT]
>Run this cmdlet when you have no more updates to install.


```Powershell
PS C:\> update-networkcontroller
NetworkControllerClusterVersion NetworkControllerVersion
------------------------------- ------------------------
10.1.1                          10.1.15
```

## Backup the SDN infrastructure

Regular backups of the Network Controller database ensures business continuity in the event of a disaster or data loss.  Backing up the Network Controller VMs is not sufficient because it does not ensure that the session continues across the multiple Network Controller nodes.

**Requirements:**
* An SMB share and credentials with Read/Write permissions to the share and file system.
* You can optionally use a Group Managed Service Account (GMSA) if the Network Controller was installed using a GMSA as well.

**Procedure:**

1. Use the VM backup method of your choice, or use Hyper-V to export a copy of each Network Controller VM.<p>Backing up the Network Controller VM ensures that the necessary certificates for decrypting the database are present.  

2. If using System Center Virtual Machine Manager (SCVMM), stop the SCVMM service and back it up via SQL Server.<p>The goal here is to ensure that no updates get made to SCVMM during this time, which could create an inconsistency between the Network Controller backup and SCVMM.  

   >[!IMPORTANT]
   >Do not re-start the SCVMM service until the Network Controller backup is complete.

3. Backup the Network Controller database with the `new-networkcontrollerbackup` cmdlet.

4. Check the completion and success of the backup with the `get-networkcontrollerbackup` cmdlet.

5. If using SCVMM, start SCVMM service.



### Example: Backing up the Network Controller database

```Powershell
$URI = "https://NC.contoso.com"
$Credential = Get-Credential

# Get or Create Credential object for File share user

$ShareUserResourceId = "BackupUser"

$ShareCredential = Get-NetworkControllerCredential -ConnectionURI $URI -Credential $Credential | Where {$_.ResourceId -eq $ShareUserResourceId }
If ($ShareCredential -eq $null) {
    $CredentialProperties = New-Object Microsoft.Windows.NetworkController.CredentialProperties
    $CredentialProperties.Type = "usernamePassword"
    $CredentialProperties.UserName = "contoso\alyoung"
    $CredentialProperties.Value = "<Password>"

    $ShareCredential = New-NetworkControllerCredential -ConnectionURI $URI -Credential $Credential -Properties $CredentialProperties -ResourceId $ShareUserResourceId -Force
}

# Create backup

$BackupTime = (get-date).ToString("s").Replace(":", "_")

$BackupProperties = New-Object Microsoft.Windows.NetworkController.NetworkControllerBackupProperties
$BackupProperties.BackupPath = "\\fileshare\backups\NetworkController\$BackupTime"
$BackupProperties.Credential = $ShareCredential

$Backup = New-NetworkControllerBackup -ConnectionURI $URI -Credential $Credential -Properties $BackupProperties -ResourceId $BackupTime -Force
```

### Example: Checking the status of a Network Controller backup operation

```Powershell
PS C:\ > Get-NetworkControllerBackup -ConnectionUri $URI -Credential $Credential -ResourceId $Backup.ResourceId
| ConvertTo-JSON -Depth 10
{
    "Tags":  null,
    "ResourceRef":  "/networkControllerBackup/2017-04-25T16_53_13",
    "InstanceId":  "c3ea75ae-2892-4e10-b26c-a2243b755dc8",
    "Etag":  "W/\"0dafea6c-39db-401b-bda5-d2885ded470e\"",
    "ResourceMetadata":  null,
    "ResourceId":  "2017-04-25T16_53_13",
    "Properties":  {
                    "BackupPath":  "\\\\fileshare\backups\NetworkController\\2017-04-25T16_53_13",
                    "ErrorMessage":  "",
                    "FailedResourcesList":  [

                                            ],
                    "SuccessfulResourcesList":  [
                                                    "/networking/v1/credentials/11ebfc10-438c-4a96-a1ee-8a048ce675be",
                                                    "/networking/v1/credentials/41229069-85d4-4352-be85-034d0c5f4658",
                                                    "/networking/v1/credentials/b2a82c93-2583-4a1f-91f8-232b801e11bb",
                                                    "/networking/v1/credentials/BackupUser",
                                                    "/networking/v1/credentials/fd5b1b96-b302-4395-b6cd-ed9703435dd1",
                                                    "/networking/v1/virtualNetworkManager/configuration",
                                                    "/networking/v1/virtualSwitchManager/configuration",
                                                    "/networking/v1/accessControlLists/f8b97a4c-4419-481d-b757-a58483512640",
                                                    "/networking/v1/logicalnetworks/24fa1af9-88d6-4cdc-aba0-66e38c1a7bb8",
                                                    "/networking/v1/logicalnetworks/48610528-f40b-4718-938e-99c2be76f1e0",
                                                    "/networking/v1/logicalnetworks/89035b49-1ee3-438a-8d7a-f93cbae40619",
                                                    "/networking/v1/logicalnetworks/a9c8eaa0-519c-4988-acd6-11723e9efae5",
                                                    "/networking/v1/logicalnetworks/d4ea002c-c926-4c57-a178-461d5768c31f",
                                                    "/networking/v1/macPools/11111111-1111-1111-1111-111111111111",
                                                    "/networking/v1/loadBalancerManager/config",
                                                    "/networking/v1/publicIPAddresses/2c502b2d-b39a-4be1-a85a-55ef6a3a9a1d",
                                                    "/networking/v1/GatewayPools/Default",
                                                    "/networking/v1/servers/4c4c4544-0058-5810-8056-b4c04f395931",
                                                    "/networking/v1/servers/4c4c4544-0058-5810-8057-b4c04f395931",
                                                    "/networking/v1/servers/4c4c4544-0058-5910-8056-b4c04f395931",
                                                    "/networking/v1/networkInterfaces/058430d3-af43-4328-a440-56540f41da50",
                                                    "/networking/v1/networkInterfaces/08756090-6d55-4dec-98d5-80c4c5a47db8",
                                                    "/networking/v1/networkInterfaces/2175d74a-aacd-44e2-80d3-03f39ea3bc5d",
                                                    "/networking/v1/networkInterfaces/2400c2c3-2291-4b0b-929c-9bb8da55851a",
                                                    "/networking/v1/networkInterfaces/4c695570-6faa-4e4d-a552-0b36ed3e0962",
                                                    "/networking/v1/networkInterfaces/7e317638-2914-42a8-a2dd-3a6d966028d6",
                                                    "/networking/v1/networkInterfaces/834e3937-f43b-4d3c-88be-d79b04e63bce",
                                                    "/networking/v1/networkInterfaces/9d668fe6-b1c6-48fc-b8b1-b3f98f47d508",
                                                    "/networking/v1/networkInterfaces/ac4650ac-c3ef-4366-96e7-d9488fb661ba",
                                                    "/networking/v1/networkInterfaces/b9f23e35-d79e-495f-a1c9-fa626b85ae13",
                                                    "/networking/v1/networkInterfaces/fdd929f1-f64f-4463-949a-77b67fe6d048",
                                                    "/networking/v1/virtualServers/15a891ee-7509-4e1d-878d-de0cb4fa35fd",
                                                    "/networking/v1/virtualServers/57416993-b410-44fd-9675-727cd4e98930",
                                                    "/networking/v1/virtualServers/5f8aebdc-ee5b-488f-ac44-dd6b57bd316a",
                                                    "/networking/v1/virtualServers/6c812217-5931-43dc-92a8-1da3238da893",
                                                    "/networking/v1/virtualServers/d78b7fa3-812d-4011-9997-aeb5ded2b431",
                                                    "/networking/v1/virtualServers/d90820a5-635b-4016-9d6f-bf3f1e18971d",
                                                    "/networking/v1/loadBalancerMuxes/5f8aebdc-ee5b-488f-ac44-dd6b57bd316a_suffix",
                                                    "/networking/v1/loadBalancerMuxes/d78b7fa3-812d-4011-9997-aeb5ded2b431_suffix",
                                                    "/networking/v1/loadBalancerMuxes/d90820a5-635b-4016-9d6f-bf3f1e18971d_suffix",
                                                    "/networking/v1/Gateways/15a891ee-7509-4e1d-878d-de0cb4fa35fd_suffix",
                                                    "/networking/v1/Gateways/57416993-b410-44fd-9675-727cd4e98930_suffix",
                                                    "/networking/v1/Gateways/6c812217-5931-43dc-92a8-1da3238da893_suffix",
                                                    "/networking/v1/virtualNetworks/b3dbafb9-2655-433d-b47d-a0e0bbac867a",
                                                    "/networking/v1/virtualNetworks/d705968e-2dc2-48f2-a263-76c7892fb143",
                                                    "/networking/v1/loadBalancers/24fa1af9-88d6-4cdc-aba0-66e38c1a7bb8_10.127.132.2",
                                                    "/networking/v1/loadBalancers/24fa1af9-88d6-4cdc-aba0-66e38c1a7bb8_10.127.132.3",
                                                    "/networking/v1/loadBalancers/24fa1af9-88d6-4cdc-aba0-66e38c1a7bb8_10.127.132.4"
                                                ],
                    "InProgressResourcesList":  [

                                                ],
                    "ProvisioningState":  "Succeeded",
                    "Credential":  {
                                        "Tags":  null,
                                        "ResourceRef":  "/credentials/BackupUser",
                                        "InstanceId":  "00000000-0000-0000-0000-000000000000",
                                        "Etag":  null,
                                        "ResourceMetadata":  null,
                                        "ResourceId":  null,
                                        "Properties":  null
                                    }
                }
}
```

## Restore the SDN infrastructure from a backup

When you restore all the necessary components from backup, the SDN environment returns to an operational state.  

>[!IMPORTANT]
>The steps vary depending on the number of components restored.


1. If necessary, redeploy Hyper-V hosts and the necessary storage.

2. If necessary, restore the Network Controller VMs, RAS gateway VMs and Mux VMs from backup. 

3. Stop NC host agent and SLB host agent on all Hyper-V hosts:

    ```
    stop-service slbhostagent

    stop-service nchostagent
    ```

4. Stop RAS Gateway VMs.

5. Stop SLB Mux VMs.

6. Restore the Network Controller with the `new-networkcontrollerrestore` cmdlet.

7. Check the restore **ProvisioningState** to know when the restore had completed successfully.

8. If using SCVMM, restore the SCVMM database using the backup that was created at the same time as the Network Controller backup.

9. If you want to restore workload VMs from backup, do that now.

10. Check the health of your system with the debug-networkcontrollerconfigurationstate cmdlet.

```Powershell
$cred = Get-Credential
Debug-NetworkControllerConfigurationState -NetworkController "https://NC.contoso.com" -Credential $cred

Fetching ResourceType:     accessControlLists
Fetching ResourceType:     servers
Fetching ResourceType:     virtualNetworks
Fetching ResourceType:     networkInterfaces
Fetching ResourceType:     virtualGateways
Fetching ResourceType:     loadbalancerMuxes
Fetching ResourceType:     Gateways
```

### Example: Restoring a Network Controller database
 
```Powershell
$URI = "https://NC.contoso.com"
$Credential = Get-Credential

$ShareUserResourceId = "BackupUser"
$ShareCredential = Get-NetworkControllerCredential -ConnectionURI $URI -Credential $Credential | Where {$_.ResourceId -eq $ShareUserResourceId }

$RestoreProperties = New-Object Microsoft.Windows.NetworkController.NetworkControllerRestoreProperties
$RestoreProperties.RestorePath = "\\fileshare\backups\NetworkController\2017-04-25T16_53_13"
$RestoreProperties.Credential = $ShareCredential

$RestoreTime = (Get-Date).ToString("s").Replace(":", "_")
New-NetworkControllerRestore -ConnectionURI $URI -Credential $Credential -Properties $RestoreProperties -ResourceId $RestoreTime -Force
```

### Example: Checking the status of a Network Controller database restore

```PowerShell
PS C:\ > get-networkcontrollerrestore -connectionuri $uri -credential $cred -ResourceId $restoreTime | convertto-json -depth 10
{
    "Tags":  null,
    "ResourceRef":  "/networkControllerRestore/2017-04-26T15_04_44",
    "InstanceId":  "22edecc8-a613-48ce-a74f-0418789f04f6",
    "Etag":  "W/\"f14f6b84-80a7-4b73-93b5-59a9c4b5d98e\"",
    "ResourceMetadata":  null,
    "ResourceId":  "2017-04-26T15_04_44",
    "Properties":  {
                    "RestorePath":  "\\\\sa18fs\\sa18n22\\NetworkController\\2017-04-25T16_53_13",
                    "ErrorMessage":  null,
                    "FailedResourcesList":  null,
                    "SuccessfulResourcesList":  null,
                    "ProvisioningState":  "Succeeded",
                    "Credential":  null
                }
}
```


For information on configuration state messages that may appear, see [Troubleshoot the Windows Server 2016 Software Defined Networking Stack](https://docs.microsoft.com/windows-server/networking/sdn/troubleshoot/troubleshoot-windows-server-software-defined-networking-stack).