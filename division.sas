PROC IMPORT OUT= WORK.data
            DATAFILE= "C:\Users\aafrida\Desktop\fries\study_abroad_2.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
	 DATAROW=2;
RUN;


Data data;
set data;

if Major1 = "AFAM" or Major1 = "AMST" or Major1 = "ANTH" or Major1 = "CSS" or Major1 = "ECON" 
or Major1 = "GOVT" or Major1 = "HIST" or Major1 = "PHIL" or Major1 = "RELI" or Major1 = "REES"
or Major1 = "SOC"
then Division1 = "SBS";

Run;


Data data;
set data;

if Major1 = "ASTR" or Major1 = "BIOL" or Major1 = "CHEM" or Major1 = "CIS" or Major1 = "COMP" 
or compress(Major1, ,'kas') = "EES" or Major1 = "ENVS" or Major1 = "MATH" or compress(Major1, ,'kas') = "MBB"
or compress(Major1, ,'kas') = "NSB" or Major1 = "PHYS" or Major1 = "PSYC"
then division1 = "NSM";

Run;


Data data;
set data;

if Major1 = "LANG" or Major1 = "ARAB" or Major1 = "ARHA"
or Major1 = "ARST" or Major1 = "CHIN" or Major1 = "FILM" 
or Major1 = "COL" or Major1 = "DANC" or Major1 = "ENGL"
or Major1 = "FRST" or Major1 = "GRST" or Major1 = "GRK" 
or Major1 = "HEBR" or Major1 = "HIUR" or Major1 = "ITAL" 
or Major1 = "JAPN" or Major1 = "KREA" or Major1 = "LAT"
or Major1 = "MUSC" or Major1 = "PORT" or compress(Major1, ,'kas') = "RLL"
or Major1 = "RUSS" or Major1 = "RULE" or Major1 = "SPAN"
or Major1 = "THEA" or Major1 = "WLIT"
then Division1 = "HA";

Run;


Data data;
set data;

if Major1 = "CEAS" or Major1 = "UNIV" or Major1 = "ITST" or Major1 = "HISP"
or Major1 = "ARCP" or Major1 = "FGSS" or Major1 = "SISP" or Major1 = "CCIV"
or Major1 = "RMST" or Major1 = "EDST" or Major1 = "CLST" or Major1 = "LAST"
then division1 = "IDS";

Run;


Data data;
set data;

if division1 = "" then division1 = .;

Run;


Data data;
set data;

if mod(term, 10) = 9 then years = cats("Fall", put(mod((term - mod(term, 10))/10, 100), 4.));
if mod(term, 10) = 1 then years = cats("Spring", put(mod((term - mod(term, 10))/10, 100), 4.));

run;


Data data;
set data;

if years = "Fall18" or years = "Spring19" then years = "2019";
if years = "Fall19" or years = "Spring20" then years = "2020";
if years = "Fall20" or years = "Spring21" then years = "2021";
if years = "Fall21" or years = "Spring22" then years = "2022";
if years = "Fall22" or years = "Spring23" then years = "2023"; 
if years = "Fall23" then years = "2024";
run;


Data data;
set data;

if years = "" then years = .;

Run;


PROC SORT DATA = data OUT = data;
by years;
proc freq DATA=WORK.data;
	*tables degree *  abany/ plots=freqplot(type=dotplot scale=percent); 
	tables language_type *  division1 /out=res  chisq outpct plots=freqplot(scale=percent);
by years;
	/*output  out=b1 chisq ; ** NOTE: different than out= in tables statement;*/
run;

