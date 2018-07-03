/**
 * 
 */
package com.javateam.service.deprecated;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.web.context.support.ServletContextParameterFactoryBean;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author oracle
 *
 */
@Repository
@Slf4j
@Transactional
public class JpaDAOImpl implements JpaDAO {
	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	private JpaTransactionManager transactionManager;

	@Autowired // 추가 : 트랜잭션 template 사용
	private TransactionTemplate transactionTemplate;

	/**
	 * @see com.javateam.springBoard.repository.JpaDAO#insert
	 *      (com.javateam.springBoard.domain.vo.BoardVO)
	 */
	/*
	 * @Override public void insert(BoardVO board) {
	 * 
	 * log.info("insert");
	 * 
	 * DefaultTransactionDefinition def = new DefaultTransactionDefinition();
	 * def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
	 * 
	 * TransactionStatus status = transactionManager.getTransaction(def);
	 * 
	 * try { entityManager.merge(board); // (O)
	 * 
	 * transactionManager.commit(status); // Spring transaction commit
	 * 
	 * } catch (Exception e) {
	 * 
	 * log.info("error : {}",e);
	 * 
	 * transactionManager.rollback(status); // Spring transaction rollback
	 * e.getStackTrace(); } //
	 * 
	 * } //
	 */
	@Override
	public void insert(BoardVO board) {

		System.out.println(board);

		transactionTemplate.execute(new TransactionCallbackWithoutResult() {

			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {

				try {

					entityManager.merge(board);

				} catch (Exception e) {

					log.debug("insert error : {}", e);
					status.setRollbackOnly();

				}
			}
		});
	}

	/**
	 * @see com.javateam.service.deprecated.springBoard.repository.JpaDAO#list()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BoardVO> list() {

		log.info("select All");

		return (List<BoardVO>) entityManager.createNativeQuery("SELECT * FROM board_tbl ORDER BY board_num", BoardVO.class)
				.getResultList();
	} //

	/**
	 * @see com.javateam.service.deprecated.springBoard.repository.JpaDAO#update(com.javateam.model.vo.springBoard.domain.vo.BoardVO)
	 */
	@Override
	public void update(BoardVO board) {

		log.info("update");
		System.out.println("update !!!");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		System.out.println("board.getBoardNum() : "+board.getBoardNum());

		try {
            entityManager.createNativeQuery("UPDATE board_tbl SET board_subject=?, board_price=?,board_file=?,board_filecontent=?,"
            		+ "board_content=? WHERE board_num=?")
            .setParameter(1, board.getBoardSubject())
            .setParameter(2, board.getBoardPrice())
            .setParameter(3, board.getBoardFile())
            .setParameter(4, board.getBoardFileContent())
            .setParameter(5, board.getBoardContent())
            .setParameter(6, board.getBoardNum())
            .executeUpdate(); 
            
			transactionManager.commit(status);
			
			System.out.println("update complete");
		} catch (Exception e) {
			log.info("error");
			transactionManager.rollback(status);
		} // try

	} //

	/**
	 * @see com.javateam.service.deprecated.springBoard.repository.JpaDAO#delete(int)
	 */
	@Override
	public boolean delete(int boardNum) {

		log.info("delete");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);

		BoardVO board = entityManager.find(BoardVO.class, boardNum);
		// PK만으로는 삭제안됨.

		log.info("Delete board {}", board);
		
