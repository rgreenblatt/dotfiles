#!/usr/bin/env bash

rm -f items.zip.gpg && zip -r items.zip items/ && \
    gpg -c --no-symkey-cache --cipher-algo AES256 items.zip && \
    rm items.zip
