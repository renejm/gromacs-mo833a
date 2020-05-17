#!/bin/bash

for f in ./*.pub; do
	cat $f >> ~/.ssh/authorized_keys
done
