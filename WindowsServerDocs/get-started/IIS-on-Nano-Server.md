---
title: IIS on Nano Server
description: "Details for configuring IIS on Nano Server"
ms.prod: windows-server
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.tgt_pltfrm: na
ms.topic: article
ms.date: 09/06/2017
ms.assetid: 16984724-2d77-4d7b-9738-3dff375ed68c
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# IIS on Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

You can install the Internet Information Services (IIS) server role on Nano Server by using the -Package parameter with Microsoft-NanoServer-IIS-Package. For information about configuring Nano Server, including installing packages, see [Install Nano Server](Getting-Started-with-Nano-Server.md).  

In this release of Nano Server, the following IIS features are available:  

|Feature|Enabled by default|  
|-----------|----------------------|  
|**Common HTTP Features**||  
|Default document|x|  
|Directory browsing|x|  
|HTTP Errors|x|  
|Static content|x|  
|HTTP redirection||  
|**Health and Diagnostics**||  
|HTTP logging|x|  
|Custom logging||  
|Request monitor||  
|Tracing||  
|**Performance**||  
|Static content compression|x|  
|Dynamic content compression||  
|**Security**||  
|Request filtering|x|  
|Basic authentication||  
|Client certificate mapping authentication||  
|Digest authentication||  
|IIS client certificate mapping authentication||  
|IP and domain restrictions||  
|URL authorization||  
|Windows authentication||  
|**Application Development**||  
|Application initialization||  
|CGI||  
|ISAPI extensions||  
|ISAPI filters||  
|Server-side includes||  
|WebSocket protocol||  
|**Management Tools**||  
|IISAdministration module for Windows PowerShell|x|  

