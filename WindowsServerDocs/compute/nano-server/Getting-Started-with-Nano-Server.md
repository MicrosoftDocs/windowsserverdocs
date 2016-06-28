---
title: Getting Started with Nano Server
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: 
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c2be4bbf-5022-4bd7-aabb-dbe58fb1f7bb
author: jaimeo
---
# Getting Started with Nano Server

>Applies To: Windows Server Technical Preview

Windows Server® 2016 Technical Preview offers a new installation option: Nano Server. Nano Server is a remotely administered server operating system optimized for private clouds and datacenters. It is similar to Windows Server in Server Core mode, but significantly smaller, has no local logon capability, and only supports 64-bit applications, tools, and agents. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than Windows Server. When it does restart, it restarts much faster. The Nano Server installation option is available for Standard and Datacenter editions of Windows Server 2016.  
  
Nano Server is ideal for a number of scenarios:  
  
-   As a “compute” host for Hyper-V virtual machines, either in clusters or not  
  
-   As a storage host for Scale-Out File Server.  
  
-   As a DNS server  
  
-   As a web server running Internet Information Services (IIS)  
  
-   As a host for applications that are developed using cloud application patterns and run in a container or virtual machine guest operating system  
  
This guide describes how to configure a Nano Server image with the packages you’ll need, add additional device drivers, and deploy it with an Unattend.xml file. It also explains the options for managing Nano Server remotely, managing the Hyper-V role running on Nano Server, and setup and management of a failover cluster of computers that are running Nano Server.  
  
> [!NOTE]  
> This comprehensive guide covers a wide variety of options for working with Nano Server; you don't need to complete all sections. To just get up and running quickly with a basic deployment, use the **Nano Server Quick Start** section.  
  
## <a name="BKMK_QuickStart"></a>Nano Server Quick Start  
Follow the steps in this section to get started quickly with a basic deployment of Nano Server using DHCP to obtain an IP address. The sections that come after go into more detail about further customizing the image for your specific needs, as well as remotely managing Nano Server. You can run a Nano Server VHD either in a virtual machine or boot to it on a physical computer; the steps are slightly different.  
  
**Nano Server in a virtual machine**  
  
Follow these steps to create a Nano Server VHD that will run in a virtual machine.  
  
#### To quickly deploy Nano Server in a virtual machine  
  
1.  Copy *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server Technical Preview ISO to a folder on your hard drive.  
  
2.  Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`  
>[!NOTE]  
>You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
3.  Create a VHD for the Standard edition that sets a computer name and includes the Hyper-V **guest drivers** by running the following command which will prompt you for an administrator password for the new VHD:  
  
    `New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerVM\NanoServerVM.vhd -ComputerName <computer name>` where  
  
    -   **-MediaPath <path to root of media\>** specifies a path to the root of the contents of the Technical Preview ISO. For example if you have copied the contents of the ISO to d:\TP5ISO you would use that path.  
  
    -   **-BasePath** (optional) specifies a folder that will be created to copy the Nano Server WIM and packages to.  
  
    -   **-TargetPath** specifies a path, including the filename and extension, where the resulting VHD or VHDX will be created.  
  
    -   **Computer_name** specifies the computer name that the Nano Server virtual machine you are creating will have.  
  
    **Example:** `New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1\Nano.vhd -ComputerName Nano1`  
  
    This example creates a VHD from an ISO mounted as f:\\. When creating the VHD it will use a folder called Base in the same directory where you ran New-NanoServerImage; it will place the VHD (called Nano.vhd) in a folder called Nano1 in the folder from where the command is run. The computer name will be Nano1. The resulting VHD will contain the Standard edition of Windows Server 2016 and will be suitable for Hyper-V virtual machine deployment. If you want a Generation 1 virtual machine, create a VHD image by specifying a  **.vhd** extension for -TargetPath. For a Generation 2 virtual machine, create a VHDX image by specifying a  **.vhdx** extension for -TargetPath. You can also directly generate a WIM file by specifying a **.wim** extension for -TargetPath.  
  
    > [!NOTE]  
    > New-NanoServerImage is supported on Windows 8.1, Windows 10, Windows Server 2012 R2, and Windows Server 2016 Threshold Preview.  
  
4.  In Hyper-V Manager, create a new virtual machine and use the VHD created in Step 3.  
  
5.  Boot the virtual machine and in Hyper-V Manager connect to the virtual machine.  
  
6.  Log on to the Recovery Console (see the "Nano Server Recovery Console" section in this guide), using the administrator and password you supplied while running the script in Step 3.  
  
7.  Obtain the IP address of the Nano Server virtual machine and use Windows PowerShell remoting or other remote management tool to connect to and remotely manage the virtual machine.  
  
**Nano Server on a physical computer**  
  
You can also create a VHD that will run Nano Server on a physical computer, using the pre-installed device drivers. If your hardware requires a driver that is not already provided in order to boot or connect to a network, follow the steps in the "Adding Additional Drivers" section of this guide.  
  
#### To quickly deploy Nano Server on a physical computer  
  
1.  Copy *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server Technical Preview ISO to a folder on your hard drive.  
  
2.  Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`  
  
>[!NOTE]  
>You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
3.  Create a VHD that sets a computer name and includes the OEM drivers and Hyper-V by running the following command which will prompt you for an administrator password for the new VHD:  
  
    `New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerPhysical\NanoServer.vhd -ComputerName <computer name> -OEMDrivers -Compute -Clustering` where  
  
    -   **-MediaPath <path to root of media\>** specifies a path to the root of the contents of the Technical Preview ISO. For example if you have copied the contents of the ISO to d:\TP5ISO you would use that path.  
  
    -   **BasePath** specifies a folder that will be created to copy the Nano Server WIM and packages to. (This parameter is optional.)  
  
    -   **TargetPath** specifies a path, including the filename and extension, where the resulting VHD or VHDX will be created.  
  
    -   **Computer_name** is the computer name for the Nano Server you are creating.  
  
    **Example:**`New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath F:\ -BasePath .\Base -TargetPath .\Nano1\NanoServer.vhd -ComputerName Nano-srv1 -OEMDrivers –Compute -Clustering`  
  
    This example creates a VHD from an ISO mounted as F:\\. When creating the VHD it will use a folder called Base in the same directory where you ran New-NanoServerImage; it will place the VHD in a folder called Nano1 in the folder from where the command is run. The computer name will be Nano-srv1 and will have OEM drivers installed for most common hardware and has the Hyper-V role and clustering feature enabled. The Standard Nano edition is used.  
  
4.  Log in as an administrator on the physical server where you want to run the Nano Server VHD.  
  
5.  Copy the VHD that this script creates to the physical computer and configure it to boot from this new VHD. To do that, follow these steps:  
  
    1.  Mount the generated VHD. In this example, it's mounted under D:\\.  
  
    2.  Run **bcdboot d:\windows**.  
  
    3.  Unmount the VHD.  
  
