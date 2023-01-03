# wow-extractor
Extractor script for use with TrinityCore tools that can be configured as a one-liner. Not thoroughly documented, but with usage examples.

Annoyed by official Trinity Core extractor being buggy and unpredictable? Check this out.

Thanks to nk412 for optparse! 
https://github.com/nk412/optparse/blob/master/sample_head.sh

# Usage
Used to extract WoW data for your TrinityCore server.
Copy the two scripts of this repository (`extractor.sh` and `optparse.bash`) along with `mapextractor`, `mmaps_generator`, `vmap4extractor` and `vmap4assembler` into where your `WoW.exe` is located (works for WotLk), then run `extractor.sh` with the required options.
You don't know what to do?
I recommend you to navigate to said folder using the terminal (Linux only), then type
```
./extractor.sh -ca -d '<server>/data'
```
This will clean up your WoW folder, extract files and copy them to where you need them.

# Additional examples

Type `extract.sh --help` for help.

Clean up app directories and generate content:
```
./extract.sh -ca 
```

Cleanup all directories, then exit:
```
./extract.sh -cas
```

Clean up directories required for map extraction (`maps`, `Cameras`, `dbc`), then extract maps and copy them to destination:
```
./extract.sh -cm -d <destination>
```

Move previously created `vmaps` and `Buildings` to destination:
```
# ./extract.sh -Vs -d <destination>
```

Feel free to ask questions!
