#!/bin/env python
###
###
###
Author = 'Adam Grigolato'
Version = '0'
###
###
###
import json
import yaml


def p2j(pson):
    jsout = json.loads( pson, "latin_1")
    return jsout

def j2p(json):
    psout = json.dump(json, "latin_1")
    return psout
    
def j2y(json):
    ymlout = yaml.safe_dump(json.loads(json))
    return ymlout
