base="$(cut -d ':' -f2 <<< '${{ matrix.base }}')"
echo "RELEASE_TAG=${{secrets.DOCKER_USERNAME}}/squeezelite:${base}" >> $GITHUB_ENV