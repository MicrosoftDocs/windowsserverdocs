---
title: Shielded VMs - Tenant creates shielding data to define a shielded VM
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 49f4e84d-c1f7-45e5-9143-e7ebbb2ef052
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---
# Shielded VMs - Tenant creates shielding data to define a shielded VM

>Applies To: Windows Server 2016

This topic provides information about what is included in a shielding data file, how to create a shielding data file, and how to create a shielded VM in VMM. To understand how this topic fits in the overall process of deploying shielded VMs, see [Configuration scenarios for shielded VMs in a guarded fabric](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

For a diagram of the contents of a shielding data file, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary).

In order to leverage the signed template disks configured in VMM, tenants must prepare at least one shielding data file - a file that contains all of the tenant's secrets necessary to deploy a VM. These secrets include the unattend file used to specialize the VM, any certificates that need to be deployed, administrator account passwords, and more. The shielding data file also identifies which guarded fabrics a tenant trusts to host their VM, as well as which signed template disks the shielding data can be applied to. Everything in the shielding data file is encrypted such that only a host in a guarded fabric the tenant trusts is able to decrypt the shielding data file and apply its contents and settings to a signed template disk for provisioning.

This section covers the necessary steps to create a shielding data file, including some of the supporting files that go into the shielding data file.

>**Important**&nbsp;&nbsp;The steps in this section should be completed on a tenant machine running Windows Server 2016. That machine must not be part of a guarded fabric (that is, should not be configured to use an HGS cluster).

## Obtain a certificate for Remote Desktop Connection

Since tenants are only able to connect to their shielded VMs using Remote Desktop Connection or other remote management tools, it is important to ensure that tenants can verify they are connecting to the right endpoint. That is, to ensure that there is not a "man in the middle" intercepting the connection and recording the user's keystrokes, which may reveal important information such as an administrator password.

One way to verify you are connecting to the intended server is to install and configure a certificate for Remote Desktop Services to present when you initiate a connection. The client machine connecting to the server will check whether it trusts the certificate and show a warning if it does not. Generally, to ensure the connecting client trusts the certificate, RDP certificates are issued from the tenant's PKI. More information about [Using certificates in Remote Desktop Services](https://technet.microsoft.com/library/dn781533.aspx) can be found on TechNet.

<!-- The previous link comes from Windows 2012 R2 content, but as of Sept 2016, there isn't a more recent link that covers the same information. -->

>**Note**&nbsp;&nbsp;When selecting an RDP certificate to include in your shielding data file, be sure to use a wildcard certificate. One shielding data file may be used to create an unlimited number of VMs. Since each VM will share the same certificate, a wildcard certificate ensures the certificate will be valid regardless of the VM's hostname.

