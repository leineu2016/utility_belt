SRC=.
DEPS_VER=v0.2.1
DEPS_PREFIX=https://github.com/tyrchen/mix-deps/releases/download
BUILDS_FILE=builds.tgz
DEPS_FILE=deps.tgz
BUILDS_URL=$(DEPS_PREFIX)/$(DEPS_VER)/$(BUILDS_FILE)
DEPS_URL=$(DEPS_PREFIX)/$(DEPS_VER)/$(DEPS_FILE)

extract-deps:
	@cd $(SRC); wget $(BUILDS_URL) --quiet; wget $(DEPS_URL) --quiet; tar zxf $(BUILDS_FILE); tar zxf $(DEPS_FILE); rm $(BUILDS_FILE) $(DEPS_FILE);
