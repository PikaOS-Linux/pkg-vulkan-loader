#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/KhronosGroup/Vulkan-Loader.git
cd Vulkan-Loader
git checkout v1.3.278
mkdir vulkan-headers
cd vulkan-headers
git clone https://github.com/KhronosGroup/Vulkan-Headers.git .
git checkout v1.3.278
cd ..
cd ..
cp -rvf ./debian ./Vulkan-Loader
tar --transform 's,^,vulkan-loader_1.3.278.99pikaos/,' \
		--exclude-vcs \
		-cJf ../vulkan-loader_1.3.278.99pikaos.orig.tar.xz .

# Get build deps
apt-get update
apt-get build-dep ./ -y

# Build package

#LOGNAME=root dh_make --createorig -y -l -p vulkan-loader_1.3.278.99pikaos
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
