#!/bin/bash

 Mengunduh dan mengekstrak menu.zip
apt update -y
apt install -y unzip

    wget https://raw.githubusercontent.com/kayu55/os/main/menu/aryapro
    unzip aryapro
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf aryapro
    
    wget https://raw.githubusercontent.com/kayu55/os/main/menu/aryanet
    unzip aryanet
    chmod +x menu/*
    mv menu/* /usr/bin
    rm -rf menu
    rm -rf aryanet    
