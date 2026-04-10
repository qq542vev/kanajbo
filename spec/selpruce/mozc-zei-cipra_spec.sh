#!/usr/bin/env sh

### File: mozc-zei-cipra_spec.sh
##
## .i lo mozc zei liste cu te cipra
##
## Usage:
##
## ------ Text ------
## shellspec mozc-zei-cipra_spec.sh
## ------------------
##
## Metadata:
##
##   id - 0322d6d0-4b4f-4a43-8f51-3a296596eb9a
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2026-04-10
##   modified - 2026-04-10
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, find
##   conforms-to - <https://github.com/bashellspec/bashellspec/blob/master/docs/references.md>

eval "$(shellspec -) exit 1"

Describe '.i lo mozc zei liste cu te cipra'
	mozc_zei_cipra() {
		awk -F '\t' -- '
			BEGIN {
				morna = "^([a-gi-pr-vx-z]|([aeiou](\047[aeiou])+))+$"
				jalge = 0

				if(ARGV[1] ~ /[^\/]+-at-[^\/]+$/) {
					lidne = "^@.+"
				} else if(ARGV[1] ~ /[^\/]+-bs-[^\/]+$/) {
					lidne = "^\\\\.+"
				} else if(ARGV[1] ~ /[^\/]+-em-[^\/]+$/) {
					lidne = "^!.+"
				} else if(ARGV[1] ~ /[^\/]+-ziho-[^\/]+$/) {
					lidne = "^.+"
				}
			}

			NF != 4 || $1 !~ lidne || $2 !~ morna || $3 != "固有名詞" || $4 == "" {
				printf("fliba %d: [%s]\n", NR, $0)
				jalge = 1
			}

			END { exit jalge }
		' "${1}" >&2
	}

	Parameters:value $(find -- "${VASRU:-selpruce}" -name 'mozc-*.txt' -type f)

	Example ".i la'o zoi ${1} zoi te cipra"
		When call mozc_zei_cipra "${1}"
		The status should eq 0
	End
End
