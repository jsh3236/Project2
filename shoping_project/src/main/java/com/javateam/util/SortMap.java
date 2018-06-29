package com.javateam.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

public class SortMap {

	public List sortByValue( Map map) {

        List<String> list = new ArrayList();

        list.addAll(map.keySet());


        Collections.sort(list,new Comparator() {

            public int compare(Object o1,Object o2) {

                Object v1 = map.get(o1);

                Object v2 = map.get(o2);

                 

                return ((Comparable) v2).compareTo(v1);

            }

        });

        Collections.reverse(list); // 주석시 오름차순

        return list;

    }

	
}
