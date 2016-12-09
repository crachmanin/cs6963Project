#!/bin/bash
ssh slave0 < clearRAM.sh
ssh slave1 < clearRAM.sh
ssh slave2 < clearRAM.sh
ssh master < clearRAM.sh
