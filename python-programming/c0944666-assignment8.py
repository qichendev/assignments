#CSD-1233-01
# Assignment 8
#Qi Chen
#15 April 2025

import random

def dict_pop_item(my_dic):
    if (len(my_dic) == 0):
        return None
    ret = []
    index = random.randint(0, len(my_dic) - 1)
    random_popped_key = list(my_dic.keys())[index]
    random_popped_value = my_dic.pop(random_popped_key)
    ret.append(my_dic)
    ret.append(tuple([random_popped_key, random_popped_value]))
    return ret

for i in range(10):
    print(dict_pop_item({"bob":10,"ahmed":50}))