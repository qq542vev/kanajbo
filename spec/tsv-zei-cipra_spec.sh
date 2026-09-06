#!/usr/bin/env sh

### File: tsv-zei-cipra_spec.sh
##
## .i lo tsv zei vreji cu te cipra
##
## Usage:
##
## ------ Text ------
## shellspec tsv-zei-cipra_spec.sh
## ------------------
##
## Metadata:
##
##   id - 37bd1ed6-ff1e-4795-ae87-8de577d3a682
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.1.0
##   created - 2026-04-10
##   modified - 2026-09-06
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, find
##   conforms-to - <https://github.com/bashellspec/bashellspec/blob/master/docs/references.md>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/kanajbo>
##   * <Bug report at https://github.com/qq542vev/kanajbo/issues>

eval "$(shellspec -) exit 1"

Describe '.i lo tsv zei vreji cu te cipra'
	tsv_zei_cipra() {
		LANG=C awk -F '\t' -- '
			function fliba(xi, ciksi) {
				printf("fliba %d %d: %s : [%s]\n", NR, xi, ciksi, $xi)
				jalge = 1
			}

			BEGIN {
				morna = "^([a-gi-pr-vx-z]|([aeiou](\047[aeiou])+))+$"
				kmorna = "\343\201[\201-\277]|\343\202[\200-\237]|\343\203\274"
				jalge = 0
			}

			NF != 3 {
				printf("fliba %d: na cimei : [%s]\n", NR, $0)
				jalge = 1
				next
			}

			$1 !~ morna {
				fliba(1, "na lojbo valsi")
			}

			$2 == "" {
				fliba(2, "ciksi fo no da")
			}

			$3 !~ "^(" kmorna ")+(,(" kmorna ")+)*$" {
				fliba(3, "na me la xiraganas")
			}

			{
				terkancu = split($3, kana, ",")

				for(xi = 1; xi < terkancu; xi++) {
					if(kana[xi + 1] <= kana[xi]) {
						fliba(3, "me lo te porsi")
						break
					}
				}
			}

			END { exit jalge }
		' "${1}" >&2
	}

	Parameters:value $(find -- "${VASRU:-terpruce}" -name '*.tsv' -type f)

	Example ".i la'o zoi ${1} zoi te cipra"
		When call tsv_zei_cipra "${1}"
		The status should eq 0
	End
End
