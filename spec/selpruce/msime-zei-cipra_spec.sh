#!/usr/bin/env sh

### File: msime-zei-cipra_spec.sh
##
## .i lo msime zei liste cu te cipra
##
## Usage:
##
## ------ Text ------
## shellspec msime-zei-cipra_spec.sh
## ------------------
##
## Metadata:
##
##   id - e5f2d6c1-18d1-4041-b040-2f86e9736f8a
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.1.0
##   created - 2026-04-10
##   modified - 2026-04-10
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, find, iconv, tr
##   conforms-to - <https://github.com/bashellspec/bashellspec/blob/master/docs/references.md>

eval "$(shellspec -) exit 1"

Describe '.i lo msime zei liste cu te cipra'
	msime_zei_cipra() {
		iconv -f UTF-16 -t UTF-8 -- "${1}" | liste_cipra '\t' "$(lidne_cpacu "${1}")" "$(morna_cpacu)" '^固有名詞$' "^.+$(printf '\r')$"
	}

	Parameters:value $(find -- "${VASRU:-selpruce}" -name 'msime-*.txt' -type f)

	Example ".i la'o zoi ${1} zoi te cipra"
		When call msime_zei_cipra "${1}"
		The status should eq 0
	End
End