A series of articles on other configurations of IIS (such as using ASP.NET, PHP, and Java), as well as other related content is published at [http://iis.net/learn](https://iis.net/learn).  

## Installing IIS on Nano Server  
You can install this server role either offline (with the Nano Server off) or online (with the Nano Server running); offline installation is the recommended option.  

For offline installation, add the package with the -Packages parameter of New-NanoServerImage, as in this example:  

`New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1.vhd -ComputerName Nano1 -Package Microsoft-NanoServer-IIS-Package`  

If you have an existing VHD file, you can install IIS offline with DISM.exe by mounting the VHD, and then using the **Add-Package** option.   
The following example steps assume that you are running from the directory specified by BasePath option, which was created after running New-NanoServerImage.  

1.  mkdir mountdir
2.  .\Tools\dism.exe /Mount-Image /ImageFile:.\NanoServer.vhd /Index:1 /MountDir:.\mountdir
3.  .\Tools\dism.exe /Add-Package /PackagePath:.\packages\Microsoft-NanoServer-IIS-Package.cab /Image:.\mountdir
4.  .\Tools\dism.exe /Add-Package /PackagePath:.\packages\en-us\Microsoft-NanoServer-IIS-Package_en-us.cab /Image:.\mountdir
5.  .\Tools\dism.exe /Unmount-Image /MountDir:.\MountDir /Commit


> [!NOTE]  
> Note that Step 4 adds the language pack--this example installs EN-US.  

At this point you can start Nano Server with IIS.  

### Installing IIS on Nano Server online  
Though offline installation of the server role is recommended, you might need to install it online (with the Nano Server running) in container scenarios. To do this, follow these steps:  

1.  Copy the Packages folder from the installation media locally to the running Nano Server (for example, to C:\packages).  

2.  Create a new Unattend.xml file on another computer and then copy it to the Nano Server. You can copy and paste this XML content into the XML file you created:  



```  

    <unattend xmlns="urn:schemas-microsoft-com:unattend">  
    <servicing>  
        <package action="install">  
            <assemblyIdentity name="Microsoft-NanoServer-IIS-Package" version="10.0.14393.0" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" />  
            <source location="c:\packages\Microsoft-NanoServer-IIS-Package.cab" />  
        </package>  
        <package action="install">  
            <assemblyIdentity name="Microsoft-NanoServer-IIS-Package" version="10.0.14393.0" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="en-US" />  
            <source location="c:\packages\en-us\Microsoft-NanoServer-IIS-Package_en-us.cab" />  
        </package>  
    </servicing>  
    <cpi:offlineImage cpi:source="" xmlns:cpi="urn:schemas-microsoft-com:cpi" />  
</unattend>  
```  




3. In the new XML file you created (or copied), edit C:\packages to the directory you copied the content of Packages to.  

4. Switch to the directory with the newly created XML file and run  

   **dism /online /apply-unattend:.\unattend.xml**  


5. Confirm that the IIS package and its associated language pack is installed correctly by running:  

   **dism /online /get-packages**  

   You should see "Package Identity : Microsoft-NanoServer-IIS-Package~31bf3856ad364e35~amd64~~10.0.14393.1000" listed twice, once for Release Type : Language Pack and once for Release Type : Feature Pack.  

6. Start the W3SVC service either with **net start w3svc** or by restarting the Nano Server.  

## Starting IIS  
Once IIS is installed and running, it is ready to serve web requests. Verify that IIS is running by browsing the default IIS web page at http://\<IP address of Nano Server>. On a physical computer, you can determine the IP address by using the Recovery Console. On a virtual machine, you can get the IP address by using a Windows PowerShell prompt and running:  

`Get-VM -name <VM name> | Select -ExpandProperty networkadapters | select IPAddresses`  

If you are not able to access the default IIS web page, double-check the IIS installation by looking for the **c:\inetpub** directory on the Nano Server.  

## Enabling and disabling IIS features  
A number of IIS features are enabled by default when you install the IIS role (see the table in the "Overview of IIS on Nano Server" section of this topic). You can enable (or disable) additional features using DISM.exe

Each feature of IIS exists as a set of configuration elements. For example, the Windows authentication feature comprises these elements:  

|Section|Configuration elements|  
|-----------|--------------------------|  
|`<globalModules>`|`<add name="WindowsAuthenticationModule" image="%windir%\System32\inetsrv\authsspi.dll`|  
|`<modules>`|`<add name="WindowsAuthenticationModule" lockItem="true" \/>`|  
|`<windowsAuthentication>`|`<windowsAuthentication enabled="false" authPersistNonNTLM\="true"><providers><add value="Negotiate" /><add value="NTLM" /><br /></providers><br /></windowsAuthentication>`|  

The full set of IIS sub-features are included in Appendix 1 of this topic and their corresponding configuration elements is included in Appendix 2 of this topic.  


### Example: installing Windows authentication  

1.  Open a Windows PowerShell remote session console on the Nano Server.  

2.  Use `DISM.exe` to install the Windows authentication module:

    ```
    dism /Enable-Feature /online /featurename:IIS-WindowsAuthentication /all
    ```

    The `/all` switch will install any feature that the chosen feature depends on.

### Example: uninstalling Windows authentication  

1.  Open a Windows PowerShell remote session console on the Nano Server.  

2.  Use `DISM.exe` to uninstall the Windows authentication module:

    ```
    dism /Disable-Feature /online /featurename:IIS-WindowsAuthentication
    ```

## Other common IIS configuration tasks  
**Creating websites**  

Use this cmdlet:  

`PS D:\> New-IISSite -Name TestSite -BindingInformation "*:80:TestSite" -PhysicalPath c:\test`  

You can then run `Get-IISSite` to verify the state of the site (returns the web site name, ID, state, physical path, and bindings).  

**Deleting web sites**  

Run `Remove-IISSite -Name TestSite -Confirm:$false`.  

**Creating virtual directories**  

You can create virtual directories by using the IISServerManager object returned by Get-IISServerManager, which exposes the .NET Microsoft.Web.Administration.ServerManager API. In this example, these commands access the "Default Web Site" element of the Sites collection and the root application element ("/") of the Applications section. They then call the Add() method of the VirtualDirectories collection for that application element to create the new directory:  

```  
PS C:\> $sm = Get-IISServerManager  
PS C:\> $sm.Sites["Default Web Site"].Applications["/"].VirtualDirectories.Add("/DemoVirtualDir1", "c:\test\virtualDirectory1")  
PS C:\> $sm.Sites["Default Web Site"].Applications["/"].VirtualDirectories.Add("/DemoVirtualDir2", "c:\test\virtualDirectory2")  
PS C:\> $sm.CommitChanges()  
```  

**Creating application pools**  

Similarly you can use Get-IISServerManager to create application pools:  

```  
PS C:\> $sm = Get-IISServerManager  
PS C:\> $sm.ApplicationPools.Add("DemoAppPool")  
```  

**Configuring HTTPS and certificates**  

Use the Certoc.exe utility to import certificates, as in this example, which shows configuring HTTPS for a website on a Nano Server:  

1.  On another computer that is not running Nano Server, create a certificate (using your own certificate name and password), and then export it to c:\temp\test.pfx.  

    `$newCert = New-SelfSignedCertificate -DnsName "www.foo.bar.com" -CertStoreLocation cert:\LocalMachine\my`  

    `$mypwd = ConvertTo-SecureString -String "YOUR_PFX_PASSWD" -Force -AsPlainText`  

    `Export-PfxCertificate -FilePath c:\temp\test.pfx -Cert $newCert -Password $mypwd`  

2.  Copy the test.pfx file to the Nano Server computer.  

3.  On the Nano Server, import the certificate to the "My" store with this command:  

    **certoc.exe -ImportPFX -p YOUR_PFX_PASSWD My c:\temp\test.pfx**  

4.  Retrieve the thumbprint of this new certificate (in this example, 61E71251294B2A7BB8259C2AC5CF7BA622777E73) with `Get-ChildItem Cert:\LocalMachine\my`.  

5.  Add the HTTPS binding to the Default Web Site (or whatever website you want to add the binding to) by using these Windows PowerShell commands:  

    ```  
    $certificate = get-item Cert:\LocalMachine\my\61E71251294B2A7BB8259C2AC5CF7BA622777E73  
    # Use your actual thumbprint instead of this example  
    $hash = $certificate.GetCertHash()  

    Import-Module IISAdministration  
    $sm = Get-IISServerManager  
    $sm.Sites["Default Web Site"].Bindings.Add("*:443:", $hash, "My", "0")    # My is the certificate store name  
    $sm.CommitChanges()  
    ```  

    You could also use Server Name Indication (SNI) with a specific host name with this syntax: `$sm.Sites["Default Web Site"].Bindings.Add("*:443:www.foo.bar.com", $hash, "My", "Sni".`  

## Appendix 1: List of IIS sub-features

- IIS-WebServer
- IIS-CommonHttpFeatures
- IIS-StaticContent
- IIS-DefaultDocument
- IIS-DirectoryBrowsing
- IIS-HttpErrors
- IIS-HttpRedirect
- IIS-ApplicationDevelopment
- IIS-CGI
- IIS-ISAPIExtensions
- IIS-ISAPIFilter
- IIS-ServerSideIncludes
- IIS-WebSockets
- IIS-ApplicationInit
- IIS-Security
- IIS-BasicAuthentication
- IIS-WindowsAuthentication
- IIS-DigestAuthentication
- IIS-ClientCertificateMappingAuthentication
- IIS-IISCertificateMappingAuthentication
- IIS-URLAuthorization
- IIS-RequestFiltering
- IIS-IPSecurity
- IIS-CertProvider
- IIS-Performance
- IIS-HttpCompressionStatic
- IIS-HttpCompressionDynamic
- IIS-HealthAndDiagnostics
- IIS-HttpLogging
- IIS-LoggingLibraries
- IIS-RequestMonitor
- IIS-HttpTracing
- IIS-CustomLogging

## Appendix 2: Elements of HTTP features  
Each feature of IIS exists as a set of configuration elements. This appendix lists the configuration elements for all of the features in this release of Nano Server  

### Common HTTP features  
**Default document**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="DefaultDocumentModule" image="%windir%\System32\inetsrv\defdoc.dll" />`|  
|`<modules>`|`<add name="DefaultDocumentModule" lockItem="true" />`|  
|`<handlers>`|`<add name="StaticFile" path="*" verb="*" modules="DefaultDocumentModule" resourceType="EiSecther" requireAccess="Read" />`|  
|`<defaultDocument>`|`<defaultDocument enabled="true"><br /><files><br /> <add value="Default.htm" /><br />        <add value="Default.asp" /><br />        <add value="index.htm" /><br />        <add value="index.html" /><br />        <add value="iisstart.htm" /><br />    </files><br /></defaultDocument>`|  

The `StaticFile <handlers>` entry might already be present; if so, just add "DefaultDocumentModule" to the \<modules> attribute, separated by a comma.  

**Directory browsing**  

|Section|Configuration elements|  
|----------------|--------------------------|   
|`<globalModules>`|`<add name="DirectoryListingModule" image="%windir%\System32\inetsrv\dirlist.dll" />`|  
|`<modules>`|`<add name="DirectoryListingModule" lockItem="true" />`|  
|`<handlers>`|`<add name="StaticFile" path="*" verb="*" modules="DirectoryListingModule" resourceType="Either" requireAccess="Read" />`|  

The `StaticFile <handlers>` entry might already be present; if so, just add "DirectoryListingModule" to the \<modules> attribute, separated by a comma.  

**HTTP errors**  

|Section|Configuration elements|  
|----------------|--------------------------|   
|`<globalModules>`|`<add name="CustomErrorModule" image="%windir%\System32\inetsrv\custerr.dll" />`|  
|`<modules>`|`<add name="CustomErrorModule" lockItem="true" />`|  
|`<httpErrors>`|`<httpErrors lockAttributes="allowAbsolutePathsWhenDelegated,defaultPath"><br />    <error statusCode="401"    prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="401.htm" ><br />    <error statusCode="403" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="403.htm" /><br />    <error statusCode="404" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="404.htm" /><br />    <error statusCode="405" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="405.htm" /><br />    <error statusCode="406" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="406.htm" /><br />    <error statusCode="412" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="412.htm" /><br />    <error statusCode="500" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="500.htm" /><br />    <error statusCode="501" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="501.htm" /><br />    <error statusCode="502" prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="502.htm" /><br /></httpErrors>`|  

**Static content**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="StaticFileModule" image="%windir%\System32\inetsrv\static.dll" />`|  
|`<modules>`|`<add name="StaticFileModule" lockItem="true" />`|  
|`<handlers>`|`<add name="StaticFile" path="*" verb="*" modules="StaticFileModule" resourceType="Either" requireAccess="Read" />`|  

The `StaticFile \<handlers>` entry might already be present; if so, just add "StaticFileModule" to the \<modules> attribute, separated by a comma.  

**HTTP redirection**  

|Section|Configuration elements|  
|----------------|--------------------------|    
|`<globalModules>`|`<add name="HttpRedirectionModule" image="%windir%\System32\inetsrv\redirect.dll" />`|  
|`<modules>`|`<add name="HttpRedirectionModule" lockItem="true" />`|  
|`<httpRedirect>`|`<httpRedirect enabled="false" />`|  

### Health and diagnostics  
**HTTP logging**  

|Section|Configuration elements|  
|----------------|--------------------------|   
|`<globalModules>`|`<add name="HttpLoggingModule" image="%windir%\System32\inetsrv\loghttp.dll" />`|  
|`<modules>`|`<add name="HttpLoggingModule" lockItem="true" />`|  
|`<httpLogging>`|`<httpLogging dontLog="false" />`|  

**Custom logging**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="CustomLoggingModule" image="%windir%\System32\inetsrv\logcust.dll" />`|  
|`<modules>`|`<add name="CustomLoggingModule" lockItem="true" />`|  

**Request monitor**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="RequestMonitorModule" image="%windir%\System32\inetsrv\iisreqs.dll" />`|  

**Tracing**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="TracingModule" image="%windir%\System32\inetsrv\iisetw.dll" \/><br /><add name="FailedRequestsTracingModule" image="%windir%\System32\inetsrv\iisfreb.dll" />`|  
|`<modules>`|`<add name="FailedRequestsTracingModule" lockItem="true" />`|  
|`<traceProviderDefinitions>`|`<traceProviderDefinitions><br />    <add name="WWW Server" guid\="{3a2a4e84-4c21-4981-ae10-3fda0d9b0f83}"><br />        <areas><br />            <clear /><br />            <add name="Authentication" value="2" /><br />            <add name="Security" value="4" /><br />            <add name="Filter" value="8" /><br />            <add name="StaticFile" value="16" /><br />            <add name="CGI" value="32" /><br />            <add name="Compression" value="64" /><br />            <add name="Cache" value="128" /><br />            <add name="RequestNotifications" value="256" /><br />            <add name="Module" value="512" /><br />            <add name="FastCGI" value="4096" /><br />            <add name="WebSocket" value="16384" /><br />        </areas><br />    </add><br />    <add name="ISAPI Extension" guid="{a1c2040e-8840-4c31-ba11-9871031a19ea}"><br />        <areas><br />            <clear /><br />        </areas><br />    </add><br /></traceProviderDefinitions>`|  

### Performance  
**Static content compression**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="StaticCompressionModule" image="%windir%\System32\inetsrv\compstat.dll" />`|  
|`<modules>`|`<add name="StaticCompressionModule" lockItem="true" />`|  
|`<httpCompression>`|`<httpCompression directory="%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files"><br />    <scheme name="gzip" dll="%Windir%\system32\inetsrv\gzip.dll" /><br />   <staticTypes><br />        <add mimeType="text/*" enabled="true" /><br />        <add mimeType="message/*" enabled="true" /><br />        <add mimeType="application/javascript" enabled="true" \/><br />        <add mimeType="application/atom+xml" enabled="true" /><br />        <add mimeType="application/xaml+xml" enabled="true" /><br />        <add mimeType="\*\*" enabled="false" /><br />    </staticTypes><br /></httpCompression>`|  

**Dynamic content compression**  

|Section|Configuration elements|  
|-----------|--------------------------|  
|`<globalModules>`|`<add name="DynamicCompressionModule" image="%windir%\System32\inetsrv\compdyn.dll" />`|  
|`<modules>`|`<add name="DynamicCompressionModule" lockItem="true" />`|  
|`<httpCompression>`|`<httpCompression directory\="%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files"><br />    <scheme name="gzip" dll="%Windir%\system32\inetsrv\gzip.dll" \/><br />    \<dynamicTypes><br />        <add mimeType="text/*" enabled="true" \/><br />        <add mimeType="message/*" enabled="true" /><br />        <add mimeType="application/x-javascript" enabled="true" /><br />        <add mimeType="application/javascript" enabled="true" /><br />        <add mimeType="*/*" enabled="false" /><br />    <\/dynamicTypes><br /></httpCompression>`|  

### Security  
**Request filtering**  


|       Section        |                                                                                                                                        Configuration elements                                                                                                                                        |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  `<globalModules>`   |                                                                                                        `<add name="RequestFilteringModule" image="%windir%\System32\inetsrv\modrqflt.dll" />`                                                                                                        |
|     `<modules>`      |                                                                                                                       `<add name="RequestFilteringModule" lockItem="true" />`                                                                                                                        |
| \`<requestFiltering> | `<requestFiltering><br />    <fileExtensions allowUnlisted="true" applyToWebDAV="true" /><br />    <verbs allowUnlisted="true" applyToWebDAV="true" /><br />    <hiddenSegments applyToWebDAV="true"><br />        <add segment="web.config" /><br />    </hiddenSegments><br /></requestFiltering>` |

**Basic authentication**  

|Section|Configuration elements|  
|----------------|--------------------------|   
|`<globalModules>`|`<add name="BasicAuthenticationModule" image="%windir%\System32\inetsrv\authbas.dll" />`|  
|`<modules>`|`<add name="WindowsAuthenticationModule" lockItem="true" />`|  
|`<basicAuthentication>`|`<basicAuthentication enabled="false" />`|  

**Client certificate mapping authentication**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="CertificateMappingAuthentication" image="%windir%\System32\inetsrv\authcert.dll" />`|  
|`<modules>`|`<add name="CertificateMappingAuthenticationModule" lockItem="true" />`|  
|`<clientCertificateMappingAuthentication>`|`<clientCertificateMappingAuthentication enabled="false" />`|  

**Digest authentication**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="DigestAuthenticationModule" image="%windir%\System32\inetsrv\authmd5.dll" />`|  
|`<modules>`|`<add name="DigestAuthenticationModule" lockItem="true" />`|  
|`<other>`|`<digestAuthentication enabled="false" />`|  

**IIS client certificate mapping authentication**  


|                  Section                   |                                         Configuration elements                                         |
|--------------------------------------------|--------------------------------------------------------------------------------------------------------|
|             `<globalModules>`              | `<add name="CertificateMappingAuthenticationModule" image="%windir%\System32\inetsrv\authcert.dll" />` |
|                `<modules>`                 |               `<add name="CertificateMappingAuthenticationModule" lockItem="true" `/>\`                |
| `<clientCertificateMappingAuthentication>` |                      `<clientCertificateMappingAuthentication enabled="false" />`                      |

**IP and domain restrictions**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|```<add name="IpRestrictionModule" image="%windir%\System32\inetsrv\iprestr.dll" /><br /><add name="DynamicIpRestrictionModule" image="%windir%\System32\inetsrv\diprestr.dll" />```|  
|`<modules>`|`<add name="IpRestrictionModule" lockItem="true" \/><br /><add name="DynamicIpRestrictionModule" lockItem="true" \/>`|  
|`<ipSecurity>`|`<ipSecurity allowUnlisted="true" />`|  

**URL authorization**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="UrlAuthorizationModule" image="%windir%\System32\inetsrv\urlauthz.dll" />`|  
|`<modules>`|`<add name="UrlAuthorizationModule" lockItem="true" />`|  
|`<authorization>`|`<authorization><br />    <add accessType="Allow" users="*" /><br /></authorization>`|  

**Windows authentication**  

|Section|Configuration elements|  
|----------------|--------------------------|    
|`<globalModules>`|`<add name="WindowsAuthenticationModule" image="%windir%\System32\inetsrv\authsspi.dll" />`|  
|`<modules>`|`<add name="WindowsAuthenticationModule" lockItem="true" />`|  
|`<windowsAuthentication>`|`<windowsAuthentication enabled="false" authPersistNonNTLM\="true"><br />    <providers><br />        <add value="Negotiate" /><br />        <add value="NTLM" /><br />    <\providers><br /><\windowsAuthentication><windowsAuthentication enabled="false" authPersistNonNTLM\="true"><br />    <providers><br />        <add value="Negotiate" /><br />        <add value="NTLM" /><br />    <\/providers><br /><\/windowsAuthentication>`|  

### Application development  
**Application initialization**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="ApplicationInitializationModule" image="%windir%\System32\inetsrv\warmup.dll" />`|  
|`<modules>`|`<add name="ApplicationInitializationModule" lockItem="true" />`|  

**CGI**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|`<add name="CgiModule" image="%windir%\System32\inetsrv\cgi.dll" /><br /><add name="FastCgiModule" image="%windir%\System32\inetsrv\iisfcgi.dll" />`|  
|`<modules>`|`<add name="CgiModule" lockItem="true" /><br /><add name="FastCgiModule" lockItem="true" />`|  
|`<handlers>`|`<add name="CGI-exe" path="*.exe" verb="\*" modules="CgiModule" resourceType="File" requireAccess="Execute" allowPathInfo="true" />`|  

**ISAPI extensions**  

|Section|Configuration elements|  
|----------------|--------------------------|    
|`<globalModules>`|`<add name="IsapiModule" image="%windir%\System32\inetsrv\isapi.dll" />`|  
|`<modules>`|`<add name="IsapiModule" lockItem="true" />`|  
|`<handlers>`|`<add name="ISAPI-dll" path="*.dll" verb="*" modules="IsapiModule" resourceType="File" requireAccess="Execute" allowPathInfo="true" />`|  

**ISAPI filters**  

|Section|Configuration elements|  
|----------------|--------------------------|    
|`<globalModules>`|`<add name="IsapiFilterModule" image="%windir%\System32\inetsrv\filter.dll" />`|  
|`<modules>`|`<add name="IsapiFilterModule" lockItem="true" />`|  

**Server-side includes**  

|Section|Configuration elements|  
|----------------|--------------------------|  
|`<globalModules>`|<`add name="ServerSideIncludeModule" image="%windir%\System32\inetsrv\iis_ssi.dll" />`|  
|`<modules>`|`<add name="ServerSideIncludeModule" lockItem="true" />`|  
|`<handlers>`|`<add name="SSINC-stm" path="*.stm" verb="GET,HEAD,POST" modules="ServerSideIncludeModule" resourceType="File" \/><br /><add name="SSINC-shtm" path="*.shtm" verb="GET,HEAD,POST" modules="ServerSideIncludeModule" resourceType="File" /><br /><add name="SSINC-shtml" path="*.shtml" verb="GET,HEAD,POST" modules="ServerSideIncludeModule" resourceType="File" />`|  
|`<serverSideInclude>`|`<serverSideInclude ssiExecDisable="false" />`|  

**WebSocket protocol**  

|Section|Configuration elements|  
|----------------|--------------------------|    
|`<globalModules>`|`<add name="WebSocketModule" image="%windir%\System32\inetsrv\iiswsock.dll" />`|  
|`<modules>`|`<add name="WebSocketModule" lockItem="true" />`|  