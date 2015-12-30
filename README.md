####ZipCutter Utility :

In Unix, there is a very good utility called - zipsplit
zipsplit will split an archive into smaller, sequentially-numbered zipfiles.
It is generally used to split a large archive into smaller parts, each of which is no larger than the <size in bytes> specified.

ZipCutter Utility is written in Ruby/JRuby which solves the same purpose, but you can provide the chunk size as number of files instead of bytes.
e.g. If you have a big zip file which contains 1000 files and you want to split it into smaller zips with 200 files each, then you can run the utility as ->

####Usage :

$ jruby zip_cutter.rb --chunk-size=200 --zip-file=Archive.zip

"Total Number of entries in the zip file -> 1000"

"Zipping 200 files into Archive_1.zip..."

"Zipping 200 files into Archive_2.zip..."

"Zipping 200 files into Archive_3.zip..."

"Zipping 200 files into Archive_4.zip..."

"Zipping 200 files into Archive_5.zip..."

"Zip Split Complete."

Please note the SRC and DEST in the script. These are hardcoded from my machine path, but you can modify the script according to your needs or even make those as part of arguments. Feel free to modify the script as per your needs.

Using **jruby 1.7.0 (1.9.3p203)**

For Zip/Unzip, I am using java.util.zip package, because it can handle zips > 4 GB. 