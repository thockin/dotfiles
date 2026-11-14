all:
	@echo "try 'make install'"

# Keep this sorted
FILES = \
	bash_aliases \
	claude/settings.json \
	config/dlv/config.yml \
	config/nvim/init.vim \
	exrc \
	gitconfig \
	gitignore \
	inputrc \
	ssh/allowed_signers \
	tmux.conf \
	vimrc \
	vi/wordlist

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

