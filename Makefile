shell = ${SHELL}
.PHONY: all clean test default hook unhook

setup:
	$(info ******** Setup Terraform ********)
	@cp /.config/.env .
	# We want to copy the versioned source file to the root and use this, it can be altered for use but is ignored in git
	@/bin/bash -c ". .env"
	@chmod +x scripts/setup.sh && ./scripts/setup.sh
