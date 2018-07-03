package com.javateam.util;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.javateam.model.vo.OrderListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class VOCountCalC {
	
	public Map<Integer, Integer> toMap(List<OrderListVO> list) {
		
		System.out.println("list :"+list);
		
		Map<Integer,Integer> map = new TreeMap<>();
		
		list.forEach(x->map.put(x.getBoardNum(), getCountNum(list, x.getBoardNum())));	
		
		return map;
	}
	
	public int getCountNum(List<OrderListVO> list, int boardNum) {
		
		log.info("boardNum : {}",boardNum);
		
		return (int) list.stream().filter(x->(x.getBoardNum()==boardNum)).count();
		
	}
	
	
	
}
