package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Bshistory entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.stock.dao.Bshistory
 * @author MyEclipse Persistence Tools
 */

public class BshistoryDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(BshistoryDAO.class);
	// property constants
	public static final String NUM = "num";
	public static final String PLAYER_NAME = "playerName";
	public static final String STOCK_NUM = "stockNum";
	public static final String BS_SORT = "bsSort";
	public static final String BS_NUM = "bsNum";
	public static final String BS_WT_PRICE = "bsWtPrice";
	public static final String BS_CJ_PRICE = "bsCjPrice";
	public static final String TAX_STAMP = "taxStamp";
	public static final String COMMISION = "commision";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(Bshistory transientInstance) {
		log.debug("saving Bshistory instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Bshistory persistentInstance) {
		log.debug("deleting Bshistory instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Bshistory findById(java.lang.Long id) {
		log.debug("getting Bshistory instance with id: " + id);
		try {
			Bshistory instance = (Bshistory) getHibernateTemplate().get(
					"com.stock.dao.Bshistory", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Bshistory instance) {
		log.debug("finding Bshistory instance by example");
		try {
			List results = getHibernateTemplate().findByExample(instance);
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Bshistory instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Bshistory as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByNum(Object num) {
		return findByProperty(NUM, num);
	}

	public List findByPlayerName(Object playerName) {
		return findByProperty(PLAYER_NAME, playerName);
	}

	public List findByStockNum(Object stockNum) {
		return findByProperty(STOCK_NUM, stockNum);
	}

	public List findByBsSort(Object bsSort) {
		return findByProperty(BS_SORT, bsSort);
	}

	public List findByBsNum(Object bsNum) {
		return findByProperty(BS_NUM, bsNum);
	}

	public List findByBsWtPrice(Object bsWtPrice) {
		return findByProperty(BS_WT_PRICE, bsWtPrice);
	}

	public List findByBsCjPrice(Object bsCjPrice) {
		return findByProperty(BS_CJ_PRICE, bsCjPrice);
	}

	public List findByTaxStamp(Object taxStamp) {
		return findByProperty(TAX_STAMP, taxStamp);
	}

	public List findByCommision(Object commision) {
		return findByProperty(COMMISION, commision);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all Bshistory instances");
		try {
			String queryString = "from Bshistory";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Bshistory merge(Bshistory detachedInstance) {
		log.debug("merging Bshistory instance");
		try {
			Bshistory result = (Bshistory) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Bshistory instance) {
		log.debug("attaching dirty Bshistory instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Bshistory instance) {
		log.debug("attaching clean Bshistory instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static BshistoryDAO getFromApplicationContext(ApplicationContext ctx) {
		return (BshistoryDAO) ctx.getBean("BshistoryDAO");
	}
}