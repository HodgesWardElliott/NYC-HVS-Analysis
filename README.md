NYC HVS read in and analysis
================

This set of scripts reads in NYC HVS data and puts it into a usable format

The initial commit contains only the requisite files which are not cleaned or optimized for running on machines other than BB's local desktop. Some redundant steps are included and there is a high likelihood they won't function property without some tinkering. Future iterations will make the code usable on other machines, include some of the basic analyses which have been done so far along with some instructions detailing some of the nuances of the data.

Order of scripts
================

HVS 83\_87 readin
-----------------

While the 1991 to 2014 files were accompanied by machine readable PDFs, the 1978 to 1987 files were accompanied by PDFs which were not machine readable. Variable position csvs had to be entered into excel by hand.

The NYC HVS data we recieved from the Census Bureau has occupied, vacant and non-response units on each fwf file (in contrast to the 1991-2014 files we got online). Depending on record type, the same character position can refer to different variables. As a result these records must be treated differently from the 1991-2014 records.

Each fwf file is subset by record type and is read in using different pre-compiled csvs. Once the files are read in and pertinent variables are renamed the vacant and occupied dataframes are joined to have a single dataframe for the given year's survey. The finalized dataframes are then placed into a list to be joined with the 1991-2014 data.

HVS 91\_14 VAC var position readin
----------------------------------

The 1991 to 2014 files were accompanied by machine readable PDFs. An online tool was used to convert these into excel files which were then lightly cleaned. This script takes those files and manipulates them into a dataframe which gives the positions of each variable in the fwf file for given years.

HVS 91\_14 VAC var position readin
----------------------------------

The same process for the occupied fwf files is used in this script for the vacant fwf files.

HVS 91\_14 OCC readin v3
------------------------

This script uses the precompiled csvs indicating character positions of variables to read in the occupied unit fwf files for years 1991 to 2014. After reading the fwf files variables are named and the resulting dataframes are placed in a list.

HVS 91\_14 VAC readin
---------------------

The same process is used here as was for the occupied file readin

OCC VAC join v1
---------------

This script takes the lists created for the 1983-1987 files and the 1991-2014 files and combines them. Note that currently it is set up to handle overlap in the various lists.
