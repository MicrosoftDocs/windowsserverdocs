---
title: WDS: Working with Images
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 497f5b73-b795-41d7-a801-6d8cc5fdbf6c
---
# WDS: Working with Images
This topic contains information about the images that you use with Windows Deployment Services. Windows Deployment Services uses two basic image types, both of which use the Windows Image \(.wim\) file format:  
  
-   **Install image**: The operating system image that you deploy to the client computer. To create install images using Windows Deployment Services, you must first create a capture image.  
  
-   **Boot image**: The Microsoft Windows Preinstallation Environment \(Windows PE\) image that you boot a client into before you install the install image. To install an operating system, you first boot the computer into the boot image, and then you select the install image to install. You can also create two additional types of boot images:  
  
    -   **Capture image**: A type of boot image that you boot a client computer into to capture the operating system as a .wim file. You must first create a capture image when you are creating custom install images.  
  
    -   **Discover image**: A type of boot image that you can use to install an operating system on a computer that is not Pre\-Boot Execution Environment \(PXE\) enabled. When you boot a computer into a discover image, a Windows Deployment Services server will be located, and then you can choose the install image you want to install.  
  
## <a name="BKMK_2"></a>Boot Images  
These images contain Windows PE and the Windows Deployment Services client. The Windows Deployment Services client is Windows Vista Setup.exe with some additional functionality needed for network deployments. In most cases, you should use the standard boot image that is included on the operating system DVD \(located at \\Sources\\boot.wim\) without modification.  
  
### <a name="Custom"></a>Creating Custom Boot Images  
You can use the tools in the Windows Automated Installation Kit \(AIK\) to create custom boot images. You may want to create custom boot images for different tasks and architecture types. For example, you could have boot images that do the following:  
  
-   Start Setup to install Windows.  
  
-   Reformat the hard disks to support BitLocker Drive Encryption \(using unattend\), and then install Windows.  
  
-   Contain the Windows Recovery Environment \(Windows RE\) that you want to use when a computer fails to start.  
  
-   Include a Windows PE image for administrators who want to perform other operations within Windows PE.  
  
To create custom boot image, use one of the following procedures:  
  
##### To create a custom boot image using Windows PE 2.0 or 2.1  
  
1.  Download the appropriate version of the Windows AIK.  
  
2.  Create a Windows PE build environment. For example: `copype.cmd x86 c:\winpe_x86`  
  
3.  Mount the Windows PE image. For example: `imagex /mountrw c:\winpe_x86\winpe.wim 1 c:\winpe_x86\mount`  
  
4.  Create a top\-level folder named **Sources** in the \\mount directory.  
  
5.  Obtain the Boot.wim from the product DVD and copy all of the files from the \\Sources folder to the \\Sources folder of your mounted image.  
  
6.  As desired, add any Windows features, applications, or scripts that you want.  
  
7.  If desired, remove any non\-installed packages from the final image \(to reduce the image size a minimal amount\): `peimg /prep c:\winpe_x86\mount\Windows`  
  
8.  Unmount and commit changes. For example: `imagex /unmount c:\winpe_x86\mount /commit`  
  
9. Now you are ready to add the custom boot image to the Windows Deployment Services server.  
  
##### To create a custom boot image using Windows PE 3.0  
  
1.  Download the appropriate version of the Windows AIK.  
  
2.  Create a WinPE build environment. For example: `copype.cmd x86 c:\winpe_x86`  
  
3.  Mount the .wim image using DISM. For example: `dism /mount-wim /wimfile:c:\winpe_x86\winpe.wim /index:1 /mountdir: c:\winpe_x86\mount`  
  
4.  Add the following components using the DISM \/AddPackage option.  
  
    1.  Setup package: `dism /image:c:\winpe_x86\mount /add-package:”<path to WAIK>\Tools\PETools\<arch>\WinPE_FPs\winpe-setup.cab”`  
  
    2.  Setup branding: `dism /image:c:\winpe_x86\mount /add-package:”<path to WAIK>\Tools\PETools\<arch>\WinPE-FPs\winpe-setup-server.cab”`  
  
        > [!NOTE]  
        > You can also use the winpe\-setup\-client.cab instead as there is no difference between the files.  
  
    3.  Windows Deployment Services tools: `dism /image:”c:\winpe_x86\mount /add-package:<path to WAIK>\Tools\PETools\<arch>\WinPE_FPs\winpe-wds-tools.cab”`  
  
5.  Add language packs for the above feature packs:  
  
    ```  
    dism /image:c:\winpe_x86\mount /add-package:<path to WAIK>\Tools\PETools\<arch>\WinPE_FPs\<lang>\winpe-setup_<lang>.cab  
    ```  
  
    ```  
    dism /image:c:\winpe_x86\mount /add-package:<path to WAIK>\Tools\PETools\<arch>\WinPE_FPs\<lang>\winpe-setup-server_<lang>.cab  
    ```  
  
    ```  
    dism /image:c:\winpe_x86\mount /add-package:<path to WAIK>\Tools\PETools\<arch>\WinPE_FPs\<lang>\winpe-wds-tools_<lang>.cab  
    ```  
  
6.  Unmount and commit the changes: `dism /unmount-wim /mountdir:c:\winpe_x86\mount /commit`  
  
7.  Now you are ready to add the custom boot image to the Windows Deployment Services server.  
  
Note the following about creating custom boot images:  
  
