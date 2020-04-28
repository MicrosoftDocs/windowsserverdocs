---
title: Verify Server Enrollment of a Server Certificate
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: bd80a018-5a30-47c3-89fc-aacb9f5ad298
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Verify Server Enrollment of a Server Certificate

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to verify that your Network Policy Server (NPS) servers have enrolled a server certificate from the certification authority (CA).   
  
>[!NOTE]  
>Membership in the **Domain Admins** group is the minimum required to complete these procedures.  
  
## Verify Network Policy Server (NPS) enrollment of a server certificate  
  
Because NPS is used to authenticate and authorize network connection requests, it is important to ensure that the server certificate you have issued to NPSs is valid when used in network policies.  
  
To verify that a server certificate is correctly configured and is enrolled to the NPS, you must configure a test network policy and allow NPS to verify that NPS can use the certificate for authentication.  
  
### To verify NPS enrollment of a server certificate  
  
1.  In Server Manager, click **Tools**, and then click **Network Policy Server**. The Network Policy Server Microsoft Management Console (MMC) opens.  
  
2.  Double-click **Policies**, right-click **Network Policies**, and click **New**. The New Network Policy wizard opens.  
  
3.  In **Specify Network Policy Name and Connection Type**, in **Policy name**, type **Test policy**. Ensure that **Type of network access server** has the value **Unspecified**, and then click **Next**.  
  
4.  In **Specify Conditions**, click **Add**. In **Select condition**, click **Windows Groups**, and then click **Add**.  
  
5.  In **Groups**, click **Add Groups**. In **Select Group**, type **Domain Users**, and then press ENTER. Click **OK**, and then click **Next**.  
  
6.  In **Specify Access Permission**, ensure that **Access granted** is selected, and then click **Next**.  
  
7.  In **Configure Authentication Methods**, click **Add**. In **Add EAP**, click **Microsoft: Protected EAP (PEAP)**, and then click **OK**. In **EAP Types**, select **Microsoft: Protected EAP (PEAP)**, and then click **Edit**. The **Edit Protected EAP Properties** dialog box opens.  
  
8.  In the **Edit Protected EAP Properties** dialog box, in **Certificate issued to**, NPS displays the name of your server certificate in the format *ComputerName*.*Domain*. For example, if your NPS is named NPS-01 and your domain is example.com, NPS displays the certificate **NPS-01.example.com**. In addition, in **Issuer**, the name of your certification authority is displayed, and in **Expiration date**, the date of expiration of the server certificate is shown. This demonstrates that your NPS has enrolled a valid server certificate that it can use to prove its identity to client computers that are trying to access the network through your network access servers, such as virtual private network (VPN) servers, 802.1X-capable wireless access points, Remote Desktop Gateway servers, and 802.1X-capable Ethernet switches.  
  
    > [!IMPORTANT]  
    > If NPS does not display a valid server certificate and if it provides the message that such a certificate cannot be found on the local computer, there are two possible reasons for this problem. It is possible that Group Policy did not refresh properly, and the NPS has not enrolled a certificate from the CA. In this circumstance, restart the NPS. When the computer restarts, Group Policy is refreshed, and you can perform this procedure again to verify that the server certificate is enrolled. If refreshing Group Policy does not resolve this issue, either the certificate template, certificate autoenrollment, or both are not configured correctly. To resolve these issues, start at the beginning of this guide and perform all steps again to ensure that the settings that you have provided are accurate.  
  
9. When you have verified the presence of a valid server certificate, you can click **OK** and **Cancel** to exit the New Network Policy wizard.  
  
    > [!NOTE]  
    > Because you are not completing the wizard, the test network policy is not created in NPS.  
  


