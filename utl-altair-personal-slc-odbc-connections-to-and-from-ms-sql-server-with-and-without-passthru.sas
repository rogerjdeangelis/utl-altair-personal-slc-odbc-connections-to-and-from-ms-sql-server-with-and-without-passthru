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
 password = "xxxxxxxx"
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
  connect to sqlserver (dsn="sql17" database="db" user="sa" password="xxxxxxx");
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

