#!/bin/sh

echo '\nKilling Dynamo Running on Port 8000'

lsof -i :8000 | sed "1 d" | cut -c 9-13 > dynamo.pid

read dynamoPID < dynamo.pid

echo `Killing Dynamo Running on PID: $dynamoPID`

kill -9 $dynamoPID

rm dynamo.pid

echo '\nDone..!'
