---
title: Deploy Nano Server
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/30/2016
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c2be4bbf-5022-4bd7-aabb-dbe58fb1f7bb
author: jaimeo
ms.author: jaimeo
---
# Deploy Nano Server

>Applies To: Windows Server 2016

This topic covers information you need to deploy Nano Server images that are more customized to your needs compared to the simple examples in the Nano Server Quick Start topic. You'll find information about making a custom Nano Server image with exactly the features you want, installing Nano Server images from VHD or WIM, editing files, working with domains, dealing with packages by several methods, and working with server roles.

## Nano Server Image Builder
[comment]: # (##Using the Nano Server Image Creation wizard - info goes here)
The Nano Server Image Builder is a tool that helps you create a custom Nano Server image and bootable USB media with the aid of a graphical interface. Based on the inputs you provide, it generates reusable PowerShell scripts that allow you easily automate consistent installations of Nano Server running either Windows Server 2016 Datacenter or Standard editions. 

The tool also requires [Windows Assessment and Deployment Kit (ADK)](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit).


Nano Server Image Builder creates customized Nano Server images in VHD, VHDX or ISO formats and can create bootable USB media to deploy Nano server or detect the hardware configuration of a server. It also can do the following:

- Accept the license terms 
- Create VHD, VHDX or ISO formats
- Add server roles
- Add device drivers
- Set machine name, administrator password, logfile path, and timezone
- Join a domain by using an existing Active Directory account or a harvested domain-join blob
- Enable WinRM for communication outside the local subnet
- Enable Virtual LAN IDs and configure static IP addresses
- Inject new servicing packages on the fly
- Add a setupcomplete.cmd or other customer scripts to run after the unattend.xml is processed
- Enable Emergency Management Services (EMS) for serial port console access
- Enable development services to enable test signed drivers and unsigned applications, PowerShell default shell
- Enable debugging over serial, USB, TCP/IP, or IEEE 1394 protocols
- Create USB media using WinPE that will partition the server and install the Nano image
- Create USB media using WinPE that will detect your existing Nano Server hardware configuration and report all the details in a log and on-screen. This includes network adapters, MAC addresses, and firmware Type (BIOS or UEFI). The detection process will also list all of the volumes on the system and the devices that do not have a driver included in the Server Core drivers package.

If any of these are unfamiliar to you, review the remainder of this topic and the other Nano Server topics so that you'll be prepared to provide the tool with the information it will need.

## <a name="BKMK_CreateImage"></a>Creating a custom Nano Server image  
For Windows Server 2016, Nano Server is distributed on the physical media, where you will find a **NanoServer** folder; this contains a .wim image and a subfolder called **Packages**. It is these package files that you use to add server roles and features to the VHD image, which you then boot to.  
  
You can also find and install these packages with the the NanoServerPackage provider of PackageManagement (OneGet) PowerShell module. See the "Installing roles and features online" section of this topic.  
  
This table shows the roles and features that are available in this release of Nano Server, along with the Windows PowerShell options that will install the packages for them. Some packages are installed directly with their own Windows PowerShell switches (such as -Compute); others you install by passing package names to the -Packages parameter, which you can combine in a comma-separated list. You can dynamically list available packages using Get-NanoServerPackage cmdlet.  
  
