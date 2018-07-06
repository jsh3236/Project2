package com.javateam.util;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PaymentComplVO;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Log
public class VOCountCalC {
	
	public Map<Integer, Integer> toMap(List<OrderListVO> list) {
		
		System.out.println("list :"+list);
		
		Map<Integer,Integer> map = new TreeMap<>();
		
		list.forEach(x->map.put(x.getBoardNum(), getCountNum(list, x.getBoardNum())));	
		
		return map;
	}
	
	public int getCountNum(List<OrderListVO> list, int boardNum) {
		
		
		return (int) list.stream().filter(x->(x.getBoardNum()==boardNum)).count();
		
	}
	
	public Map<Integer, Integer> toMap2(List<PaymentComplVO> list) {
		
		System.out.println("list :"+list);
		
		Map<Integer,Integer> map = new TreeMap<>();
		
		list.forEach(x->map.put(x.getBoardNum(), getCountNum2(list, x.getBoardNum())));	
		
		return map;
	}
	
	public int getCountNum2(List<PaymentComplVO> list, int boardNum) {
		
		
		return (int) list.stream().filter(x->(x.getBoardNum()==boardNum)).count();
		
	}
	
	
	public Map<Integer, Integer> toMap3(List<PaymentComplVO> list) {
		
		System.out.println("list :"+list);
		
		Map<Integer,Integer> map = new TreeMap<>();
		
		list.forEach(x->map.put(x.getPaymentNum(), getCountNum3(list, x.getPaymentNum())));	
		
		return map;
	}
	
	public int getCountNum3(List<PaymentComplVO> list, int paymentNum) {
		
		return (int) list.stream().filter(x->(x.getPaymentNum()==paymentNum)).count();
		
	}
	
	public Map<Integer, Integer> paging(int[] key) {
		
		System.out.println("key :"+key);
		
		Map<Integer,Integer> map = new TreeMap<>();
		System.out.println("key.length :"+key.length);
		for(int i=0; i<key.length; i++) {
			map.put(key[i], (int) Math.ceil((key.length-i+3)/4));
		}
		
		return map;
	}
	
	
	
}