6.  Boot the physical computer into the Nano Server VHD.  
  
7.  Log on to the Recovery Console (see the "Nano Server Recovery Console" section in this guide), using the administrator and password you supplied while running the script in Step 3.  
  
8.  Obtain the IP address of the Nano Server computer and use Windows PowerShell remoting or other remote management tool to connect to and remotely manage the virtual machine.  
  
## <a name="BKMK_CreateImage"></a>Creating a custom Nano Server image  
For Windows Server 2016 Technical Preview, Nano Server is distributed on the physical media, where you will find a **NanoServer** folder; this contains a .wim image and a subfolder called **Packages**. It is these package files that you use to add server roles and features to the VHD image, which you then boot to.  
  
You can also find and install these packages with the the NanoServerPackage provider of PackageManagement (OneGet) PowerShell module. See the [Installing roles and features online](Getting-Started-with-Nano-Server.md#BKMK_online) section of this topic.  
  
This table shows the roles and features that are available in this release of Nano Server, along with the Windows PowerShell options that will install the packages for them. Some packages are installed directly with their own Windows PowerShell switches (such as -Compute); others you install by passing package names to the -Packages parameter, which you can combine in a comma-separated list. You can dynamically list available packages using Get-NanoServerPackage cmdlet.  
  
|Role or feature|Option|  
|-------------------|----------|  
|Hyper-V role (including NetQoS|-Compute|  
|Failover Clustering|-Clustering|  
|Basic drivers for a variety of network adapters and storage controllers. This is the same set of drivers included in a Server Core installation of Windows Server 2016 Technical Preview.|-OEMDrivers|  
|File Server role and other storage components|-Storage|  
|Windows Defender Antimalware, including a default signature file|-Defender|  
|Reverse forwarders for application compatibility, for example common application frameworks such as Ruby, Node.js, etc.|Now included by default  
|DNS Server role|-Packages Microsoft-NanoServer-DNS-Package|  
|Desired State Configuration (DSC)|-Packages Microsoft-NanoServer-DSC-Package **Note:** For full details, see [Using DSC on Nano Server](https://msdn.microsoft.com/powershell/dsc/nanoDsc) .|  
|Internet Information Server (IIS)|-Packages Microsoft-NanoServer-IIS-Package **Note:** See the IIS on Nano Server sub-topic for details about working with IIS.|  
|Host support for Windows Containers|-Containers|  
|System Center Virtual Machine Manager agent|   -Packages Microsoft-NanoServer-SCVMM-Package<br />   -Packages Microsoft-NanoServer-SCVMM-Compute-Package <br>**Note:**     Use the SCVMM Compute package only if you are monitoring Hyper-V.|  
|Network Performance Diagnostics Service (NPDS) (**Note:** Requires Windows Defender Anti-Malware package, which you should install before installing NPDS)|-Packages Microsoft-NanoServer-NPDS-Package |  
|Data Center Bridging (including DCBQoS|-Packages Microsoft-NanoServer-DCB-Package|  
|Ability to boot and run from a RAM disk|Microsoft-NanoServer-BootFromWim-Package|  
|Deploying on a virtual machine|Microsoft-NanoServer-Guest-Package|  
|Deploying on a physical machine|Microsoft-NanoServer-Host-Package|  
|Secure Startup|-Packages Microsoft-NanoServer-SecureStartup-Package|  
|Shielded VM|-Packages Microsoft-NanoServer-ShieldedVM-Package **Note:** This package is only available for the Datacenter edition of Nano Server.|  
  
> [!NOTE]  
> When you install packages with these options, a corresponding language pack is also installed based on selected server media locale. You can find the available language packs and their locale abbreviations in the installation media in subfolders named for the locale of the image.  
  
> [!NOTE]  
> When you use the -Storage parameter to install File Services, File Services is not actually enabled. Enable this feature from a remote computer with Server Manager.  
  
  
  
### Installing a Nano Server VHD  
This example creates a GPT-based VHDX image with a given computer name and including Hyper-V guest drivers, starting with Nano Server installation media on a network share. In an elevated Windows PowerShell prompt, start with this cmdlet:  
  
`Import-Module <Server media location>\NanoServer\NanoServerImageGenerator; New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\server_en-us -BasePath .\Base -TargetPath .\FirstStepsNano.vhdx -ComputerName FirstStepsNano`  
  
The cmdlet will accomplish all of these tasks:  
  
1.  Select Standard as a base edition  
  
2.  Prompt you for the Administrator password  
  
3.  Copy installation media from \\\Path\To\Media\server_en-us into .\Base  
  
4.  Convert the WIM image to a VHD. (The file extension of the target path argument determines whether it creates an MBR-based VHD for Generation 1 virtual machines versus a GPT-based VHDX for Generation 2 virtual machines.)  
  
5.  Copy the resulting VHD into .\FirstStepsNano.vhdx  
  
6.  Set the Administrator password for the image as specified  
  
7.  Set the computer name of the image to FirstStepsNano  
  
8.  Install the Hyper-V guest drivers  
  
All of this results in an image of .\FirstStepsNano.vhdx.  
  
The cmdlet generates a log as it runs and will let you know where this log is located once it is finished. The WIM-to-VHD conversion accomplished by the companion script generates its own log in %TEMP%\Convert-WindowsImage\\\<GUID> (where \<GUID> is a unique identifier per conversion session).  
  
As long as you use the same base path, you can omit the media path parameter every time you run this cmdlet, since it will use cached files from the base path. If you don't specify a base path, the cmdlet will generate a default one in the TEMP folder. If you want to use different source media, but the same base path, you should specify the media path parameter, however.  
  
>[!NOTE]  
>You now have the option to specify the Nano Server edition to build either the Standard or Datacenter edition. Use the -Edition parameter to specify *Standard* or *Datacenter* editions.  
  
Once you have an existing image, you can modify it as needed using the *Edit-NanoServerImage* cmdlet.  
  
If you do not specify a computer name, a random name will be generated.  
  
### Installing a Nano Server WIM  
  
1.  Copy the *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server Technical Preview ISO a local folder on your computer.  
2. Start Windows PowerShell as an administrator, change directory to the folder where you placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`.  
  
 >[!NOTE]  
>You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
To create a Nano Server image to serve as a Hyper-V host, run the following:  
  
`New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerPhysical\NanoServer.wim -ComputerName <computer name> -OEMDrivers -Compute -Clustering`  
  
Where  
-   -MediaPath is the root of the DVD media or ISO image containing Windows Server Technical Preview .  
-   -BasePath will contain a copy of the Nano Server binaries, so you can use New-NanoServerWim –BasePath without having to specify –MediaPath in future runs.  
-   -TargetPath will contain the resulting .wim file containing the roles & features you selected. Make sure to specify the .wim extension.  
-   -Compute adds the Hyper-V role.  
-   -OemDrivers adds a number of common drivers.  
  
You will be prompted to enter an administrator password.  
  
For more information, run `Get-Help New-NanoServerWim -Full`.  
   
Boot into WinPE and ensure that the .wim file just created is accessible from WinPE. (You could, for example, copy the .wim file to a bootable WinPE image on a USB flash drive.)  
  
Once WinPE boots, use Diskpart.exe to prepare the target computer's hard drive. Run the following Diskpart commands (modify accordingly, if you’re not using UEFI & GPT):  
   
> [!WARNING]  
> These commands will delete all data on the hard drive.  
  
**Diskpart.exe  
Select disk 0  
Clean  
Convert GPT  
Create partition efi size=100  
Format quick FS=FAT32 label="System"  
Assign letter="s"  
Create partition msr size=128  
Create partition primary  
Format quick FS=NTFS label="NanoServer"  
Assign letter="n"  
List volume  
Exit**  
   
Apply the Nano Server image (adjust the path of the .wim file):  
  
**Dism.exe /apply-imagmediafile:.\NanoServer.wim /index:1 /applydir:n:\   
Bcdboot.exe n:\Windows /s s:**  
   
Remove the DVD media or USB drive and reboot your system with **Wpeutil.exe reboot**  
  
  
 ### Editing files on Nano Server locally and remotely  
 In either case, connect to Nano Server, such as with Windows PowerShell remoting.  
   
 Once you've connected to Nano Server, you can edit a file residing on your local computer by passing the file's relative or absolute path to the psEdit command, for example:   
`psEdit C:\Windows\Logs\DISM\dism.log` or `psEdit .\myScript.ps1`  
  
Edit a file residing on the remote Nano Server by starting a remote session with `Enter-PSSession –ComputerName "192.168.0.100" -Credential ~\Administrator` and then passing the file’s relative or absolute path to the psEdit command like this:   
`psEdit C:\Windows\Logs\DISM\dism.log`  
  
## <a name="BKMK_online"></a>Installing roles and features online  
  
### Installing roles and features from a package repository  
You can find and install Windows Packages from the online package repository by using the NanoServerPackage provider of PackageManagement (OneGet) PowerShell module. To install this provider, use these cmdlets:  
 `Install-PackageProvider NanoServerPackage`  
 `Import-PackageProvider NanoServerPackage`  
   
Once this provider is installed and imported, you can search for, download, or install Windows Packages using PowerShell cmdlets. Cmdlets specifically for working with Windows Packages are:  
  
`Find-NanoServerPackage`  
`Save-NanoServerPackage`  
`Install-NanoServerPackage`  
  
The generic PackageManagement cmdlets are:  
  
`Find-Package`  
`Save-Package`  
`Install-Package`  
`Get-Package`  
  
To use any of these cmdlets with Windows packages on Nano Server, add `–provider NanoServerPackage`. If you don't add the –provider parameter, PackageManagement will iterate all of the providers. For a complete details for the cmdlets, use `get-help <cmdlet>`, but here are some examples of common usages:  
    
### Searching for Windows packages  
You can use either `Find-NanoServerPackage` or `Find-Package` to search for and return a list of Windows Packages that are available in the online repository. For example, you can get a list of all the latest packages with  
`Find-NanoServerPackage`.  
  
Using `Find-Package –provider NanoServerPackage -displayCulture` displays all cultures available.  
      
If you need a specific locale version, such as US English, you could use `Find-NanoServerPackage -Culture en-us` or  
`Find-Package –provider NanoServerPackage –Culture en-us` or `Find-Package –Culture en-us -displayCulture`.  
  
To find a specific package by package name, use the –name parameter, which accepts wildcards. For example, to find all packages with NPDS in the name, use `Find-NanoServerPackage -Name *NPDS*` or `Find-Package –provider NanoServerPackage -Name *NPDS*`.  
     
You can find a particular version with –RequiredVersion, -MinimumVersion, or –MaximumVersion parameters. To find all available versions, use –AllVersions. Otherwise, only the latest version is returned. Example: `Find-NanoServerPackage –AllVersions -Name *NPDS* -RequiredVersion 10.0.14300.1000`. Or, for all versions: `Find-Package –provider NanoServerPackage –AllVersions -Name *NPDS*`  
  
### Installing Windows Packages  
You can install a Windows package to Nano Server either locally or an offline image with either `Install-NanoServerPackage` or `Install-Package`. Both of these accept pipeline results from search cmdlets.  
  
> [!NOTE]  
> Some Windows Packages have dependencies to other Windows Packages, so if you don't install them in the correct order, the installation will fail.  
  
To install the latest version of a Windows Package to an online Nano Server, use either `Install-NanoServerPackage -Name Microsoft-NanoServer-Containers-Package` or `Install-Package -Name Microsoft-NanoServer-Containers-Package`. PackageManagement will use the culture of the Nano Server.  
      
You can install a Windows Package to an offline image, specifying a particular version and culture, like this:  
  
 `Install-NanoServerPackage -Name Microsoft-NanoServer-DCB-Package -culture de-de -RequiredVersion 10.0.14300.1000 –ToVHd c:\MyNanoVhd.vhd`  
 or:  
`Install-Package -Name Microsoft-NanoServer-DCB-Package -culture de-de -RequiredVersion 10.0.14300.1000 –ToVHd c:\MyNanoVhd.vhd`  
  
Here are some examples of pipelining package search results to the installation cmdlet:  
  
`Find-NanoServerPackage *dcb* | Install-NanoServerPackage` finds any package with "dcb" in the name and then installs them.  
  
`Find-Package *nanoserver-compute-* | Install-Package` finds packages with "nanoserver-computer-" in the name and installs them.  
  
`Find-NanoServerPackage -Name *compute* |Install-NanoServerPackage -ToVhd c:\MyNanoVhd.vhd` finds packages with "compute" in the name and installs them to an offline image.  
  
`Find-Package -provider NanoserverPackage *nanoserver-compute-* | Install-Package -ToVhd c:\MyNanoVhd.vhd` does the same thing with any package that has "nanoserver-compute-" in the name.  
  
### Download Windows Packages  
  
`Save-NanoServerPackage` or `Save-Package` allow you download packages and save them without installing them. Both cmdlets accept pipeline results from the search cmdlets.  
  
For example, to download and save a Windows Package to a directory that matches the wildcard path, use `Save-NanoServerPackage -Name Microsoft-NanoServer-NPDS-Package -Path C:\t*p\`  
In this example, –Culture wasn't specified, so the culture of the local machine will be used. No version was specified, so the latest version will be saved.  
  
`Save-Package –provider NanoServerPackage -Name Microsoft-NanoServer-IIS-Package -Path .\temp -culture it-it -MinimumVersion 10.0.14300.1000` saves a particular version and for the Italian language and locale.  
  
You can pipeline search results as in these examples:  
`Find-NanoServerPackage -Name *containers* -MaximumVersion 10.2 -MinimumVersion 1.0 -Culture es-es | Save-NanoServerPackage -Path c:\`  
  
or  
  
`Find-Package -provider nanoserverPackage -Name *shield* -Culture es-es | Save-Package -Path`  
  
### Inventory installed packages  
You can discover which Window Packages are installed with `PackageManagement Get-Package`. For example, see which packages are on Nano Server with `Get-Package -provider NanoserverPackage`.   
  
To check the Windows Packages that are installed in an offline image, use, for example, `Get-Package -provider NanoserverPackage -fromVhd c:\MyNanoVhd.vhd`.  
  
  
### Installing roles and features from local source  
Though offline installation of server roles and other packages is recommended, you might need to install them online (with the Nano Server running) in container scenarios. To do this, follow these steps:  
  
1.  Copy the Packages folder from the installation media locally to the running Nano Server (for example, to C:\packages).  
  
2.  Create a new Unattend.xml file on another computer and then copy it to Nano Server. You can copy and paste this XML content into the XML file you created (this example shows installing the IIS package):  
  
   
     
```  
 <?xml version="1.0" encoding="utf-8"?>  
    <unattend xmlns="urn:schemas-microsoft-com:unattend">  
    <servicing>  
        <package action="install">  
            <assemblyIdentity name="Microsoft-NanoServer-IIS-Feature-Package" version="10.0.14300.1000" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" />  
            <source location="c:\packages\Microsoft-NanoServer-IIS-Package.cab" />  
        </package>  
        <package action="install">  
            <assemblyIdentity name="Microsoft-NanoServer-IIS-Feature-Package" version="10.0.14300.1000" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="en-US" />  
            <source location="c:\packages\en-us\Microsoft-NanoServer-IIS-Package_en-us.cab" />  
        </package>  
    </servicing>  
    <cpi:offlineImage cpi:source="" xmlns:cpi="urn:schemas-microsoft-com:cpi" />  
</unattend>  
```  
  
  
  
  
3.  In the new XML file you created (or copied), edit C:\packages to the directory you copied the content of Packages to.  
  
4.  Switch to the directory with the newly created XML file and run  
  
    **dism /online /apply-unattend:.\unattend.xml**  
  
     
  
5.  Confirm that the package and its associated language pack is installed correctly by running:  
  
    **dism /online /get-packages**  
  
    You should see "Package Identity : Microsoft-NanoServer-IIS-Package~31bf3856ad364e35~amd64~en-US~10.0.10586.0" listed twice, once for Release Type : Language Pack and once for Release Type : Feature Pack.  
  
## Additional tasks you can accomplish with New-NanoServerImage and Edit-NanoServerImage  
  
### Joining domains  
New-NanoServerImage offers two methods of joining a domain; both rely on offline domain provisioning, but one harvests a blob to accomplish the join. In this example, the cmdlet harvests a domain blob for the Contoso domain from the local computer (which of course must be part of the Contoso domain), then it performs offline provisioning of the image using the blob:  
  
`New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\JoinDomHarvest.vhdx -ComputerName JoinDomHarvest -DomainName Contoso`  
  
When this cmdlet completes, you should find a computer named "JoinDomHarvest" in the Active Directory computer list.  
  
You can also use this cmdlet on a computer that is not joined to a domain. To do this, harvest a blob from any computer that is joined to the domain, and then provide the blob to the cmdlet yourself. Note that when you harvest such a blob from another computer, the blob already includes that computer's name--so if you try to add the *-ComputerName* parameter, an error will result.  
  
You can harvest the blob with this command:  
  
**djoin**  
 **/Provision**  
 **/Domain Contoso**  
 **/Machine JoiningDomainsNoHarvest**  
 **/SaveFile JoiningDomainsNoHarvest.djoin**  
  
Run New-NanoServerImage using the harvested blob:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\JoinDomNoHrvest.vhd -DomainBlobPath .\Path\To\Domain\Blob\JoinDomNoHrvestContoso.djoin`  
  
In the event that you already have a node in the domain with the same computer name as your future Nano Server, you could reuse the computer name by adding the `-ReuseDomainNode` parameter.  

### Adding additional drivers
Nano Server offers a package that includes a set of basic drivers for a variety of network adapters and storage controllers; it's possible that drivers for your network adapters might not be included. You can use these steps to find drivers in a working system, extract them, and then add them to the Nano Server image.

1.	Install Windows Server 2016 on the physical computer where you will run Nano Server.
2.	Open Device Manager and identify devices in the following categories:
* Network adapters
* Storage controllers
* Disk drives
3.	For each device in these categories, right-click the device name, and click **Properties**. In the dialog that opens, click the **Driver** tab, and then click **Driver Details**.
4.	Note the filename and path of the driver file that appears. For example, let’s say the driver file is e1i63x64.sys, which is in C:\Windows\System32\Drivers.
5.	In a command prompt, search for the driver file and search for all instances with dir e1i*.sys /s /b. In this example, the driver file is also present in the path C:\Windows\System32\DriverStore\FileRepository\net1ic64.inf_amd64_fafa7441408bbecd\e1i63x64.sys.
6.	In an elevated command prompt, navigate to the directory where the Nano Server VHD is and run the following commands:
     **md mountdir**
     
     **dism\dism /Mount-Image /ImageFile:.\NanoServer.vhd /Index:1 /MountDir:.\mountdir**
     
     **dism\dism /Add-Driver /image:.\mountdir /driver: C:\Windows\System32\DriverStore\FileRepository\net1ic64.inf_amd64_fafa7441408bbecd**
     
     **dism\dism /Unmount-Image /MountDir:.\MountDir /Commit**
7.	Repeat these steps for each driver file you need.

> [!NOTE]  
> In the folder where you keep your drivers, both the SYS files and corresponding INF files must be present. Also, Nano Server only supports signed, 64\-bit drivers. 
  
### Injecting drivers  
Nano Server offers a package that includes a set of basic drivers for a variety of network adapters and storage controllers; it's possible that drivers for your network adapters might not be included. You can use this syntax to have New-NanoServerImage search the directory for available drivers and inject them into the Nano Server image:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\InjectingDrivers.vhdx -DriversPath .\Extra\Drivers`  
  
> [!NOTE]  
> In the folder where you keep your drivers, both the SYS files and corresponding INF files must be present. Also, Nano Server only supports signed, 64-bit drivers.  
  
### Connecting with WinRM  
To be able to connect to a Nano Server computer using Windows Remote Management (WinRM) (from another computer that is not on the same subnet), open port 5985 for inbound TCP traffic on the Nano Server image. Use this cmdlet:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\ConnectingOverWinRM.vhd -EnableRemoteManagementPort`  
  
### Setting static IP addresses  
To configure a Nano Server image to use static IP addresses, first find the name or index of the interface you want to modify by using Get-NetAdapter, netsh, or the Nano Server Recovery Console. Use the -Ipv6Address, -Ipv6Dns, -Ipv4Address, -Ipv4SubnetMask, -Ipv4Gateway and -Ipv4Dns parameters to specify the configuration, as in this example:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\StaticIpv4.vhd -InterfaceNameOrIndex Ethernet -Ipv4Address 192.168.1.2 -Ipv4SubnetMask 255.255.255.0 -Ipv4Gateway 192.168.1.1 -Ipv4Dns 192.168.1.1`  
  
### Custom image size  
You can configure the Nano Server image to be a dynamically expanding VHD or VHDX with the -MaxSize parameter, as in this example:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\BigBoss.vhd -MaxSize 100GB`  
  
### Embedding custom data  
To embed your own script or binaries in the Nano Server image, use the -CopyFiles parameter (you can pass an array of files and directories to be copied):  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\BigBoss.vhd -CopyFiles .\tools`  
  
### Running custom commands after the first boot  
To run custom commands as part of setupcomplete.cmd, use the -SetupCompleteCommands parameter (you can pass an array of commands):  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -SetupCompleteCommands @("echo foo", "echo bar")`  
  
### Running Nano Server from a RAM disk  
You can run Nano Server in an environment with no physical disk by using a RAM disk. To generate media that can boot from a RAM disk, use the -RamdiskBoot parameter and pass the path to a WIM file as -TargetPath:  
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -RamdiskBoot`  
  
### Support for development scenarios  
If you want to develop and test on Nano Server, you can use the -Development parameter. This will enable installation of unsigned drivers, copy debugger binaries, open a port for debugging, enable test signing and enable installation of AppX packages without a developer license:  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -Development`  
  
### <a name="BKMK_Svcing"></a>Installation of servicing packages  
If you want install a servicing packages, use the -ServicingPackages parameter (you can pass an array of paths to .cab files):  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackages \\path\to\kb123456.cab`  
  
Often, a servicing package or hotfix is downloaded as a KB item which contains a .cab file. Follow these steps to extract the .cab file, which you can then install with the -ServicingPackages parameter:  
  
1.  Download the servicing package (from the associated Knowledge Base article or from [Microsoft Update Catalog](http://catalog.update.microsoft.com/v7/site/home.aspx). Save it to a local directory or network share, for example: C:\ServicingPackages  
2.  Create a folder in which you will save the extracted servicing package.  Example: c:\KB3157663_expanded  
3.  Open a Windows PowerShell console and use the `Expand` command specifying the path to the .msu file of the servicing package, including the `-f:*` parameter and the path where you want servicing package to be extracted to.  For example:  `Expand “C:\ServicingPackages\Windows10.0-KB3157663-x64.msu” –f:* “C:\KB3157663_expanded”`  
  
    The expanded files should look similar to this:  
C:>dir C:\KB3157663_expanded   
Volume in drive C is OS  
Volume Serial Number is B05B-CC3D  
   
      Directory of C:\KB3157663_expanded  
   
      04/19/2016  01:17 PM    \<DIR>          .  
      04/19/2016  01:17 PM    \<DIR>          ..  
        04/17/2016  12:31 AM               517 Windows10.0-KB3157663-x64-pkgProperties.txt  
04/17/2016  12:30 AM        93,886,347 Windows10.0-KB3157663-x64.cab  
04/17/2016  12:31 AM               454 Windows10.0-KB3157663-x64.xml  
04/17/2016  12:36 AM           185,818 WSUSSCAN.cab  
               4 File(s)     94,073,136 bytes  
               2 Dir(s)  328,559,427,584 bytes free  
4.  Run `New-NanoServerImage` with the –ServicingPackages parameter pointing to the .cab file in this directory, for example: `New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackages C:\KB3157663_expanded\Windows10.0-KB3157663-x64.cab`  
  
  
### Custom unattend file  
If you want to use your own unattend file, use the -UnattendPath parameter:  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -UnattendPath \\path\to\unattend.xml`  
  
Specifying an administrator password or computer name in this unattend file will override the values set by -AdministratorPassword and -ComputerName.  
  
  
--------------------------------------------------  
  
  
## <a name="BKMK_JoinDomain"></a>Joining Nano Server to a domain  
  
#### To add Nano Server to a domain online  
  
1.  Harvest a data blob from a computer in the domain that is already running Windows Threshold Server using this command:  
  
    **djoin.exe /provision /domain <domain-name> /machine <machine-name> /savefile .\odjblob**  
  
    This saves the data blob in a file called “odjblob”.  
  
2.  Copy the “odjblob” file to the Nano Server computer with these commands:  
  
    **net use z: \\\\\<ip address of Nano Server>\c$**  
  
    > [!NOTE]  
    > If the net use command fails, you probably need to adjust Windows Firewall rules. To do this, first open an elevated command prompt, start Windows PowerShell and then connect to the Nano Server computer with Windows PowerShell Remoting with these commands:  
    >   
    > `Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
    >   
    > `$ip = "<ip address of Nano Server>"`  
    >   
    > `Enter-PSSession -ComputerName $ip -Credential $ip\Administrator`  
    >   
    > When prompted, provide the Administrator password, then run this command to set the firewall rule:  
    >   
    > **netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes**  
    >   
    > Exit Windows PowerShell with `Exit-PSSession`, and then retry the net use command. If successful, continue copying the “odjblob” file contents to the Nano Server.  
  
    **md z:\Temp**  
  
    **copy odjblob z:\Temp**  
  
3.  Check the domain you want to join Nano Server to and ensure that DNS is configured. Also, verify that name resolution of the domain or a domain controller works as expected. To do this, open an elevated command prompt, start Windows PowerShell and then connect to the Nano Server computer with Windows PowerShell remoting with these commands:  
  
    `Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
  
    `$ip = "<ip address of Nano Server>"`  
  
    `Enter-PSSession -ComputerName $ip -Credential $ip\Administrator`  
  
    When prompted, provide the Administrator password. Nslookup is not available on Nano Server, so you can verify name resolution with Resolve-DNSName.

4. If name resolution succeeds, then in the same Windows PowerShell session, run this command to join the domain:  
  
    `djoin /requestodj /loadfile c:\Temp\odjblob /windowspath c:\windows /localos`  
  
5.  Restart the Nano Server computer, and then exit the Windows PowerShell session:  
  
    `shutdown /r /t 5`  
  
    `Exit-PSSession`  
  
6.  After you have joined Nano Server to a domain, add the domain user account to the Administrators group on the Nano Server.

7. For security, remove the Nano Server from the trusted hosts list with this command:
`Set-Item WSMan:\localhost\client\TrustedHosts ""` 
  
**Alternate method to join a domain in one step**  
  
First, harvest the data blob from another computer running Windows Threshold Server that is already in your domain using this command:  
  
**djoin.exe /provision /domain <domain-name> /machine <machine-name> /savefile .\odjblob**  
  
Open the file “odjblob” (perhaps in Notepad), copy its contents, and then paste the contents into the \<AccountData> section of the Unattend.xml file below.  
  
Put this Unattend.xml file into the C:\NanoServer folder, and then use the following commands to mount the VHD and apply the settings in the `offlineServicing` section:  
  
**dism\dism /Mount-ImagemediaFile:.\NanoServer.vhd /Index:1 /MountDir:.\mountdir**  
  
**dism\dismmedia:.\mountdir /Apply-Unattend:.\unattend.xml**  
  
Create a “Panther” folder (used by Windows systems for storing files during setup; see [Windows 7, Windows Server 2008 R2, and Windows Vista setup log file locations](http://support.microsoft.com/en-us/kb/927521) if you’re curious), copy the Unattend.xml file to it, and then unmount the VHD with these commands:  
  
**md .\mountdir\windows\panther**  
  
**copy .\unattend.xml .\mountdir\windows\panther**  
  
**dism\dism /Unmount-Image /MountDir:.\mountdir /Commit**  
  
The first time you boot Nano Server from this VHD, the other settings will be applied.  
  
After you have joined Nano Server to a domain, add the domain user account to the Administrators group on the Nano Server.  
  
## <a name="BKMK_RecoveryConsole"></a>Using the Nano Server Recovery Console  
Starting with Windows Server 2016 Technical Preview, Nano Server includes an Recovery Console that ensures you can access your Nano Server even if a network mis-configuration interferes with connecting to the Nano Server. You can use the Recovery Console to fix the network and then use your usual remote management tools.  
  
When you boot Nano Server in either a virtual machine or on a physical computer that has a monitor and keyboard attached, you'll see a full-screen, text-mode logon prompt. Log into this prompt with an administrator account to see the computer name and IP address of the Nano Server. You can use these commands to navigate in this console:  
  
-   Use arrow keys to scroll  
  
-   Use TAB to move to any text that starts with **>**; then press ENTER to select.  
  
-   To go back one screen or page, press ESC. If you're on the home page, pressing ESC will log you off.  
  
-   Some screens have additional capabilities displayed on the last line of the screen. For example, if you explore a network adapter, F4 will disable the network adapter.  
  
In Windows Server 2016 Technical Preview, the Recovery Console allows you to view and configure network adapters and TCP/IP settings, as well as firewall rules.  
  
## <a name="BKMK_ManageRemote"></a>Managing Nano Server remotely  
Nano Server is managed remotely. There is no local logon capability at all, nor does it support Terminal Services. However, you have a wide variety of options for managing Nano Server remotely, including Windows PowerShell, Windows Management Instrumentation (WMI), Windows Remote Management, and Emergency Management Services (EMS).  
  
To use any remote management tool, you will probably need to know the IP address of the Nano Server. Some ways to find out the IP address include:  
  
-   Use the Nano Recovery Console (see the Using the Nano Server Recovery Console section of this topic for details).  
  
-   Connect a serial cable to the computer and use EMS.  
  
-   Using the computer name you assigned to the Nano Server while configuring it, you can get the IP address with ping. For example, `ping NanoServer-PC /4`.  
  
### Using Windows PowerShell remoting  
To manage Nano Server with Windows PowerShell remoting, you need to add the IP address of the Nano Server to your management computer’s list of trusted hosts, add the account you are using to the Nano Server’s administrators, and enable CredSSP if you plan to use that feature.  

 >[!NOTE]  
    > If the target Nano Server and your management computer are in the same AD DS forest (or in forests with a trust relationship), you should not add the Nano Server to the trusted hosts list--you can connect to the Nano Server by using its fully qualified domain name, for example:
    PS C:\> Enter-PSSession -ComputerName nanoserver.contoso.com -Credential (Get-Credential)
  
  
To add the Nano Server to the list of trusted hosts, run this command at an elevated Windows PowerShell prompt:  
  
`Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
  
To start the remote Windows PowerShell session, start an elevated local Windows PowerShell session, and then run these commands:  
  
  
```  
$ip = “\<IP address of Nano Server>”  
$user = “$ip\Administrator”  
Enter-PSSession -ComputerName $ip -Credential $user  
```  
  
  
You can now run Windows PowerShell commands on the Nano Server as normal.  
  
> [!NOTE]  
> Not all Windows PowerShell commands are available in this release of Nano Server. To see which are available, run `Get-Command -CommandType Cmdlet`  
  
Stop the remote session with the command `Exit-PSSession`  
  
### Using Windows PowerShell CIM sessions over WinRM  
You can use CIM sessions and instances in Windows PowerShell to run WMI commands over Windows Remote Management (WinRM).  
  
Start the CIM session by running these commands in a Windows PowerShell prompt:  
  
  
```  
$ip = “<IP address of the Nano Server\>”  
$ip\Administrator  
$cim = New-CimSession –Credential $user –ComputerName $ip  
```  
  
  
With the session established, you can run various WMI commands, for example:  
  
  
```  
Get-CimInstance –CimSession $cim –ClassName Win32_ComputerSystem | Format-List *  
Get-CimInstance -CimSession $Cim -Query "SELECT * from Win32_Process WHERE name LIKE 'p%'"  
```  
  
  
### Windows Remote Management  
You can run programs remotely on the Nano Server with Windows Remote Management (WinRM). To use WinRM, first configure the service and set the code page with these commands at an elevated command prompt:  
  
**winrm quickconfig**  
  
**winrm set winrm/config/client @{TrustedHosts="<ip address of Nano Server"}**  
  
**chcp 65001**  
  
Now you can run commands remotely on the Nano Server. For example:  
  
**winrs –r:\<IP address of Nano Server> -u:Administrator -p:\<Nano Server administrator password> ipconfig**  
  
For more information about Windows Remote Management, see [Windows Remote Management (WinRM) Overview](https://technet.microsoft.com/library/dn265971.aspx).  
   
   
  
  ### Running a network trace on Nano Server  
 Netsh trace, Tracelog.exe, and Logman.exe are not available in Nano Server. To capture network packets, you can use these Windows PowerShell cmdlets:  
   
   
```  
New-NetEventSession [-Name]  
Add-NetEventPacketCaptureProvider -SessionName  
Start-NetEventSession [-Name]  
Stop-NetEventSession [-Name]  
```  
These cmdlets are documented in detail at [Network Event Packet Capture Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn268520(v=wps.630).aspx)  
  
### Accessing a Distributed File System (DFS) host from a Nano Server  
You can access files on a DFS host computer that is running Windows 10 or Windows Server 2016 Preview. To do this, you'll have to do some configuration on both the Nano Server and the host computer.  
  
First, on the Nano Server, do the following:  
1. Join the Nano Server to the same domain as the DFS host (see the "Joining Nano Server to a domain" section of this topic).  
2. Set up PowerShell remoting for the Nano Server (see "Using Windows PowerShell remoting" in this topic).  
3. Start the remote Windows PowerShell session by opening an elevated local Windows PowerShell session, and then running these commands:  
  
```  
$ip = “\<IP address of Nano Server>”  
$user = “$ip\Administrator”  
Enter-PSSession -ComputerName $ip -Credential $user  
```  
4. Enable CredSSP with these cmdlets:  
  
```  
Enable-WSManCredSSP -Role Server  
Net localgroup administrators <domain\user> /add  
```  
Now, on the DFS host, complete these steps:  
1. In a local, elevated Windows PowerShell session, run these cmdlets (make sure to use the Nano Server *name*, not its IP address):  
  
```  
Enable-WSManCredSSP –Role Client –DelegateComputer <client Nano Server name>  
$s1=new-pssession -ComputerName <client Nano Server name>  -authentication CredSSP -Credential <domain\user>   
```  
Connect to the Nano Server again with PowerShell remoting using the new session:  
  
```  
enter-psSession $s1   
New-PSDrive –Name <drive label> –PSProvider FileSystem –Root <\\DFShost\share>  
```  
   
   
  
  
  
## <a name="BKMK_HyperV"></a>Using Hyper-V on Nano Server  
Hyper-V works the same on Nano Server as it does on Windows Server in Server Core mode, with two exceptions:  
  
-   You must perform all management remotely and the management computer must be running the same build of Windows Server as the Nano Server. Older versions of Hyper-V Manager or Hyper-V Windows PowerShell cmdlets will not work.  
  
-   RemoteFX is not available.  
  
In this release, these features of Hyper-V have been verified:  
  
-   Enabling Hyper-V  
  
-   Creation of Generation 1 and Generation 2 virtual machines  
  
-   Creation of virtual switches  
  
-   Starting virtual machines and running Windows guest operating systems  
- Hyper-V Replica  
  
  
  
If you want to perform a live migration of virtual machines, create a virtual machine on an SMB share, or connect resources on an existing SMB share to an existing virtual machine, it is vital that you configure authentication correctly. You have two options for doing this:  
  
**Constrained delegation**  
  
Constrained delegation works exactly the same as in previous releases. Refer to these articles for more information:  
  
-   [Enabling Hyper-V Remote Management - Configuring Constrained Delegation For SMB and Highly Available SMB](http://blogs.msdn.com/b/taylorb/archive/2012/03/20/enabling-hyper-v-remote-management-configuring-constrained-delegation-for-smb-and-highly-available-smb.aspx)  
  
-   [Enabling Hyper-V Remote Management - Configuring Constrained Delegation For Non-Clustered Live Migration](http://blogs.msdn.com/b/taylorb/archive/2012/03/20/enabling-hyper-v-remote-management-configuring-constrained-delegation-for-non-clustered-live-migration.aspx)  
  
**CredSSP**  
  
First, refer to the “Using Windows PowerShell remoting” section of this topic to enable and test CredSSP. Then, on the management computer, you can use Hyper-V Manager and select the option to “connect as another user.” Hyper-V Manager will use CredSSP. You should do this even if you are using your current account.  
  
Windows PowerShell cmdlets for Hyper-V can use CimSession or Credential parameters, either of which work with CredSSP.  
  
## <a name="BKMK_Failover"></a>Using Failover Clustering on Nano Server  
Failover clustering works the same on Nano Server as it does on Windows Server in Server Core mode, but keep these caveats in mind:  
  
-   Clusters must be managed remotely with Failover Cluster Manager or Windows PowerShell.  
  
-   All Nano Server cluster nodes must be joined to the same domain, similar to cluster nodes in Windows Server.  
  
-   The domain account must have Administrator privileges on all Nano Server nodes, as with cluster nodes in Windows Server.  
  
-   All commands must be run in an elevated command prompt.  
  
> [!NOTE]  
> Additionally, certain features are not supported in this release:  
>   
> -   You cannot run failover clustering cmdlets on a local Nano Server through Windows PowerShell.  
> -   Clustering roles other than Hyper-V and File Server.  
  
You’ll find these Windows PowerShell cmdlets useful in managing Failover clusters:  
  
You can create a new cluster with `New-Cluster -Name <clustername> -Node <comma-separated cluster node list>`  
  
Once you've established a new cluster, you should run `Set-StorageSetting -NewDiskPolicy OfflineShared` on all nodes.  
  
Add an additional node to the cluster with `Add-ClusterNode -Name <comma-separated cluster node list>  -Cluster <clustername>`  
  
Remove a node from the cluster with  `Remove-ClusterNode -Name <comma-separated cluster node list>  -Cluster <clustername>`  
  
Create a Scale-Out File Server with `Add-ClusterScaleoutFileServerRole -name <sofsname> -cluster <clustername>`  
  
You can find additional cmdlets for failover clustering at [Microsoft.FailoverClusters.PowerShell](https://technet.microsoft.com/library/ee461009.aspx).  
  
## <a name="BKMK_DNS"></a>Using DNS Server on Nano Server  
To provide Nano Server with the DNS Server role, add the Microsoft-NanoServer-DNS-Package to the image (see the "Creating a custom Nano Server image" section of this topic. Once the Nano Server is running, connect to it and run this command from and elevated Windows PowerShell console to enable the feature:  
  
`Enable-WindowsOptionalFeature -Online -FeatureName DNS-Server-Full-Role`  
  
## <a name="BKMK_IIS"></a>Using IIS on Nano Server  
For steps to use the Internet Information Services (IIS) role, see [IIS on Nano Server](IIS-on-Nano-Server.md).  
  
## Appendix 1: Sample Unattend.xml file  
In this sample, the **offlineServicing** section is applied by the DISM command as soon as you run it, but the other sections are added to the image later when the server starts for the first time.  
  
> [!NOTE]  
> -   This sample Unattend.xml does not add the Nano Server to a domain, so you should use it if you want to run Nano Server as a standalone computer or if you want to wait to join it to a domain later. The values for ComputerName and AdministratorPassword are merely examples.  
> -   This Unattend.xml file will not work with versions of Windows prior to Windows 10® or Windows Server 2016 Technical Preview.  
  
```  
<?xml version='1.0' encoding='utf-8'?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
  
  <settings pass="offlineServicing">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
      <ComputerName>NanoServer1503</ComputerName>  
    </component>  
  </settings>  
  
  <settings pass="oobeSystem">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
      <UserAccounts>  
        <AdministratorPassword>  
           <Value>Tuva</Value>  
           <PlainText>true</PlainText>  
        </AdministratorPassword>  
      </UserAccounts>  
      <TimeZone>Pacific Standard Time</TimeZone>  
    </component>  
  </settings>  
  
  <settings pass="specialize">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
      <RegisteredOwner>My Team</RegisteredOwner>  
      <RegisteredOrganization>My Corporation</RegisteredOrganization>  
    </component>  
  </settings>  
</unattend>  
```  
  
## Appendix 2: Sample Unattend.xml file that joins Nano Server to a domain  
  
> [!NOTE]  
> Be sure to delete the trailing space in the contents of “odjblob” once you paste it into the Unattend file.  
  
```  
<?xml version='1.0' encoding='utf-8'?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
  
  <settings pass="offlineServicing">  
    <component name="Microsoft-Windows-UnattendedJoin" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
        <OfflineIdentification>                
           <Provisioning>    
             <AccountData> AAAAAAARUABLEABLEABAoAAAAAAAMABSUABLEABLEABAwAAAAAAAAABbMAAdYABc8ABYkABLAABbMAAEAAAAMAAA0ABY4ABZ8ABbIABa0AAcIABY4ABb8ABZUABAsAAAAAAAQAAZoABNUABOYABZYAANQABMoAAOEAAMIAAOkAANoAAMAAAXwAAJAAAAYAAA0ABY4ABZ8ABbIABa0AAcIABY4ABb8ABZUABLEAALMABLQABU0AATMABXAAAAAAAKdf/mhfXoAAUAAAQAAAAb8ABLQABbMABcMABb4ABc8ABAIAAAAAAb8ABLQABbMABcMABb4ABc8ABLQABb0ABZIAAGAAAAsAAR4ABTQABUAAAAAAACAAAQwABZMAAZcAAUgABVcAAegAARcABKkABVIAASwAAY4ABbcABW8ABQoAAT0ABN8AAO8ABekAAJMAAVkAAZUABckABXEABJUAAQ8AAJ4AAIsABZMABdoAAOsABIsABKkABQEABUEABIwABKoAAaAABXgABNwAAegAAAkAAAAABAMABLIABdIABc8ABY4AADAAAA4AAZ4ABbQABcAAAAAAACAAkKBW0ID8nJDWYAHnBAXE77j7BAEWEkl+lKB98XC2G0/9+Wd1DJQW4IYAkKBAADhAnKBWEwhiDAAAM2zzDCEAM6IAAAgAAAAAAAQAAAAAAAAAAAABwzzAAA  
</AccountData>  
           </Provisioning>    
         </OfflineIdentification>    
    </component>  
  </settings>  
  
  <settings pass="oobeSystem">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
      <UserAccounts>  
        <AdministratorPassword>  
           <Value>Tuva</Value>  
           <PlainText>true</PlainText>  
        </AdministratorPassword>  
      </UserAccounts>  
      <TimeZone>Pacific Standard Time</TimeZone>  
    </component>  
  </settings>  
  
  <settings pass="specialize">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">  
      <RegisteredOwner>My Team</RegisteredOwner>  
      <RegisteredOrganization>My Corporation</RegisteredOrganization>  
    </component>  
  </settings>  
</unattend>  
```  
  
## Appendix 3: Accessing Nano Server over a serial port with Emergency Management Services  
Emergency Management Services (EMS) lets you perform basic troubleshooting, get network status, and open console sessions (including CMD/PowerShell) by using a terminal emulator over a serial port. This replaces the need for a keyboard and monitor to troubleshoot a server. For more information about EMS, see [Emergency Management Services Technical Reference](https://technet.microsoft.com/library/cc784411(v=ws.10).aspx).

To enable EMS on a Nano Server image so that it's ready should you need it later, run this cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\EnablingEMS.vhdx   -EnableEMS   -EMSPort 3   -EMSBaudRate 9600`  
  
This example cmdlet enables EMS on serial port 3 with a baud rate of 9600 bps. If you don't include those parameters, the defaults are port 1 and 115200 bps. To use this cmdlet for VHDX media, be sure to include the Hyper-V feature and the corresponding Windows PowerShell modules.  
  
## Appendix 4: Customizing an existing Nano Server VHD  
You can change the details of an existing VHD by using the Edit-NanoServerImage cmdlet, as in this example:  
  
`Edit-NanoServerImage   -BasePath .\Base   -TargetPath .\BYOVHD.vhd`  
  
This cmdlet does the same things as New-NanoServerImage, but changes the existing image instead of converting a WIM to a VHD. It supports the same parameters as New-NanoServerImage with the exception of -MediaPath and -MaxSize, so the initial VHD must have been created with those parameters before you can make changes with Edit-NanoServerImage.  
  
## Appendix 5: Kernel debugging  
You can configure the Nano Server image to support kernel debugging by a variety of methods. To use kernel debugging with a VHDX image, be sure to include the Hyper-V feature and the corresponding Windows PowerShell modules. For more information about remote kernel debugging generally see [Setting Up Kernel-Mode Debugging over a Network Cable Manually](https://msdn.microsoft.com/library/windows/hardware/hh439346%28v=vs.85%29.aspx) and  [Remote Debugging Using WinDbg](https://msdn.microsoft.com/library/windows/hardware/hh451173%28v=vs.85%29.aspx).  
  
### Debugging using a serial port  
Use this example cmdlet to enable the image to be debugged using a serial port:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingSerial   -DebugMethod Serial   -DebugCOMPort 1   -DebugBaudRate 9600`  
  
This example enables serial debugging over port 2 with a baud rate of 9600 bps. If you don't specify these parameters, the defaults are prot 2 and 115200 bps. If you intend to use both EMS and kernel debugging, you'll have to configure them to use two separate serial ports.  
  
### Debugging over a TCP/IP network  
Use this example cmdlet to enable the image to be debugged over a TCP/IP network:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingNetwork   -DebugMethod Net   -DebugRemoteIP 192.168.1.100   -DebugPort 64000`  
  
This cmdlet enables kernel debugging such that only the computer with the IP address of 192.168.1.100 is allowed to connect, with all communications over port 64000. The -DebugRemoteIP and -DebugPort parameters are mandatory, with a port number greater than 49152. This cmdlet generates an encryption key in a file alongside the resulting VHD which is required for communication over the port. Alternately, you can specify your own key with the -DebugKey parameter, as in this example:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingNetwork   -DebugMethod Net   -DebugRemoteIP 192.168.1.100   -DebugPort 64000   -DebugKey 1.2.3.4`  
  
### Debugging using the IEEE1394 protocol (Firewire)  
To enable debugging over IEEE1394 use this example cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingFireWire   -DebugMethod 1394   -DebugChannel 3`  
  
The -DebugChannel parameter is mandatory.  
  
### Debugging using USB  
You can enable debugging over USB with this cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingUSB   -DebugMethod USB   -DebugTargetName KernelDebuggingUSBNano`  
  
When you connect the remote debugger to the resulting Nano Server, specify the target name as set by the -DebugTargetName parameter.  
  


