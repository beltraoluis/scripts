#!/bin/bash

cert_file="$1"

openssl x509 -in "$cert_file" -text -noout