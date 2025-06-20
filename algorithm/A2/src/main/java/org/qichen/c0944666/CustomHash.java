package org.qichen.c0944666;

import java.util.ArrayList;

public class CustomHash {
    /**
     *
     * @param tableSize size of custom hashmap
     * @param key   key of custom hashmap
     * @return return index of custom when success, otherwise return -1
     */
    public int hash(int tableSize,  String key) {
        if (key == null || key.isEmpty()) {
            System.out.println("key can't be empty!");
            return -1;
        }
        if (tableSize <= 0) {
            System.out.println("invalid table size!");
            return -1;
        }
        int hash = 0;
        for (var letter: key.toCharArray()) {
            if (letter > 127) {
                System.out.println("key contains invalid letter!");
                return -1;
            }
            hash = (hash + letter) % tableSize;
        }
        return hash;
    }
}
