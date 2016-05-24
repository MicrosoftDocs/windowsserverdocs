---
title: 8 Scenario #2 – Create a new shielded VM from a VM template using SC VMM
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4eb1f6c6-5de5-4a29-95e9-611929e07d01
robots: noindex,nofollow
---
# 8 Scenario #2 – Create a new shielded VM from a VM template using SC VMM
For this scenario, hosting service providers prepare a signed disk template for use by their tenants, and then make it available to the tenants. The tenants then connect to the VMM and create a shielded VM from the shielded VM template, and then provide the desired configuration (for example, VM Name, RDP Certificate, and any other secret data at the time of VM creation).  
  
1.  Hosting service providers configure the VMM and Hyper-V fabric to support shielded VM.    
2.  Hosting service providers use the following procedures to create a shielded VM template:  
  
  1.  Download or prepare the VHD to use as a template.  
  2.  Create a signed disk template.  
  3.  Copy and publish the disk template to the VMM library.  
  4.  Create the shielded VM template in VMM using the signed disk.  
3.  Tenant administrators use the following procedures to create shielding data for the shielded VM. ***These steps must be completed on the tenant Hyper-V computer and not on the fabric Hyper-V host.***    
  1.  Create an RDP certificate.    
    2.  Create an Unattend file.    
    3.  Get the Volume Signature Catalog file.    
    4.  Get the Host Guardian Service Metadata and import it using cmdlets.    
    5.  Create a shielding Data File.    
4.  Finally, tenants use the following procedures to create and start the virtual machine:  
    1.  Create a shielded VM using VMM.  
    2.  Start the shielded VM and connect to it.  
  
### 8.1  Configure Host Guardian Service Settings in Virtual Machine Manager  
Virtual Machine Manager Technical Preview (VMM) includes features to manage shielded virtual machines (shielded VMs). Before you use VMM with the Host Guardian Service, you should already have VMM installed and configured for your infrastructure.  
  
  >For more information about installing and configuring VMM, see Virtual Machine Manager guidance or download the pre-configured image that has been made available to make the configuration of the scenario easier.  
  
**VMM should have the following:**  
  
1.  Tenants need to have the Tenant Administration user role so that they can use the remote VMM Administrator console.  
  1.  Verify that the user role you create for tenant administrators has the **Deploy shielded** property and **Deploy** permissions.  
2.  Clouds created for tenants, so that shielded VMs can be added to them.  
    1.  On the General property page of a cloud, verify that for **Shielded VM support**, you select **Supported on this private cloud**.  
    2.  Verify that the cloud’s host group contains the guarded hosts that will run shielded VMs.  
  
In VMM, you specify global URLs for the Host Guardian Service. VMM uses the attestation server URL to communicate with the Host Guardian Service to verify that a host is guarded and is allowed to run shielded VMs. After a host is configured with Host Guardian Service settings and VMM’s **Change properties of a virtual machine host job** runs for the host, it is ready to host shielded VMs. You can view the status of any changes in the **Jobs** workspace.  
  
Use the following procedures to configure VMM for guarded hosts.  
  
#### 8.1.1  Configure the Host Guardian Service settings  
  
1.  In VMM, open the **Settings** workspace, and then select **General**.  
1.  In the **Settings** view, open **Host Guardian Service Settings**.  
2.  In the **Host Guardian Service Settings** dialog box, type the URLs for the following servers:  
  1.  **Attestation Server URL**  
      1.  This URL might resemble <http://Relecloud.com/Attestation>  
  2.  **Key Protection Server URL**  
  1.  This URL might resemble <http://Relecloud.com/KeyProtection>  
  
  >If you enabled HTTPS endpoints when initializing the HGS Server in Section 6.4, use the https:// prefix for your URLs here. See Appendix B for more information on working with HTTPS.  
  
#### 8.1.2  Configure a specific guarded host’s settings  
  
1.  In VMM, open the **Fabric** workspace.    
2.  In the **Fabric** pane, under **Servers**, select **All Hosts.** .    
3.  In the **Hosts** view, select the guarded host that you want to update, and then click **Properties**.    
4.  In the **Host Properties** box, click **Host Guardian Service**.    
5.  Select the **Enable the Host Guardian Service and use the URLs configured as global settings in VMM** check box.    
6.  Click **OK**.    
  ![Enable Host Guardian Service](/Image/GF-shieldVM-Host-Guardian-Service-Settings.png)  
