To prepare to migrate an AD FS 2.0 federation server proxy to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must export and back up the AD FS configuration data from this server proxy.  The steps in this topic apply to a scenario with one proxy federation server or multiple proxy federation servers.  
  
 To export the AD FS configuration data, perform the following tasks:  
  
-   [Step 1: Export proxy service settings](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server%20Proxy.md#BKMK_1)  
  
-   [Step 2: Back up webpage customizations](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server%20Proxy.md#BKMK_2)  
  
##  <a name="BKMK_1"></a> Step 1: Export proxy service settings  
 To export federation server proxy service settings, perform the following procedure:  
  
#### To export proxy service settings  
  
1.  Export the Secure Sockets Layer (SSL) certificate and its private key to a .pfx file. For more information, see [Export the Private Key Portion of a Server Authentication Certificate](../Topic/Export%20the%20Private%20Key%20Portion%20of%20a%20Server%20Authentication%20Certificate.md).  
  
    > [!NOTE]
    >  This step is optional because this certificate is preserved during the operating system upgrade.  
  
2.  Export AD FS 2.0 federation proxy properties to a file. You can do that by using Windows PowerShell.  
  
     Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export federation proxy properties to a file: `PSH:> Get-ADFSProxyProperties | out-file “.\proxyproperties.txt”`.  
  
3.  Ensure you know the credentials of an account that is either an administrator of the AD FS federation server or the service account under which the AD FS federation service runs.  This information is required for the proxy trust setup.  
  
 Completing this step results in gathering the following information that is required to configure your AD FS federation server proxy:  
  
-   AD FS federation service name  
  
-   Name of the domain account that is required for the proxy trust setup  
  
-   The address and the port of the HTTP proxy (if there is an HTTP proxy between the AD FS federation server proxy and the AD FS federation servers)  
  
##  <a name="BKMK_2"></a> Step 2: Back up webpage customizations  
 To back up webpage customizations, copy the AD FS proxy webpages and the **web.config** file from the directory that is mapped to the virtual path **“/adfs/ls”** in IIS.  By default, it is in the **%systemdrive%\inetpub\adfs\ls** directory.  
  
## See Also  
 [Migrate AD FS Role Services to Windows Server 2012](../Topic/Migrate%20Active%20Directory%20Federation%20Services%20Role%20Services%20to%20Windows%20Server%202012.md)