-   You can also make additional changes to the boot menu, using the Bcdedit.exe tool to edit the Default.bcd file located at %REMINST%\\boot\\<architecture>. For more information, see How to Modify the BCD Store Using Bcdedit \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=115267](http://go.microsoft.com/fwlink/?LinkId=115267)\).  
  
-   The boot menu on x86\-based computers will display only x86 boot images \(because x86\-based computers cannot run x64 boot images\); however, if you boot into an x86\-based boot image from an x64\-based computer, x86\-based and x64\-based install images will be displayed. If you boot into an x64\-based boot image from an x64\-based computer, only x64\-based boot images will be displayed.  
  
-   If you have a WinPESHL.ini file in the boot image, you need to create an entry in the WinPESHL.ini file to start Setup.exe in Windows Deployment Services mode. For more information, see “When Setup Is Started in Windows Deployment Services Mode” in How the Windows Deployment Services Client Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=147067](http://go.microsoft.com/fwlink/?LinkID=147067)\).  
  
> [!IMPORTANT]  
> When creating custom boot images, the version of Windows PE that you use must match or be newer than the install image.  
  
## <a name="DiscoverImage"></a>Discover Images  
Discover images are generally used in scenarios where the client cannot perform a network boot. These images enable a computer to locate a Windows Deployment Services server to install an image. To create a discover image, right\-click a boot image in the MMC snap\-in, and then click **Create discover boot image**. In most cases, you should use the Boot.wim file included on the operating system install media to create your image. For instructions, see the [Windows Deployment Services Getting Started Guide](http://go.microsoft.com/fwlink/?LinkID=84628).When you create a discover images, you configure one of the following:  
  
-   **Static discovery**. Static discovery is when you specify the server that the computer should use when you create the discover image. Static discovery works well in data center environments or branch offices where DHCP may not be available. One major disadvantage of static discovery is that it introduces a single point of failure. For example, if the server that is specified is unavailable, Windows Deployment Services will not work, and there is no way to have the client try a different server. Another flaw is that static discovery does not allow for load balancing, because all clients using a particular boot image would use the specified server.  
  
-   **Dynamic discovery**. If you do not specify the server to use when you create a discover image, Windows Deployment Services will emulate a network boot request from within Windows PE. Based on the responses to that request, the client can locate a valid server and continue the installation process.  
  
## <a name="Capture"></a>Capture Images  
Capture images are a type of boot image that you boot a client computer into to capture the operating system as a .wim file. You must first create a capture image when you are creating custom install images. These images are an alternative to using ImageX.  
  
Capture images contain Windows PE and the Windows Deployment Services Image Capture Wizard. When you boot a computer \(that has been prepared with Sysprep\) into a capture image, the wizard creates an install image of the computer and saves it as a .wim file. Then you can upload the image to the Windows Deployment Services server or copy it to bootable media \(CD, DVD, USB drive, and so on\). You create capture images from existing boot images — most commonly, the Boot.wim file from the operating system install media. For instructions on creating these images, see the [Windows Deployment Services Getting Started Guide](http://go.microsoft.com/fwlink/?LinkID=84628).  
  
Capture images provide a subset of the functionality included in the **ImageX \/capture** command. The following table compares these two tools.  
  
|Functionality|Image Capture Wizard|ImageX|  
|-----------------|------------------------|----------|  
|Captures a partial volume?|No|Yes|  
|Captures an image that has not been prepared by using Sysprep?|No|Yes|  
|Uploads directly to the Windows Deployment Services server?|Yes|No|  
|Can the process be automated?|Yes|Yes|  
|Has a GUI?|Yes|No|  
|Provides additional functionality beyond image capture?|No|Yes|  
|Enables me to specify a capture exclusion list?|Yes|Yes|  
|Captures directly to a network location without making a local image copy?|No|Yes|  
  
Regardless of which tool you use \(capture images or ImageX\), the high\-level process for capturing images remains essentially the same:  
  
1.  Install Windows on a reference computer.  
  
2.  Perform customizations and install software.  
  
3.  Run the correct version of Sysprep for the reference computer's operating system.  
  
4.  Reboot into Windows PE.  
  
5.  Capture the image into .wim format.  
  
6.  Upload the image to the Windows Deployment Services server.  
  
## <a name="BKMK_custom"></a>Custom Discover or Capture Images  
For advanced scenarios as part of a custom deployment solution, you can create discover or capture images manually by using the tools provided in the Windows AIK.  
  
#### To create a discover or capture image manually  
  
1.  Locate the boot image that you want to modify, and save it to a known location. This boot image can be either the custom boot image that you created in the “Creating Custom Boot Images” section, or the Boot.wim from the product DVD.  
  
2.  Mount the image using either DISM or ImageX.  
  
3.  Create a Winpeshl.ini file in the Windows\\System32 folder of the custom boot image with one of the following sections.  
  
    -   **Capture Images**.  
  
        ```  
        [LaunchApps]%SYSTEMROOT%\system32\wdscapture.exe  
        ```  
  
    -   **Discover Images**.  
  
        ```  
        [LaunchApps]%SYSTEMROOT%\sources\setup.exe, "/wds /wdsdiscover"  
        ```  
  
        or  
  
        ```  
        [LaunchApps]%SYSTEMROOT%\sources\setup.exe, "/wds /wdsdiscover /wdsserver:<server>"  
        ```  
  
        Note the following about the \/wdsdiscover and \/wdsserver options:  
  
        -   **\/WDSDiscover**. \(Default\) Specifies that the Windows Deployment Services client should be in discover mode. If you do not specify \/WDSServer with this option, Windows Deployment Services will search for a server.  
  
        -   **\/WDSServer:<ServerName>**. Specifies the name of the Windows Deployment Services server that the client should connect to. Note that **<ServerName>** can be an IP address, a NetBIOS name, or a fully qualified domain name \(FQDN\). You must also specify **\/WDSDiscover**.  
  
4.  Unmount and commit the changes using either DISM or ImageX.  
  
5.  Update the image metadata to reflect any changes to the image name or description.  
  