		System.out.println("JpaDAOImpl.boardNum : "+boardNum);
        try {
            entityManager.createNativeQuery("DELETE FROM board_tbl "
                                       + "WHERE board_num=?")
                         .setParameter(1, boardNum)
                         .executeUpdate(); 
 
            transactionManager.commit(status); 
           
        } catch (Exception e) {
            log.info("error");
            transactionManager.rollback(status);
            return false;
        } // try
		
/*		try {
			entityManager.remove(board);
			transactionManager.commit(status);
		} catch (Exception e) {
			log.info("error");
			transactionManager.rollback(status);
			return false;
		} // try
*/
		return true;

	} //

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.javateam.springBoard.repository.JpaDAO#get(int)
	 */
	@Override
	public BoardVO get(int boardNum) {

		log.info("get");

		return entityManager.find(BoardVO.class, boardNum);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BoardVO> getListByPageAndLimit(int page, int limit) {

		log.info("getListByPageAndLimit");

		List<BoardVO> list = null;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		TransactionStatus status = transactionManager.getTransaction(def);

		String board_list_sql = "SELECT * FROM (" + "                SELECT "  
								+ "                       m.*,"
								+ "                       FLOOR((ROWNUM - 1)/? + 1) page " + "                FROM ("
								+ "                         SELECT * FROM board_tbl "
								+ "                ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC " + "                     ) m"
								+ "              )" + "      WHERE page = ?";

		try {
			list = entityManager.createNativeQuery(board_list_sql, BoardVO.class).setParameter(1, limit)
					.setParameter(2, page).getResultList();

			transactionManager.commit(status);
		} catch (Exception e) {
			log.debug("getListByPageAndLimit error");
			transactionManager.rollback(status);
		} //

		return list;
	} //

	@Override
	public void updateReadCount(int boardNum) {

        log.info("updateReadCount");
        log.info("boardNum : {}", boardNum);
       
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = transactionManager.getTransaction(def);
       
        try {
            entityManager.createNativeQuery("UPDATE board_tbl SET "
                                       + "board_read_count = board_read_count + 1 "
                                       + "WHERE board_num=?")
                         .setParameter(1, boardNum)
                         .executeUpdate(); 
 
            transactionManager.commit(status); 
           
        } catch (Exception e) {
            log.info("error");
            transactionManager.rollback(status);
        } // try
       
    } //

	@Override
	public void insert(OrderListVO orderlist) {
		transactionTemplate.execute(new TransactionCallbackWithoutResult() {

			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {

				try {

					entityManager.merge(orderlist);

				} catch (Exception e) {

					log.debug("insert error : {}", e);
					status.setRollbackOnly();

				}
			}
		});
		
	}

	@Override
	public OrderListVO getorder(int orderNum) {

		log.info("get");

		return entityManager.find(OrderListVO.class, orderNum);
	}

	@Override
	public List<OrderListVO> getListByPageAndLimit(int page, int limit,String username) {
		String list_sql = "SELECT * "
				+ "		   FROM ( SELECT  s.*, FLOOR((ROWNUM - 1)/? + 1) page "
				+ "				  FROM ( select *"
				+ "						 from orderlist_tbl"
				+ "						 where USERNAME=?"
				+ "						 order by BOARD_NUM desc,ORDER_NUM desc) s ) "
				+ "		   where page = ?";
		
		
		List<OrderListVO> list = null;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			list = entityManager.createNativeQuery(list_sql, OrderListVO.class)
					.setParameter(1, limit)
					.setParameter(2, username)
					.setParameter(3, page)
					.getResultList();
					

			transactionManager.commit(status);
		} catch (Exception e) {
			log.debug("Orderlist getListByPageAndLimit error");
			transactionManager.rollback(status);
		} //
		
		return list;
	}

	@Override
	public void update(OrderListVO orderlist) {

		log.info("order count update");
		System.out.println("order count update !!!");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		System.out.println("orderlist.getOrderNum() : "+orderlist.getOrderNum());
		System.out.println("orderlist.getOrderCount() : "+orderlist.getOrderCount());
		
		try {
            entityManager.createNativeQuery("UPDATE orderlist_tbl SET order_count=? WHERE order_num=?")
            .setParameter(1, orderlist.getOrderCount())
            .setParameter(2, orderlist.getOrderNum())
            .executeUpdate(); 
            
			transactionManager.commit(status);
			
			System.out.println("orderCount update complete");
		} catch (Exception e) {
			log.info("error");
			transactionManager.rollback(status);
		} // try
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderListVO> orderlist(String username) {

		log.info("select All");
		
		

		return (List<OrderListVO>) entityManager.createNativeQuery("SELECT * FROM orderlist_tbl WHERE username=? ORDER BY order_num", OrderListVO.class)
				.setParameter(1, username).getResultList();
	}

	@Override
	public List<OrderListVO> getList(String username,String sc) {
		String list_sql = "select *"
				+ "	       from orderlist_tbl"
				+ "		   where USERNAME=?"
				+ "		   order by BOARD_NUM "+sc+",ORDER_NUM desc";
		
		
		List<OrderListVO> list = null;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			list = entityManager.createNativeQuery(list_sql,OrderListVO.class)
					.setParameter(1, username)
					.getResultList(); 
					
			System.out.println("JpaDAOIMpl list : "+list);
			transactionManager.commit(status);
		} catch (Exception e) {
			log.debug("Orderlist getListByPageAndLimit error");
			transactionManager.rollback(status);
		} //
		
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<List<OrderListVO>> getList(String username,int[] boardNumList,String sc) {
		String list_sql = "select *"
				+ "	       from orderlist_tbl"
				+ "		   where USERNAME=? and board_num=?"
				+ "		   order by BOARD_NUM "+sc+",ORDER_NUM desc";
		
		
		List<List<OrderListVO>> allList = new ArrayList<>();
		List<OrderListVO> list = null;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		TransactionStatus status = transactionManager.getTransaction(def);
		for(int i=0; i<boardNumList.length; i++){
			System.out.println("boardNumList["+i+"] : "+boardNumList[i]);
		}
		try {
			for(int i=0; i<boardNumList.length; i++){
				System.out.println("i : " + i);
				list = entityManager.createNativeQuery(list_sql,OrderListVO.class)
						.setParameter(1, username)
						.setParameter(2, boardNumList[i])
						.getResultList(); 
				System.out.println("list : "+list);
				allList.add(list);
			}
			System.out.println("JpaDAOIMpl list : "+list);
			transactionManager.commit(status);
		} catch (Exception e) {
			log.debug("Orderlist getListByPageAndLimit error");
			transactionManager.rollback(status);
		} //
		
		return allList;
	}

	@Override
	public boolean deleteOrderList(int orderNum) {

		log.info("delete");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);

		OrderListVO orderlist = entityManager.find(OrderListVO.class, orderNum);
		// PK만으로는 삭제안됨.

		log.info("Delete board {}", orderlist);
		
		System.out.println("JpaDAOImpl.boardNum : "+orderNum);
        try {
            entityManager.createNativeQuery("DELETE FROM orderlist_tbl "
                                       + "WHERE order_num=?")
                         .setParameter(1, orderNum)
                         .executeUpdate(); 
 
            transactionManager.commit(status); 
           
        } catch (Exception e) {
            log.info("error");
            transactionManager.rollback(status);
            return false;
        } // try
        
		return true;
	}

}