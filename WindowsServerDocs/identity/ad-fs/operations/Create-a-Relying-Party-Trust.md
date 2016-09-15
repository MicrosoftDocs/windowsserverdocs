---
title: Create a Relying Party Trust
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 08/22/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
---



# Create a Relying Party Trust

>Applies To: Windows Server 2016, Windows Server 2012 R2

To add a new relying party trust by using the AD FS Management snap\-in and manually configure the settings, perform the following procedure on a federation server.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
##To create a claims aware Relying Party Trust manually 
  
1. In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  Under **Actions**, click **Add Relying Party Trust**.  
![](media/Create-a-Relying-Party-Trust/addtrust1.PNG)   

3.  On the **Welcome** page, choose **Claims aware** and click **Start**.  
![](media/Create-a-Relying-Party-Trust/addtrust2.PNG) 
  
4.  On the **Select Data Source** page, click **Enter data about the relying party manually**, and then click **Next**.  
![](media/Create-a-Relying-Party-Trust/addtrust3.PNG) 
  
5.  On the **Specify Display Name** page, type a name in **Display name**, under **Notes** type a description for this relying party trust, and then click **Next**.  
![](media/Create-a-Relying-Party-Trust/addtrust4.PNG) 

6. On the **Configure Certificate** page, if you have an optional token encryption certificate, click **Browse** to locate a certificate file, and then click **Next**.  
![](media/Create-a-Relying-Party-Trust/addtrust5.PNG) 

7.  On the **Configure URL** page, do one or both of the following, click **Next**, and then go to step 10:  
  
    -   Select the **Enable support for the WS\-Federation Passive protocol** check box. Under **Relying party WS\-Federation Passive protocol URL**, type the URL for this relying party trust, and then click **Next**.  
  
    -   Select the **Enable support for the SAML 2.0 WebSSO protocol** check box. Under **Relying party SAML 2.0 SSO service URL**, type the Security Assertion Markup Language \(SAML\) service endpoint URL for this relying party trust, and then click **Next**.  
![](media/Create-a-Relying-Party-Trust/addtrust6.PNG)   

8. On the **Configure Identifiers** page, specify one or more identifiers for this relying party, click **Add** to add them to the list, and then click **Next**.  
![](media/Create-a-Relying-Party-Trust/addtrust8.PNG)
  
9.  On the **Choose Access Control Policy** select a policy and click **Next**.  For more information about Access Control Policies, see [Access Control Policies in AD FS](Access-Control-Policies-in-AD-FS.md). 
![](media/Create-a-Relying-Party-Trust/addtrust9.PNG)

14. On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.  
   ![](media/Create-a-Relying-Party-Trust/addtrust10.PNG) 
15. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box.  
![](media/Create-a-Relying-Party-Trust/addtrust11.PNG) 

## See Also  
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md) 
