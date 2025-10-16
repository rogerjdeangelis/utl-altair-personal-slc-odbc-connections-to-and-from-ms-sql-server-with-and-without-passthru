# utl-altair-personal-slc-odbc-connections-to-and-from-ms-sql-server-with-and-without-passthru
Altair personal slc odbc connections to and from ms sql server with and without passthru
    %let pgm=utl-altair-personal-slc-odbc-connections-to-and-from-ms-sql-server-with-and-without-passthru;

    Altair personal slc odbc connections to and from ms sql server with and without passthru

    Too Long to post here, see git hub

       TWO SOLUTION

           1 without passthru (explicit-execute using sas language)
           2 with passthru (implicit - execute using sql server sql dialect inside the sql server database)

    github
    https://github.com/rogerjdeangelis/utl-altair-personal-slc-odbc-connections-to-and-from-ms-sql-server-with-and-without-passthru

    PREP

    1 Download the Developer Version of SQL Server and SSMS  Sql Server Management Studio
    2 Create use sa and password
    3 Create empty database db
    4 Download northwinds database
    5 Select database and run northwinds build sql script
    6 Create dsn sql17 using windows 64 bit odbc administator

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    ods listing;
    data class;
      input
        name$
        sex$ age;
    cards4;
    Alfred  M 14
    Alice   F 13
    Barbara F 13
    Carol   F 14
    Henry   M 14
    James   M 12
    ;;;;
    run;quit;

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    375      data class;
    6376        input
    6377          name$
    6378          sex$ age;
    6379      cards4;

    NOTE: Data set "WORK.class" has 6 observation(s) and 3 variable(s)
    NOTE: The data step took :
          real time : 0.005
          cpu time  : 0.000


    6380      Alfred  M 14
    6381      Alice   F 13
    6382      Barbara F 13
    6383      Carol   F 14
    6384      Henry   M 14
    6385      James   M 12
    6386      ;;;;
    6387      run;quit;


    /*           _ _   _                 _                        _   _
    / |__      _(_) |_| |__   ___  _   _| |_  _ __   __ _ ___ ___| |_| |__  _ __ _   _
    | |\ \ /\ / / | __| `_ \ / _ \| | | | __|| `_ \ / _` / __/ __| __| `_ \| `__| | | |
    | | \ V  V /| | |_| | | | (_) | |_| | |_ | |_) | (_| \__ \__ \ |_| | | | |  | |_| |
    |_|  \_/\_/ |_|\__|_| |_|\___/ \__,_|\__|| .__/ \__,_|___/___/\__|_| |_|_|   \__,_|
                                             |_|
                         _         _        _     _        _             _ _
      ___ _ __ ___  __ _| |_ ___  | |_ __ _| |__ | | ___  (_)_ __     __| | |__
     / __| `__/ _ \/ _` | __/ _ \ | __/ _` | `_ \| |/ _ \ | | `_ \   / _` | `_ \
    | (__| | |  __/ (_| | ||  __/ | || (_| | |_) | |  __/ | | | | | | (_| | |_) |
     \___|_|  \___|\__,_|\__\___|  \__\__,_|_.__/|_|\___| |_|_| |_|  \__,_|_.__/

    */

    libname db sqlserver
     server   = "localhost"
     user     = "sa"
     password = "Sas2@rlx"
     database = 'db'
     dsn      = "sql17"
     ;

    /* this creates table males in sql server database db ---*/
    ods listing;


    proc sql;
      drop table db.males
    ;quit;

    proc sql;
      create
         table db.males as
      select
         *
      from
         class
      where
         sex="M"
    ;quit;

    /*--- print database db males ---*/
    proc print data= db.males;
    run;quit;

    OUTPUT

    sql server table db.males

    Obs    NAME        SEX         AGE

     1     Alfred      M            14
     2     Henry       M            14
     3     James       M            12

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    5488
    5489      libname db sqlserver
    5490       server   = "localhost"
    5491       user     = "sa"
    5492       password = XXXXXXXXXX
    5493       database = 'db'
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: Library db assigned as follows:
          Engine:        SQLSERVER
          Physical Name: sql17 (Microsoft SQL Server version 16.00.1000)

    5494       dsn      = "sql17"
    5495       ;
    5496
    5497      /* this creates table males in sql server database db ---*/
    5498      ods listing;
    5499
    5500
    5501      proc sql;
    5502        drop table db.males
    5503      ;quit;
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: Table DB.males has been dropped.
    NOTE: Procedure sql step took :
          real time : 0.080
          cpu time  : 0.015


    5504
    5505      proc sql;
    5506        create
    5507           table db.males as
    5508        select
    5509           *
    5510        from
    5511           class
    5512        where
    5513           sex="M"
    5514      ;quit;
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: Data set "DB.males" has an unknown number of observation(s) and 3 variable(s)
    NOTE: Procedure sql step took :
          real time : 0.397
          cpu time  : 0.093


    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    5515
    5516      /*--- print database db males ---*/
    5517      proc print data= db.males;
    5518      run;quit;
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: 3 observations were read from "DB.males"
    NOTE: Procedure print step took :
          real time : 0.338
          cpu time  : 0.093

    /*                   _             _        _        _     _        __                           _ _
      ___ _ __ ___  __ _| |_ ___   ___| | ___  | |_ __ _| |__ | | ___  / _|_ __ ___  _ __ ___     __| | |__
     / __| `__/ _ \/ _` | __/ _ \ / __| |/ __| | __/ _` | `_ \| |/ _ \| |_| `__/ _ \| `_ ` _ \   / _` | `_ \
    | (__| | |  __/ (_| | ||  __/ \__ \ | (__  | || (_| | |_) | |  __/|  _| | | (_) | | | | | | | (_| | |_) |
     \___|_|  \___|\__,_|\__\___| |___/_|\___|  \__\__,_|_.__/|_|\___||_| |_|  \___/|_| |_| |_|  \__,_|_.__/

    */

    proc sql;
      create
         table males_from_db as
      select
         *
      from
         db.males
      where
         sex="M"
    ;quit;

    proc print data=males_from_db;
    run;quit;

    OUTPUT

    work.males_from_db

    Obs    NAME        SEX         AGE

     1     Alfred      M            14
     2     Henry       M            14
     3     James       M            12

    /*___             _ _   _                          _   _                           _
    |___ \  __      _(_) |_| |__   _ __   __ _ ___ ___| |_| |__  _ __ ___  _   _  __ _| |__
      __) | \ \ /\ / / | __| `_ \ | `_ \ / _` / __/ __| __| `_ \| `__/ _ \| | | |/ _` | `_ \
     / __/   \ V  V /| | |_| | | || |_) | (_| \__ \__ \ |_| | | | | | (_) | |_| | (_| | | | |
    |_____|   \_/\_/ |_|\__|_| |_|| .__/ \__,_|___/___/\__|_| |_|_|  \___/ \__,_|\__, |_| |_|
                                  |_|                                            |___/
                         _         _        _     _        _             _ _
      ___ _ __ ___  __ _| |_ ___  | |_ __ _| |__ | | ___  (_)_ __     __| | |__
     / __| `__/ _ \/ _` | __/ _ \ | __/ _` | `_ \| |/ _ \ | | `_ \   / _` | `_ \
    | (__| | |  __/ (_| | ||  __/ | || (_| | |_) | |  __/ | | | | | | (_| | |_) |
     \___|_|  \___|\__,_|\__\___|  \__\__,_|_.__/|_|\___| |_|_| |_|  \__,_|_.__/

    */

    /*--- filter table inside sql server with sql server sql dialect ---*/
    /*--- output to a SLC wpd table                                  ---*/
    proc sql;
      connect to sqlserver (dsn="sql17" database="db" user="sa" password="Sas2@rlx");
      create table tst as (
      select * from connection to sqlserver
        (select * from db.dbo.Orders where ShipVia=1));
      disconnect from sqlserver;
    quit;

    proc print data=tst(obs=5)  width=min;
      var orderid customerid ShipVia;
    run;quit;


    OUTPUT

    SLC TAble from sql server db database

    Obs        ORDERID    CUSTOMERID        SHIPVIA

     1           10249      TOMSP                 1
     2           10251      VICTE                 1
     3           10258      ERNSH                 1
     4           10260      OTTIK                 1
     5           10265      BLONP                 1

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    6364      proc sql;
    6365        connect to sqlserver (dsn="sql17" database="db" user="sa" password=XXXXXXXXXX);
    NOTE: DSN option is used; DRIVER, SERVER, PORT and DATABASE options are ignored.
    NOTE: Connected to DB: sql17 (Microsoft SQL Server version 16.00.1000)
    NOTE: Successfully connected to database SQLSERVER as alias SQLSERVER.
    6366        create table tst as (
    6367        select * from connection to sqlserver
    6368          (select * from db.dbo.Orders where ShipVia=1));
    NOTE: Data set "WORK.tst" has 249 observation(s) and 14 variable(s)
    6369        disconnect from sqlserver;
    NOTE: Successfully disconnected from database SQLSERVER.
    6370      quit;
    NOTE: Procedure sql step took :
          real time : 0.204
          cpu time  : 0.078


    6371
    6372      proc print data=tst(obs=5)  width=min;
    6373        var orderid customerid ShipVia;
    6374      run;quit;
    NOTE: 5 observations were read from "WORK.tst"
    NOTE: Procedure print step took :
          real time : 0.016
          cpu time  : 0.000

     /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */




































































































































































































































































































































































