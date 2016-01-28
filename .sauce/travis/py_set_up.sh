#! /bin/sh

printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
echo "Downloading Python 2.7.11; ---------------------------------------------------------------------------------------------"
printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
curl -o .sauce/Python.pkg https://www.python.org/ftp/python/2.7.11/python-2.7.11-macosx10.6.pkg

printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
echo "Installing Python 2.7.11; ----------------------------------------------------------------------------------------------"
printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
sudo installer -package .sauce/Python.pkg -target /

printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
echo "Upgrading pip; ---------------------------------------------------------------------------------------------------------"
printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
sudo -H pip install --upgrade pip

printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
echo "Installing requests; ---------------------------------------------------------------------------------------------------"
printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
sudo -H pip install requests

printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
echo "Installing TravisPy; ---------------------------------------------------------------------------------------------------"
printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
sudo -H pip install travispy