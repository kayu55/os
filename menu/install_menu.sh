#!/bin/bash

 Mengunduh dan mengekstrak menu.zip
apt update -y
apt install -y unzip

    wget https://raw.githubusercontent.com/kayu55/os/main/menu/menu.zip
    unzip menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip