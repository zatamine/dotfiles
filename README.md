# Amine's Dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

### Installation

On a new machine, install Manage your dotfiles across multiple diverse machines, securely

Usage:
  chezmoi [command]

Documentation commands:
  doctor               Check your system for potential problems
  help                 Print help about a command
  license              Print license

Daily commands:
  add                  Add an existing file, directory, or symlink to the source state
  apply                Update the destination directory to match the target state
  chattr               Change the attributes of a target in the source state
  diff                 Print the diff between the target state and the destination state
  edit                 Edit the source state of a target
  forget               Remove a target from the source state
  init                 Setup the source directory and update the destination directory to match the target state
  merge                Perform a three-way merge between the destination state, the source state, and the target state
  merge-all            Perform a three-way merge for each modified file
  re-add               Re-add modified files
  status               Show the status of targets
  update               Pull and apply any changes

Template commands:
  cat                  Print the target contents of a file, script, or symlink
  data                 Print the template data
  execute-template     Execute the given template(s)

Advanced commands:
  cd                   Launch a shell in the source directory
  edit-config          Edit the configuration file
  edit-config-template Edit the configuration file template
  generate             Generate a file for use with chezmoi
  git                  Run git in the source directory
  ignored              Print ignored targets
  managed              List the managed entries in the destination directory
  unmanaged            List the unmanaged files in the destination directory
  verify               Exit with success if the destination state matches the target state, fail otherwise

Encryption commands:
  age                  Interact with age
  age-keygen           Generate an age identity or convert an age identity to an age recipient
  decrypt              Decrypt file or standard input
  edit-encrypted       Edit an encrypted file
  encrypt              Encrypt file or standard input

Remote commands:
  docker               Use your dotfiles in a Docker container
  ssh                  SSH to a host and initialize dotfiles

Migration commands:
  archive              Generate a tar archive of the target state
  destroy              Permanently delete an entry from the source state, the destination directory, and the state
  import               Import an archive into the source state
  purge                Purge chezmoi's configuration and data
  upgrade              Upgrade chezmoi to the latest released version

Internal commands:
  cat-config           Print the configuration file
  completion           Generate shell completion code
  dump                 Generate a dump of the target state
  dump-config          Dump the configuration values
  secret               Interact with a secret manager
  source-path          Print the source path of a target
  state                Manipulate the persistent state
  target-path          Print the target path of a source path

Flags:
      --age-recipient string                           Override age recipient
      --age-recipient-file string                      Override age recipient
      --cache path                                     Set cache directory (default /Users/zatamine/.cache/chezmoi)
      --color bool|auto                                Colorize output (default auto)
  -c, --config path                                    Set config file
      --config-format <none>|json|toml|yaml            Set config file format
      --debug                                          Include debug information in output
  -D, --destination path                               Set destination directory (default /Users/zatamine)
  -n, --dry-run                                        Do not make any modifications to the destination directory
      --error-on-conflict                              Error on conflict
      --force                                          Make all changes without prompting
  -h, --help                                           help for chezmoi
      --interactive                                    Prompt for all changes
  -k, --keep-going                                     Keep going as far as possible after an error
      --less-interactive                               Prompt for changed or pre-existing targets
      --mode file|symlink                              Mode (default file)
      --no-pager                                       Do not use the pager
      --no-tty                                         Do not attempt to get a TTY for prompts
  -o, --output path                                    Write output to path instead of stdout
      --override-data string                           Override data
      --override-data-file path                        Override data with file
      --persistent-state path                          Set persistent state file
      --progress bool|auto                             Display progress bars (default auto)
  -R, --refresh-externals always|auto|never[=always]   Refresh external cache (default auto)
      --skip-secrets                                   Skip all templates containing secrets
  -S, --source path                                    Set source directory (default /Users/zatamine/.local/share/chezmoi)
      --source-path                                    Specify targets by source path
      --use-builtin-age bool|auto                      Use builtin age (default auto)
      --use-builtin-diff                               Use builtin diff
      --use-builtin-git bool|auto                      Use builtin git (default auto)
  -v, --verbose                                        Make output more verbose
      --version                                        version for chezmoi
  -W, --working-tree path                              Set working tree directory

Use "chezmoi [command] --help" for more information about a command. and initialize it from this repository:

