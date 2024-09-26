#!/bin/bash

help()
{
	echo "this script for build mongo driver from source. (version 3.10)"
	echo "you can run this command with boost argument"
	echo "if you want to build with boost in c++17"
	exit
}


if [[ "$1" = "--help" ]] || [[ "$1" = "-h" ]]
then
	help
fi

echo "start installing ..."

sleep 1

# install curl
sudo apt install -y curl 

# download source code (version: 3.10.1)
curl -OL https://github.com/mongodb/mongo-cxx-driver/releases/download/r3.10.1/mongo-cxx-driver-r3.10.1.tar.gz
tar -xzf mongo-cxx-driver-r3.10.1.tar.gz
cd mongo-cxx-driver-r3.10.1/build

# configure the driver

if [[ "$1" = "boost" ]]
then

	cmake ..                                \
	    -DCMAKE_BUILD_TYPE=Release          \
	    -DBSONCXX_POLY_USE_BOOST=1           \
	    -DMONGOCXX_OVERRIDE_DEFAULT_INSTALL_PREFIX=OFF

else

	cmake ..                                \
	    -DCMAKE_BUILD_TYPE=Release          \
	    -DMONGOCXX_OVERRIDE_DEFAULT_INSTALL_PREFIX=OFF

fi

# build and install the driver
cmake --build .
sudo cmake --build . --target install

