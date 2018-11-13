The following ZIP file contains selected examples from the
SQL*Loader book:

     sql_loader_examples.zip

Below, you'll find chapter-by-chapter descriptions of all
the example files. This information is also contained in the
readme.txt file within the ZIP archive.

QUESTIONS or PROBLEMS? If you have questions about any of these
examples, or problems executing any of them, please contact
one of the authors or O'Reilly book support. You can use one of
the following email addresses:

     jonathan@gennick.com       Jonathan Gennick (author)
     sanjay_mishra@i2.com       Sanjay Mishra (author)
     bookquestions@oreilly.com  O'Reilly book support

Before you run any of the examples, you need create the
neccessary destination tables. Do that by connecting to your
database using SQL*Plus and executing the following script:

     create_tables.sql

In order to execute this script, you'll need the CREATE TABLE,
CREATE SEQUENCE, and CREATE TYPE privileges. In addition, you'll
need CREATE PROCEDURE for one of the examples.

I've designed all the control files to assume that all input
files are in the current working directy. All output files
will also be generated in the current working directory. You
may need to modify these files somewhat to suit your environment.

In my SQL*Loader commands, I use the following values:

     Username: gennick
     Password: secret
     Net service name (from tnsnames.ora): prod

You will need to modify the SQL*Loader commands shown here to
suit your own environment.



Chapter 1, Introduction to SQL*Loader
=====================================
Beginning on page 4 of the book, you'll find an example of a
simple load done using SQL*Loader. You can execute this load
yourself using the following files:

     michigan_delimited.dat - Contains the data to be loaded.
     ch01_gnis.ctl - Is the SQL*Loader control file.

Issue the following operating system command to initiate the load:

     sqlldr gennick/secret@prod control=ch01_gnis.ctl log=michigan_delimited.log data=michigan_delimited.dat



Chapter 2, The Mysterious Control File
======================================
On page 41 of the book you'll find an example of a control file
that loads fixed-width, columnar data into two tables. Use the
following files to reproduce that load. Note that I've
embellished this example so that it not only loads two tables,
it also reads from two separate input files.

     alger_county_fixed.dat - Alger County place names
     keweenaw_county_fixed.dat - Keweenaw County place names
     ch02_counties.ctl - The SQL*Loader control file

Use the following command to initiate the load:

sqlldr gennick/secret@prod control=ch02_counties.ctl log=counties.log

As a result of this load, you will have many duplicate county
names in a table named temp_gnis_county. Use the following query
to update the permenant county table with just one copy of each
new name:

INSERT INTO gc_gnis_county
  SELECT DISTINCT gc_state_abbr, gc_county_name
  FROM temp_gnis_county;

This query selects one occurrence of each distinct county name,
and inserts that into the gc_gnis_county table.



Chapter 3, Fields and Datatypes
===============================
You can reproduce the numeric external example shown on pages 64
and 65 using the following files:

     numeric_external_test.dat - Contains the numeric data
     numeric_external_test.ctl - Is the control file to load the
                                 numeric data

Issue the following command to initiate the load:

     sqlldr gennick/secret@prod control=numeric_external_test.ctl log=numeric_external_test.log



To load zoned decimal data with an assumed decimal point, as
described in the sidebar on page 72, use the following files:

     zoned_test.dat - Contains book price data where the prices
                      use an assumed decimal point.
     zoned_test.ctl - Is a control file to load the book price
                      data, and which uses the ZONED data type
                      to deal with the assumed decimal point.

Use the following command to initiate the load:

     sqlldr gennick/secret@prod control=zoned_test.ctl log=zoned_test.log

Be sure to query the book_prices table following the load, so
that you can see how the assumed decimal point has been taken
into account during the load process.



Chapter 4, Loading from Fixed-Width Files
=========================================
Use the following files to execute the example shown in the
sidebar on page 94:

     alger_nested.dat - Data file containing columnar data with
                        nested, delimited fields.
     alger_nested.ctl - Control file to load the nested,
                        delimited fields into separate database
                        columns.

Use the following command to initiate the load:

     sqlldr gennick/secret@prod control=alger_nested.ctl



Chapter 5, Loading Delimited Data
=================================
Use the following files to execute the final CSV example shown
on page 115:

     csv.dat - Feature name data in CSV format
     csv.ctl - Control file to load the csv.dat file

Issue the following command to initiate the load:

     sqlldr gennick/secret@prod control=csv.ctl