7.  You can review the job status for the guarded host in the **Jobs** workspace.  
  
**To review the job status and host status for a guarded host:**    
1.  After you have made changes to the Host Guardian Service settings for a host, open the **Jobs** workspace.    
  
  >**Note:** For TPM-based attestation only: If you have changed the code integrity policy for a host, it should have restarted the host. This job may take several minutes to complete.  
  
1.  In the **Jobs** pane, click **History**, and in the **History – Recent Jobs** view, select the **Change properties of a virtual machine host** job.    
2.  The status of the job is displayed:  
    1.  If the Status is **Running**, wait for the job to complete.  
    2.  If the Status is **Completed**, then the job successfully ran; however you should review the host status to verify that it is ready to host and run shielded VMs.    
3.  Open the **Fabric** workspace.    
4.  In the **Fabric** pane, under **Servers**, select **All Hosts**.    
5.  In the **Hosts** view, review the **Host Status** and take any actions needed, as follows:    
    1.  If the Host Status is **OK**, then the host is ready for shielded VMs.    
    ![Host Status](/Image/GF-shieldedVM-host-status.png)   
    2.  If the Host Status is **Needs Attention**, select the host, and then click **View Status**.    
        1.  In the **Host Properties** box, click **Status**. You should see one or more items with **Warning** status. Review the error details for the warning.    
        2.  If the warning indicates that the Key Protection Server or Attestation Server do not match the expected global Host Guardian Service setting, then you’ll need to change the settings for that host.    
        3.  For TPM-based attestation only: If the warning indicates that the code integrity policy needs to be updated, close the **Host Properties** box, and then click **Apply Latest Code Integrity Policy**. If an informational dialog appears, click **OK** to close it. The Host Status should change to **OK** after the host restarts and the **Change properties of a virtual machine host** runs.  
  
### 8.2  Hosting Service Provider Creates a Signed Disk Template  
#### 8.2.1  Create Generation 2 Disk Template  
  
