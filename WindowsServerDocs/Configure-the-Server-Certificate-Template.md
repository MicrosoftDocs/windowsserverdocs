---
title: Configure the Server Certificate Template
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ff610e2-43ca-407f-a828-06d9366e02f0
---
# Configure the Server Certificate Template
You can use this procedure to configure the certificate template that Active Directory® Certificate Services \(AD CS\) uses as the basis for server certificates that are enrolled to servers on your network.

While configuring this template, you can specify the servers by Active Directory group that should automatically receive a server certificate from AD CS. 

The procedure below includes instructions for configuring the template to issue certificates to all of the following server types:

- Software Defined Networking (SDN) servers that are members of a Network Controller Servers group that you created by following previous instructions in this guide.
- SDN servers that are members of a Software Load Balancing Multiplexer (MUX) Servers group that you created by following previous instructions in this guide.
- Servers that are running the Remote Access service, including RAS Gateway servers, that are members of the **RAS and IAS Servers** group.
- Servers that are running the Network Policy Server (NPS) service that are members of the **RAS and IAS Servers** group.

If you are not using SDN, you do not need to configure the template to provide certificates to SDN servers.

>[!NOTE]
>You can modify this procedure to create a certificate template for each type of server to which you are enrolling server certificates, rather than using one template for all server types. This idea is useful only if you want certain types of servers to have a certificate with different properties than certificates that are issued to other types of servers. For example, if you want certificates that are issued to your Network Controller servers to have a longer validity period than those issued to NPS servers, you need to create two certificate templates, one for RAS and IAS Servers, and one for Network Controller servers. To create additional templates for different server types, repeat step 5 - duplicate the RAS and IAS Server template more than one time, ensuring that you give each duplicate a different name. Then configure each template with the corresponding Active Directory group rather than configuring one template with all groups, following all steps in the procedure from step 5 onward for each new template that you create.

Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.

### To configure the certificate template

1.  On CA1, in Server Manager, click **Tools**, and then click **Certification Authority**. The Certification Authority Microsoft Management Console \(MMC\) opens.

2.  In the MMC, double\-click the CA name, right\-click **Certificate Templates**, and then click **Manage**.

3.  The Certificate Templates console opens. All of the certificate templates are displayed in the details pane.

4.  In the details pane, click the **RAS and IAS Server** template.

5.  Click the **Action** menu, and then click **Duplicate Template**. The template **Properties** dialog box opens.

6.  Click the **Security** tab. In **Group or user names**, click **Add**. The **Select Users, Computers, Service Accounts, or Groups** dialog box opens.

7.  In **Select Users, Computers, Service Accounts, or Groups**, in **Enter the object names to select**, type the names for the groups that you created for Software Defined Networking servers, and separate group names with a semicolon (;). For example, if you created a group named Network Controller Servers and a group named Software Load Balancing Servers, type **Network Controller Servers; Software Load Balancing Servers**, and then click OK.

8.  In **Group or user names**, click an SDN server group name. For example, click **Network Controller Servers**.

9.  In **Permissions for Network Controller Servers**, under **Allow**, select the **Enroll** and the **Autoenroll** check boxes. Click **Apply**.

10. Repeat the previous two steps for any additional SDN groups that you created.

6.  On the **Security** tab, in **Group or user names**, click **RAS and IAS servers**.

7.  In **Permissions for RAS and IAS servers**, under **Allow**, ensure that **Enroll** is selected, and then select the **Autoenroll** check box. Click **OK**, and close the Certificate Templates MMC.

8.  In the Certification Authority MMC, click **Certificate Templates**. On the **Action** menu, point to **New**, and then click **Certificate Template to Issue**. The **Enable Certificate Templates** dialog box opens.

9. In **Enable Certificate Templates**, click the name of the certificate template that you just configured, and then click **OK**. For example, if you did not change the default certificate template name, click **Copy of RAS and IAS Server**, and then click **OK**.


