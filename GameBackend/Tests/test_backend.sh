#!/bin/zsh

# Config
BASE_URL="http://localhost:5299"
EMAIL="user1234@testmail.com"
PASSWORD="TestPassword123!"
USERNAME="testplayer"

# Register user
echo "\n--- Registering user ---"
REGISTER_RESPONSE=$(curl -s -X POST "$BASE_URL/register" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\",\"username\":\"$USERNAME\"}")

echo "Register response:"
echo $REGISTER_RESPONSE

# Login user
echo "\n--- Logging in user ---"
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

echo "Login response:"
echo $LOGIN_RESPONSE

# Extract access token from login JSON
ACCESS_TOKEN=$(echo $LOGIN_RESPONSE | python3 -c "import sys, json; print(json.load(sys.stdin).get('access_token',''))")

if [ -z "$ACCESS_TOKEN" ]; then
  echo "Login failed! Exiting."
  exit 1
fi

echo "\nAccess token: $ACCESS_TOKEN"

# Submit a score
echo "\n--- Submitting score ---"
SCORE_RESPONSE=$(curl -s -X POST "$BASE_URL/scores" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"value":500,"lives":3,"duration":45,"mode":"classic"}')

echo "Score response:"
echo $SCORE_RESPONSE

# Check profile (/me)
echo "\n--- Checking profile (/me) ---"
PROFILE_RESPONSE=$(curl -s -X GET "$BASE_URL/me" \
  -H "Authorization: Bearer $ACCESS_TOKEN")

echo "Profile response:"
echo $PROFILE_RESPONSE

# Get leaderboard
echo "\n--- Leaderboard ---"
LEADERBOARD_RESPONSE=$(curl -s -X GET "$BASE_URL/leaderboard?limit=10&threshold=100")

echo "Leaderboard response:"
echo $LEADERBOARD_RESPONSE

echo "\n--- End of test ---"
