---
ms.assetid: ab97948a-c434-48f2-8313-c1a7a518e5f7
title: Create a Stand-Alone Federation Server
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Create a Stand-Alone Federation Server

After you install the Federation Service role service and configure the required certificates on a computer, you are ready to configure the computer to become a federation server. You can use the following procedure to set up the computer to become a stand\-alone federation server. The act of creating a stand\-alone federation server also creates a new Federation Service. You do create a federation server with the AD FS Federation Server Configuration Wizard.  
  
> [!NOTE]  
> For the Federated Web Single\-Sign\-On \(SSO\) design, you must have at least one federation server in the account partner organization and at least one federation server in the resource partner organization. For more information, see [Where to Place a Federation Server](https://technet.microsoft.com/library/dd807127.aspx).  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
### To create a stand\-alone federation server  
  
1.  There are two ways to start the AD FS Federation Server Configuration Wizard. To start the wizard, do one of the following:  
  
    -   After the Federation Service role service installation is complete, open the AD FS Management snap\-in and click the **AD FS Federation Server Configuration Wizard** link on the **Overview** page or in the **Actions** pane.  
  
    -   Anytime after the setup wizard is complete, open Windows Explorer, navigate to the **C:\\Windows\\ADFS** folder, and then double\-click **FsConfigWizard.exe**.  
  
2.  On the **Welcome** page, verify that **Create a new Federation Service** is selected, and then click **Next**.  
  
3.  On the **Select Stand\-Alone or Farm Deployment** page, click **Stand\-alone federation server**, and then click **Next**.  
  
    > [!IMPORTANT]  
    > When you select the Stand\-alone federation server option in the AD FS Federation Server Configuration Wizard, the service account associated with this Federation Service will automatically be assigned to the NETWORK SERVICE account. Using NETWORK SERVICE as the service account is only recommended in situations where you are evaluating AD FS in a test lab environment. If you intend to use the Stand\-alone federation server option to deploy a federation server in a production environment, it is important that you change this service account to a more appropriate service account that can be dedicated to serving requests for this new Federation Service. Changing the service account to an account other than NETWORK SERVICE will mitigate possible attack vectors that would otherwise make your federation server vulnerable to malicious attacks.  
  
4.  On the **Specify the Federation Service Name** page, verify that the **SSL certificate** that is showing is correct. If not, select the appropriate certificate from the **SSL certificate** list.  
  
    This certificate is generated from the Secure Sockets Layer \(SSL\) settings for the Default Web Site. If the Default Web Site has only one SSL certificate configured, that certificate is presented and automatically selected for use. If multiple SSL certificates are configured for the Default Web Site, all those certificates are listed here and you must select from among them. If there are no SSL settings configured for the Default Web Site, the list is generated from the certificates that are available in the personal certificates store on the local computer.  
  
    > [!NOTE]  
    > The wizard will not allow you to override the certificate if an SSL certificate is configured for IIS. This ensures that any intended prior IIS configuration for SSL certificates is preserved. To work around this restriction, you can remove the certificate or reconfigure manually it with the IIS Management Console.  
  
5.  If the AD FS database that you selected already exists, the **Existing AD FS Configuration Database Detected** page appears. If that occurs, click **Delete database**, and then click **Next**.  
  
    > [!CAUTION]  
    > Select this option only when you are sure that the data in this AD FS database is not important or that it is not used in a production federation server farm.  
  
6.  On the **Ready to Apply Settings** page, review the details. If the settings appear to be correct, click **Next** to begin configuring AD FS with these settings.  
  
7.  On the **Configuration Results** page, review the results. When all the configuration steps are finished, click **Close**  to exit the wizard.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  

