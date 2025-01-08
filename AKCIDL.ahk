RAlt::

;; Key to stop the script I don't know why Del and Backspace are not working
stop_key := ["Space", "Esc", "Enter", "Tab", "Backspace", "Delete"]

;; Print a temporary central dot (debian style)
SendInput {U+2219}

;; Take first character after RAlt
Input, first_chr, L1


;; If the first character after RAlt is \ send Alt+\ combination
;; used for sending shortcut for converting equation in Mathtype from Tex in MS Word
if (first_chr == Chr(92)) {
	SendInput, {Backspace}
	SendInput, {Alt Down}
	SendInput, \
	SendInput, {Alt Up}
	
;; If any of the stop key is pressed, stop the script
} else if (not InStr(stop_key, first_chr)) {

	;; Take the second character
	SendInput, %first_chr% ;;print the current first character
	Input, sec_chr, L1
	SendInput, {Backspace}{Backspace} ;; remove the temporary characters

	;; If the second character is a stop key
	if (InStr(stop_key,sec_chr)) {
		;; stop the script
		Return
	}


	;; Concatenate the character (think a way more efficient)
	in_char = %first_chr%%sec_chr%

	;; Take type of accent and char to treat
	;; Position of acute or grave accent
	PosAcuteAcc := InStr(in_char,Chr(39)) ;; character '
	PosGraveAcc := InStr(in_char,Chr(96)) ;; character `

	;; Position of the accent
	PosAcc := Max(PosAcuteAcc, PosGraveAcc) ;; if both are pressed?
	;; Character to treat
	char := SubStr(in_char,PosAcc-1,1) ;; ok, since just two characters are taken


	;; Vowel for which accents are applied
	;; Grave
	vow_ga := Chr(97) . Chr(101) . Chr(105) . Chr(111) . Chr(117)  . Chr(65) . Chr(69) . Chr(73) . Chr(79) . Chr(85)
	;; Acute
	vow_aa := Chr(101) . Chr(111) . Chr(69) . Chr(79)


	;;Accented letter to put
	;; Grave accented vowels
	ga_vow := Chr(224) . Chr(232) . Chr(236) . Chr(242) . Chr(249) . Chr(192) . Chr(200) . Chr(204) . Chr(210) . Chr(217)
	;; Acute accented vowels
	aa_vow := Chr(233) . Chr(243) . Chr(201) . Chr(211)



	;; if  the first char is an acute accented letter (and the other one can be modified)
	if (PosAcuteAcc AND InStr(vow_aa, char)) {
		ac_char := SubStr(aa_vow, InStr(vow_aa, char, 1),1)

	    SendInput, %ac_char%
	}
	;; if the first char is a grave accented letter (and the other one can be modified)
	else if (PosGraveAcc AND InStr(vow_ga, char)) {
		ac_char := SubStr(ga_vow, InStr(vow_ga,char, 1),1)

        SendInput, %ac_char%
	}





	;;;
	;; Other special characters
	;;;

	;; Euro symbol (with double click on one of the euro_chr)
	euro_chr := "eE"
	if (InStr(euro_chr, first_chr) AND InStr(euro_chr, sec_chr) ) { ;;if the first is e and second is E (and vice-versa) it works anyway (but I don't think is a problem)
		SendInput, % Chr(8364)
	}

	;; O with slash symbol "Ø" (with double click on "O")
	if (first_chr == Chr(079) AND sec_chr == Chr(079) ) {
		SendInput, % Chr(0216)
	}

	;; Degree symbol "°" (with double click on "o")
	if (first_chr == Chr(0111) AND sec_chr == Chr(0111) ) {
		SendInput, % Chr(0176)
	}

	;; Paragraph symbol "§" (with double click on "p")
	if (first_chr == Chr(0112) AND sec_chr == Chr(0112) ) {
		SendInput, % Chr(0167)
	}

} else {
	SendInput {Backspace} ;; remove the temporary central dot (to improve)
}


return