|Role or feature|Option|  
|-------------------|----------|  
|Hyper-V role (including NetQoS|-Compute|  
|Failover Clustering|-Clustering|  
|Basic drivers for a variety of network adapters and storage controllers. This is the same set of drivers included in a Server Core installation of Windows Server 2016.|-OEMDrivers|  
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
  
1.  Copy the *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server 2016 ISO a local folder on your computer.  
2. Start Windows PowerShell as an administrator, change directory to the folder where you placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`.  
  
 >[!NOTE]  
>You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
To create a Nano Server image to serve as a Hyper-V host, run the following:  
  
`New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerPhysical\NanoServer.wim -ComputerName <computer name> -OEMDrivers -Compute -Clustering`  
  
Where  
-   -MediaPath is the root of the DVD media or ISO image containing Windows Server 2016 .  
-   -BasePath will contain a copy of the Nano Server binaries, so you can use New-NanoServerImage -BasePath without having to specify -MediaPath in future runs.  
-   -TargetPath will contain the resulting .wim file containing the roles & features you selected. Make sure to specify the .wim extension.  
-   -Compute adds the Hyper-V role.  
-   -OemDrivers adds a number of common drivers.  
  
You will be prompted to enter an administrator password.  
  
For more information, run `Get-Help New-NanoServerImage -Full`.  
   
Boot into WinPE and ensure that the .wim file just created is accessible from WinPE. (You could, for example, copy the .wim file to a bootable WinPE image on a USB flash drive.)  
  
Once WinPE boots, use Diskpart.exe to prepare the target computer's hard drive. Run the following Diskpart commands (modify accordingly, if you're not using UEFI & GPT):  
   
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
  
Edit a file residing on the remote Nano Server by starting a remote session with `Enter-PSSession -ComputerName "192.168.0.100" -Credential ~\Administrator` and then passing the file's relative or absolute path to the psEdit command like this:   
`psEdit C:\Windows\Logs\DISM\dism.log`  
  
## <a name="BKMK_online"></a>Installing roles and features online  
  
### Installing roles and features from a package repository  
You can find and install Windows Packages from the online package repository by using the NanoServerPackage provider of PackageManagement (OneGet) PowerShell module. To install this provider, use these cmdlets:  
  `Save-Module -Path “$env:ProgramFiles\WindowsPowerShell\Modules”  -Name NanoServerPackage -MinimumVersion 1.0.0.0`

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
  
To use any of these cmdlets with Windows packages on Nano Server, add `-provider NanoServerPackage`. If you don't add the -provider parameter, PackageManagement will iterate all of the providers. For a complete details for the cmdlets, use `get-help <cmdlet>`, but here are some examples of common usages:  
    
### Searching for Windows packages  
You can use either `Find-NanoServerPackage` or `Find-Package` to search for and return a list of Windows Packages that are available in the online repository. For example, you can get a list of all the latest packages with  
`Find-NanoServerPackage`.  
  
Using `Find-Package -provider NanoServerPackage -displayCulture` displays all cultures available.  
      
If you need a specific locale version, such as US English, you could use `Find-NanoServerPackage -Culture en-us` or  
`Find-Package -provider NanoServerPackage -Culture en-us` or `Find-Package -Culture en-us -displayCulture`.  
  
To find a specific package by package name, use the -name parameter, which accepts wildcards. For example, to find all packages with NPDS in the name, use `Find-NanoServerPackage -Name *NPDS*` or `Find-Package -provider NanoServerPackage -Name *NPDS*`.  
     
You can find a particular version with -RequiredVersion, -MinimumVersion, or -MaximumVersion parameters. To find all available versions, use -AllVersions. Otherwise, only the latest version is returned. Example: `Find-NanoServerPackage -AllVersions -Name *NPDS* -RequiredVersion 10.0.14393.0`. Or, for all versions: `Find-Package -provider NanoServerPackage -AllVersions -Name *NPDS*`  
  
### Installing Windows Packages  
You can install a Windows package (including its dependency packages, if any) to Nano Server either locally or an offline image with either `Install-NanoServerPackage` or `Install-Package`. Both of these accept pipeline results from search cmdlets.  

To install the latest version of a Windows Package to an online Nano Server, use either `Install-NanoServerPackage -Name Microsoft-NanoServer-Containers-Package` or `Install-Package -Name Microsoft-NanoServer-Containers-Package`. PackageManagement will use the culture of the Nano Server.  
      
You can install a Windows Package to an offline image, specifying a particular version and culture, like this:  
  
`Install-NanoServerPackage -Name Microsoft-NanoServer-DCB-Package -culture de-de -RequiredVersion 10.0.14393.0  -ToVHd c:\MyNanoVhd.vhd`

 or:

`Install-Package -Name Microsoft-NanoServer-DCB-Package -culture de-de -RequiredVersion 10.0.14393.0  -ToVHd c:\MyNanoVhd.vhd`  
  
Here are some examples of pipelining package search results to the installation cmdlet:  
  
`Find-NanoServerPackage *dcb* | Install-NanoServerPackage` finds any package with "dcb" in the name and then installs them.  
  
`Find-Package *nanoserver-compute-* | Install-Package` finds packages with "nanoserver-computer-" in the name and installs them.  
  
`Find-NanoServerPackage -Name *nanoserver-compute* |Install-NanoServerPackage -ToVhd c:\MyNanoVhd.vhd` finds packages with "compute" in the name and installs them to an offline image.  
  
`Find-Package -provider NanoserverPackage *nanoserver-compute-* | Install-Package -ToVhd c:\MyNanoVhd.vhd` does the same thing with any package that has "nanoserver-compute-" in the name.  
  
### Download Windows Packages  
  
`Save-NanoServerPackage` or `Save-Package` allow you download packages and save them without installing them. Both cmdlets accept pipeline results from the search cmdlets.  
  
For example, to download and save a Windows Package to a directory that matches the wildcard path, use `Save-NanoServerPackage -Name Microsoft-NanoServer-NPDS-Package -Path C:\t*p\`  
In this example, -Culture wasn't specified, so the culture of the local machine will be used. No version was specified, so the latest version will be saved.  
  
`Save-Package -provider NanoServerPackage -Name Microsoft-NanoServer-IIS-Package -Path .\temp -culture it-it -MinimumVersion 10.0.14393.0` saves a particular version and for the Italian language and locale.  
  
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
  
## Customizing an existing Nano Server VHD  
You can change the details of an existing VHD by using the Edit-NanoServerImage cmdlet, as in this example:  
  
`Edit-NanoServerImage   -BasePath .\Base   -TargetPath .\BYOVHD.vhd`  
  
This cmdlet does the same things as New-NanoServerImage, but changes the existing image instead of converting a WIM to a VHD. It supports the same parameters as New-NanoServerImage with the exception of -MediaPath and -MaxSize, so the initial VHD must have been created with those parameters before you can make changes with Edit-NanoServerImage.  

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
4.	Note the filename and path of the driver file that appears. For example, let's say the driver file is e1i63x64.sys, which is in C:\Windows\System32\Drivers.
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
  
`New-NanoServerImage -DeploymentType Host -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\InjectingDrivers.vhdx -DriverPath .\Extra\Drivers`  
  
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
  

### Support for development scenarios  
If you want to develop and test on Nano Server, you can use the -Development parameter. This will enable installation of unsigned drivers, copy debugger binaries, open a port for debugging, enable test signing and enable installation of AppX packages without a developer license:  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -Development`  
  
  
### Custom unattend file  
If you want to use your own unattend file, use the -UnattendPath parameter:  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -UnattendPath \\path\to\unattend.xml`  
  
Specifying an administrator password or computer name in this unattend file will override the values set by -AdministratorPassword and -ComputerName.  

## Installing apps and drivers
[comment]: # (From Xumin Sun, bug #68620.)  

### Windows Server App installer
Windows Server App (WSA) installer provides a reliable installation option for Nano Server. Since Windows Installer (MSI) is not supported on Nano Server, WSA also the only installation technology available for non-Microsoft products. WSA leverages Windows app package technology designed to install and service applications safely and reliably, using a declarative manifest. It extends the Windows app package installer to support Windows Server-specific extensions, with the limitation that WSA does not support installing drivers.

Creating and installing a WSA package on Nano Server involves steps for both the publisher and the consumer of the package.

The package publisher should do the following:

1. Install [Windows 10 SDK](https://developer.microsoft.com/windows/downloads/windows-10-sdk), which includes the tools needed to create a WSA package: MakeAppx, MakeCert, Pvk2Pfx, SignTool.
2. Declare a manifest: Follow the [WSA manifest extension schema](https://msdn.microsoft.com/library/windows/apps/mt670653.aspx) to create the manifest file, AppxManifest.xml.
3. Use the **MakeAppx** tool to create a WSA package.
4. Use **MakeCert** and **Pvk2Pfx** tools to create the certificate, and the use **Signtool** to sign the package.

Next, the package consumer should follow these steps:

1. Run the [*Import-Certificate*](https://technet.microsoft.com/library/hh848630) PowerShell cmdlet to import the publisher’s certificate from Step 4 above to Nano Server with the certStoreLocation at “Cert:\LocalMachine\TrustedPeople”. For example: `Import-Certificate -filepath ".\xyz.cer" -certStoreLocation "Cert:\LocalMachine\TrustedPeople"`
2. Install the app on Nano Server by running the [**Add-AppxPackage**](https://technet.microsoft.com/library/mt575516(v=wps.620).aspx) PowerShell cmdlet to install a WSA package on Nano Server. For example: `Add-AppxPackage wsaSample.appx`

#### Additional resources for creating apps
WSA is server extension of Windows app package technology (though it is not hosted in Windows Store). If you want to publish apps with WSA,these topics will help you familiarize youself with the app package pipeline:

- [How to create a basic package manifest](https://msdn.microsoft.com/library/windows/desktop/br211475.aspx)
- [App Packager (MakeAppx.exe)](https://msdn.microsoft.com/library/windows/desktop/hh446767(v=vs.85).aspx)
- [How to create an app package signing certificate](https://msdn.microsoft.com/library/windows/desktop/jj835832(v=vs.85).aspx)
- [SignTool](https://msdn.microsoft.com/library/windows/desktop/aa387764(v=vs.85).aspx)

### Installing drivers on Nano Server
You can install non-Microsoft drivers on Nano Server by using INF driver packages. These include both Plug-and-Play (PnP) driver packages and File System Filter driver packages. Network Filter drivers are not currently supported on Nano Server.

Both PnP and File System Filter driver packages must follow the Universal driver requirements and installation process, as well as general driver package guidelines such as signing. They are documented at these locations:

- [Driver Signing](https://msdn.microsoft.com/windows/hardware/drivers/install/driver-signing)
- [Using a Universal INF File](https://msdn.microsoft.com/windows/hardware/drivers/install/using-a-configurable-inf-file)

#### Installing driver packages offline

Supported driver packages can be installed on Nano Server offline via [DISM.exe](https://msdn.microsoft.com/windows/hardware/commercialize/manufacture/desktop/dism-driver-servicing-command-line-options-s14) or [DISM PowerShell](https://technet.microsoft.com/library/dn376497.aspx) cmdlets.

#### Installing driver packages online
PnP driver packages can be installed to Nano Server online by using [PnpUtil](https://msdn.microsoft.com/library/windows/hardware/ff550419(v=vs.85).aspx). Online driver installation for non-PnP driver packages is not currently supported on Nano Server.





 
--------------------------------------------------  
  
  
## <a name="BKMK_JoinDomain"></a>Joining Nano Server to a domain  
  
### To add Nano Server to a domain online  
  
1.  Harvest a data blob from a computer in the domain that is already running Windows Threshold Server using this command:  
  
    `djoin.exe /provision /domain <domain-name> /machine <machine-name> /savefile .\odjblob`  
  
    This saves the data blob in a file called "odjblob".  
  
2.  Copy the "odjblob" file to the Nano Server computer with these commands:  
  
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
    > Exit Windows PowerShell with `Exit-PSSession`, and then retry the net use command. If successful, continue copying the "odjblob" file contents to the Nano Server.  
  
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
  
`djoin.exe /provision /domain <domain-name> /machine <machine-name> /savefile .\odjblob`  
  
Open the file "odjblob" (perhaps in Notepad), copy its contents, and then paste the contents into the \<AccountData> section of the Unattend.xml file below.  
  
Put this Unattend.xml file into the C:\NanoServer folder, and then use the following commands to mount the VHD and apply the settings in the `offlineServicing` section:  
  
**dism\dism /Mount-ImagemediaFile:.\NanoServer.vhd /Index:1 /MountDir:.\mountdir**  
  
**dism\dismmedia:.\mountdir /Apply-Unattend:.\unattend.xml**  
  
Create a "Panther" folder (used by Windows systems for storing files during setup; see [Windows 7, Windows Server 2008 R2, and Windows Vista setup log file locations](http://support.microsoft.com/en-us/kb/927521) if you're curious), copy the Unattend.xml file to it, and then unmount the VHD with these commands:  
  
**md .\mountdir\windows\panther**  
  
**copy .\unattend.xml .\mountdir\windows\panther**  
  
**dism\dism /Unmount-Image /MountDir:.\mountdir /Commit**  
  
The first time you boot Nano Server from this VHD, the other settings will be applied.  
  
After you have joined Nano Server to a domain, add the domain user account to the Administrators group on the Nano Server.  
 
## Working with server roles on Nano Server

###Using Hyper-V on Nano Server  
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
  
First, refer to the "Using Windows PowerShell remoting" section of this topic to enable and test CredSSP. Then, on the management computer, you can use Hyper-V Manager and select the option to "connect as another user." Hyper-V Manager will use CredSSP. You should do this even if you are using your current account.  
  
Windows PowerShell cmdlets for Hyper-V can use CimSession or Credential parameters, either of which work with CredSSP.  
  
### <a name="BKMK_Failover"></a>Using Failover Clustering on Nano Server  
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
  
You'll find these Windows PowerShell cmdlets useful in managing Failover clusters:  
  
You can create a new cluster with `New-Cluster -Name <clustername> -Node <comma-separated cluster node list>`  
  
Once you've established a new cluster, you should run `Set-StorageSetting -NewDiskPolicy OfflineShared` on all nodes.  
  
Add an additional node to the cluster with `Add-ClusterNode -Name <comma-separated cluster node list>  -Cluster <clustername>`  
  
Remove a node from the cluster with  `Remove-ClusterNode -Name <comma-separated cluster node list>  -Cluster <clustername>`  
  
Create a Scale-Out File Server with `Add-ClusterScaleoutFileServerRole -name <sofsname> -cluster <clustername>`  
  
You can find additional cmdlets for failover clustering at [Microsoft.FailoverClusters.PowerShell](https://technet.microsoft.com/library/ee461009.aspx).  
  
### <a name="BKMK_DNS"></a>Using DNS Server on Nano Server  
To provide Nano Server with the DNS Server role, add the Microsoft-NanoServer-DNS-Package to the image (see the "Creating a custom Nano Server image" section of this topic. Once the Nano Server is running, connect to it and run this command from and elevated Windows PowerShell console to enable the feature:  
  
`Enable-WindowsOptionalFeature -Online -FeatureName DNS-Server-Full-Role`  
  
### <a name="BKMK_IIS"></a>Using IIS on Nano Server  
For steps to use the Internet Information Services (IIS) role, see [IIS on Nano Server](IIS-on-Nano-Server.md). 

### Using MPIO on Nano Server
For steps to use MPIO, see [MPIO on Nano Server](MPIO-on-Nano-Server.md) 

### <a name="BKMK_SSH"></a>Using SSH on Nano Server
For instructions on how to install and use SSH on Nano Server with the OpenSSH project, see the [Win32-OpenSSH wiki](https://github.com/PowerShell/Win32-OpenSSH/wiki).

## Appendix: Sample Unattend.xml file that joins Nano Server to a domain  
  
> [!NOTE]  
> Be sure to delete the trailing space in the contents of "odjblob" once you paste it into the Unattend file.  
  
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
  