/*                    _             _                          _   _        _     _
  ___ _ __ ___  __ _| |_ ___   ___| | ___ __      ___ __   __| | | |_ __ _| |__ | | ___
 / __| `__/ _ \/ _` | __/ _ \ / __| |/ __|\ \ /\ / / `_ \ / _` | | __/ _` | `_ \| |/ _ \
| (__| | |  __/ (_| | ||  __/ \__ \ | (__  \ V  V /| |_) | (_| | | || (_| | |_) | |  __/
 \___|_|  \___|\__,_|\__\___| |___/_|\___|  \_/\_/ | .__/ \__,_|  \__\__,_|_.__/|_|\___|
                                                   |_|
*/

/*--- create slc table from sqlserver table db.customers ---*/
proc sql;
  create
    table slc_customers as
  select
    *
  from
    exdb.customers
;quit;

proc print data=slc_customers width=min;
run;quit;

/*___             _ _   _                           _   _
|___ \  __      _(_) |_| |__    _ __   __ _ ___ ___| |_| |__  _ __ _   _
  __) | \ \ /\ / / | __| `_ \  | `_ \ / _` / __/ __| __| `_ \| `__| | | |
 / __/   \ V  V /| | |_| | | | | |_) | (_| \__ \__ \ |_| | | | |  | |_| |
|_____|   \_/\_/ |_|\__|_| |_| | .__/ \__,_|___/___/\__|_| |_|_|   \__,_|
                               |_|
*/



