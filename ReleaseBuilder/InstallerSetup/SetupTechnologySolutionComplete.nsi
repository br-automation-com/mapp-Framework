!include "SetupmappFramework_TS.nsh"

Var nsiPVI_OptionsFileName
Var nsiPVI_ErrorText

; Text resources for section text (component selection)
LangString mappFrameworkShortText ${LANG_GERMAN} "${ProductNameShort} ${Version}"
LangString mappFrameworkShortText ${LANG_ENGLISH} "${ProductNameShort} ${Version}"
LangString mappFrameworkLongText ${LANG_GERMAN} "${ProductNameLong} ${Version}"
LangString mappFrameworkLongText ${LANG_ENGLISH} "${ProductNameLong} ${Version}"

LangString mappFrameworkBaseShortText ${LANG_GERMAN} "Solution Hauptpaket"
LangString mappFrameworkBaseShortText ${LANG_ENGLISH} "Solution main package"
LangString mappFrameworkBaseLongText ${LANG_GERMAN} "mapp Framework - Importer Tool / Technology Package / Hilfe"
LangString mappFrameworkBaseLongText ${LANG_ENGLISH} "mapp Framework - Importer Tool / Technology Package / Help"

LangString MenuShortText ${LANG_GERMAN} "Start Menù Eintrag"
LangString MenuShortText ${LANG_ENGLISH} "Start Menu entry"
LangString MenuLongText ${LANG_GERMAN} "Eintrag in das Startmenù"
LangString MenuLongText ${LANG_ENGLISH} "Entry into the start menu"

LangString mappFrameworkEndShortText ${LANG_GERMAN} "mappFramework Ende"
LangString mappFrameworkEndShortText ${LANG_ENGLISH} "mappFramework end"
LangString mappFrameworkEndLongText ${LANG_GERMAN} "mappFramework Ende"
LangString mappFrameworkEndLongText ${LANG_ENGLISH} "mappFramework end"

; Variable declarationen for sections
!insertmacro VariableForSection "mappFramework"
	!insertmacro VariableForSection "mappFrameworkBase"
	;!insertmacro VariableForSection "Menu"

!insertmacro VariableForSection "mappFrameworkEnd"

Section # Remove old
	SetOutPath "$INSTDIR\${ProductNameShort}"
	RMDir /r "$INSTDIR\${ProductNameShort}"

	SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}"
	FindFirst $0 $1 "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}\*.*.9"
	loop:
		StrCmp $1 "" done
		RMDir /r "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}\$1"
		FindNext $0 $1
		Goto loop
	done:
	FindClose $0

	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
	RMDir /r "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"

	SetOutPath "$VersionBaseFolder\Help-en\Data\technologysolutions\mappFrameworkHelp"
	RMDir /r "$VersionBaseFolder\Help-en\Data\technologysolutions\mappFrameworkHelp"

	SetOutPath "$MSPROGRAMS\${COMPANYNAME}\${ProductNameShort}"
	RMDir /r "$MSPROGRAMS\${COMPANYNAME}\${ProductNameShort}"

SectionEnd

; Dummy section for the start of the root group
Section "$(mappFrameworkLongText)" mappFramework
SectionEnd

Section "$(mappFrameworkBaseShortText)" mappFrameworkBase

	!insertmacro WaitForProcessToClose "FrameworkImporter.exe" "mapp Framework Import Tool"

	SetOutPath "$INSTDIR\${ProductNameShort}"
	File /r "mappFrameworkLogo.ico"

	!insertmacro InstallHelp "$VersionBaseFolder" "Help"

	SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}"
	File /r "TechnologyPackage\*.*"

	SetOutPath "$VersionBaseFolder\AS\Images\Files\"
	File /oname=FrameworkImporter.exe.ico mappFrameworkLogo.ico

SectionEnd

; Dummy section for the end of the root group
Section "$(mappFrameworkEndShortText)" mappFrameworkEnd
SectionEnd

; description text (LongText) for component selection
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro SetDescriptionTextforMUI "mappFramework"
	!insertmacro SetDescriptionTextforMUI "mappFrameworkBase"
	;!insertmacro SetDescriptionTextforMUI "Menu"

!insertmacro MUI_FUNCTION_DESCRIPTION_END


;!insertmacro CreateUninstaller "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}"
SectionEnd

;!insertmacro CreateUninstaller "$INSTDIR\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$INSTDIR\${ProductNameShort}"
SectionEnd


Function OnInit
	; check Windows-Version
	; at least Windows VISTA SP 2 or Windows 7 SP1 or Windows Server 2008 R2 must be available.
	${IfNot} ${AtLeastWin2008R2}
		${If} ${IsWinVista}
		${AndIf} ${AtLeastServicePack} 2
		${Else}
			${If} ${IsWin7}
			${AndIf} ${AtLeastServicePack} 1
			${Else}
				!insertmacro GenerateError ${ErrorCode_WrongOS} "$(LangWrongOS)"
			${EndIf}
		${EndIf}
	${EndIf}

	; initializing section Flags
	; Flags are defined as follows:
	; SF_SELECTED   1
	; SF_SECGRP     2
	; SF_SECGRPEND  4
	; SF_BOLD       8
	; SF_RO         16  ReadOnly
	; SF_EXPAND     32
	; SF_PSELECTED  64
	StrCpy $mappFrameworkSectionRO 35

		StrCpy $mappFrameworkBaseSectionRO 1
		;StrCpy $MenuSectionRO 1
	StrCpy $mappFrameworkEndSectionRO 4

	; initializing Section Flags
	!insertmacro ReadAndSetSectionFlag "mappFramework" "mappFramework"
	!insertmacro ReadAndSetSectionFlag "mappFrameworkBase" "mappFramework"
	;!insertmacro ReadAndSetSectionFlag "Menu" "mappFramework"

	!insertmacro ReadAndSetSectionFlag "mappFrameworkEnd" "mappFramework"

	; check command line parameter "-O=" in case it's selected
	Call DoOptionFileHandling
FunctionEnd

Function DoOptionFileHandling
	${GetOptions} $CommandLine "-O=" $nsiPVI_OptionsFileName
	${If} "$nsiPVI_OptionsFileName" != ""
		${If} ${FileExists} "$nsiPVI_OptionsFileName"
			!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "mappFramework" "mappFrameworkBase"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "mappFramework" "Menu"
		${Else}
			!insertmacro FormatString1 "$(ErrorFileNotFound)" "$nsiPVI_OptionsFileName" $nsiPVI_ErrorText
			!insertmacro GenerateError "${ErrorCode_FileNotFound}" $nsiPVI_ErrorText
		${EndIf}
	${EndIf}
FunctionEnd


Function .onComponentsPre
	${If} "$IsSilent" == "${TRUE}"
	${OrIf} "$IsReduced" == "${TRUE}"
		Abort
	${EndIf}
FunctionEnd

Function .onComponentsLeave
	!insertmacro GetAndWriteSectionFlag "mappFramework" "mappFramework"
	;!insertmacro GetAndWriteSectionFlag "Menu" "mappFramework"
FunctionEnd
