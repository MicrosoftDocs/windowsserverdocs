---
title: Add RD Web and Gateway server to the RDS deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac7e1cf8-b63f-4a3b-92ef-56dc8512f7db
author: Lizap
---
# Add RD Web and Gateway server to the RDS deployment
Use the following steps to add the RD Web and Gateway server you created to your existing Remote Desktop Services basic deployment.

1.	Create a public IP address for the virtual machine running Remote Desktop Management Services (RDMS). The RDMS virtual machine is usually the virtual machine running the first instance of the RD Connection Broker role. Note that this step is not necessary if the RDMS virtual machine already has a public IP address to allow RDP connections.
    1. In the Azure portal, click **Browse > Virtual Machines**, and then click the RDMS virtual machine (for example, Contoso-CB1).
    2. Click **Settings > Network interfaces**, and then click the corresponding network interface. 
    3. Click **Settings > IP address**. 
    4. For **Public IP address**, select **Enabled**, and then click **IP address**. 
    5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**. 
2.	Connect to the RDMS virtual machine:
    1.	In the Azure portal click **Browse > Virtual Machines**.
    2.	Select the new RDMS virtual machine (for example, Contoso-CB1).
    3.	Click **Connect > Open** to open the Remote Desktop client.
    4.	In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for a user in the Azure AD DC Administrators group.
    5.	Click **Yes** when warned about the certificate.
3.	Add the new RD Web and Gateway server to Server Manager:
    1. Launch Server Manager, click **Manage > Add Servers**. 
    2. In the Add Servers dialog, click **DNS**. 
    3. Browse to and select the newly created RD Session Host server, e.g. Contoso-WebGw2. 
    4. Click **OK**.
 4.	Add RD Web and Gateway servers to the deployment
    1. Launch Server Manager .
    2. Click **Remote Desktop Services > Overview > Deployment Servers > Tasks > Add RD Web Access Servers**. 
    3. Select the newly created server (for example, Contoso-WebGw2), and then click **Next**.
    4. On the Confirmation page, select **Restart remote computers as needed**, and then click **Add**.
    5. Repeat these steps to add the RD Gateway server, but choose **RD Gateway Servers** in step b.

5.	Add the RD Gateway servers to a farm
a.	From Server Manager on the RDMS server, select All Servers, right click one of the RD Gateway servers and select Remote Desktop Connection
b.	Logon to the RD Gateway server using a domain admin account
c.	From Server Manager on the RD Gateway server, select Tools, Terminal Services, and RD Gateway Manager
d.	In the RD Gateway Manager’s left pane, select the Local computer (e.g. Contoso-WebGw1)
e.	In the RD Gateway Manager’s center pane, select Add RD Gateway Server Farm members
f.	In the Gateway properties dialog, select the Server Farm tab, enter the name of each RD Gateway server, then select Add and Apply
g.	Repeat steps a. through f. for each RD Gateway server

7.	Add the RD Web Access servers to a farm
The steps below configure the Validation and Decryption Machine Keys to be the same on both RDWeb sites.
a.	From Server Manager on the RDMS server, select All Servers, right click the first RD Web Access server, e.g. Contoso-WebGw1, and select Remote Desktop Connection
b.	Logon to the RD Web Access server using a Domain Admin account
c.	From Server Manager on the RD Web Access server, select Tools, Terminal Services, and Internet Information Services (IIS) Manager
d.	In the IIS Manager’s left pane, expand the local computer (e.g. Contoso-WebGw1), Sites, and Default Web Site and then select RDWeb
e.	In the IIS Manager’s center pane, right click Machine Key and select Open Feature
f.	On the Machine Key page, go to the Actions pane, then select Generate Keys and Apply
g.	Double click the Validation Key field, right click and select Copy
h.	Minimize the RD Connection window to this RD Web server
i.	Repeat steps b. through e. for the second RD Web Access server
j.	For the Validation Key, uncheck the box Automatically generate at runtime, double click the Validation Key field, right click, and select Paste.
k.	Under Actions, select Apply
l.	Minimize the RD Connection window to the second RD Web Access server 
m.	Maximize the RD Connection window to the first RD Web Access server
n.	Repeat steps g. through k. for the Decryption Key
o.	After the Validation Key and Decryption Key are identical on both RD Web Access servers, sign out of all RD Connection windows to the RD Web Access servers
8.	Re-install certificates for the RD Gateway servers
a.	From Server Manager on the RDMS server, select Remote Desktop Services, Overview, Tasks and Edit Deployment Properties
b.	In the Deployment Properties dialog and expand Certificates
c.	Scroll down to the table and select the RD Gateway Role Service and Select existing certificate…
d.	In the Select Existing Certificate dialog, select Choose a different certificate and Browse…
e.	In the Open dialog, navigate to the location of the certificates (e.g. \\Contoso-CB1\Certificates), select the certificate file for the RD Web and Gateway server created during the prerequisites (e.g. ContosoRdGwCert) and select Open
f.	Enter the Password for the certificate, check the box labeled Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers, and select OK.
g.	In the Deployment Properties dialog select Apply.
h.	Wait for the certificate to be successfully applied to the RD Gateway server.
i.	Repeat steps c. through h. for the RD Web Access Role Service.


