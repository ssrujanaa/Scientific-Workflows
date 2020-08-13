#!/usr/bin/env python3
with open("hp.txt", "r") as _if, open("wc.txt", "w") as of:
    words = {}
    for l in _if:
        for w in l.split():
            w = w.lower()
            for char in w:
                if not char.isalnum():
                    w = w.replace(char,"")
            if w in words:
                words[w] += 1
            elif w!= "":
                words[w] = 1

    for k,v in words.items():
        of.write("{} {}\n".format(k,v))

