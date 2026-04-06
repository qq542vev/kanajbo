#!/usr/bin/make -f

### File: makefile
##
## zbasu lo valsi liste be pi'o la'o zoi ponjo IME zoi
##
## Usage:
##
## ------ Text ------
## make -f makefile
## ------------------
##
## Metadata:
##
##   id - f6c6ee41-4426-4e98-8cae-572de1d02812
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 0.3.1
##   created - 2026-03-22
##   modified - 2026-04-03
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, echo, find, git, glab, iconv, printf, rm, sort
##   conforms-to - <https://pubs.opengroup.org/onlinepubs/9799919799/utilities/make.html>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/kanajbo>
##   * <Bug report at https://github.com/qq542vev/kanajbo/issues>

# Sp Targets
# ==========

.POSIX:

.PHONY: ro anthy gboard mozc msime vimcu zahurehu gubni mipri sidju velfarvi

.SILENT: sidju velfarvi

# Macro
# =====

NAMCU = 1.0.0
VASRU = selzbasu

# cmene morna
# -----------

GIMTERGAHI = $(VASRU)/gimgafi.tsv
ROLSINXA = at bs ziho
GIMVEI = $(ROLSINXA:%=-%-gismu.txt)

# minde
# -----

MKDIR = mkdir -p -- '$(@D)'
SET = set -efu -o pipefail
BREDI = \
	$(SET); $(MKDIR); \
	case '$(@F)' in \
		*'-at-'*) export SINXA='@';; \
		*'-bs-'*) export SINXA='\';; \
	esac;

# Anthy
# -----

ANTHY_LISTE = $(GIMVEI:%=$(VASRU)/anthy%)
ANTHY_ZBASU = $(BREDI) awk -F '\t' -- '{ printf("%s \#T35*500 %s\n", ENVIRON["SINXA"] $$1, $$2); }' '$(<)' >'$(@)'

# Gboard
# ------

GBOARD_LISTE = $(GIMVEI:%=$(VASRU)/gboard%)
GBOARD_ZBASU = $(BREDI) awk -F '\t' -- 'BEGIN { print("\# Gboard Dictionary version:2"); print("\# Gboard Dictionary format:shortcut	word	language_tag	pos_tag"); } { printf("%s\t%s\tja-JP\t\n", ENVIRON["SINXA"] $$1, $$2); }' '$(<)' >'$(@)'

# Mozc
# ----

MOZC_LISTE = $(GIMVEI:%=$(VASRU)/mozc%)
MOZV_ZBASU = $(BREDI) awk -F '\t' -- '{ printf("%s\t%s\t固有名詞\t%s\n", ENVIRON["SINXA"] $$1, $$2, $$3); }' '$(<)' >'$(@)'

# Microsoft IME
# -------------

MSIME_LISTE = $(GIMVEI:%=$(VASRU)/msime%)
MSIME_ZBASU = $(BREDI) awk -F '\t' -- '{ printf("%s\t%s\t固有名詞\t%s\r\n", ENVIRON["SINXA"] $$1, $$2, $$3); }' '$(<)' | { printf '\377\376' && iconv -f UTF-8 -t UTF-16LE; } >'$(@)'

# zbasu
# =====

ro: anthy gboard mozc msime

# Anthy
# -----

anthy: $(ANTHY_LISTE)

$(GIMVEI:%=$(VASRU)/anthy%): $(GIMTERGAHI)
	$(ANTHY_ZBASU)

# Gboard
# ------

gboard: $(GBOARD_LISTE)

$(GIMVEI:%=$(VASRU)/gboard%): $(GIMTERGAHI)
	$(GBOARD_ZBASU)

# Mozc
# ----

mozc: $(MOZC_LISTE)

$(GIMVEI:%=$(VASRU)/mozc%): $(GIMTERGAHI)
	$(MOZC_ZBASU)

# Microsoft IME
# -------------

msime: $(MSIME_LISTE)

$(GIMVEI:%=$(VASRU)/msime%): $(GIMTERGAHI)
	$(MSIME_ZBASU)

# zbepi
# ------

$(GIMTERGAHI): gismu.tsv
	$(BREDI) awk -F '\t' -- '{ terkancu = split($$3, kana, ","); for(xi = 1; xi <= terkancu; xi++) { printf("%s\t%s\t%s\n", kana[xi], $$1, $$2); }; }' '$(<)' | LANG=C sort -o '$(@)'

# drata
# -----

LICENSE.txt:
	curl -sSfLo '$(@)' -- 'https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt'

# vimcu
# =====

vimcu:
	rm -f -- $(ANTHY:%='%') $(GBOARD:%='%') $(MOZC:%='%') $(MSIME:%='%') '$(GIMTERGAHI)'

zahurehu: vimcu
	$(MAKE)

# gubni
# =====

gubni: ro
	glab release create '$(NAMCU)' --name ".i li $(NAMCU) velfarvi sinxa" --notes "$$(git tag -l '$(NAMCU)' --format='%(contents)')" --no-update --use-package-registry $$(find "$(VASRU)" -name '*.txt' -type f | LANG=C sort)

mipri:
	if glab release view '$(NAMCU)' >/dev/null 2>&1; then \
		glab release delete '$(NAMCU)' -y; \
	fi

# notci
# =====

sidju:
	echo "zbasu lo valsi liste be pi'o la'o zoi ponjo IME zoi"
	echo
	echo "pilno tadji:"
	echo "  make [OPTION...] [MACRO=VALUE...] [TARGET...]"
	echo
	echo "TARGET:"
	echo "  ro       zbasu ro da"
	echo "  anthy    zbasu lo se pilno be la'o zoi Anthy zoi"
	echo "  gboard   zbasu lo se pilno be la'o zoi Gboard zoi"
	echo "  mozc     zbasu lo se pilno be la'o zoi Mozc zoi"
	echo "  msime    zbasu lo se pilno be la'o zoi Microsoft IME zoi"
	echo "  vimcu    vimcu lo se zbasu"
	echo "  zahurehu za'u re'u zbasu"
	echo "  gubni    lo se zbasu cu co'a gubni"
	echo "  mipri    mipri lo gubni"
	echo "  sidju    jarco tu'a lo ti sidju notci"
	echo "  velfarvi jarco tu'a lo ve farvi datni"

velfarvi:
	echo '$(NAMCU)'
