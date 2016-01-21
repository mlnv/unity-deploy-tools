#! /bin/sh

project="${TRAVIS_REPO_SLUG##*/}"
package=$project.unitypackage

if [ "$project" == "unitypackage-ci" ]; then
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Preparing directories; -------------------------------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  mkdir ./Temp
  mkdir ./Deploy
  
  #grab everything inside CI/ except the files created during the build. Also grab the readme and license.
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Moving relevant files to Temp/ directory; ------------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  mv ./CI ./Temp/CI
  rm ./Temp/CI/*.pkg
  rm ./Temp/CI/*.log
  mv README.rst ./Temp/README.rst
  mv LICENSE ./Temp/LICENSE
  
  
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Writing new yml file; --------------------------------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo 'language: objective-c

install:
  - sh ./CI/py_set_up.sh
  - python ./CI/deploy_set_up.py
  - sh ./CI/unity_install.sh

script:
  - sh ./CI/unity_build.sh

env:
    global:
      - secure: Github_encrypted_token_here' >./Temp/.travis.yml
  cat ./Temp/.travis.yml
  
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Compressing relevant files to Deploy/ directory; -----------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  cd Temp/
  zip -r -X $project.zip .
  cd ..
  mv ./Temp/$project.zip ./Deploy/$project.zip
  
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Checking compression was successful; -----------------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  
  file=./Deploy/$project.zip
  
  if [ -e $file ];
  then
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	echo "Package compressed successfully: $file"
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	exit 0
  else
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	echo "Package not compressed. Aborting.---------------------------------------------------------------------------------------"
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	exit 1
  fi
else
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Compressing package to Deploy/ directory; ----------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  mkdir ./Deploy
  
  zip -r -X ./Deploy/$project.zip ./Project/$package \;
   
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  echo "Checking compression was successful; -----------------------------------------------------------------------------------"
  printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
  
  file=./Deploy/$project.zip
   
  if [ -e $file ];
  then
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	echo "Package compressed successfully: $file"
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	exit 0
  else
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	echo "Package not compressed. Aborting. --------------------------------------------------------------------------------------"
    printf '%s\n' ------------------------------------------------------------------------------------------------------------------------
	exit 1
  fi
fi
