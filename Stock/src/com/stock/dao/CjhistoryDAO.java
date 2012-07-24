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
 * Cjhistory entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.stock.dao.Cjhistory
 * @author MyEclipse Persistence Tools
 */

public class CjhistoryDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(CjhistoryDAO.class);
	// property constants
	public static final String STOCK_NUM = "stockNum";
	public static final String CJ_SORT = "cjSort";
	public static final String CJ_NUM = "cjNum";
	public static final String CJ_PRICE = "cjPrice";

	protected void initDao() {
		// do nothing
	}

	public void save(Cjhistory transientInstance) {
		log.debug("saving Cjhistory instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Cjhistory persistentInstance) {
		log.debug("deleting Cjhistory instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Cjhistory findById(java.lang.Long id) {
		log.debug("getting Cjhistory instance with id: " + id);
		try {
			Cjhistory instance = (Cjhistory) getHibernateTemplate().get(
					"com.stock.dao.Cjhistory", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Cjhistory instance) {
		log.debug("finding Cjhistory instance by example");
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
		log.debug("finding Cjhistory instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Cjhistory as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByStockNum(Object stockNum) {
		return findByProperty(STOCK_NUM, stockNum);
	}

	public List findByCjSort(Object cjSort) {
		return findByProperty(CJ_SORT, cjSort);
	}

	public List findByCjNum(Object cjNum) {
		return findByProperty(CJ_NUM, cjNum);
	}

	public List findByCjPrice(Object cjPrice) {
		return findByProperty(CJ_PRICE, cjPrice);
	}

	public List findAll() {
		log.debug("finding all Cjhistory instances");
		try {
			String queryString = "from Cjhistory";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Cjhistory merge(Cjhistory detachedInstance) {
		log.debug("merging Cjhistory instance");
		try {
			Cjhistory result = (Cjhistory) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Cjhistory instance) {
		log.debug("attaching dirty Cjhistory instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Cjhistory instance) {
		log.debug("attaching clean Cjhistory instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static CjhistoryDAO getFromApplicationContext(ApplicationContext ctx) {
		return (CjhistoryDAO) ctx.getBean("CjhistoryDAO");
	}
}