Query the michigan_feature_names table after the load in order
to view the results. Notice in the entry for the Township of
Baraga, that the word Baraga is enclosed within double quotes.
In the original input file (csv.dat), two quotes in succession
were used to indicate the presence of quote characters in the
data.



Chapter 6, Recovering from Failure
==================================
This chapter deals with recovery from failed loads. Any
load can fail, so no specific example is provided for this
chapter.



Chapter 7, Validating and Selectively Loading Data
==================================================
The following files can be used to implement a modified version
of the example shown on page 150:

     alger_county_fixed.dat - Alger County place names
     keweenaw_county_fixed.dat - Keweenaw County place names
     when_demo.ctl - Control file to load airports and schools

This example differs from the book in that it loads from files
containing fixed-width, columnar data. This reduces the number
of data files in this example archive, because those files are
shared with a previous example.

Issue the following command to initiate the load:

     sqlldr gennick/secret@prod control=when_demo.ctl log=when_demo.log



Chapter 8, Transforming Data During a Load
==========================================
The following files can be used to implement the example shown
on pages 156 through 158, in which you invoke a stored function
to modify the input data:

     book.dat - Book price data
     price_page_threshold.sql - SQL statements to create and
                                populate a table used by the
                                stored function.
     price_check.sql - CREATE FUNCTION statement to create
                       stored function to check and adjust
                       book prices.
     book.ctl - Control file

Before you run this load, run price_page_threshold.sql from
SQL*Plus in order to create and populate the price_page_threshold
table. Then run price_check.sql from SQL*Plus in order to create
the stored function. Finally, initiate the load from by
issuing the folloing command from the operating system command
prompt:

     sqlldr gennick/secret@prod control=book.ctl log=book.log

After the load completes, query the book table and
compare the prices in that table to those in the input data
file. NOTE: That the book_prices.ctl control file in this
archive specifies ZONED(4,2) as the data type for the book_price
field. The example in the book mistakenly omitted this rather
crucial declaration.



Chapter 9, Transaction Size and Performance Issues
==================================================
We have no specific example for this chapter. Instead, we
recommend that you try the techniques described in this chapter
on your own loads, or on some of the other example loads
provided in this archive.



Chapter 10, Direct Path Loads
=============================
Again, we have no specific examples for this chapter. If you
wish to experiment with DIRECT=Y, we recommend that you do so
using the load example provided for chapter 1. That example uses
an input file large enough to make the effects of using the
direct path noticable.



Chapter 11, Loading Large Objects
=================================
Use the following files to execute the example shown on pages
215 through 217 under the heading "Placing Multiple LOBs in One
File":

     waterfalls_directions.dat - A file containing directions
                                 to several waterfalls in Alger
                                 County, Michigan
     waterfalls_photos.dat - The main input data file. This file
                             contains information about three
                             waterfalls in Alger County,
                             Michigan.
     Dcp_1213.jpg - A photo of Chapel Falls
     Dcp_1422.jpg - A photo of Scott Falls
     Dcp_1505.jpg - A photo of Tannery Falls
     waterfalls_directions.ctl - The control file to load all
                                 this information into the
                                 waterfalls table.

Use the following command to initiate the load:

     sqlldr gennick/secret@prod control=waterfalls_directions.ctl log=waterfalls_directions.log



Chapter 12, Loading Objects and Collections
===========================================
You can run the "Loading Object Columns" example shown on pages
212 through 214 using the following files:

     coll_obj.dat - Contains the data
     coll_obj.ctl - Is the control file

Use the following command to initiate the load:

     sqlldr gennick/secret@prod control=coll_obj.ctl log=coll_obj.log



You can run the example shown on pages 229 through 231 to load
inline collection data using the following files:

     coll_inline.dat - Contains inline collection data
     coll_test.ctl - Is the control file

Initiate the load using the following command:

     sqlldr gennick/secret@prod control=coll_test.ctl log=coll_test.log



Use the following files for the example shown on pages 237
through 239. This example loads collection data from a secondary
data file.

     coll_nest2.dat - Contains the primary data to load
     coll_nest_sdf2a.dat - Is one of the secondary data files
     coll_nest_sdf2b.dat - Is the other secondary data file
     coll_nest2.ctl - Is the control file for the load

Initiate the load using the following command:

     sqlldr gennick/secret@prod control=coll_nest2.ctl log=coll_nest2.log




