---
title: Configure the SQL Database for IPAM
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e040e462-8cb3-45ff-9624-957714e1df22
---
# Configure the SQL Database for IPAM
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > **Configure the SQL Database for IPAM**  
  
> [!IMPORTANT]  
> External database support is introduced in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], enabling you to choose Windows Internal Database \(WID\) or a Microsoft SQL database. This option is not available in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. Skip this procedure if your IPAM server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Configuration of the SQL database for IPAM differs if IPAM is running on the same computer with SQL Server. Steps are also different depending on whether you use Windows authentication or SQL authentication.  
  
Choose one of the four following procedures to configure the IPAM database on Microsoft SQL Server 2008 or later.  
  
-   Database configuration with SQL and IPAM on separate computers:  
  
    -   [To use Windows authentication](#bkmk_W1)  
  
    -   [To use SQL authentication](#bkmk_S1)  
  
-   Database configuration with SQL and IPAM on the same computer:  
  
    -   [To use Windows authentication](#bkmk_W2)  
  
    -   [To use SQL authentication](#bkmk_S2)  
  
> [!TIP]  
> In the Provision IPAM wizard, **IPAM server credentials** refers to using Windows authentication. If you select IPAM server credentials, then perform the procedure to configure Windows authentication.  
  
Substitute names and values that are appropriate for your environment for the placeholder values that are used in the following procedures. These values are described in the following table.  
  
|Value|Description|  
|---------|---------------|  
|contoso\\IPAM1$|Domain and computer account of the IPAM server<br /><br />This is the login domain and computer account name of the IPAM server. The computer account name is its host name terminated with the “$” character.|  
|IPAM\_DB|Name of the IPAM database<br /><br />This must match the name provided when you specify the IPAM database.|  
|ipamuser|SQL authentication login name<br /><br />This is the user name of the user designated to have database owner permissions in SQL Server. This name must be configured on the SQL server and the same name must be used when the IPAM server is provisioned.|  
|P@ssword1|Password for the IPAM user<br /><br />This is the SQL database password for the IPAM user. This does not need to be the same password as the user’s Windows password.|  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Database configuration with SQL and IPAM on separate computers  
Use one of the following procedures on a computer running Microsoft SQL Server 2008 or later to configure the SQL database for a connection to IPAM on a separate computer.  
  
### <a name="bkmk_W1"></a>To use Windows authentication  
  
1.  To use the SQLCMD utility to enter Transact\-SQL statements, open an elevated command prompt and type **SQLCMD**.  
  
2.  Type the following commands at the SQLCMD prompt:  
  
    ```  
    CREATE LOGIN [contoso\IPAM1$] FROM WINDOWS   
    CREATE DATABASE IPAM_DB   
    GO   
    USE IPAM_DB   
    CREATE USER IPAM FOR LOGIN [contoso\IPAM1$]   
    ALTER ROLE DB_OWNER ADD MEMBER IPAM   
    USE MASTER   
    GRANT VIEW ANY DEFINITION TO [contoso\IPAM1$]  
    ```  
  
3.  Type **exit** to quit the SQLCMD prompt.  
  
### <a name="bkmk_S1"></a>To use SQL authentication  
  
1.  To use the SQLCMD utility to enter Transact\-SQL statements, open an  elevated command prompt and type **SQLCMD**.  
  
2.  Type the following commands at the SQLCMD prompt:  
  
    ```  
    CREATE LOGIN ipamuser WITH PASSWORD = 'P@ssword1'  
    CREATE DATABASE IPAM_DB   
    GO  
    USE IPAM_DB   
    CREATE USER IPAM FOR LOGIN ipamuser    
    ALTER ROLE DB_OWNER ADD MEMBER IPAM  
    GO  
    USE MASTER   
    GRANT VIEW ANY DEFINITION TO ipamuser  
    GO  
    ```  
  
3.  Type **exit** to quit the SQLCMD prompt.  
  
> [!TIP]  
> If a connection to the database fails due to invalid login, verify that the SQL server is enabled for SQL authentication.  
  
## Database configuration with SQL and IPAM on the same computer  
Use one of the following procedures to configure the SQL database for a connection to IPAM on the same computer.  
  
### <a name="bkmk_W2"></a>To use Windows authentication  
  
1.  To use the SQLCMD utility to enter Transact\-SQL statements, open an elevated command prompt and type **SQLCMD**.  
  
2.  Type the following commands at the SQLCMD prompt:  
  
    ```  
    CREATE LOGIN [NT AUTHORITY\Network Service] FROM WINDOWS   
    CREATE DATABASE IPAM_DB   
    GO   
    USE IPAM_DB   
    CREATE USER IPAM FOR LOGIN [NT AUTHORITY\Network Service]   
    ALTER ROLE DB_OWNER ADD MEMBER IPAM   
    GO  
    USE MASTER   
    GRANT VIEW ANY DEFINITION TO [NT AUTHORITY\Network Service]  
    GO  
    ```  
  
3.  Type **exit** to quit the SQLCMD prompt.  
  
### <a name="bkmk_S2"></a>To use SQL authentication  
  
1.  To use the SQLCMD utility to enter Transact\-SQL statements, open an elevated command prompt and type **SQLCMD**.  
  
2.  Type the following commands at the SQLCMD prompt:  
  
    ```  
    CREATE LOGIN ipamuser WITH PASSWORD = 'P@ssword1'   
    CREATE DATABASE IPAM_DB   
    GO  
    USE IPAM_DB   
    CREATE USER IPAM FOR LOGIN ipamuser    
    ALTER ROLE DB_OWNER ADD MEMBER IPAM  
    GO  
    USE MASTER   
    GRANT VIEW ANY DEFINITION TO ipamuser  
    GO  
    ```  
  
3.  Type **exit** to quit the SQLCMD prompt.  
  
## See also  
[Specify the IPAM Database](../Topic/Specify-the-IPAM-Database.md)  
  
