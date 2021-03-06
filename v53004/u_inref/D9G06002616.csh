#!/usr/local/bin/tcsh -f

echo "Run M code which contains FOR statement having >= 127 expression"

$GTM << GTM_EOF
	F vNod=2,1099,"%ATM","%BATH","%BPT","%","%RD","%ET","%HELP","%IO","%KEYS","%LIBS","%MP","%TBLS","%TO","%TOHALT","%N","AHORIG","ANMRP","ADDR","ADSR","AGEMS","ALOUNT","ALP","ANAOFF","BANNER","BINDEF","BOBR","BSA","BTTJOB","BAPGM","BO","HK","HKHLDRTN","HKPNT","IDBLK","IDLOLM","IF","IFMRP","IFVER","NTRY","O","OM","ONAM","OPY","OURTMSG","RDTHR","RT","RTDSP","RTMSGD","RTMSGL","RTR","STFMTRTN","URRENV","USPGM","DAYEND","DBS","DBSLSTEXP","DEAL","DELDIS","DELQ","DENFLG","DEP","DEPVER","DFTENV","DRMT","DRVMSG","EOMM","EFD","EFTPAY","EFTPRI","EFTRTY","EIN","ERBRES","ESHEAT","ESRO","EUR","FVMEMO","FEPXALL","FTPTIME","FXRATEDF","GLAN","GL","GLEFD","GLS","GLSBO","GLSETPGM","GLTS","GLTSFP","GLTSTO","GLTSTS","GLXFR","GRAE","HANG","HISTRPT","HOTLIN","IAMGESYMBL","IMAGE","INK","INQBAL","INS","INTPGM","INTPOS","INV","IPD","IRAHIST","ISO","LNBD","LETTER","LN","LNNV","LNON","LOGINMSG","LSP","MAXPM","MFUND","MIR","MULTIITSID","MXTRLM","NOREGD","NOSTPURG","ODP","ODPE","OPTIMIZE","PAYERNAM","PBALRTN","PN","P" S:'\$D(vobj(v1,vNod)) vobj(v1,vNod)=1
GTM_EOF

echo "End of subtest"
