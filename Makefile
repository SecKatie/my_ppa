.PHONY: generate-repo
generate-repo: repo.generated

repo.generated: debian/InRelease debian/joshuamulliken_ppa.list
	touch repo.generated

debian/joshuamulliken_ppa.list:
	echo "deb https://joshuamulliken.github.io/my_ppa/debian ./" > debian/joshuamulliken_ppa.list

debian/InRelease: debian/Release.gpg
	@echo "# Please run the following command on the machine with access to the private key:"
	@echo "gpg --clearsign -o - debian/Release > debian/InRelease"
	@read -p "Press enter to continue..." ARG

debian/Release.gpg: debian/Release
	@echo "# Please run the following command on the machine with access to the private key:"
	@echo "gpg -abs -o - debian/Release > debian/Release.gpg"
	@read -p "Press enter to continue..." ARG

debian/Packages: debian croc/build.done
	cp croc/croc*.deb debian
	cd debian && dpkg-scanpackages -m . > Packages

debian/Packages.gz: debian/Packages
	gzip -k -f debian/Packages

debian/Release: debian/Packages.gz
	cd debian && apt-ftparchive release . > Release

croc/build.done:
	cd croc && make $*

debian:
	@echo "# Please create the following directory and files:"
	@echo "- debian/"
	@echo "- debian/KEY.gpg"
	@exit 1

.PHONY: clean
clean:
	rm -rf debian/croc* debian/Packages* debian/Release* debian/InRelease
	cd croc && make clean