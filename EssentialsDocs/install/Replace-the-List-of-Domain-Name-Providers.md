---
title: "Replace the List of Domain Name Providers"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 104d0412-2d77-4cd4-99f7-65a885522850
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Replace the List of Domain Name Providers

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can replace the list of domain name providers that is displayed in the Set Up Domain Name Wizard by completing the following tasks:  


-   [Create the referral service files](Replace-the-List-of-Domain-Name-Providers.md#BKMK_ReferralFiles)  

-   [Add an entry to the registry on the reference computer](Replace-the-List-of-Domain-Name-Providers.md#BKMK_AddRegistry)  

-   [Create the referral service files](../install/Replace-the-List-of-Domain-Name-Providers.md#BKMK_ReferralFiles)  

-   [Add an entry to the registry on the reference computer](../install/Replace-the-List-of-Domain-Name-Providers.md#BKMK_AddRegistry)  


###  <a name="BKMK_ReferralFiles"></a> Create the referral service files  
 The Referral Service Administration Tool creates a set of files that are used to define the list of domain name providers that are displayed in the Set Up Domain Name Wizard. An XML formatted file is created for each worldwide region and contains information for the domain name providers that you specify in the tool. The files that are created by the tool must be located in a folder that can be accessed through a secure link (HTTPS) that you manage on the Internet.  

##### To create the referral files  

1.  Open the Referral Service Administration Tool.  

2.  Click **Add**.  

3.  In the Add a Domain Name Provider dialog box, enter the name of the domain name provider.  

4.  Add the top-level domains that are supported by the domain name provider. You do this by clicking **Add**, entering the top-level domain identifier, and then selecting the supported regions. You can select **All Regions**.  

5.  Enter the description of the domain name provider.  

6.  Add the URLs for all websites that are associated with the domain name provider.  

7.  If a logo is available for the domain name provider, add the logo by clicking **Change Logo**.  

8.  Click **Save**.  

9. Repeat steps 2 through 8 for each domain name provider that you want to list in the wizard.  

10. After you add all of the domain name providers, choose the folder where the referral files will be located. Keep in mind when choosing a folder that the referral files must be accessed through an HTTPS link.  

11. Click **Generate Files to File System**.  

###  <a name="BKMK_AddRegistry"></a> Add an entry to the registry on the reference computer  
 A registry entry must be added to specify where the operating system can find the referral service files.  

##### To add a key to the registry  

1.  On the reference computer, click **Start**, enter **regedit**, and then press **Enter**.  

2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**, expand **Domain Managers**, and then expand **Providers**.  

3.  Right-click the **E423C85D-6B1F-4583-95E0-449D8263BAC4** key, and then click **String Value**.  

4.  Type **ReferralServerHttpsUri** for the name of the string, and then press **Enter**.  

5.  Right-click the new **ReferralServerHttpsUri** string in the right pane, and then click **Modify**.  


6.  Type the HTTPS URL that is used to access the referral files that you created in [Create the referral service files](Replace-the-List-of-Domain-Name-Providers.md#BKMK_ReferralFiles), and then click **OK**.  

6.  Type the HTTPS URL that is used to access the referral files that you created in [Create the referral service files](../install/Replace-the-List-of-Domain-Name-Providers.md#BKMK_ReferralFiles), and then click **OK**.  


~~~
> [!IMPORTANT]
>  A slash (/) is required at the end of the URL.  
~~~

###  <a name="BKMK_ReplaceDomainNameProviders"></a> Domain name status issues  
 If a partner adds domain name providers and uses an application programming interface (API) in the  Windows Server Essentials SDK to set the Unknown, Failed, and CertificateRequestNotSubmitted statuses for the certificate, the customer receives an incorrect message and configuration result. This is because the cases are handled by exceptions rather than returning a status.  

 The following domain statuses are failures and should be reported as an error:  

- Failed  

- PendingCustomerInterventionRequired  

- PurchaseFailed  

- DomainNotFound  

- InRenewalCustomerInterventionRequired  

- RenewalFailed  

  The following domain statuses are successful and should be reported as a success:  

- Ready  

- Pending  

- InRenewal  

## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

