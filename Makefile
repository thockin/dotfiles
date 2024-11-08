all:
	@echo "try 'make install'"

FILES = \
	bash_aliases \
	gitconfig \
	gitignore \
	ssh/allowed_signers \
	inputrc \
	exrc \
	vimrc \
	vi/wordlist \
	config/dlv/config.yml \
	config/nvim/init.vim

install:
	@for f in $(FILES); do \
		if ! diff -N ~/.$$f $$f >/dev/null; then \
			echo "replacing ~/.$$f"; \
			mkdir -p ~/.$$(dirname $$f); \
			cat $$f > ~/.$$f; \
		fi; \
	done

pull:
	@for f in $(FILES); do \
		if ! diff ~/.$$f $$f >/dev/null; then \
			echo "ingesting $$f"; \
			mkdir -p $$(dirname $$f); \
			cat ~/.$$f > $$f; \
		fi; \
	done

diff:
	@for f in $(FILES); do \
		diff -uN ~/.$$f $$f || true; \
	done

