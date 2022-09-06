all:
	@echo "try 'make install'"

FILES = bash_aliases \
	gitconfig \
	ssh/allowed_signers
	inputrc \
	exrc \
	vimrc

install:
	for f in $(FILES); do \
		cat $$f > ~/.$$f; \
	done

pull:
	for f in $(FILES); do \
		cat ~/.$$f > $$f; \
	done
