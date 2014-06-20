expanpath=/usr/bin/expan
perlpath=/usr/bin/perl
IFS=$'\n'

shopt -s nocasematch;

# Only works in Expandrive 4
# ServerList=( $($expanpath list | grep -v === | /usr/bin/perl -pi -e 's|^(.*)\s\s\s\s*\(.*$|$1|'))

# Works, but not with hostnames that have parentheses in them. 
# FIX in next version
ServerList=( $($expanpath list | grep -v === | /usr/bin/perl -pi -e 's|\s*\(.+$||'))

MountedVols=( "$(ls -1 /Volumes/)")

echo '<?xml version="1.0" encoding="utf-8"?>'
echo '<items>'
echo ''


for i in ${ServerList[@]}; do
	if [[ $i == *{query}* ]]; then
		matched=0
		for x in ${MountedVols[@]}; do
			if [[ $i == "$x" ]] ; then
				matched=1
			fi
		done
		echo "<item arg=\"$i\">"
		echo "<title>$i</title>"
		if [[ $matched = "1" ]]; then
			echo "<item arg=\"$i\" valid=\"yes\">"
			echo "<title>$i</title>"
			echo "<subtitle>Disconnect $i</subtitle>"
			echo "<icon>disconnect.png</icon></item>"
		else
			echo "<item arg=\"$i\" valid=\"yes\">"
			echo "<title>$i</title>"
			echo "<subtitle>Connect $i</subtitle>"
			echo "<icon>connect.png</icon></item>"
		fi
		echo ""
	fi
done
echo "</items>"