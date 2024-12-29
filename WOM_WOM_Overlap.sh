# Check if two groups on wise old man have overlap

group1="7802" # Fe Nix clan ID
group2="1230" # f2p im clan ID

# Let user know things are happening
echo "Starting check for overlap between groups..."

# create a temporary directory to download files in
tempdir=`mktemp -d` || exit 1
cd $tempdir

# download csv of users for both groups
wget "http://api.wiseoldman.net/v2/groups/$group1/csv" -O group1.csv -q
wget "http://api.wiseoldman.net/v2/groups/$group2/csv" -O group2.csv -q

# remove header row and get first column from both csv files
cat group1.csv | tail -n+2 | cut -d, -f1 | sort | cat > group1
cat group2.csv | tail -n+2 | cut -d, -f1 | sort | cat > group2

# find the overlap
comm -12 group1 group2 > overlap

# print results
echo "Total number of members in both groups: $(wc -l overlap | cut -d ' ' -f1)"
echo "List of all members in both groups follows:"
cat overlap