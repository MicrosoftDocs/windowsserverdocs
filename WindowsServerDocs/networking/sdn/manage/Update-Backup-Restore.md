---
title: Update, Backup, and Restore Software Defined Networking Infrastructure
description: This topic is part of the Software Defined Networking guide on how to Update, Backup and Restore SDN infrastructure in Windows Server 2016.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-sdn
ms.topic: article
ms.assetid: e9a8f2fd-48fe-4a90-9250-f6b32488b7a4
ms.author: grcusanz
author: grcusanz
---

# Update, Backup, and Restore Software Defined Networking Infrastructure

>Applies To: Windows Server 2016

This topic contains the following sections.

- [Updating the SDN infrastructure](#bkmk_Updating)
- [Backup the SDN infrastructure](#bkmk_backup)
- [Restore the SDN infrastructure from a backup](#bkmk_restore)

## <a name="bkmk_Updating"></a>Updating the SDN Infrastructure

Updating is the process of installing Windows updates on all of the operating system components of the Software Defined Networking (SDN) system.  This includes the SDN enabled Hyper-V hosts, Network Controller VMs, Software Load Balancer Mux VMs and RAS Gateway VMs.  It is critical that all of these components have the exact same set of Updates installed.  If System Center Virtual Machine Manager is used it is also recommended that you also update it with the latest Update Rollups as well.

Updating of each component is performed using any of the standard methods for installing windows updates, however the steps described below must be followed to ensure minimal down time for workloads, and to ensure the integrity of the Network Controller database.

### Step 1: Update the management consoles
Install necessary updates on each of the computers where you use the Network Controller Powershell module.  This includes anywhere that you have the RSAT-NetworkController role installed by itself.  This does not including the Network Controller VMs themselves as they will be updated in Step 2.

### Step 2: Update the Network Controllers
This is the most critical step in the update cycle since each Network Controller VM must be updated and be fully back online in the Network Controller cluster before proceeding to the next one.

Start with one Network Controller VM and install all necessary updates.  Restart the VM if necessary.

Before proceeding to the next Network Controller VM use get-networkcontrollernode to check the status of the node that was Updated and rebooted.  Wait for the Network Controller node to go down during the reboot cycle and then come back up again.  After the VM has rebooted, it can still take several minutes for it to go back into the Up state.

#### Example: Using get-networkcontrollernode to check the status of Network Controller nodes

This example shows the output from running get-networkcontrollernode from within one of the Network Controller VMs.  It shows that NCNode1.contoso.com is Down while the other two nodes are healthy.  You must wait up to several minutes until the status for that node changes to Up before proceeding with Updating any additional nodes.

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

Only after all Network Controller nodes are in the Up state can you repeat these steps for each additional Network Controller node.  Continue to update each node one at a time.

Once all of the Network Controller nodes are updated, the Network Controller will update the microservices running within the Network Controller cluster within one hour.  You can trigger an immediate update using the update-networkcontroller cmdlet.

#### Example: Using update-networkcontroller to force Network Controller to update

This command shows the result of update-networkcontroller when there are not updates remaining to be installed.

```Powershell
PS C:\> update-networkcontroller
NetworkControllerClusterVersion NetworkControllerVersion
------------------------------- ------------------------
10.1.1                          10.1.15
```

### Step 3: Update SLB Muxes

Install updates on each SLB Mux VM one at a time to ensure continuous availability of the load balancer infrastructure.

### Step 4: Update Hyper-V Hosts and RAS Gateways

Because RAS Gateway VMs can't be live migrated without losing tenant connections, care must be taken in order to minimize the number of times that tenant connections will be failed over to a new RAS gateways during the Updating cycle.  By coordinating the Updating of the hosts and RAS gateways each tenant will only fail-over at most one time.  

Follow these steps for each host, starting with the hosts that contain the RAS Gateways that are in Standby mode:

1.	Evacuate the host of VMs that are capable of live migration.  RAS Gateway VMs should remain on the host.
2.	Install updates on each Gateway VM on this host.
3.	If update requires the gateway VM to reboot then reboot the VM.  
4.	Install updates on the host containing the gateway VM that was just Updated.
5.	Reboot the host if required by the updates.
6.	Repeat for each additional host containing a standby gateway.  If no standby gateways remain, then follow these same steps for all remaining hosts.

## <a name="bkmk_backup"></a>Backup the SDN infrastructure

Regular backups of the Network Controller database are critical to ensure business continuity in the event of a disaster or data loss.  Backing up the Network Controller VMs is insufficient because it does not ensure that quorum is maintained across the multiple Network Controller nodes.
Requirements:
 * A SMB share and credentials with Read/Write permissions to the share and file system.
 * You can optionally use a Group Managed Service Account (GMSA) if the Network Controller was installed using a GMSA as well.

Follow these steps to perform a backup:

1. Backup the Network Controller VMs using the VM backup method of your choice, or use Hyper-V to export a copy of each Network Controller VM.  This will ensure that if a full rebuild including restoration of the infrastructure VMs is performed, the necessary certificates for decrypting the database are present.
2. If you are using System Center Virtual Machine Manager (SCVMM), stop the SCVMM service and back it up via SQL Server to ensure that no updates are made to SCVMM during this time which could create an inconsistency between the Network Controller backup and SCVMM.  Do not re-start the SCVMM service until the Network Controller backup is complete.
3. Backup the Network Controller database using new-networkcontrollerbackup.

 #### Example: Backing up the Network Controller database
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

4. Use get-networkcontrollerbackup to check for completion and success of the backup.

 #### Example: Checking the status of a Network Controller backup operation

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

5.	If using SCVMM you can now start SCVMM service.

## <a name="bkmk_restore"></a>Restore the SDN infrastructure from a backup

Restore is the process of restoring all necessary components from backup to return an SDN environment to an operational state.  The steps will vary slightly depending on the amount of components that are being restored.

1. If necessary, redeploy Hyper-V hosts and the necessary storage.

2. If necessary, restore the Network Controller VMs, RAS Gateway VMs and Mux VMs from backup. 

3. Stop NC Host Agent and SLB Host Agent on all Hyper-V hosts

    ```
    stop-service slbhostagent

    stop-service nchostagent
    ```

4. Stop RAS Gateway VMs

5. Stop SLB Mux VMs

6. Restore the Network Controller using the new-networkcontrollerrestore cmdlet.

 #### Example: Restoring a Network Controller database
 
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

7. Check the restore ProvisioningState to know when the restore had completed successfully.

 #### Example: Checking the status of a Network Controller database restore

    ```
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

8. If using SCVMM, restore the SCVMM database using the backup that was created at the same time as the Network Controller backup.

9. If workload VMs are being restored from backup, you can do that now.

10. Use the debug-networkcontrollerconfigurationstate cmdlet to check the health of your system.

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

For information on configuration state messages that may appear, see [Troubleshoot the Windows Server 2016 Software Defined Networking Stack](../troubleshoot/troubleshoot-windows-server-2016-software-defined-networking-stack.md).