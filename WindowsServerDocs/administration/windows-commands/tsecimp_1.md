---
title: tsecimp_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7488ec6-0eff-45ff-89ee-9cbe752416bf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# tsecimp_1

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

imports assignment information from an Extensible Markup Language (XML) file into the TAPI server security file (Tsec.ini). You can also use this command to display the list of TAPI providers and the lines devices associated with each of them, validate the structure of the XML file without importing the contents, and check domain membership.  
## Syntax  
```  
tsecimp /f <Filename> [{/v | /u}]  
tsecimp /d  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|/f <Filename>|Required. Specifies the name of the XML file that contains the assignment information that you want to import.|  
|/v|Validates the structure of the XML file without importing the information into the Tsec.ini file.|  
|/u|Checks whether each user is a member of the domain specified in the XML file. The computer on which you use this parameter must be connected to the network. This parameter might significantly slow performance if you are processing a large amount of user assignment information.|  
|/d|Displays a list of installed telephony providers. For each telephony provider, the associated line devices are listed, as well as the addresses and users associated with each line device.|  
|/?|Displays help at the command prompt.|  
### remarks  
-   The XML file from which you want to import assignment information must follow the structure described below.  
    -   **Userlist** element  
        The **Userlist** is the top element of the XML file.  
    -   **User** element  
        Each **User** element contains information about a user who is a member of a domain. Each user might be assigned one or more line devices.  
        additionally, each **User** element might have an attribute named **NoMerge**. When this attribute is specified, all current line device assignments for the user are removed before new ones are made. You can use this attribute to easily remove unwanted user assignments. By default, this attribute is not set.  
        The **User** element must contain a single **DomainuserName** element, which specifies the domain and user name of the user. The **User** element might also contain one **FriendlyName** element, which specifies a friendly name for the user.  
        The **User** element might contain one **Linelist** element. If a **Linelist** element is not present, all line devices for this user are removed.  
    -   **Linelist** element  
        The **Linelist** element contains information about each line or device that  might be assigned to the user. Each **Linelist** element can contain more than one **Line** element.  
    -   **Line** element  
        Each **Line** element specifies a line device. You must identify each line device by adding either an **address** element or a **PermanentID** element under the **Line** element.  
        for each **Line** element, you can set the **remove** attribute. If you set this attribute, the user is no longer assigned that line device. If this attribute is not set, the user gains access to that line device. No error is given if the line device is not available to the user.  
-   The following sample XML code segments illustrate correct usage of the elements defined above.  
    -   The following code removes all line devices assigned to User1.  
        ```  
        <Userlist>  
          <User NoMerge="1">  
            <Domainuser>domain1\user1</Domainuser>  
          </User>  
        </Userlist>  
        ```  
    -   The following code removes all line devices assigned to User1 before assigning one line with address 99999. User1 will have no other lines devices assigned, regardless of whether any line devices were assigned previously.  
        ```  
        <Userlist>  
          <User NoMerge="1">  
            <Domainuser>domain1\user1</Domainuser>  
            <FriendlyName>User1</FriendlyName>  
            <Linelist>  
              <Line>  
                <address>99999</address>  
              </Line>  
            </Linelist>  
          </User>  
        </Userlist>  
        ```  
    -   The following code adds one line device for User1 without deleting any previously assigned line devices.  
        ```  
        <Userlist>  
          <User>  
            <Domainuser>domain1\user1</Domainuser>  
            <FriendlyName>User1</FriendlyName>  
            <Linelist>  
              <Line>  
                <address>99999</address>  
              </Line>  
            </Linelist>  
          </User>  
        </Userlist>  
        ```  
    -   The following code adds line address 99999 and removes line address 88888 from User1's access.  
        ```  
        <Userlist>  
          <User>  
            <Domainuser>domain1\user1</Domainuser>  
            <FriendlyName>User1</FriendlyName>  
            <Linelist>  
              <Line>  
                <address>99999</address>  
              </Line>  
              <Line remove="1">  
                <address>88888</address>  
              </Line>  
            </Linelist>  
          </User>  
        </Userlist>  
        ```  
    -   The following code adds permanent device 1000 and removes line 88888 from User1's access.  
        ```  
        <Userlist>  
          <User>  
            <Domainuser>domain1\user1</Domainuser>  
            <FriendlyName>User1</FriendlyName>  
            <Linelist>  
              <Line>  
                <PermanentID>1000</PermanentID>  
              </Line>  
              <Line remove="1">  
                <address>88888</address>  
              </Line>  
            </Linelist>  
          </User>  
        </Userlist>  
        ```  
-   The following sample output appears after the **/d** command-line option is specified to display the current TAPI configuration. For each telephony provider, the associated line devices are listed, as well as the addresses and users associated with each line device.  
    ```  
    NDIS Proxy TAPI Service Provider  
            Line: "WAN Miniport (L2TP)"  
                    Permanent ID: 12345678910  
    NDIS Proxy TAPI Service Provider  
            Line: "LPT1DOMAIN1\User1"  
                    Permanent ID: 12345678910  
    Microsoft H.323 Telephony Service Provider  
            Line: "H323 Line"  
                    Permanent ID: 123456  
                    addresses:  
                            BLDG1-TAPI32  
    ```  
### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
[Command shell overview](https://technet.microsoft.com/library/cc737438(v=ws.10).aspx)  