```bash
# On macOS
brew install chezmoi

# On Linux (or general fallback)
sh -c "#!/bin/sh

# chezmoi install script
# contains code from and inspired by
# https://github.com/client9/shlib
# https://github.com/goreleaser/godownloader

# Copyright (C) 2017 Nick Galbreath
# Copyright (C) 2018 Tom Payne
# SPDX-License-Identifier: MIT

set -e

BINDIR="${BINDIR:-bin}"
TAGARG=latest
LOG_LEVEL=2

tmpdir="$(mktemp -d)"
trap 'rm -rf -- "${tmpdir}"' EXIT
trap 'exit' INT TERM

usage() {
	this="${1}"
	cat <<EOF
${this}: download chezmoi and optionally run chezmoi

Usage: ${this} [-b bindir] [-d] [-t tag] [chezmoi-args]
	-b	sets the installation directory, default is ${BINDIR}.
	-d	enables debug logging.
	-t	sets the tag, default is ${TAGARG}.
If chezmoi-args are given, after install chezmoi is executed with chezmoi-args.
EOF
	exit 2
}

main() {
	parse_args "${@}"
	shift "$((OPTIND - 1))"

	GOOS="$(get_goos)"
	GOARCH="$(get_goarch)"
	check_goos_goarch "${GOOS}/${GOARCH}"

	TAG="$(real_tag "${TAGARG}")"
	VERSION="${TAG#v}"

	log_info "found chezmoi version ${VERSION} for ${TAGARG}/${GOOS}/${GOARCH}"

	BINSUFFIX=
	FORMAT=tar.gz
	GOOS_EXTRA=
	case "${GOOS}" in
	linux)
		case "${GOARCH}" in
		amd64)
			case "$(get_libc)" in
			glibc)
				GOOS_EXTRA="-glibc"
				;;
			musl)
				GOOS_EXTRA="-musl"
				;;
			esac
			;;
		esac
		;;
	windows)
		BINSUFFIX=.exe
		FORMAT=zip
		;;
	esac
	case "${GOARCH}" in
	386) arch=i386 ;;
	*) arch="${GOARCH}" ;;
	esac

	# download tarball
	NAME="chezmoi_${VERSION}_${GOOS}${GOOS_EXTRA}_${arch}"
	TARBALL="${NAME}.${FORMAT}"
	TARBALL_URL="https://github.com/twpayne/chezmoi/releases/download/${TAG}/${TARBALL}"
	http_download "${tmpdir}/${TARBALL}" "${TARBALL_URL}" || exit 1

	# download checksums
	CHECKSUMS="chezmoi_${VERSION}_checksums.txt"
	CHECKSUMS_URL="https://github.com/twpayne/chezmoi/releases/download/${TAG}/${CHECKSUMS}"
	http_download "${tmpdir}/${CHECKSUMS}" "${CHECKSUMS_URL}" || exit 1

	# verify checksums
	hash_sha256_verify "${tmpdir}/${TARBALL}" "${tmpdir}/${CHECKSUMS}"

	(cd -- "${tmpdir}" && untar "${TARBALL}")

	# install binary
	if [ ! -d "${BINDIR}" ]; then
		install -d "${BINDIR}"
	fi
	BINARY="chezmoi${BINSUFFIX}"
	install -- "${tmpdir}/${BINARY}" "${BINDIR}/"
	log_info "installed ${BINDIR}/${BINARY}"

	if [ -n "${1+n}" ]; then
		exec "${BINDIR}/${BINARY}" "${@}"
	fi
}

parse_args() {
	while getopts "b:dh?t:" arg; do
		case "${arg}" in
		b)
			if [ "${OPTARG}" = ".local/bin" ] || [ "${OPTARG}" = "./.local/bin" ]; then
				log_info "instead of using 'get.chezmoi.io -b .local/bin', use 'get.chezmoi.io/lb' instead"
			fi
			BINDIR="${OPTARG}"
			;;
		d) LOG_LEVEL=3 ;;
		h | \?) usage "${0}" ;;
		t) TAGARG="${OPTARG}" ;;
		*) return 1 ;;
		esac
	done
}

get_goos() {
	os="$(uname -s | tr '[:upper:]' '[:lower:]')"
	case "${os}" in
	cygwin_nt*) goos="windows" ;;
	linux)
		case "$(uname -o | tr '[:upper:]' '[:lower:]')" in
		android) goos="android" ;;
		*) goos="linux" ;;
		esac
		;;
	mingw*) goos="windows" ;;
	msys_nt*) goos="windows" ;;
	*) goos="${os}" ;;
	esac
	printf '%s' "${goos}"
}

get_goarch() {
	arch="$(uname -m)"
	case "${arch}" in
	aarch64) goarch="arm64" ;;
	arm64) goarch="arm64" ;;
	armv5*) goarch="armv5" ;;
	arm*) goarch="armv6" ;;
	i386) goarch="386" ;;
	i686) goarch="386" ;;
	i86pc) goarch="amd64" ;;
	x86) goarch="386" ;;
	x86_64) goarch="amd64" ;;
	*) goarch="${arch}" ;;
	esac
	printf '%s' "${goarch}"
}

check_goos_goarch() {
	case "${1}" in
	android/arm64) return 0 ;;
	darwin/amd64) return 0 ;;
	darwin/arm64) return 0 ;;
	freebsd/386) return 0 ;;
	freebsd/amd64) return 0 ;;
	freebsd/arm) return 0 ;;
	freebsd/arm64) return 0 ;;
	linux/386) return 0 ;;
	linux/amd64) return 0 ;;
	linux/armv5) return 0 ;;
	linux/armv6) return 0 ;;
	linux/arm64) return 0 ;;
	linux/loong64) return 0 ;;
	linux/mips64) return 0 ;;
	linux/mips64le) return 0 ;;
	linux/ppc64) return 0 ;;
	linux/ppc64le) return 0 ;;
	linux/riscv64) return 0 ;;
	linux/s390x) return 0 ;;
	openbsd/386) return 0 ;;
	openbsd/amd64) return 0 ;;
	openbsd/arm) return 0 ;;
	openbsd/arm64) return 0 ;;
	openbsd/ppc64) return 0 ;;
	windows/386) return 0 ;;
	windows/amd64) return 0 ;;
	*)
		log_crit '%s: unsupported platform
' "${1}" 1>&2
		return 1
		;;
	esac
}

get_libc() {
	if is_command ldd; then
		case "$(ldd --version 2>&1 | tr '[:upper:]' '[:lower:]')" in
		*glibc* | *"gnu libc"*)
			# If the version of glibc is too old then use the statically-linked
			# musl version instead. chezmoi releases are built on GitHub Actions
			# ubuntu-22.04 runners, which have glibc version 2.35.
			minimum_glibc_version=2.35
			glibc_version="$(ldd --version 2>&1 | awk '$1 == "ldd" { print $NF }')"
			# shellcheck disable=SC2046,SC2183
			minimum_glibc_version_string="$(printf "%03d%03d" $(echo "${minimum_glibc_version}" | tr "." " "))"
			# shellcheck disable=SC2046,SC2183
			glibc_version_string="$(printf "%03d%03d" $(echo "${glibc_version}" | tr "." " "))"
			log_info "found glibc version ${glibc_version}"
			if [ "${glibc_version_string}" -lt "${minimum_glibc_version_string}" ]; then
				printf musl
				return
			fi
			printf glibc
			return
			;;
		*musl*)
			printf musl
			return
			;;
		esac
	fi
	if is_command getconf; then
		case "$(getconf GNU_LIBC_VERSION 2>&1)" in
		*glibc*)
			printf glibc
			return
			;;
		esac
	fi
	log_crit "unable to determine libc" 1>&2
	exit 1
}

real_tag() {
	tag="${1}"
	log_debug "checking GitHub for tag ${tag}"
	release_url="https://github.com/twpayne/chezmoi/releases/${tag}"
	json="$(http_get "${release_url}" "Accept: application/json")"
	if [ -z "${json}" ]; then
		log_err "real_tag error retrieving GitHub release ${tag}"
		return 1
	fi
	real_tag="$(printf '%s
' "${json}" | tr -s '
' ' ' | sed 's/.*"tag_name":"//' | sed 's/".*//')"
	if [ -z "${real_tag}" ]; then
		log_err "real_tag error determining real tag of GitHub release ${tag}"
		return 1
	fi
	if [ -z "${real_tag}" ]; then
		return 1
	fi
	log_debug "found tag ${real_tag} for ${tag}"
	printf '%s' "${real_tag}"
}

http_get() {
	tmpfile="$(mktemp)"
	http_download "${tmpfile}" "${1}" "${2}" || return 1
	body="$(cat "${tmpfile}")"
	rm -f "${tmpfile}"
	printf '%s
' "${body}"
}

http_download_curl() {
	local_file="${1}"
	source_url="${2}"
	header="${3}"
	if [ -z "${header}" ]; then
		code="$(curl -w '%{http_code}' -fsSL -o "${local_file}" "${source_url}")"
	else
		code="$(curl -w '%{http_code}' -fsSL -H "${header}" -o "${local_file}" "${source_url}")"
	fi
	if [ "${code}" != "200" ]; then
		log_debug "http_download_curl received HTTP status ${code}"
		return 1
	fi
	return 0
}

http_download_wget() {
	local_file="${1}"
	source_url="${2}"
	header="${3}"
	if [ -z "${header}" ]; then
		wget -q -O "${local_file}" "${source_url}" || return 1
	else
		wget -q --header "${header}" -O "${local_file}" "${source_url}" || return 1
	fi
}

http_download() {
	log_debug "http_download ${2}"
	if is_command curl; then
		http_download_curl "${@}" || return 1
		return
	elif is_command wget; then
		http_download_wget "${@}" || return 1
		return
	fi
	log_crit "http_download unable to find wget or curl"
	return 1
}

hash_sha256() {
	target="${1}"
	if is_command sha256sum; then
		hash="$(sha256sum "${target}")" || return 1
		printf '%s' "${hash}" | cut -d ' ' -f 1
	elif is_command shasum; then
		hash="$(shasum -a 256 "${target}" 2>/dev/null)" || return 1
		printf '%s' "${hash}" | cut -d ' ' -f 1
	elif is_command sha256; then
		hash="$(sha256 -q "${target}" 2>/dev/null)" || return 1
		printf '%s' "${hash}" | cut -d ' ' -f 1
	elif is_command openssl; then
		hash="$(openssl dgst -sha256 "${target}")" || return 1
		printf '%s' "${hash}" | cut -d ' ' -f a
	else
		log_crit "hash_sha256 unable to find command to compute SHA256 hash"
		return 1
	fi
}

hash_sha256_verify() {
	target="${1}"
	checksums="${2}"
	basename="${target##*/}"

	want="$(grep "${basename}\$" "${checksums}" 2>/dev/null | tr '	' ' ' | cut -d ' ' -f 1)"
	if [ -z "${want}" ]; then
		log_err "hash_sha256_verify unable to find checksum for ${target} in ${checksums}"
		return 1
	fi

	got="$(hash_sha256 "${target}")"
	if [ "${want}" != "${got}" ]; then
		log_err "hash_sha256_verify checksum for ${target} did not verify ${want} vs ${got}"
		return 1
	fi
}

untar() {
	tarball="${1}"
	case "${tarball}" in
	*.tar.gz | *.tgz) tar -xzf "${tarball}" ;;
	*.tar) tar -xf "${tarball}" ;;
	*.zip) unzip -- "${tarball}" ;;
	*)
		log_err "untar unknown archive format for ${tarball}"
		return 1
		;;
	esac
}

is_command() {
	type "${1}" >/dev/null 2>&1
}

log_debug() {
	[ 3 -le "${LOG_LEVEL}" ] || return 0
	printf 'debug %s
' "${*}" 1>&2
}

log_info() {
	[ 2 -le "${LOG_LEVEL}" ] || return 0
	printf 'info %s
' "${*}" 1>&2
}

log_err() {
	[ 1 -le "${LOG_LEVEL}" ] || return 0
	printf 'error %s
' "${*}" 1>&2
}

log_crit() {
	[ 0 -le "${LOG_LEVEL}" ] || return 0
	printf 'critical %s
' "${*}" 1>&2
}

main "${@}""
```

### Setup

```bash
# Initialize and apply configuration
chezmoi init --apply git@github.com:zatamine/dotfiles.git
```

---

## 📂 Key Configurations

* **Git**:
  * `~/.gitconfig`: Main configuration with directory-based includeIf directives.
  * `~/.gitconfig-perso`: Personal profile config (uses GitHub noreply email).
  * `~/.gitconfig-pro`: Professional profile config (uses work email).
* **Shell**:
  * `~/.zshrc`: ZSH shell configuration.
  * `~/.bashrc`: Bash shell configuration.
* **Vim**:
  * `~/.vimrc`: Editor configuration.

---

## 🛠️ Common Workflows

### 1. Modifying an existing config file
Don't edit dotfiles directly in your home directory. Instead, use:
```bash
chezmoi edit ~/.gitconfig
```
This opens the file in your preferred editor from the chezmoi source directory.

### 2. Previewing changes
To see what changes would be made to your home directory:
```bash
chezmoi diff
```

### 3. Applying changes
To apply changes from the chezmoi source directory to your home directory:
```bash
chezmoi apply
```

### 4. Pushing changes to GitHub
To push updates back to this repository:
```bash
chezmoi cd
git add .
git commit -m "Update configurations"
git push origin master
```