proc sql;
  connect to sqlserver (dsn='sql17' user='sa' password='Sas2@rlx' database='db');
  create
     table
        oeders_1 as
     Select
        *
     from
       connection to sqlserver
        (select
           *
         from
           employees
         where
           EmployeeID = 1);
       disconnect
         from sqlserver;
;quit;

proc print data=orders_1 width=min;
run;quit;


proc sql;
  connect to sqlserver (dsn='dql17file');
  create
     table
        orders_1 as
     Select
        *
     from
       connection to sqlserver
        (select
           *
         from
           Employees
         where
           EmployeeID = 1);
       disconnect
         from sqlserver;
;quit;


proc sql;
  connect to sqlserver (dsn='sql17file' user='sa' password='Sas2@rlx' database='db');
  create
     table
        orders_1 as
     Select
        *
     from
       connection to sqlserver
        (select
           *
         from
           Employees
         where
           EmployeeID = 1);
       disconnect
         from sqlserver;
;quit;

proc print data=orders_1 width=min;
run;quit;

connect to sqlserver (dsn='sql17' user='sa' password='Sas2@rlx' database='db');
connect to odbc (dsn='sql17' user='sa' password='Sas2@rlx' database='db');
(complete="ODBC Driver 18 for SQL Server";SERVER="localhost";DATABASE="db";UID="sa";PWD="Sas2@rlx")


proc sql;
  connect to odbc (dsn='sql17' user='sa' password='Sas2@rlx' database='db');
  connect to sqlserver (dsn='sql17' user='sa' password='Sas2@rlx' database='db');
  create
     table
        orders_1 as
     Select
        *
     from
       connection to odbc
        (select
           *
         from
           Employees
         where
           EmployeeID = 1);
       disconnect
         from odbc;
;quit;

proc print data=orders_1 width=min;
run;quit;



proc sql;
connect to sqlserver
(complete="ODBC Driver 18 for SQL Server";SERVER="localhost";DATABASE="db";UID="sa";PWD="Sas2@rlx");
  create
     table
        orders_1 as
     Select
        *
     from
       connection to sqlserver
        (select
           *
         from
           employees
         where
           EmployeeID = 1);
       disconnect
         from sqlserver;
;quit;

proc print data=orders_1 width=min;
run;quit;



proc sql;
connect to sqlserver
(complete="ODBC Driver 18 for SQL Server";DATABASE="db";UID="sa";PWD="Sas2@rlx");
  create
     table
        orders_1 as
     Select
        *
     from
       connection to sqlserver
        (select
           *
         from
           employees
         where
           EmployeeID = 1);
       disconnect
         from sqlserver;
