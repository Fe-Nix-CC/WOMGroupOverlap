# Check if a group on wise old man and f2p wiki have overlap

womid="7802" # Fe Nix clan ID
wikiid="F2P_IM_Clan" # f2p im clan ID

# Let user know things are happening
echo "Starting check for overlap between groups..."

# create a temporary directory to download files in
tempdir=`mktemp -d` || exit 1
cd $tempdir

# download csv of wom group
wget "http://api.wiseoldman.net/v2/groups/$womid/csv" -O womgroup.csv -q

# download html of wiki group
wget "https://www.f2p.wiki/clans/$wikiid" -O wikigroup.html -q

# remove header row and get first column from wom csv file
cat womgroup.csv | tail -n+2 | cut -d, -f1 | sort | tr '[:upper:]' '[:lower:]' | cat > womgroup

# look for all links to a player page from wiki page to get member names
cat wikigroup.html | grep "players/" | sed "s|.*players/\([^\"]*\)\".*|\1|g" | \
	sort | tr '[:upper:]' '[:lower:]' | cat > wikigroup

# find the overlap
comm -12 womgroup wikigroup > overlap

# print results
echo "Total number of members in both groups: $(wc -l overlap | cut -d ' ' -f1)"
echo "List of all members in both groups follows:"
cat overlap