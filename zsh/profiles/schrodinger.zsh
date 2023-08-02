# Find latest Schrödinger version
location=~/progs/schrodinger
latest_version=`ls $location/ -1 | tail -n 1`
latest_build=`ls $location/$latest_version -1 | tail -n 1`
export SCHRODINGER=$location/$latest_version/$latest_build

if [[ $(grep microsoft /proc/version) ]]
then
  location="/mnt/c/Program Files"
  export WIN_SCHRO=`ls $location/Schrodinger* -1 -d | tail -n 1`
fi
