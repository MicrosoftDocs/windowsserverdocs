---
title: Realm Names
description: This topic provides an overview of using realm names in Network Policy Server connection request processing in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: d011eaad-f72a-4a83-8099-8589c4ee8994
ms.author: lizross 
author: eross-msft
---

# Realm Names

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016


You can use this topic for an overview of using realm names in Network Policy Server connection request processing.

The User-Name RADIUS attribute is a character string that typically contains a user account location and a user account name. The user account location is also called the realm or realm name, and is synonymous with the concept of domain, including DNS domains, Active Directory® domains, and Windows NT 4.0 domains. For example, if a user account is located in the user accounts database for a domain named example.com, then example.com is the realm name.

In another example, if the User-Name RADIUS attribute contains the user name user1@example.com, user1 is the user account name and example.com is the realm name. Realm names can be presented in the user name as a prefix or as a suffix:

- **Example\user1**. In this example, the realm name **Example** is a prefix; and it is also the name of an Active Directory&reg; Domain Services \(AD DS\) domain.

- <strong>user1@example.com</strong>. In this example, the realm name **example.com** is a suffix; and it is either a DNS domain name or the name of an AD DS domain.

You can use realm names configured in connection request policies while designing and deploying your RADIUS infrastructure to ensure that connection requests are routed from RADIUS clients, also called network access servers, to RADIUS servers that can authenticate and authorize the connection request.

When NPS is configured as a RADIUS server with the default connection request policy, NPS processes connection requests for the domain in which the NPS is a member and for trusted domains.

To configure NPS to act as a RADIUS proxy and forward connection requests to untrusted domains, you must create a new connection request policy. In the new connection request policy, you must configure the User Name attribute with the realm name that will be contained in the User-Name attribute of connection requests that you want to forward. You must also configure the connection request policy with a remote RADIUS server group. The connection request policy allows NPS to calculate which connection requests to forward to the remote RADIUS server group based on the realm portion of the User-Name attribute.

## Acquiring the realm name

The realm name portion of the user name is provided when the user types password-based credentials during a connection attempt or when a Connection Manager (CM) profile on the user's computer is configured to provide the realm name automatically.

You can designate that users of your network provide their realm name when typing their credentials during network connection attempts.

For example, you can require users to type their user name, including the user account name and the realm name, in **User name** in the **Connect** dialog box when making a dial-up or virtual private network (VPN) connection.

In addition, if you create a custom dialing package with the Connection Manager Administration Kit (CMAK), you can assist users by adding the realm name automatically to the user account name in CM profiles that are installed on users' computers. For example, you can specify a realm name and user name syntax in the CM profile so that the user only has to specify the user account name when typing credentials. In this circumstance, the user does not need to know or remember the domain where their user account is located.

During the authentication process, after users type their password-based credentials, the user name is passed from the access client to the network access server. The network access server constructs a connection request and includes the realm name within the User-Name RADIUS attribute in the Access-Request message that is sent to the RADIUS proxy or server.

If the RADIUS server is an NPS, the Access-Request message is evaluated against the set of configured connection request policies. Conditions on the connection request policy can include the specification of the contents of the User-Name attribute.

You can configure a set of connection request policies that are specific to the realm name within the User-Name attribute of incoming messages. This allows you to create routing rules that forward RADIUS messages with a specific realm name to a specific set of RADIUS servers when NPS is used as a RADIUS proxy.

## Attribute manipulation rules

Before the RADIUS message is either processed locally (when NPS is being used as a RADIUS server) or forwarded to another RADIUS server (when NPS is being used as a RADIUS proxy), the User-Name attribute in the message can be modified by attribute manipulation rules. You can configure attribute manipulation rules for the User-Name attribute by selecting **User name** on the **Conditions** tab in the properties of a connection request policy. NPS attribute manipulation rules use regular expression syntax.

You can configure attribute manipulation rules for the User-Name attribute to change the following:

- Remove the realm name from the user name \(also known as realm stripping\). For example, the user name user1@example.com is changed to user1.

- Change the realm name but not its syntax. For example, the user name user1@example.com is changed to user1@wcoast.example.com.

- Change the syntax of the realm name. For example, the user name example\user1 is changed to user1@example.com.

After the User-Name attribute is modified according to the attribute manipulation rules that you configure, additional settings of the first matching connection request policy are used to determine whether:

- The NPS processes the Access-Request message locally (when NPS is being used as a RADIUS server).

- The NPS forwards the message to another RADIUS server (when NPS is being used as a RADIUS proxy).

## Configuring the NPS-supplied domain name

When the user name does not contain a domain name, NPS supplies one. By default, the NPS-supplied domain name is the domain of which the NPS is a member. You can specify the NPS-supplied domain name through the following registry setting:

    
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\RasMan\PPP\ControlProtocols\BuiltIn\DefaultDomain
    

>[!CAUTION]
>Incorrectly editing the registry can severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

Some non-Microsoft network access servers delete or modify the domain name as specified by the user. As the result, the network access request is authenticated against the default domain, which might not be the domain for the user's account. To resolve this problem, configure your RADIUS servers to change the user name into the correct format with the accurate domain name.
