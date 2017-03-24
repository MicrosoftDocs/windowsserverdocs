

The topics in this section provide instructions for deploying Work Folders with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] and Web Application Proxy (WAP), and also provide [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts that automate the deployment process. The instructions and scripts are designed to help you create a complete functioning Work Folders setup, with client machines that are ready to start using Work Folders either on-premises or over the Internet.  
  
 Work Folders is a component introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that allows information workers to sync work files between their devices. For more information about Work Folders, see [Work Folders](../Topic/Work%20Folders%20Overview.md).  
  
 To enable users to sync their Work Folders across the Internet, you need to publish Work Folders through a reverse proxy, making Work Folders available externally on the Internet. Web Application Proxy, which is included in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], is one option that you can use to provide reverse proxy functionality. Web Application Proxy pre-authenticates access to the Work Folders web application by using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], so that users on any device can access Work Folders from outside the corporate network.  
  
 These topics provide both of the following:  
  
-   Step-by-step instructions for setting up and deploying Work Folders with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] and Web Application Proxy via the Windows Server UI. The instructions describe how to set up a simple test environment with self-signed certificates. You can then use the test example as a guide to help you create a production environment that uses publicly trusted certificates.  
  
-   [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts that enable you to set up and configure the same test environment in less than 15 minutes. Instructions for editing and using the scripts can be found in the topic [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy%20using%20Windows%20PowerShell.md).  
  
  Download the scripts included in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap/) blog post.  
  
## Prerequisites  
 To follow the procedures and examples in these topics, you need to have the following components ready:  
  
-   An [!INCLUDE[ad_adds_1](../Token/ad_adds_1_md.md)] forest with schema extensions in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to support automatic referral of PCs and devices to the correct file server when you are using multiple file servers. It is preferable that DNS be enabled in the forest, but this is not required.  
  
-   A domain controller: A server that has the AD DS role enabled, and is configured with a domain (for the test example, contoso.com).  
  
     A domain controller running at least [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is needed in order to support device registration for Workplace Join. If you don't want to use Workplace Join, you can run Windows [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on the domain controller.  
  
-   Two servers that are joined to the domain (contoso.com) and that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. One server will be for used for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], and the other will be used for Work Folders.  
  
-   One server that is not domain joined and that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This server will run Web Application Proxy, and it must have one network card for the network domain (contoso.com) and another network card for an external domain (fabrikam.com).  
  
-   One domain-joined client computer that is running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)].  
  
-   One non-domain-joined client computer that is running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] on Fabrikam's virtual network.  
  
 You can download evaluation versions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] Enterprise from the TechNet Evaluation center:  
  
-   [Windows Server 2012 R2 evaluation version](http://technet.microsoft.com/evalcenter/dn205286.aspx)  
  
-   [Windows 8.1 Enterprise evaluation version](http://technet.microsoft.com/evalcenter/hh699156)  
  
 The computers can be physical machines or virtual machines (VMs). If you run the provisioningEnvironment.ps1 from the scripts included in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap/) blog post, it will create all of the needed VMs, with the exception of the domain controller. Before you run the script, be sure to edit the vms.txt file to update the network information appropriately.  
  
 After you finish setting up the required computers, you should have the topology that is shown in the following diagram.  
  
 ![FS&#95;WorkFolders](../Image/FS_WorkFolders_DMZ_Contoso.png "FS_WorkFolders_DMZ_Contoso")  
Configuration of computers for Work Folders test scenario  
  
> [!NOTE]
>  In the test example that is used in this group of topics, Web Application Proxy is not joined to the domain. There are some deployments in which you might want to have Web Application Proxy joined to a domain, such as when you are using Windows authentication. If you plan to use Integrated Windows authentication, the Web Application Proxy server must be joined to an [!INCLUDE[ad_adds_2](../Token/ad_adds_2_md.md)] domain, and you must also configure Kerberos Constraint Delegation (KCD).  
  
## Deployment overview  
 In this group of topics, you’ll walk through a step-by-step example of setting up [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], Web Application Proxy, and Work Folders in a test environment. The components will be set up in this order:  
  
1.  [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]  
  
2.  Work Folders  
  
3.  Web Application Proxy  
  
4.  The domain-joined workstation and non-domain-joined workstation  
  
 You will also use one of the provided [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts to create self-signed certificates.  
  
## Deployment steps  
 To perform the deployment by using the Windows Server UI, follow the steps in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%201,%20Set%20Up%20AD%20FS.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%202,%20AD%20FS%20Post-Configuration%20Work.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%203,%20Set%20Up%20Work%20Folders.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%204,%20Set%20Up%20Web%20Application%20Proxy.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%205,%20Set%20Up%20Clients.md)  
  
 To perform the deployment by using the provided [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts, follow the steps in this topic:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy%20using%20Windows%20PowerShell.md)  
  
## See Also  
 [Work Folders](../Topic/Work%20Folders%20Overview.md)   
 [Designing a Work Folders Implementation](../Topic/Designing%20a%20Work%20Folders%20Implementation.md)   
 [Deploying Work Folders](../Topic/Deploying%20Work%20Folders.md)