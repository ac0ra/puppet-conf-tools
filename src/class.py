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

class pupclass(object):
    def __init__( self, type, repo, name, json = "" ):
        self.name = name
        self.type = type
        self.file = "{}/heiradata/{}.{}".format(repo,name,type)
        self.json = json


    def add(self):
        if self.type == "yaml":
            with open(self.file, 'w') as outfile:
                yaml.dump(json.loads(self.json), outfile, default_flow_style=True)
        elif self.type == "json":
            with open(self.file, 'w') as outfile:
                json.dump(self.json, outfile, indent=4)
            
            


    def delete(self):
        os.remove(self.file)

    def debug(self):
        print(self.name)
        print(self.type)
        print(self.file)
        print(self.json)


test = pupclass("json", "/home/cora/.pupcon/repos/C0R3/", "test")
test.debug()

    
