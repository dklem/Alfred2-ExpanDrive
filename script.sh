expanpath=/usr/bin/expan
IFS=$'\n'
shopt -s nocasematch;

MountedVols=( "$(ls -1 /Volumes/)")

matched=0
for x in ${MountedVols[@]}; do
	if [[ $x == {query} ]]; then
		matched=1
		break
	fi
done

if [[ $matched = "1" ]]; then
	$expanpath eject {query}
else
	$expanpath connect {query}
fi