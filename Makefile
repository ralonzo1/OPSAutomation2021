shell = ${SHELL}
.PHONY: all clean test default hook unhook
project := OPSAutomation

default:
	echo 'Makefile default target!'

dev-tools:
	$(info ******** Installing ASDF ********)
	@cd scripts || exit 1 && chmod +x asdf_install.sh && ./asdf_install.sh
	$(info ******** Installing Concourse Fly CLI ********)
	@cd scripts || exit 1 && chmod +x fly_install.sh && ./fly_install.sh

hook:
	# TODO: DESIGN THE GITHOOK
	#git config core.hooksPath .githooks
unhook:
	git config --unset core.hooksPath

install_asdf:
	cd scripts || exit 1 && chmod +x asdf_install.sh && ./asdf_install.sh

dev_docker:
	$(info ******** Installing Docker Environment ********)
	@cd build_scripts/dev || exit 1 && ./build_dev_docker.sh

dev_local:
	$(info ******** Installing Local Environment ********)
	@make install
	@make super_user
	@make start_server

start_server:
	$(info ******** Installing Python Environment and Starting Django Services ********)
	@dev/local/.python/bin/python ${project}/manage.py runserver

install:
	$(info ******** Installing Python Environment ********)
	@ ./scripts/pre-configure.sh
	@./scripts/setup.sh -c
	@cd scripts || exit 1 && chmod +x odbc_drivers.sh && ./odbc_drivers.sh
	@export CPPFLAGS="-I/opt/homebrew/Cellar/unixodbc/2.3.9/include" && export LDFLAGS="-L/opt/homebrew/Cellar/unixodbc/2.3.9/lib" && ./scripts/setup.sh -i

super_user:
	$(info ******** Create the SuperUser Account ********)
	@./scripts/setup.sh -s

clean:
	$(info ******** Removing Python Environments ********)
	@./scripts/setup.sh -c

	$(info ******** Removing Local Database Backups ********)
	@if [ -d database_backups ]; then rm -rf database_backups; fi
