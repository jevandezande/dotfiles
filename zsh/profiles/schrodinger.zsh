# Find latest Schrödinger version
location=~/progs/schrodinger
# Only look for directories beginning with 20
schrodinger_versions=($(find $location/20* -maxdepth 0 -type d -exec basename {} \;))
latest_schrodinger_version=$schrodinger_versions[-1]
latest_schrodinger_builds=($(find $location/$latest_schrodinger_version/* -maxdepth 0 -type d -exec basename {} \;))
latest_schrodinger_build=$latest_schrodinger_builds[-1]
export SCHRODINGER=$location/$latest_schrodinger_version/$latest_schrodinger_build

if [[ $(grep microsoft /proc/version) ]]
then
  location="/mnt/c/Program Files"
  export WIN_SCHRO=`ls $location/Schrodinger* -1 -d | tail -n 1`
fi
