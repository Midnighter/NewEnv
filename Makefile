.PHONY: git vim zsh tmux docker pip virtualenv

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
THE_SHELL = zsh

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Install git configuration
git:
	sudo apt-get install git
	cp "${PROJECT_DIR}/${THE_SHELL}/.git*" "${HOME}/"

## Install vimrc with plugins
vim:
	sudo apt-get install vim-gtk
	cp "${PROJECT_DIR}/${THE_SHELL}/.vimrc" "${HOME}/"
	git clone "https://github.com/gmarik/Vundle.vim.git" "${HOME}/.vim/bundle/Vundle.vim"
	vim +PluginInstall +qall

## Install zshrc with oh-my-zsh and powerlevel9k
zsh:
	sudo apt-get install zsh
	cp "${PROJECT_DIR}/${THE_SHELL}/.zshrc" "${HOME}/"
	cd "${HOME}"
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	git clone "https://github.com/bhilburn/powerlevel9k.git" "~/.oh-my-zsh/custom/themes/powerlevel9k"
	cd "${PROJECT_DIR}"

## Install tmux configuration with plugins and tmuxifier
tmux:
	sudo apt-get install tmux xsel
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
	cp "${PROJECT_DIR}/${THE_SHELL}/.tmux.conf" "${HOME}/"

## Install docker and docker-compose
docker:
	sudo apt-get remove docker docker-engine docker.io
	sudo apt-get update
	# sudo apt-get install docker
	# https://github.com/docker/compose/releases

## Install pip configuration
pip:
	sudo apt-get install python-pip-whl
	mkdir "${HOME}/.pip"
	cp "${PROJECT_DIR}/${THE_SHELL}/pip.conf" "${HOME}/.pip/"

## Install Python virtualenv with virtualenvwrapper
virtualenv:
	sudo apt-get install python-virtualenv python3-virtualenv virtualenvwrapper
	mkdir "${WORKON_HOME}"
	cp ${PROJECT_DIR}/${THE_SHELL}/post* "${WORKON_HOME}/"

## Install node version manager
node:

## Install ruby version manager
ruby:

## Install rust version manager
rust:
	curl -L https://raw.github.com/sdepold/rsvm/master/install.sh | sh

## Install everything
install: git vim zsh tmux docker pip virtualenv

#################################################################################
# PROJECT RULES                                                                 #
#################################################################################



#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := show-help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: show-help
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
