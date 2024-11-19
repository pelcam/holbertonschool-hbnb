#!/bin/bash

# Configuration
BASE_URL="http://localhost:5000/api/v1"
TEMP_FILE="/tmp/api_test_response.json"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print test result
print_result() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $1${NC}"
    else
        echo -e "${RED}✗ $1${NC}"
    fi
}

# Authentication Tests
echo "=== Authentication Tests ==="

# Register a new user
echo "Registering a new user..."
USER_REGISTER=$(curl -s -X POST "$BASE_URL/users/" \
    -H "Content-Type: application/json" \
    -d '{
        "first_name": "Test",
        "last_name": "User",
        "email": "testuser@example.com",
        "password": "testpassword"
    }')
echo "$USER_REGISTER"
print_result "User Registration"

# Login to get access token
echo "Logging in..."
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/auth/login" \
    -H "Content-Type: application/json" \
    -d '{
        "email": "testuser@example.com",
        "password": "testpassword"
    }')
ACCESS_TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)
echo "Access Token: $ACCESS_TOKEN"
print_result "User Login"

# Place Tests
echo -e "\n=== Place Tests ==="

# Create a place
echo "Creating a place..."
PLACE_CREATE=$(curl -s -X POST "$BASE_URL/places/" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d '{
        "title": "Test Place",
        "description": "A beautiful test place",
        "price": 100.50,
        "latitude": 40.7128,
        "longitude": -74.0060,
        "owner": "'$(echo "$USER_REGISTER" | grep -o '"id":"[^"]*' | cut -d'"' -f4)'"
    }')
PLACE_ID=$(echo "$PLACE_CREATE" | grep -o '"id":"[^"]*' | cut -d'"' -f4)
echo "$PLACE_CREATE"
print_result "Place Creation"

# Get place details
echo "Retrieving place details..."
curl -s "$BASE_URL/places/$PLACE_ID"
print_result "Get Place Details"

# Update place
echo "Updating place..."
curl -s -X PUT "$BASE_URL/places/$PLACE_ID" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d '{
        "title": "Updated Test Place",
        "price": 150.75
    }'
print_result "Update Place"

# Amenity Tests
echo -e "\n=== Amenity Tests ==="

# Create an amenity
echo "Creating an amenity..."
AMENITY_CREATE=$(curl -s -X POST "$BASE_URL/amenities/" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d '{"name": "Test Amenity"}')
AMENITY_ID=$(echo "$AMENITY_CREATE" | grep -o '"id":"[^"]*' | cut -d'"' -f4)
echo "$AMENITY_CREATE"
print_result "Amenity Creation"

# Add amenity to place
echo "Adding amenity to place..."
curl -s -X POST "$BASE_URL/places/$PLACE_ID/add_amenity/$AMENITY_ID" \
    -H "Authorization: Bearer $ACCESS_TOKEN"
print_result "Add Amenity to Place"

# Review Tests
echo -e "\n=== Review Tests ==="

# Create a review
echo "Creating a review..."
REVIEW_CREATE=$(curl -s -X POST "$BASE_URL/reviews/" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d '{
        "text": "Great place!",
        "rating": 5,
        "user_id": "'$(echo "$USER_REGISTER" | grep -o '"id":"[^"]*' | cut -d'"' -f4)'",
        "place_id": "'$PLACE_ID'"
    }')
REVIEW_ID=$(echo "$REVIEW_CREATE" | grep -o '"id":"[^"]*' | cut -d'"' -f4)
echo "$REVIEW_CREATE"
print_result "Review Creation"

# Get reviews for place
echo "Retrieving place reviews..."
curl -s "$BASE_URL/reviews/places/$PLACE_ID"
print_result "Get Place Reviews"

# Cleanup Tests
echo -e "\n=== Cleanup Tests ==="

# Delete review
echo "Deleting review..."
curl -s -X DELETE "$BASE_URL/reviews/$REVIEW_ID" \
    -H "Authorization: Bearer $ACCESS_TOKEN"
print_result "Delete Review"

# Delete place
echo "Deleting place..."
curl -s -X DELETE "$BASE_URL/places/$PLACE_ID" \
    -H "Authorization: Bearer $ACCESS_TOKEN"
print_result "Delete Place"

# Delete amenity
echo "Deleting amenity..."
curl -s -X DELETE "$BASE_URL/amenities/$AMENITY_ID" \
    -H "Authorization: Bearer $ACCESS_TOKEN"
print_result "Delete Amenity"
