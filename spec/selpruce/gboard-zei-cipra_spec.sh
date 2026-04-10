#!/usr/bin/env sh

### File: gboard-zei-cipra_spec.sh
##
## .i lo gboard zei liste cu te cipra
##
## Usage:
##
## ------ Text ------
## shellspec gboard-zei-cipra_spec.sh
## ------------------
##
## Metadata:
##
##   id - f4b1e2c1-18d1-4041-b040-2f86e9736f8a
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.1.0
##   created - 2026-04-10
##   modified - 2026-04-10
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, find
##   conforms-to - <https://github.com/bashellspec/bashellspec/blob/master/docs/references.md>

eval "$(shellspec -) exit 1"

Describe '.i lo gboard zei liste cu te cipra'
	gboard_zei_cipra() {
		awk -F '\t' -- '
			(NR == 1 && $0 != "# Gboard Dictionary version:2") ||
			(NR == 2 && $0 != "# Gboard Dictionary format:shortcut\tword\tlanguage_tag\tpos_tag") {
				printf("fliba %d (version line): [%s]\n", NR, $0)
				exit 1
			}
		' "${1}" >&2 && \
		awk -- '2 < NR { print($0) }' "${1}" | liste_cipra '\t' "$(lidne_cpacu "${1}")" "$(morna_cpacu)" '^ja-JP$' '^$'
	}

	Parameters:value $(find -- "${VASRU:-selpruce}" -name 'gboard-*.txt' -type f)

	Example ".i la'o zoi ${1} zoi te cipra"
		When call gboard_zei_cipra "${1}"
		The status should eq 0
	End
End
