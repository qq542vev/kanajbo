# shellcheck shell=sh

# Defining variables and functions here will affect all specfiles.
# Change shell options inside a function may cause different behavior,
# so it is better to set them here.
# set -eu

# This callback function will be invoked only once before loading specfiles.
spec_helper_precheck() {
  # Available functions: info, warn, error, abort, setenv, unsetenv
  # Available variables: VERSION, SHELL_TYPE, SHELL_VERSION
  : minimum_version "0.28.1"
}

# This callback function will be invoked after a specfile has been loaded.
spec_helper_loaded() {
  :
}

# This callback function will be invoked after core modules has been loaded.
spec_helper_configure() {
  # Available functions: import, before_each, after_each, before_all, after_all
  : # import 'support/custom_matcher'
}

lidne_cpacu() {
	case "${1##*/}" in
		*-at-*) printf '^@.+' ;;
		*-bs-*) printf '^\\\\.+' ;;
		*-em-*) printf '^!.+' ;;
		*)      printf '^.+' ;;
	esac
}

morna_cpacu() {
	printf "^([a-gi-pr-vx-z]|([aeiou]('[aeiou])+))+$"
}

liste_cipra() {
	__tersepli="${1}"
	shift

	awk -F "${__tersepli}" -- '
		BEGIN {
			for(xi = 2; xi < ARGC; xi++) {
				morna[xi - 1] = ARGV[xi]
			}

			mei = ARGC - 2
			ARGC = 2
		}

		{
			if(NF != mei) {
				printf("fliba %d: [%s]\n", NR, $0)
				exit 1
			}

			for(xi = 1; xi <= NF; xi++) {
				if($xi !~ morna[xi]) {
					printf("fliba %d: [%s]\n", NR, $0)
					exit 1
				}
			}
		}
	' - "${@}" >&2
}
