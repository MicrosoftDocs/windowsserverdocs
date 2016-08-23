---
title: Create a Claims Provider Trust
description:
author: billmath
manager: femila
ms.date: 08/23/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
---

# Create a Claims Provider Trust

>Applies To: Windows Server 2016, Windows Server 2012 R2

To add a new claims provider trust by using the AD FS Management snap\-in and manually configure the settings, perform the following procedure on a resource partner federation server in the resource partner organization.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
## To create a claims provider trust manually  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  Under **Actions**, click **Add Relying Party Trust**.  
![](media/Create-a-Claims-Provider-Trust/addclaim1.PNG)   
  
3.  On the **Welcome** page, click **Start**. 
![](media/Create-a-Claims-Provider-Trust/addclaim2.PNG)    
  
4.  On the **Select Data Source** page, click **Enter claims provider trust data manually**, and then click **Next**.  
![](media/Create-a-Claims-Provider-Trust/addclaim3.PNG)     

5.  On the **Specify Display Name** page, type a **Display name**, under **Notes**, type a description for this claims provider trust, and then click **Next**.  
![](media/Create-a-Claims-Provider-Trust/addclaim4.PNG)     

6.  On the **Configure URL** page, specify the **WS-Federation Passive URL** if applicable and click **Next**.
![](media/Create-a-Claims-Provider-Trust/addclaim5.PNG)     

8. On the **Configure Identifier** page, under **Claims provider trust identifier**, type the appropriate identifier, and then click **Next**.  
![](media/Create-a-Claims-Provider-Trust/addclaim6.PNG)    

9. On the **Configure Certificates** page, click **Add** to locate a certificate file and add it to the list of certificates, and then click **Next**.  
![](media/Create-a-Claims-Provider-Trust/addclaim7.PNG)    

10. On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
![](media/Create-a-Claims-Provider-Trust/addclaim8.PNG)    

11. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the following additional references.  
![](media/Create-a-Claims-Provider-Trust/addclaim9.PNG)
    
## Additional references  
[Checklist: Configuring the Resource Partner Organization](https://technet.microsoft.com/library/dd807047.aspx)  
  
[Checklist: Creating Claim Rules for a Claims Provider Trust](https://technet.microsoft.com/library/ee913564.aspx)  
  
## See Also  
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md) 
  
