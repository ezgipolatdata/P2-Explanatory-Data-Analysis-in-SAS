%LET a2_2015 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2015_YTD.csv';
%LET a2_2016 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2016_YTD.csv';
%LET a2_2017 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2017_YTD.csv';
%LET a2_2018 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2018_YTD.csv';
%LET a2_2019 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2019_YTD.csv';
%LET a2_2020 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2020_YTD.csv';
%LET a2_2021 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2021_YTD.csv';
%LET a2_2022 = '/home/u60688986/Assignment 2/Shanghai_PM2.5_2022_YTD.csv';

proc import datafile=&a2_2015
                dbms=csv out=work.a2_2015 replace;
                guessingrows=max;
run;


proc import datafile=&a2_2016
                dbms=csv out=work.a2_2016 replace;
                guessingrows=max;
run;


proc import datafile=&a2_2017
                dbms=csv out=work.a2_2017 replace;
                guessingrows=max;
run;


proc import datafile=&a2_2018
                dbms=csv out=work.a2_2018 replace;
                guessingrows=max;
run;

proc import datafile=&a2_2018
                dbms=csv out=work.a2_2018 replace;
                guessingrows=max;
run;

proc import datafile=&a2_2019
                dbms=csv out=work.a2_2019 replace;
                guessingrows=max;
run;

proc import datafile=&a2_2020
                dbms=csv out=work.a2_2020 replace;
                guessingrows=max;
run;

proc import datafile=&a2_2021
                dbms=csv out=work.a2_2021 replace;
                guessingrows=max;
run;

proc import datafile=&a2_2022
                dbms=csv out=work.a2_2022 replace;
                guessingrows=max;
run;



data a2_2015;
    set a2_2015;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2015S;
    set a2_2015;
    if group ne 1 then delete;
run;





data a2_2016;
    set a2_2016;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2016S;
    set a2_2016;
    if group ne 1 then delete;
run;



data a2_2017;
    set a2_2017;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2017S;
    set a2_2017;
    if group ne 1 then delete;
run;



data a2_2018;
    set a2_2018;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2018S;
    set a2_2018;
    if group ne 1 then delete;
run;



data a2_2019;
    set a2_2019;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2019S;
    set a2_2019;
    if group ne 1 then delete;
run;


data a2_2020;
    set a2_2020;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2020S;
    set a2_2020;
    if group ne 1 then delete;
run;



data a2_2021;
    set a2_2021;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2021S;
    set a2_2021;
    if group ne 1 then delete;
run;




data a2_2022;
    set a2_2022;
    if hour = 0 or hour = 6 or hour = 12 or hour = 18 then group=1;
run;


data S2022S;
    set a2_2022;
    if group ne 1 then delete;
run;





data Shangai_1 ;
                set S2015S S2016S S2017S S2018S S2019S S2020S S2021S S2022S;
run;



proc means data=shangai_1;
run;

/*  */
/*  */
/*  */
/*  */
/*  */
/* Clean Master 6-hourly Dataset without -999 values */

data Shangai_Clean1;
   set shangai_1;
   if AQI < 0 then delete;
run; 

data Shangai_Clean2;
   set Shangai_Clean1;
   if 'Raw Conc.'n < 0 then delete;
run;

/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */


proc means data=Shangai_Clean2;
run;

proc freq data=shangai_clean2;
table  'QC Name'n;
run;




/* Clean 6-Hourly 2015 Dataset without -999 Values */

data CleanS2015S;
   set S2015S;
   if AQI < 0 then delete;
run;

data S2015S_Clean;
   set CleanS2015S;
   if 'Raw Conc.'n < 0 then delete;
run;

/*  */

/* Clean 6-Hourly 2016 Dataset without -999 Values */

data CleanS2016S;
   set S2016S;
   if AQI < 0 then delete;
run;

data S2016S_Clean;
   set CleanS2016S;
   if 'Raw Conc.'n < 0 then delete;
run;

/*  */


/* Clean 6-Hourly 2017 Dataset without -999 Values */


data CleanS2017S;
   set S2017S;
   if AQI < 0 then delete;
run;

data S2017S_Clean;
   set CleanS2017S;
   if 'Raw Conc.'n < 0 then delete;
run;


/*  */

proc means data=S2017S_Clean;
run;

