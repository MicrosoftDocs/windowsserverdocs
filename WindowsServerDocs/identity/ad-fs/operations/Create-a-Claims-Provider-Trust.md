---
ms.assetid: a4f7842c-cfca-4d78-916e-023d12a9cdf0
title: Create a Claims Provider Trust
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Create a Claims Provider Trust

To add a new claims provider trust by using the AD FS Management snap\-in and manually configure the settings, perform the following procedure on a resource partner federation server in the resource partner organization.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
## To create a claims provider trust manually  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  Under **Actions**, click **Add Claims Provider Trust**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim1.PNG)   
  
3.  On the **Welcome** page, click **Start**. 
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim2.PNG)    
  
4.  On the **Select Data Source** page, click **Enter claims provider trust data manually**, and then click **Next**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim3.PNG)     

5.  On the **Specify Display Name** page, type a **Display name**, under **Notes**, type a description for this claims provider trust, and then click **Next**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim4.PNG)     

6.  On the **Configure URL** page, specify the **WS-Federation Passive URL** if applicable and click **Next**.
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim5.PNG)     

8. On the **Configure Identifier** page, under **Claims provider trust identifier**, type the appropriate identifier, and then click **Next**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim6.PNG)    

9. On the **Configure Certificates** page, click **Add** to locate a certificate file and add it to the list of certificates, and then click **Next**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim7.PNG)    

10. On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim8.PNG)    

11. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the following additional references.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim9.PNG)

## To create a claims provider trust using federation metadata
To add a new claims provider trust, using the AD FS Management snap-in, by automatically importing configuration data about the partner from federation metadata that the partner has published to a local network or to the Internet, perform the following procedure on a federation server in the resource partner organization.

>[!NOTE]
>Though it has long been common practice to use certificates with unqualified host names such as https:\//myserver, these certificates have no security value and can enable an attacker to impersonate a Federation Service that is publishing federation metadata. Therefore, when querying federation metadata, you should only use a fully qualified domain name such as `https://myserver.contoso.com`.

1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  Under **Actions**, click **Add Claims Provider Trust**.  
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim1.PNG)   
  
3.  On the **Welcome** page, click **Start**. 
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim2.PNG)    
  
4.  On the **Select Data Source** page, click **Import data about the claims provider published online or on a local network**. In Federation metadata address (host name or URL), type the **federation metadata URL** or host name for the partner, and then click **Next**.
![claims provider trust](media/Create-a-Claims-Provider-Trust/addclaim10.PNG)    

5.  On the Specify Display Name page type a **Display name**, under Notes type a description for this claims provider trust, and then click **Next**.

6.  On the Ready to Add Trust page, click **Next** to save your claims provider trust information.

7.  On the Finish page, click **Close**. This will automatically display the Edit Claim Rules dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the Additional references section below.



    
## Additional references  
[Checklist: Configuring the Resource Partner Organization](../../ad-fs/deployment/Checklist--Configuring-the-Resource-Partner-Organization.md)  
  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../../ad-fs/deployment/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
## See Also  
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md) 
  
