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
##   version - 0.1.0
##   created - 2026-03-22
##   modified - 2026-03-28
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - awk, echo, iconv, printf, rm, sort
##   conforms-to - <https://pubs.opengroup.org/onlinepubs/9799919799/utilities/make.html>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/kanajbo>
##   * <Bag report at https://github.com/qq542vev/kanajbo/issues>

# Sp Targets
# ==========

.POSIX:

.PHONY: ro anthy gboard mozc msime vimcu zahurehu sidju terfarvi

.SILENT: sidju terfarvi

# Macro
# =====

TERFARVI = 0.1.0
VASRU = selzbasu
GIMTERGAHI = $(VASRU)/gimgafi.tsv
ROLSINXA = at bs noda
GIMVEI = $(ROLSINXA:%=-%-gismu.txt)
MKDIR = mkdir -p -- '$(@D)'
SET = set -efu -o pipefail
BREDI = \
	$(SET); $(MKDIR); \
	case '$(@F)' in \
		*'-at-'*) export SINXA='@';; \
		*'-bs-'*) export SINXA='\';; \
	esac;
ANTHY = $(GIMVEI:%=$(VASRU)/anthy%)
GBOARD = $(GIMVEI:%=$(VASRU)/gboard%)
MOZC = $(GIMVEI:%=$(VASRU)/mozc%)
MSIME = $(GIMVEI:%=$(VASRU)/msime%)

# zbasu
# =====

ro: anthy gboard mozc msime

# Anthy
# -----

anthy: $(ANTHY)

$(GIMVEI:%=$(VASRU)/anthy%): $(GIMTERGAHI)
	$(BREDI) awk -F '\t' -- '{ printf("%s \043T35*500 %s\n", ENVIRON["SINXA"] $$1, $$2); }' '$(<)' >'$(@)'

# Gboard
# ------

gboard: $(GBOARD)

$(GIMVEI:%=$(VASRU)/gboard%): $(GIMTERGAHI)
	$(BREDI) awk -F '\t' -- 'BEGIN { print("# Gboard Dictionary version:2"); print("# Gboard Dictionary format:shortcut	word	language_tag	pos_tag"); } { printf("%s\t%s\tja-JP\t\n", ENVIRON["SINXA"] $$1, $$2); }' '$(<)' >'$(@)'

# Mozc
# ----

mozc: $(MOZC)

$(GIMVEI:%=$(VASRU)/mozc%): $(GIMTERGAHI)
	$(BREDI) awk -F '\t' -- '{ printf("%s\t%s\t固有名詞\t%s\n", ENVIRON["SINXA"] $$1, $$2, $$3); }' '$(<)' >'$(@)'

# Microsoft IME
# -------------

msime: $(MSIME)

$(GIMVEI:%=$(VASRU)/msime%): $(GIMTERGAHI)
	$(BREDI) awk -F '\t' -- '{ printf("%s\t%s\t固有名詞\t%s\r\n", ENVIRON["SINXA"] $$1, $$2, $$3); }' '$(<)' | { printf '\377\376' && iconv -f UTF-8 -t UTF-16LE; } >'$(@)'

# zbepi
# ------

$(GIMTERGAHI): gismu.tsv
	$(BREDI) awk -F '\t' -- '{ terkancu = split($$3, kana, ","); for(xi = 1; xi <= terkancu; xi++) { printf("%s\t%s\t%s\n", kana[xi], $$1, $$2); }; }' '$(<)' | LANG=C sort -o '$(@)'

# vimcu
# =====

vimcu:
	rm -f -- $(ANTHY:%='%') $(GBOARD:%='%') $(MOZC:%='%') $(MSIME:%='%') '$(GIMTERGAHI)'

zahurehu: vimcu
	$(MAKE)

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
	echo "  sidju    jarco lo ti sidju notci"
	echo "  terfarvi jarco lo te farvi datni"

terfarvi:
	echo '$(TERFARVI)'
