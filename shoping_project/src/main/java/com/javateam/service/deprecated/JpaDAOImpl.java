/**
 * 
 */
package com.javateam.service.deprecated;

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

import com.javateam.model.vo.BoardVO;

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

		return (List<BoardVO>) entityManager.createNativeQuery("SELECT * FROM board_tbl", BoardVO.class)
				.getResultList();
	} //

	/**
	 * @see com.javateam.service.deprecated.springBoard.repository.JpaDAO#update(com.javateam.model.vo.springBoard.domain.vo.BoardVO)
	 */
	@Override
	public void update(BoardVO board) {

		log.info("update");

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);

		try {
			entityManager.merge(board);
			transactionManager.commit(status);
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

		log.info("board {}", board);

		try {
			entityManager.remove(board);
			transactionManager.commit(status);
		} catch (Exception e) {
			log.info("error");
			transactionManager.rollback(status);
			return false;
		} // try

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

		String board_list_sql = "SELECT * FROM (" + "                SELECT " + "                       m.*,"
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


}