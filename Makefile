all:
	@echo "try 'make install'"

FILES = \
	bash_aliases \
	gitconfig \
	ssh/allowed_signers \
	inputrc \
	exrc \
	vimrc

install:
	@for f in $(FILES); do \
		if ! diff -N ~/.$$f $$f >/dev/null; then \
			echo "replacing ~/.$$f"; \
			cat $$f > ~/.$$f; \
		fi; \
	done

pull:
	@for f in $(FILES); do \
		if ! diff ~/.$$f $$f >/dev/null; then \
			echo "ingesting $$f"; \
			cat ~/.$$f > $$f; \
		fi; \
	done
