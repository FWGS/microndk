#!/bin/sh
realpath()
{
echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

includes()
{
for inc in $INCLUDES;do echo \"$(realpath $inc)\",;done
}

std=gnu++98

cflags()
{
for entry in $CFLAGS
do
echo $(echo "$entry" | sed -e 's/"/\\\\\\\\\\"/g') > /dev/stderr
case "$entry" in
	-std\=*) std=$(echo $entry|cut -d '=' -f2) ;;
	*) echo                                 \"$(echo "$entry"|sed -e 's/"/\\\\\\\\\\"/g')\", ;;
esac
done
echo '				);'
echo '				OTHER_CPLUSPLUSFLAGS = ('
echo '					"$(OTHER_CFLAGS)",'
for entry in $CPPFLAGS;do echo 				\"$entry\",;done
}

BASEDIR=$(dirname $0)
echo Base directory: $BASEDIR
sample=$BASEDIR/sample
echo Sample project: $sample
cp -a $sample $1
parts=$BASEDIR/parts
echo Input pbxproj parts: $parts
project=$1/lib.xcodeproj/project.pbxproj
echo Output bpxproj file: $project
cat $parts/part1 > $project
includes >> $project
cat $parts/part2 >> $project
cflags >> $project
cat $parts/part3 >> $project
includes >> $$project
cat $parts/part4 >> $project
cflags >> $project
cat $parts/part5 >> $project
sed -i -e s/gnu++98/$std/g $project
$BASEDIR/XcodeProjAdder -XCP $1/lib.xcodeproj -SCSV $(for src in $SOURCES;do /bin/echo -n $(realpath $src),;done)
