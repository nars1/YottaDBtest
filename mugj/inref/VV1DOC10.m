VV1DOC10	;VV1DOC V.7.1 -10-;TS,VV1DOC,VALIDATION VERSION 7.1;31-AUG-1987;
	;COPYRIGHT MUMPS SYSTEM LABORATORY 1987
	I IO="PRINTER" W #,!!!!!!
	W !
	F I=1:1 S A=$T(TEX+I) Q:A=""  W !,$P(A," ;",2,99)
	Q
TEX	;
	;                            Validation Content Part-I
	;
	;       I-665.8  00000000.000000
	;       I-665.9  -00000.0000000
	;     I-666. abbreviation of multiple minus sign (-)
	;       I-666.1  -432
	;       I-666.2  --06.54
	;       I-666.3  ---432E-001
	;       I-666.4  ----6.540E-3
	;       I-666.5  -+--+-000000432.000000
	;       I-666.6  ---+6.5400E00000003
	;       I-666.7  +---000006.54E+0002
	;       I-666.8  +---+00006.54E-0003
	;       I-666.9  +6.540000000000000E-3
	;       I-666.10  ++06.54E-2
	;       I-666.11  -+000.0654E+2
	;       I-666.12  -0
	;
	;
	;Interpretation of expr to numeric literal -3-
	;     (V1NUM3)
	;
	;     I-667. location of point (.), when exp exist
	;       I-667.1  0000000432E-1
	;       I-667.2  6.54000E-3
	;       I-667.3  -0432E-1
	;       I-667.4  -6.054E-3
	;       I-667.5  432E1
	;       I-667.6  6.54E3
	;       I-667.7  -432E1
	;       I-667.8  -6.54E3
	;       I-667.9  432E+1
	;       I-667.10  6.54E+3
	;       I-667.11  -432E+1
	;       I-667.12  -6.54E+3
	;       I-667.13  0E-0
	;       I-667.14  -0E0
	;       I-667.15  0000E9
	;       I-667.16  -00000E-9
	;       I-667.17  1E000
	;       I-667.18  -1E-0000
	;       I-667.19  -00000.00000E+000000
	;       I-667.20  000000.000000E+000000
	;       I-667.21  000000.000000E000000
	;       I-667.22  .000005E007
	;       I-667.23  00000.123000000000000000000000000000000000000000000000000
	;
