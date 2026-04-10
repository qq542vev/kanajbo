#!/usr/bin/env sh

### File: anthy-zei-cipra_spec.sh
##
## .i lo anthy zei liste cu te cipra
##
## Usage:
##
## ------ Text ------
## shellspec anthy-zei-cipra_spec.sh
## ------------------
##
## Metadata:
##
##   id - 896a24ea-9602-4fcd-b337-39374067de12
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2026-04-10
##   modified - 2026-04-10
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, find
##   conforms-to - <https://github.com/bashellspec/bashellspec/blob/master/docs/references.md>

eval "$(shellspec -) exit 1"

Describe '.i lo anthy zei liste cu te cipra'
	anthy_zei_cipra() {
		awk -- '
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

			NF != 3 || $1 !~ lidne || $2 != "#T35*500" || $3 !~ morna {
				printf("fliba %d: [%s]\n", NR, $0)
				jalge = 1
			}

			END { exit jalge }
		' "${1}" >&2
	}

	Parameters:value $(find -- "${VASRU:-selpruce}" -name 'anthy-*.txt' -type f)

	Example ".i la'o zoi ${1} zoi te cipra"
		When call anthy_zei_cipra "${1}"
		The status should eq 0
	End
End
