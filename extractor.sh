#!/bin/bash

# Copy extract.sh, optparse.bash, mapextractor, mmaps_generator, 
# vmap4extractor and vmap4assembler to the folder in which WoW.exe is located.
# Type extract.sh --help for help.
# Execution examples:
# ./extract.sh -ca --> Clean up app directories and generate content.
# ./extract.sh -cas --> Cleanup all directories, then exit.
# ./extract.sh -cm -d <destination> --> Clean up directories required for 
# map extraction (maps, Cameras, dbc), then extract maps and copy them 
# to destination.
# ./extract.sh -Vs -d <destination> --> Move previously created vmaps and 
# Buildings to destination



# https://github.com/nk412/optparse
# OPTPARSE START
# Source the optparse.bash file ---------------------------------------------------
source optparse.bash
# Define options
optparse.define short=c long=cleanup desc="Cleanup extracted files." variable=cleanup value=true default=false
optparse.define short=a long=all desc="Extract all." variable=extract_all value=true default=false
optparse.define short=m long=maps desc="Extract maps." variable=extract_maps value=true default=false
optparse.define short=M long=mmaps desc="Generate mmaps." variable=generate_mmaps value=true default=false
optparse.define short=v long=vmaps desc="Extract vmaps." variable=extract_vmaps value=true default=false
optparse.define short=V long=mmaps desc="Assemble vmaps." variable=assemble_vmaps value=true default=false
optparse.define short=d long=destination desc="Copy resources to <destination>" variable=destination default=.;
optparse.define short=s long=skip desc="Skip extraction." variable=skip value=true default=false

# Source the output file ----------------------------------------------------------
source $( optparse.build );
# OPTPARSE END

# Abortion criteria
if [ "$cleanup" = "true" ] && ! [ "$destination" = "." ] ; then
  echo "Error: Flags -c and -d cannot be used together!";
	exit 1;
fi

# Set variables
if [ "$extract_all" = "true" ]; then
  extract_maps='true';
  generate_mmaps='true';
  extract_vmaps='true';
  assemble_vmaps='true';
fi


# Cleanup
if [ "$cleanup" = "true" ]; then
  if [ "$extract_maps" = "true" ]; then
    rm -r maps Cameras dbc;
  fi
  if [ "$extract_vmaps" = "true" ]; then
    rm -r vmaps Buildings;
  fi 
  if [ "$generate_mmaps" = "true" ]; then
    rm -r mmaps;
  fi
fi

# Extract content
if [ "$skip" = "false" ]; then
  if [ "$extract_maps" = "true" ]; then
    ./mapextractor;
  fi

  if [ "$extract_vmaps" = "true" ]; then
    ./vmap4extractor;
  fi

  if [ "$assemble_vmaps" = "true" ]; then
    ./vmap4assembler;
  fi

  if [ "$generate_mmaps" = "true" ]; then
    ./mmaps_generator;
  fi
fi

# Copy files to destination
if ! [ "${destination}" = "." ]; then
  mkdir -p "${destination}";
  if [ "$extract_maps" = "true" ]; then
    cp -r maps "${destination}"/maps;
    cp -r dbc "${destination}"/dbc;
    cp -r Cameras "${destination}"/Cameras;
  fi
  if [ "$extract_vmaps" = "true" ] || [ "$assemble_vmaps" = "true" ]; then
    cp -r vmaps "${destination}"/vmaps;
  fi 
  if [ "$assemble_vmaps" = "true" ]; then
    cp -r Buildings "${destination}"/Buildings;
  fi 
  if [ "$generate_mmaps" = "true" ]; then
    cp -r mmaps "${destination}"/mmaps;
  fi
fi

exit 0; 
