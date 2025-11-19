#!/usr/bin/env bash

echo "First request (expected: MISS)"
curl -i -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4iLCJ1c24iOiJhZG1pbjEiLCJpYXQiOjE3NjM1Mzc1NzgsImV4cCI6MTc2MzU0MTE3OH0.8E9eNixAjJVpcCdnVKNHnjxMV97S6Sn6RG2dbYd5q4M" http://localhost:8080/api/v1/data/items

echo ""
echo "------------------------------"

echo "Second request immediately (expected: HIT)"
curl -i -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4iLCJ1c24iOiJhZG1pbjEiLCJpYXQiOjE3NjM1Mzc1NzgsImV4cCI6MTc2MzU0MTE3OH0.8E9eNixAjJVpcCdnVKNHnjxMV97S6Sn6RG2dbYd5q4M" http://localhost:8080/api/v1/data/items
echo ""
echo "------------------------------"

echo "Third request immediately (expected: HIT)"
curl -i -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4iLCJ1c24iOiJhZG1pbjEiLCJpYXQiOjE3NjM1Mzc1NzgsImV4cCI6MTc2MzU0MTE3OH0.8E9eNixAjJVpcCdnVKNHnjxMV97S6Sn6RG2dbYd5q4M" http://localhost:8080/api/v1/data/items
echo ""
echo "------------------------------"

echo "Sleeping 2 seconds to expire microcache..."
sleep 2

echo "Fourth request after expiration (expected: MISS)"
curl -i -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4iLCJ1c24iOiJhZG1pbjEiLCJpYXQiOjE3NjM1Mzc1NzgsImV4cCI6MTc2MzU0MTE3OH0.8E9eNixAjJVpcCdnVKNHnjxMV97S6Sn6RG2dbYd5q4M" http://localhost:8080/api/v1/data/items
echo ""
echo "------------------------------"