You can create Generation 2 Template by using any of the following methods documented at [https://technet.microsoft.com/en-us/library/hh427282.aspx](https://technet.microsoft.com/en-us/library/hh427282.aspx).  
  
The guest operating system must be Generation 2-compatible with the operating system (e.g. Windows Server 2016 Technical Preview 3), and the disk must be partitioned using GPT.  
  
>In the current Technical Preview 3 release, the guest operating system must be the Windows Server 2016 Technical Preview build with all available Windows updates installed. Verify that KB3081450 is installed.  
  
Verify that the disk meets the following BitLocker requirements:    
* Is formatted with the NTFS file system.    
* Does not use Dynamic Volume.    
* Has at least two partitions. One partition must include the drive on which Windows is installed. This is the drive that BitLocker will encrypt. The other partition is the active partition, which remains unencrypted so that the computer can be started.  
  
  >Do not copy the Disk Template in the VMM library at this stage.  
  
#### 8.2.2  Run Windows Update on the template operating system  
  
Before continuing, verify that the template operating system has all of the latest Windows updates installed. Recently released updates improve the reliability of the end-to-end shielding process – a process that may fail to complete if the template operating system is not up-to-date.  
  
#### 8.2.3  Signing a Template Disk  
  
Hosting service providers can use the following procedure to create a signed disk template with the Protected Template Disk Creation wizard. The procedure creates a signed disk template disk that is encrypted with BitLocker. During this process, a hash for the disk is generated and added to a .VSC (volume signature catalog) file. The .VSC file is signed using a certificate and then BitLocker creates a full volume encryption key, which is placed on the disk. The key is stored in clear text.  
  
As the wizard runs, the existing .VHDX image is modified by embedding the .VSC file in it. You may want to copy the original .VHDX image and use the copy for the new template before you run the wizard.  
  
Later, when the VM is provisioned, the key becomes protected. After the read-only signed template is created, modifying the template will render it unusable. When creating a new VM from a template, tenants use VMM to download the volume signature catalog (VSC) for a template disk; the VSC can be used as one of the inputs for the PDK generation.  
  
1.  You will need a certificate to sign the VHD that will be used as a template for creating new VM. You must protect the certificate that you will use to sign the template. For testing purposes, you can use the VMM server to create the signed template. You need to install “Remote Server Administration Tools\\Feature Administration Tools\\Shielded VM Tools” in Server Manager, either using Add Roles and Features or with PowerShell using following command, and then restart the server:    
  ```Add-WindowsFeature -Name RSAT-Shielded-VM-Tools -Restart```    
1.  For this scenario validation, you can create a self-signed certificate to sign VHDX by running the following command:    
  ```New-SelfSignedCertificate -DnsName publisher.signingcertificate.com -CertStoreLocation Cert:\\LocalMachine\\My -KeyExportPolicy Exportable```    
1.  Run **C:\\Windows\\System32\\TemplateDiskWizard.exe** to start the Protected Template Disk Creation Wizard.    
2.  On the Certificate page, click **Browse** to display a list of certificates. Select the certificate that with which to sign the template. This is the publisher of the template. Click **OK** &gt; **Next**.  
3.  On the Virtual Disk page, **Browse** to the location of the virtual disk to update &gt; **Next**.  
4.  On the Signature Catalog page, type the values for **Disk name** and **Version**.  
For example, for **Disk name** type **10514TP3**. For **Version**, type **1.0.0.0**    
1.  On the Review Settings page, review the settings, and then click **Generate**.    
  1.  The page shows the template file being generated. Wait until the signing process has finished.  
2.  On the **Summary** page, information about the template, certificate used to sign the template, and the certificate issuer is shown. Click **Close** to exit the wizard.  
  
#### 8.2.4  Copy and publish the disk template to the VMM Library  
  
Use the following procedure to copy the disk template in Virtual Machine Manager (VMM).    
1.  Copy the VHDX file to the VMM library share folder.    
2.  Refresh the library to view the shielded disk.    
  
You can optionally add the **shielded** column in the VMM Administrator console using the corresponding property to view shielded disks.    
  
#### 8.2.5  Create the shielded VM template in VMM using the signed disk    
Use the following procedure to create the shielded VM template in VMM using the signed disk.    
1.  In VMM, start the **Create VM Template Wizard** to begin creating a shielded VM template using the signed disk.    
2.  In the **Hardware Configuration**, select the .VHDX disk that you prepared previously. Notice that secure boot is enabled.    
3.  Verify that the network adapter is connected to a virtual machine network; otherwise, users won’t be able to use Remote Desktop to connect to the VM, which is the only way for a tenant to connect to their VM.    
4.  For operating system properties, the wizard differs from regular templates. VMM displays non-secure information only, such as product key, time zone, and computer name. Secure information such as administrator password and domain name is specified by the tenant through a shielding data file (.PDK).    
  
  >Verify that the correct product key is provided in the operating system properties for the template disk. If an incorrect product key is used, the VM creation will fail. You can find product key for Windows Server 2016 Technical Preview 3 at [https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-technical-preview](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-technical-preview) under “Preinstall Information” section.  
  
After the template is created, tenants can use it when they create new virtual machines. You’ll need to verify that the virtual machine template is one of the resources available to the tenant administrator user role.  
  
### 8.3  Tenant creates shielding data to define a shielded VM    
Use the information in the following sections to prepare secret information for use with the shielded VM template, and then create the shielded VM.  
  
  >**The steps in this section must be completed on tenant server and not on the fabric Hyper-V host.**  
  
#### 8.3.1  Create an RDP certificate    
Tenants create a remote desktop certificate to log on to the shielded VMs as a personal information file (.PFX) file. The exported certificate is used in an Unattend.XML file in a subsequent procedure. For basic information about certificates, see [How to Use the Certificates Console](http://social.technet.microsoft.com/wiki/contents/articles/2167.how-to-use-the-certificates-console.aspx). For more comprehensive information about remote desktop certificates, see [Configuring Remote Desktop certificates](http://blogs.msdn.com/b/rds/archive/2010/04/09/configuring-remote-desktop-certificates.aspx).  
  
1.  On the tenant computer, create an answer file for the .VHDX that will be used during VM creation from the template. Review, modify as needed, and then run the following commands:  
  ```$rdpcertificate = New-SelfSignedCertificate -DnsName ts.examplerdpcertificate.com -CertStoreLocation Cert:\\LocalMachine\\My -KeyExportPolicy Exportable```  
  
  ```$rdpcertificatepassword = ConvertTo-SecureString -AsPlainText '!!123abc' -Force```  
  
  ```Export-PfxCertificate -Cert $rdpcertificate -Password $rdpcertificatepassword -FilePath 'c:\\rdpcert.pfx'```  
  
1.  Run the following command and record the thumbprint for the certificate.  
  
  ```$rdpcertificate.Thumbprint```  
  
#### 8.3.2  Create an Unattend File    
Tenants create an Unattend.XML file to define the secret information to include in the shielded VM. This information will later be used by the shielding Data File Wizard to create a .PDK (shielding data file). Tenants can include a set of values and substitution strings in the Unattend file, which allows the hosting service to provide the ability to specify replaceable elements. If no substitution strings are used, then the explicit values included in the Unattend file are used.  
  
As an example, the following substitution strings are used in the following example code. They are the only substitution strings supported.  
  
| Replaceable Element | Substitution String |  
|---------------------|---------------------|  
| ComputerName        | @@ComputerName@@    |  
| TimeZone            | @@TimeZone@@        |  
| ProductKey          |                     |    
---  
VMM will use substitution strings if you include them in the Uattend.XML file. If you do use substitution strings, verify that corresponding values are set in the VMM virtual machine template. Otherwise, the operating system customization will stall, which will prevent the VM from shutting down, and then causes the VMM task to fail.  
  
The example XML code does the following:  
  
1.  Enables Remote Desktop for the shielded VM by installing an RDP certificate.    
2.  Specifies the operating system customization defaults, with the **Microsoft-Windows-Deployment** section. The sample requires default information so that customization can complete without any user input. At the end of the operating system customization, the code will shut down the VM. VMM waits for the provisioned VM to shut down to verify that customization process is completed for the VM.    
3.  [Optional] Joins the shielded VM to a domain, using the domain name and credentials.  
  
  >**At a minimum, you must modify the RDP certificate thumbprint (*f5d17b3d2fe391480e7532764026d6129884862b*, in this example) with your own before you can use the Unattend.xml file.**  
  
Review the following sample Unattend.XML code, copy the code, and then modify it as needed.  
Save the code as an .XML file for later use with the Shielding Data File Wizard.  
  
  
```  
<?xml version="1.0" encoding="utf-8"?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend">  
    <servicing></servicing>  
    <settings pass="specialize">  
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <ComputerName>@@ComputerName@@</ComputerName>  
<ProductKey>@@ProductKey@@</ProductKey>  
        </component>  
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <RunSynchronous>  
                <RunSynchronousCommand wcm:action="add">  
                    <Order>1</Order>  
                    <Path>certutil -p &quot;!!123abc&quot; -importpfx  %SYSTEMDRIVE%\temp\RDPCert.pfx</Path>  
                    <WillReboot>OnRequest</WillReboot>  
                    <Description>Import certificate</Description>  
                </RunSynchronousCommand>  
                <RunSynchronousCommand wcm:action="add">  
                    <Description>If there is one, copy original setupcomplete.cmd to a unique file</Description>  
                    <Order>2</Order>  
                    <Path>cmd /C if exist {%WINDIR%\Setup\Scripts\SetupComplete.cmd} (copy %WINDIR%\Setup\Scripts\SetupComplete.cmd %WINDIR%\Setup\Scripts\SC3746EE82-EA9D-423E-B99F-510F9D7FF4F5.cmd /y)</Path>  
                </RunSynchronousCommand>  
                <RunSynchronousCommand wcm:action="add">  
                    <Order>3</Order>  
                    <Description>mkdir Scripts since Windows looks for SetupComplete.cmd in that dir. If the dir exists, it should be fine.</Description>  
                    <Path>cmd.exe /C mkdir %WINDIR%\Setup\Scripts</Path>  
                </RunSynchronousCommand>  
                <RunSynchronousCommand wcm:action="add">  
                    <Order>4</Order>  
                    <Description>Put certificate configuration command in SetupComplete.cmd</Description>  
                    <Path>cmd /C echo wmic /namespace:\\root\cimv2\TerminalServices PATH Win32_TSGeneralSetting Set SSLCertificateSHA1Hash=&quot;f5d17b3d2fe391480e7532764026d6129884862b&quot; &gt;&gt; %WINDIR%\Setup\Scripts\SetupComplete.cmd</Path>  
                </RunSynchronousCommand>  
                <RunSynchronousCommand wcm:action="add">  
                    <Order>5</Order>  
                    <Description>Put shutdown VM in SetupComplete.cmd</Description>  
                    <Path>cmd /C echo shutdown /s /f &gt;&gt; %WINDIR%\Setup\Scripts\SetupComplete.cmd</Path>  
                    <WillReboot>OnRequest</WillReboot>  
                </RunSynchronousCommand>  
            </RunSynchronous>  
        </component>  
<!--  For VM to Domain Join use this section. Please ensure VM can reach domain controller -->  
<!--  
        <component name="Microsoft-Windows-UnattendedJoin" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <Identification>  
                <Credentials>  
                    <Domain>fabrikam.com</Domain>  
                    <Username>Administrator</Username>  
                    <Password>ExampleAdminPassword1!</Password>  
                </Credentials>  
                <JoinDomain>tenantdomain.com</JoinDomain>  
            </Identification>  
        </component>  
-->  
        <component name="Microsoft-Windows-TerminalServices-LocalSessionManager" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <fDenyTSConnections>false</fDenyTSConnections>  
        </component>  
        <component name="Networking-MPSSVC-Svc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <FirewallGroups>  
                <FirewallGroup wcm:action="add" wcm:keyValue="RDGroup">  
                    <Active>true</Active>  
                    <Group>Remote Desktop</Group>  
                    <Profile>all</Profile>  
                </FirewallGroup>  
            </FirewallGroups>  
        </component>  
        <component name="Microsoft-Windows-TerminalServices-RDP-WinStationExtensions" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <UserAuthentication>0</UserAuthentication>  
        </component>  
    </settings>  
    <settings pass="oobeSystem">  
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <OOBE>  
                <HideEULAPage>true</HideEULAPage>  
                <SkipUserOOBE>true</SkipUserOOBE>  
            </OOBE>  
            <UserAccounts>  
                <AdministratorPassword>  
                    <Value>ExampleAdminPassword1!</Value>  
                    <PlainText>true</PlainText>  
                </AdministratorPassword>  
            </UserAccounts>  
            <TimeZone>@@TimeZone@@</TimeZone>  
        </component>  
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
            <UserLocale>en-US</UserLocale>  
            <SystemLocale>en-US</SystemLocale>  
            <UILanguage>en-US</UILanguage>  
            <InputLocale>0409:00000409</InputLocale>  
        </component>  
    </settings>  
</unattend>  
```  
***  
#### 8.3.3  Get the volume signature catalog file    
Tenants use VMM to extract the volume signature catalog (.VSC) file, which describes the template that the .PDK file can be applied to. You can use the following procedure to get the .VSC file.  
  
1.  Using a remote VMM administrator console, open a PowerShell window. Review the following example information, modify it as needed, and then run the following commands:    
  ```$disk = Get-SCVirtualHardDisk -Name "ThresholdTP3.vhdx"```    
  
  ```$vsc = Get-SCVolumeSignatureCatalog -VirtualHardDisk $disk```    
  
  ```$vsc.WriteToFile("c:\\Disk1.VSC")```  
  
***  
#### 8.3.4  Get the Host Guardian Service metadata and import it using cmdlets    
Tenants download the Host Guardian Service metadata information, in XML form, and then import the metadata. The metadata contains the pubic portion of the encryption certificate and signature used by the Host Guardian Service. You must have already a VMM tenant administrator user role and connect to VMM remotely using the VMM Administrator console in order to perform the following procedure.  
  
Use the following procedure on a tenant computer to get the metadata file and import the Host Guardian Service certificate from it. Review the following example information and modify it as needed.  
  
##### 8.3.4.1  Create a new owner certificate    
1.  If you don’t already have one, create a New Owner certificate to use for Shielding VM. You can execute Get-HgsGuardian to see list of guardians on the machine, and if you already have “owner,” you can continue to the next step, Import guardian.  
  
  ```New-HgsGuardian -Name Owner –GenerateCertificates```  
  
##### 8.3.4.2  Import guardian    
1.  Open a web browser on the tenant machine, browse to the KPS metadata URL, and then save the file as "C:\\metadata.xml"  
  
  [http://Relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml](http://Relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml)  
  
  **If tenants don’t have access to the HGS server, you can also download the metadata file and transfer it offline to clients.**  
  
1.  On a tenant computer with a copy of the downloaded metadata from Step 1, run the following command in a PowerShell window. Note that if you have previously imported this guardian, you may skip this command and continue to the next section, “Create a shielding data file for shielded templates.”  
  
  ```Import-HgsGuardian –Path c:\\metadata.xml -Name Guardian –AllowUntrustedRoot```  
  
#### 8.3.5  Create a shielding data file for shielded templates  
  
Tenants can use the Shielding Data File wizard to create a PDK file. The PDK file is used for shielded VM creation. The file is a protected data file that only the guardian’s owner can access, and it contains the tenant’s secret information.    
1.  Run **C:\\Windows\\System32\\ShieldingDataFileWizard.exe** to start the Shielding Data File Wizard.    
2.  On the **File Selection** tab, select **Create a new shielding data file**, browse to the location where you want to save the PDK file that you’re creating, type the file name to create. Select **Shielding Data for Shielded Templates** &gt; **Next**.  
  
  For example, type **C:\\Tenant.pdk**.  
  
1.  On the **Owner and Guardians** page, select the owner of the PDK file, then select the Guardian name &gt; **Next**. Note that:    
    1.  You can select multiple guardians.    
    2.  The owner would typically be the tenant owner of the VM.    
    3.  The Guardian name is the friendly name of the Host Guardian Service identified in the metadata that you imported.    
2.  On the Volume ID Qualifiers page, click **Add** to open the **Add Volume ID Qualifier** dialog box.  
  
3.  In the Add Volume ID Qualifier dialog box, click **Browse** to locate the .VSC file that you created previously. Open it, and then click **OK**.    
  1.  Download from VMM, described in Get the Volume Signature Catalog File.    
  2.  You can change the **Version rule**, as needed.    
1.  On the **Specialization Values** pages, **Browse** for or type the path and file name of the Unattend.XML file that you created previously, and then click **Next**.  
  
  You can also click **Add** under **Other files** to securely send them to the shielded VM when it is created. For example, you might want to send an RDP certificate. If you used the sample Unattend.XML file, then you would add RDPCert.pfx.  
  
1.  On the **Review Settings** page, review the settings, and then click **Generate**.  
  
2.  On the **Shielding Data File Generation** page, progress is displayed.  
  
3.  On the **Summary** page, information about the PDK file that you created is shown. Click **Close** to exit the wizard.  
  
Tenants can now instantiate a shielded VM from a signed disk template using the virtual machine shielding information.  
  
### 8.4  Create a shielded VM using VMM    
1.  In the VMM Administration console, select the template, and then click **Create Virtual Machine** to start the Create Virtual Machine Wizard to create a new virtual machine from a shielded VM template.    
2.  In the wizard, you select the appropriate shielding data file (.PDK). You’ll make other choices for the new virtual machine just as you would a regular unshielded virtual machine, such as configuring the hardware, operating system, destination, cloud, settings, and properties.    
  
  VMM instantiates a new virtual machine from the template using information from the PDK file.  
  
  After the virtual machine is created on the Hyper-V Host, the following actions occur automatically:  
  
  1.  The source disk template (VHDX) file is copied from the VMM library.    
  2.  The VM provisioning service decrypts data in the .PDK file, creates a merged unattend.xml file and copies additional files (for example, RDPCert.pfx) inside the .PDK file to the boot volume of the VM.    
  3.  The VM restarts and enters the Sysprep process and becomes BitLocker encrypted.    
  4.  When the VM customization completes, the new virtual machine shuts down. About 10 minutes elapse for the steps above.    
  5.  In the VMM Administrator console, you’ll see that the Create VM task completed and the VM is turned off.  
