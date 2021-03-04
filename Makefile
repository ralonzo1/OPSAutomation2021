shell = ${SHELL}
.PHONY: all clean test default hook unhook

setup:
	$(info ******** Setup Terraform ********)
	@chmod +x scripts/setup.sh && ./scripts/setup.sh