If you are evaluating shielded VMs and are not yet ready to request a certificate from your certificate authority, you can create a self-signed certificate on the tenant machine by running the following Windows PowerShell command (where *contoso.com* is the tenant's domain):

``` syntax
$rdpCertificate = New-SelfSignedCertificate -DnsName '\*.contoso.com'
$password = ConvertTo-SecureString -AsPlainText 'Password1' -Force
Export-PfxCertificate -Cert $RdpCertificate -FilePath .\rdpCert.pfx -Password $password
```

## Create an answer file

Since the signed template disk in VMM is generalized, tenants are required to provide an answer file to specialize their shielded VMs during the provisioning process. The answer file (often called the unattend file) can configure the VM for its intended role - that is, it can install Windows features, register the RDP certificate created in the previous step, and perform other custom actions. It will also supply required information for Windows setup including the default administrator's password and product key.

For information about obtaining and using the **New-ShieldingDataAnswerFile** function to generate an answer file (Unattend.xml file) for creating shielded VMs, see [Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md). Using the function, you can more easily generate an answer file that reflects choices such as the following:

- Is the VM intended to be domain joined at the end of the initialization process?
- Will you be using a volume license or specific product key per VM?
- Are you using DHCP or static IP?
- Will you use a Remote Desktop Protocol (RDP) certificate that will be used to prove that the VM belongs to your organization?
- Do you want to run a script at the end of the initialization?
- Are you using a Desired State Configuration (DSC) server for further configuration?

Answer files used in shielding data files will be used on every VM created using that shielding data file. Therefore, you should make sure that you do not hard code any VM-specific information into the answer file. VMM supports some substitution strings (see the table below) in the unattend file to handle specialization values that may change from VM to VM. You are not required to use these; however, if they are present VMM will take advantage of them.

When creating an unattend.xml file for shielded VMs, keep in mind the following restrictions:

-   The unattend file must result in the VM being turned off after it has been configured. This is to allow VMM to know when it should report to the tenant that the VM finished provisioning and is ready for use. VMM will automatically power the VM back on once it detects it has been turned off during provisioning.

-   It is strongly recommended that you configure an RDP certificate to ensure you are connecting to the right VM and not another machine configured for a man-in-the-middle attack.

-   Be sure to enable RDP and the corresponding firewall rule so you can access the VM after it has been configured. You cannot use the VMM console to access shielded VMs, so you will need RDP to connect to your VM. If you prefer to manage your systems with Windows PowerShell remoting, ensure WinRM is enabled, too.

-   The only substitution strings supported in shielded VM unattend files are the following:

| Replaceable Element | Substitution String |
|-----------|-----------|
| ComputerName        | @ComputerName@      |
| TimeZone            | @TimeZone@          |
| ProductKey          | @ProductKey@        |
| IPAddr4-1           | @IP4Addr-1@         |
| IPAddr6-1           | @IP6Addr-1@         |
| MACAddr-1           | @MACAddr-1@         |
| Prefix-1-1          | @Prefix-1-1@        |
| NextHop-1-1         | @NextHop-1-1@       |
| Prefix-1-2          | @Prefix-1-2@        |
| NextHop-1-2         | @NextHop-1-2@       |

When using substitution strings, it is important to ensure that the strings will be populated during the VM provisioning process. If a string such as @ProductKey@ is not supplied at deployment time, leaving the &lt;ProductKey&gt; node in the unattend file blank, the specialization process will fail and you will be unable to connect to your VM.

Also, note that the networking-related substitution strings towards the end of the table are only used if you are leveraging VMM Static IP Address Pools. Your hosting service provider should be able to tell you if these substitution strings are required. For more information about static IP addresses in VMM templates, see the following in the VMM documentation:

- [Guidelines for IP address pools](https://technet.microsoft.com/system-center-docs/vmm/plan/plan-network#guidelines-for-ip-address-pools) 
- [Set up static IP address pools in the VMM fabric](https://technet.microsoft.com/system-center-docs/vmm/manage/manage-network-static-address-pools)

Finally, it is important to note that the shielded VM deployment process will only encrypt the OS drive. If you deploy a shielded VM with one or more data drives, it is strongly recommended that you add an unattend command or Group Policy setting in the tenant domain to automatically encrypt the data drives.

## Get the volume signature catalog file

Shielding data files also contain information about the template disks a tenant trusts. Tenants acquire the disk signatures from trusted template disks in the form of a volume signature catalog (VSC) file. These signatures are then validated when a new VM is deployed. If none of the signatures in the shielding data file match the template disk trying to be deployed with the VM (i.e. it was modified or swapped with a different, potentially malicious disk), the provisioning process will fail.

While the VSC ensures a disk has not been tampered with, it is still important for the tenant to trust the disk in the first place. In a hosting service provider scenario where the template disk is provided by the hoster and the tenant uses that disk for their own VMs, it is important for the tenant to deploy a test VM using that template disk and run their own tools (antivirus, vulnerability scanners, and so on) to validate the disk is, in fact, in a state the tenant trusts.

There are two ways to acquire the VSC of a template disk:

-  The hoster (or tenant, if the tenant has access to VMM) uses the VMM PowerShell cmdlets to save the VSC and gives it to the tenant. This can be performed on any machine with the VMM console installed and configured to manage the hosting fabric?' VMM environment. The PowerShell cmdlets to save the VSC are:

        $disk = Get-SCVirtualHardDisk -Name "templateDisk.vhdx"
    
        $vsc = Get-SCVolumeSignatureCatalog -VirtualHardDisk $disk
    
        $vsc.WriteToFile(".\templateDisk.vsc")

-  The tenant has access to the template disk file. This may be the case if the tenant creates their own template disk which is uploaded to a hosting service provider or if the tenant can download the hoster's template disk. In this case, without VMM in the picture, the tenant would run the following cmdlet (installed with the Shielded VM Tools feature, part of Remote Server Administration Tools):

        Save-VolumeSignatureCatalog -TemplateDiskPath templateDisk.vhdx -VolumeSignatureCatalogPath templateDisk.vsc

## Designate trusted fabrics

The last component in the shielding data file relates to the owner and guardians of a VM. Guardians are used to designate both the owner of a shielded VM and the guarded fabrics on which it is authorized to run.

To authorize a hosting fabric to run a shielded VM, you must obtain the guardian metadata from the hosting service provider's Host Guardian Service. Often, the hosting service provider will provide you with this metadata through their management tools. In an enterprise scenario, you may have direct access to obtain the metadata yourself.

You or your hosting service provider can obtain the guardian metadata from HGS by performing one of the following actions:

-  Obtain the guardian metadata directly from HGS by running the following Windows PowerShell command, or browsing to the website and saving the XML file that is displayed:

        Invoke-WebRequest 'http://hgs.relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml' -OutFile .\RelecloudGuardian.xml

-  Obtain the guardian metadata from VMM using the VMM PowerShell cmdlets:

        $relecloudmetadata = Get-SCGuardianConfiguration

        $relecloudmetadata.InnerXml | Out-File .\RelecloudGuardian.xml -Encoding UTF8

Obtain the guardian metadata files for each guarded fabric you wish to authorize your shielded VMs to run on before continuing.

## Create a shielding data file and add guardians

Run the Shielding Data File wizard to create a shielding data (PDK) file. Here, you'll add the RDP certificate, unattend file, volume signature catalogs, owner guardian and the downloaded guardian metadata obtained in the preceding step.

1.  Install **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools** on your machine using Server Manager or the following Windows PowerShell command:

        Install-WindowsFeature RSAT-Shielded-VM-Tools

2.  Open the Shielding Data File Wizard from the Administrator Tools section on your Start menu or by running the following executable **C:\\Windows\\System32\\ShieldingDataFileWizard.exe**.

3.  On the first page, use the second file selection box to choose a location and file name for your shielding data file. Normally, you would name a shielding data file after the entity who owns any VMs created with that shielding data (for example, HR, IT, Finance) and the workload role it is running (for example, file server, web server, or anything else configured by the unattend file). Leave the radio button set to **Shielding data for Shielded templates**.

    >**Note**&nbsp;&nbsp;In the Shielding Data File Wizard you will notice the two options below:
    >- **Shielding data for Shielded templates**
    >- **Shielding data for existing VMs and non-Shielded templates**<br>
    > The first option is used when creating new shielded VMs from shielded templates. The second option allows you to create shielding data that can only be used when converting existing VMs or creating shielded VMs from non-shielded templates.

    ![Shielding Data File Wizard, file selection](../media/Guarded-Fabric-Shielded-VM/guarded-host-shielding-data-wizard-01.png)

       Additionally, you must choose whether VMs created using this shielding data file will be truly shielded or configured in "encryption supported" mode. For more information about these two options, see [What are the types of virtual machines that a guarded fabric can run?](Guarded-Fabric-and-Shielded-VMs.md#what-are-the-types-of-virtual-machines-that-a-guarded-fabric-can-run).

    >**Important**&nbsp;&nbsp;Pay careful attention to the next step as it defines the owner of your shielded VMs and which fabrics your shielded VMs will be authorized to run on.<br>
    
    > Possession of **owner guardian** is required in order to later change an existing shielded VM from **Shielded** to **Encryption Supported** or vice-versa.
    
4.  Your goal here is two-fold then:

    - Create or select an owner guardian that represents you as the VM owner

    - Import the guardian that you downloaded from the hosting provider's (or your own) Host Guardian Service in the preceding step

    To designate an existing owner guardian, select the appropriate guardian from the drop down menu. Only guardians installed on your local machine with the private keys intact will show up in this list. You can also create your own owner guardian by selecting **Manage Local Guardians** in the lower right corner and clicking **Create** and completing the wizard.

    Next, we import the guardian metadata downloaded earlier again using the **Owner and Guardians** page. Select **Manage Local Guardians** from the lower right corner. Use the **Import** feature to import the guardian metadata file. Click OK once you have imported or added all of the necessary guardians. As a best practice, name guardians after the hosting service provider or enterprise datacenter they represent. Finally, select all the guardians that represent the datacenters in which your shielded VM is authorized to run. You do not need to select the owner guardian again. Click Next once finished.

    ![Shielding Data File Wizard, owner and guardians](../media/Guarded-Fabric-Shielded-VM/guarded-host-shielding-data-wizard-02.png)

5.  On the Volume ID Qualifiers page, click **Add** to authorize a signed template disk in your shielding data file. When you select a VSC in the dialog box, it will show you information about that disk's name, version, and the certificate that was used to sign it. Repeat this process for each template disk you wish to authorize.

6.  On the **Specialization Values** page, click **Browse** to select your unattend.xml file that will be used to specialize your VMs.

    Use the **Add** button at the bottom to add any additional files to the PDK that are needed during the specialization process. For example, if your unattend file is installing an RDP certificate onto the VM (as described in [Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md)), you should add the RDPCert.pfx file referenced in the unattend file here. Note that any files you specify here will automatically be copied to C:\\temp\\ on the VM that is created. Your unattend file should expect the files to be in that folder when referencing them by path.

7.  Review your selections on the next page, and then click **Generate**.

8.  Close the wizard after it has completed.

You can now use the shielding data file to deploy VMs using VMM in your hosting environment.

## Create a shielded VM in VMM

The following steps apply to tenants who have access to the VMM console to deploy new shielded VMs.

1.  In the **VMs and Services** workspace of the VMM Console, click **Create Virtual Machine**.

2.  Select a VM template from those your hosting service provider or enterprise admin made available to you. The template you select must use a template disk you authorized in your shielding data file.

3.  On the **Select Shielding Data File** page, click **Browse &gt; Import Shielding Data &gt; Browse**, and select the shielding data file that you created. Click **Import &gt; OK &gt; Next**. If your shielding data file was previously imported, you can simply select it from the first window.

4.  Continue with the wizard, selecting destination, cloud, and other settings and properties. When you have made your selections, on the last page of the wizard, click **Create**.

VMM creates a new shielded virtual machine from the VM template using information from the shielding data file. To create the VM, VMM performs the following actions automatically:

1.  The template disk (VHDX) file is copied from the VMM library.

2.  The VM provisioning service decrypts data in the shielding data file, completes any substitution strings in your Unattend.xml file and copies over the additional files from your shielding data file to the OS drive (e.g. the RDP certificate).

3.  The VM restarts, enters the specialization process, and is re-encrypted with BitLocker. The BitLocker full volume encryption key is stored in the virtual TPM of the newly created VM. In the **Jobs** workspace in VMM, you can see the status of the VM, and whether it has entered the customization process.

4.  VM specialization is complete when the shutdown command in your unattend file is executed and the VM remains off. Once VMM is aware that specialization has completed, it will start the VM back up and report back to the user that the VM was successfully created.

>**Note**&nbsp;&nbsp;If you see that customization of the VM begins but eventually times out without completion, there might be an issue with your unattend file. Try using the unattend file on an unshielded or encryption supported VM to see if the customization process stalls at any point, and remedy the stalling task if possible.

## See also

- [Configuration scenarios for shielded VMs in a guarded fabric](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