;quit;

proc print data=orders_1 width=min;
run;quit;


(complete="ODBC Driver 18 for SQL Server";SERVER="localhost";DATABASE="db";UID="SA";PWD=Sas2@rlx");











ods listing;
LIBNAME ExLib SQLSERVER SERVER="localhost" USER="sa" PASSWORD="Sas2@rlx" database='db' dsn="sql17";
proc print data=exlib.Orders;
run;quit;

















LIBNAME ExLib SQLSERVER SERVER="localhost" USER="sa" PASSWORD="Sas2@rlx" DATABASE='db' DSN="sql17";
proc print data=exlib.Orders;
run;quit;





































proc sql ;
  create



       CurrentDateTime
1 2025-10-15 13:58:10
  OrderID CustomerID EmployeeID  OrderDate RequiredDate ShippedDate
1   10248      VINET          5 1996-07-04   1996-08-01  1996-07-16
2   10249      TOMSP          6 1996-07-05   1996-08-16  1996-07-10
3   10250      HANAR          4 1996-07-08   1996-08-05  1996-07-12
4   10251      VICTE          3 1996-07-08   1996-08-05  1996-07-15
5   10252      SUPRD          4 1996-07-09   1996-08-06  1996-07-11
6   10253      HANAR          3 1996-07-10   1996-07-24  1996-07-16


please provide a reproducible example for connecting to a sql server database using a odbc dsn


please provide a reproducible example using the sas libname engine to connect to a sql server database using a odbc dsn
and database=db

ods listing;
LIBNAME ExLib SQLSERVER SERVER="localhost" USER="sa" PASSWORD="Sas2@rlx" DATABASE='db' DSN="sql17";
proc print data=exlib.Orders;
run;quit;

proc sql ;
  create


data orders_from_sas;


proc r;
submit;
library(DBI)
library(odbc)
# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")
# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")
result
result1 <- dbGetQuery(con, "SELECT * from Orders")
head(result1)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;



proc r;
submit;
library(DBI)
library(odbc)
# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")
# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")
result
result1 <- dbGetQuery(con, "SELECT * from Orders")
head(result1)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;



please use sql server passthrough to create table orders1 from oders using sql server passthrough

proc r;
submit;
library(DBI)
library(odbc)
# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")
# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result1 <- dbGetQuery(con, "SELECT * from Orders")
head(result1)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;




proc sql;
connect to sqlserver as myconn (dsn=sql17file uid=sa pwd="Sas2@rlx" database=db);
execute (
    SELECT OrderID, CustomerID, OrderDate, TotalAmount
    INTO orders1
    FROM Orders
    WHERE OrderDate >= '2023-01-01'
) by myconn;
disconnect from sqlserver;
quit;


proc sql;
connect to sqlserver as myconn (dsn=sql17 uid=sa pwd="Sas2@rlx");
execute (
    SELECT OrderID, CustomerID, OrderDate, TotalAmount
    INTO orders1
    FROM Orders
    WHERE OrderDate >= '2023-01-01'
) by myconn;
disconnect from sqlserver;
quit;































LIBNAME ExLib SQLSERVER SERVER="localhost" USER=sa PASSWORD="Sas2@rlx";


database specific error follows:
DB: 08001: [Microsoft][ODBC Driver 17 for SQL Server]Named Pipes Provider: Could not open a connection to SQL Server [53].
HYT00: [Microsoft][ODBC Driver 17 for SQL Server]Named Pipes Provider: Could not open a connection to SQL Server [53].


on DRIVER= has not been specified; the default value 'ODBC Driver 17 for SQL Server' will be used.
ERROR: A database error occurred. The database specific error follows:
       DB: 28000: [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]Login failed for user 'Roger'.

4514
4515      LIBNAME ExLib SQLSERVER SERVER="localhost" USER="Roger" PASSWORD=XXXXXXXXXX;



NOTE: The connection option DRIVER= has not been specified; the default value 'ODBC Driver 17 for SQL Server' will be used.
ERROR: A database error occurred. The database specific error follows:
       DB: 28000: [Microsoft][ODBC Driver 17 for SQL Server][SQL Server]Login failed for user 'sa'.

4517
4518      LIBNAME ExLib SQLSERVER SERVER="localhost" USER=sa PASSWORD=XXXXXXXXXX;
                  ^
ERROR: Could not connect to DB




        \
ALTER LOGIN sa ENABLE;
GO
ALTER LOGIN sa WITH PASSWORD = 'Sas2@rlx';
GO


C:\Windows\System32>sqlcmd -S localhost -U "sa" -P "xxxxxxx"
Sqlcmd: Error: Microsoft ODBC Driver 17 for SQL Server : Login failed for user 'sa'..




sqlcmd -S localhost -U "sa" -P "Sas2@rlx"

=dbo;
=dbo;

sqlcmd -S localhost -E



/* Define connection to MS SQL Server database using SQL Server ODBC or Native Client */
libname mydblib odbc
   datasrc="YourServerName"   /* server name or IP */
   schema=dbo
   user="sas"                 /* SQL Server login */
   password="YourPassword";   /* SQL Server password */

/* Example SAS dataset to upload */
data work.example;
  input id name $ age;
  datalines;
1 Alice 30
2 Bob 25
3 Carol 27
;
run;

/* Upload SAS dataset to SQL Server */
data mydblib.example;
  set work.example;
run;

/* Check that data was uploaded */
proc sql;
  connect to odbc (datasrc="YourServerName" user="sas" password="YourPassword");
  select * from connection to odbc
    (select * from dbo.example);
  disconnect from odbc;
quit;




libname sqlsrv odbc dsn="C:\Path\To\YourFile.dsn";



text
libname mydblib odbc datasrc="sqlsv1" schema=dbo;






database specific error follows:
DB: IM002: [Microsoft][ODBC Driver Manager] Data source name not found and no default driver specified

4507      libname mydblib odbc datasrc="sqlsv1" schema=dbo;
                  ^




libname mydblib odbc dsn="sqlsrv1" user="sa" password="Sas2@rlx" schema=dbo;




-- Enable the 'sa' login if disabled
ALTER LOGIN sa ENABLE;
GO

ALTER LOGIN sa WITH PASSWORD = 'Sas2@rlx';
GO

EXEC sp_addsrvrolemember 'sa', 'sysadmin';
GO

SELECT name, is_disabled FROM sys.server_principals WHERE name = 'sa';
SELECT IS_SRVROLEMEMBER('sysadmin', 'sa') AS IsSysadmin;
GO


























ods listing;
proc r;
submit;

install.packages(c("odbc", "DBI"))

# Load libraries
library(DBI)
library(odbc)

# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sqlsrv1",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")

# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")

print(result)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;



proc r;
submit;
library(DBI)
library(odbc)
# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")

# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")
result1 <- dbGetQuery(con, "SELECT * from Orders")
head(result1)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;








ods listing;
proc r;
submit;


# Load libraries
library(DBI)
library(odbc)

# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")

# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")

print(result)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;


LIBNAME ExLib SQLSERVER SERVER="localhost" USER="sa" PASSWORD="Sas2@rlx" database='db';

proc r;
submit;
library(DBI)
library(odbc)
# Create a connection to the SQL Server using the DSN
con <- dbConnect(odbc(),
                 dsn = "sql17",
                 uid = "sa",
                 pwd = "Sas2@rlx",
                 database = "db")
# Test the connection with a simple query (for example, retrieve current date/time from SQL Server)
result <- dbGetQuery(con, "SELECT GETDATE() AS CurrentDateTime")
result
result1 <- dbGetQuery(con, "SELECT * from Orders")
head(result1)

# Disconnect when done
dbDisconnect(con)
endsubmit;
run;quit;


       CurrentDateTime
1 2025-10-15 13:58:10
  OrderID CustomerID EmployeeID  OrderDate RequiredDate ShippedDate
1   10248      VINET          5 1996-07-04   1996-08-01  1996-07-16
2   10249      TOMSP          6 1996-07-05   1996-08-16  1996-07-10
3   10250      HANAR          4 1996-07-08   1996-08-05  1996-07-12
4   10251      VICTE          3 1996-07-08   1996-08-05  1996-07-15
5   10252      SUPRD          4 1996-07-09   1996-08-06  1996-07-11
6   10253      HANAR          3 1996-07-10   1996-07-24  1996-07-16


please provide a reproducible example for connecting to a sql server database using a odbc dsn


please provide a reproducible example using the sas libname engine to connect to a sql server database using a odbc dsn
and database=db

ods listing;
LIBNAME ExLib SQLSERVER SERVER="localhost" USER="sa" PASSWORD="Sas2@rlx" database='db' dsn="sql17";
proc print data=exlib.Orders;
run;quit;

proc sql ;
  create


data orders_from_sas;




libname mydblib odbc dsn="sql17" user="sa" password="Sas2@rlx" database="db";
