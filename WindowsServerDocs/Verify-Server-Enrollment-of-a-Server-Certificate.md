---
title: Verify Server Enrollment of a Server Certificate
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bd80a018-5a30-47c3-89fc-aacb9f5ad298
---
# Verify Server Enrollment of a Server Certificate
You can use this procedure to verify that your servers have enrolled a server certificate from the certification authority (CA). 

There are two different verification procedures below. 

The first procedure allows you to verify that your SDN servers (Network Controller, Software Load Balancing Multiplexer (MUX), and RAS Gateway servers) have properly enrolled a certificate.

The second procedure allows you to verify that your Network Policy Server (NPS) servers have properly enrolled a certificate.

>[!NOTE]
>Membership in the **Domain Admins** group is the minimum required to complete these procedures.

## Verify SDN server enrollment of a server certificate
You can perform this procedure on any SDN server that is a member of an Active Directory group for which you have deployed autoenrolled server certificates. Ensure that you have either rebooted the server or manually refreshed Group Policy on the server before performing this procedure.

### To verify SDN server enrollment of a server certificate

1. Click **Start**. In **Windows Server**, right\-click **Windows PowerShell**, and then click **Run as Administrator**. The Windows PowerShell console opens.
2. Type **mmc**, and then press ENTER. The Microsoft Management Console \(MMC\) opens.
3. In the MMC, click **File**, and then click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.
4. In **Add or Remove Snap-ins**, in **Available snap-ins**, double\-click **Certificates**. The **Certificates snap-in** dialog box opens.
5. In **Certificates snap-in**, in **This snap-in will always manage certificates for**, click **Computer account**. Click **Next**.
6. In **Select Computer**, select the computer whose certificate store you want to view, and then click **Finish**.
7. In **Add or Remove Snap-ins**, click **OK**.
8. In the MMC, double\-click **Certificates \(Local Computer\)** to expand the tree, and then double\-click the **Personal** folder.
9. Under **Personal**, click the **Certificates** folder. In the details pane the server certificate is displayed with the following properties.
10. In the details pane, in **Issued to**, the certificate name has the format *ComputerName*.*DomainName*. For example, if your computer name is MUX1 and your domain name is corp.contoso.com, the certificate is named **MUX1.corp.contoso.com**.
11. In the details pane, in **Issued By**, the issued by name has the format *DomainNETBiosName*\-*CertificationAuthorityName*\-CA. For example, if your CA name is CA1 and your domain name is corp.contoso.com, the issued by name is **corp\-CA1\-CA**.
12. In the details pane, in **Intended Purposes**, it reads **Server Authentication**.

You can also double\-click the certificate to inspect additional properties, such as validity period, Enhanced Key Usage values, and CRL distribution point - which will include the URL to the share on your Web server.

If the server certificate is not displayed in the MMC, rebooting the server is recommended. After reboot, repeat this procedure to view the certificate.

After reboot, if the server certificate is not present in the MMC, verify that you added the server to the appropriate group in Active Directory.

If no servers autoenrolled a certificate after Group Policy refresh or reboot, verify the configuration of the certificate template and of autoenrollment in Group Policy.


## Verify Network Policy Server (NPS) enrollment of a server certificate

Because NPS is used to authenticate and authorize network connection requests, it is important to ensure that the server certificate you have issued to NPS servers is valid when used in network policies.

To verify that a server certificate is correctly configured and is enrolled to the NPS server, you must configure a test network policy and allow NPS to verify that NPS can use the certificate for authentication.

### To verify NPS server enrollment of a server certificate

1.  In Server Manager, click **Tools**, and then click **Network Policy Server**. The Network Policy Server Microsoft Management Console \(MMC\) opens.

2.  Double\-click **Policies**, right\-click **Network Policies**, and click **New**. The New Network Policy wizard opens.

3.  In **Specify Network Policy Name and Connection Type**, in **Policy name**, type **Test policy**. Ensure that **Type of network access server** has the value **Unspecified**, and then click **Next**.

4.  In **Specify Conditions**, click **Add**. In **Select condition**, click **Windows Groups**, and then click **Add**.

5.  In **Groups**, click **Add Groups**. In **Select Group**, type **Domain Users**, and then press ENTER. Click **OK**, and then click **Next**.

6.  In **Specify Access Permission**, ensure that **Access granted** is selected, and then click **Next**.

7.  In **Configure Authentication Methods**, click **Add**. In **Add EAP**, click **Microsoft: Protected EAP \(PEAP\)**, and then click **OK**. In **EAP Types**, select **Microsoft: Protected EAP \(PEAP\)**, and then click **Edit**. The **Edit Protected EAP Properties** dialog box opens.

8.  In the **Edit Protected EAP Properties** dialog box, in **Certificate issued to**, NPS displays the name of your server certificate in the format *ComputerName*.*Domain*. For example, if your NPS server is named NPS\-01 and your domain is example.com, NPS displays the certificate **NPS\-01.example.com**. In addition, in **Issuer**, the name of your certification authority is displayed, and in **Expiration date**, the date of expiration of the server certificate is shown. This demonstrates that your NPS server has enrolled a valid server certificate that it can use to prove its identity to client computers that are trying to access the network through your network access servers, such as virtual private network \(VPN\) servers, 802.1X\-capable wireless access points, Remote Desktop Gateway servers, and 802.1X\-capable Ethernet switches.

    > [!IMPORTANT]
    > If NPS does not display a valid server certificate and if it provides the message that such a certificate cannot be found on the local computer, there are two possible reasons for this problem. It is possible that Group Policy did not refresh properly, and the NPS server has not enrolled a certificate from the CA. In this circumstance, restart the NPS server. When the computer restarts, Group Policy is refreshed, and you can perform this procedure again to verify that the server certificate is enrolled. If refreshing Group Policy does not resolve this issue, either the certificate template, certificate autoenrollment, or both are not configured correctly. To resolve these issues, start at the beginning of this guide and perform all steps again to ensure that the settings that you have provided are accurate.

9. When you have verified the presence of a valid server certificate, you can click **OK** and **Cancel** to exit the New Network Policy wizard.

    > [!NOTE]
    > Because you are not completing the wizard, the test network policy is not created in NPS.