data Seasonal_2017;
set S2017S_Clean;
IF month = 1 or month = 2 or month = 3 then season = 'winter';
IF month = 4 or month = 5 or month = 6 then season = 'spring';
IF month = 7 or month = 8 or month = 9 then season = 'summer';
IF month = 10 or month = 11 or month = 12 then season = 'fall';
run;


/* Seasonal Master Dataset */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */

data Master_Seasonal;
set Shangai_Clean2;
IF month = 1 or month = 2 or month = 3 then Season = '2-WINTER';
IF month = 4 or month = 5 or month = 6 then Season = '3-SPRING';
IF month = 7 or month = 8 or month = 9 then Season = '4-SUMMER';
IF month = 10 or month = 11 or month = 12 then Season = '1-FALL';
run;







/* Means Of Years and Seasons in Master Dataset */


proc means data=Master_Seasonal MAXDEC=2;
TITLE ‘Seasonal AQI Levels’;
TITLE2 ‘Calculated with Proc Means’;
VAR AQI;
CLASS Year Season;
run;





/*  95% Confidence Limits of the Mean */


proc means data=Master_Seasonal LCLM MEAN UCLM MEDIAN MAXDEC=2;
TITLE ‘Seasonal AQI Levels’;
TITLE2 ‘2015-2022’;
CLASS Year Season;
VAR AQI;

run;

/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */

/* CREATING OUTPUT TABLE FOR PROC MEANS DATA OF SEASONAL AQI LEVELS 2015-2022*/

proc means data=Master_Seasonal LCLM MEAN UCLM MEDIAN MAXDEC=2;
TITLE ‘Seasonal AQI Levels’;
TITLE2 ‘2015-2022’;
CLASS Year Season;
VAR AQI;
output out=class_means mean= sum= /autoname;

run;


/*  */

ods trace on;
proc means data=Master_Seasonal LCLM MEAN UCLM MEDIAN MAXDEC=2;
TITLE ‘Seasonal AQI Levels’;
TITLE2 ‘2015-2022’;
CLASS Year Season;
VAR AQI;
run;
ods trace off;

/*  */

ods output summary=class_means_ods;
proc means data=Master_Seasonal LCLM MEAN UCLM MEDIAN MAXDEC=2;
TITLE ‘Seasonal AQI Levels’;
TITLE2 ‘2015-2022’;
CLASS Year Season;
VAR AQI;
output out=class_means mean= sum= /autoname;
run;
ods output close;

/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */


proc print data=Shangai_Clean2;
WHERE 'Raw Conc.'n > 500;
run;

Data Shangai_Clean3;
Set Shangai_Clean2;
IF 'Raw Conc.'n > 500 THEN 'Raw Conc.'n = 500;
run;




/* Box Plot Data Output - The one that worked */
/*  */


ods graphics / reset width=6.4in height=4.8in imagemap;




ods output sgplot=boxplot_data;




proc sgplot data=WORK.SHANGAI_CLEAN2;
	title height=12pt "AQI Levels Among Years";
	
	vbox AQI / category=Year fillattrs=(color=CXcccae6);
	yaxis grid;
run;

ods graphics / reset;
title;



proc print data=boxplot_data;


/*  */




/* Systematic Sampling  */

proc sort data=shangai_clean2 out=WORK.TableSorted;
	by Year Month;
run;
proc surveyselect data=WORK.TableSorted method=sys sampsize=4

                  out=work.SampleSYS1;
                  strata year month;
run;


/*

Proc SurveySelect
data = shangai_clean2
method = sys
n = 350
out = Example_Systematic
seed = 31636;
Run;



Proc SurveySelect
data = work.
method = sys
sampsize=4
out = Systematic;
strata year month;
;
Run;

 */




/* CHI SQUARE TEST */


proc freq data=work.SampleSYS1;
tables 'AQI Category'n * Year /chisq;
run;
































/*  */

/* EXPORTING THE DATASET

proc export data=shangai_clean2 outfile='/home/u60688986/DEMO 1/outbabe.csv'
dbms=csv;
run;


*/




/* Correlation Analysis */

PROC CORR DATA=shangai_clean2;
    VAR AQI;
    WITH Year;
RUN;

/* ? */

PROC CORR DATA=shangai_clean2;
    VAR AQI Year;
   
RUN;

/*  Correlation Matrix */

proc gplot data = shangai_clean2;
plot AQI*Year;
run;
quit;


/*  */













