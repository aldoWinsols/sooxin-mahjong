package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Dline
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Dline
 * @author MyEclipse Persistence Tools
 */

public class DlineDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(DlineDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String FINIST_NUM = "finistNum";
	public static final String START_NUM = "startNum";
	public static final String TOP_NUM = "topNum";
	public static final String LAST_NUM = "lastNum";
	public static final String TURNOVER = "turnover";

	protected void initDao() {
		// do nothing
	}

	public void save(Dline transientInstance) {
		log.debug("saving Dline instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Dline persistentInstance) {
		log.debug("deleting Dline instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Dline findById(java.lang.Long id) {
		log.debug("getting Dline instance with id: " + id);
		try {
			Dline instance = (Dline) getHibernateTemplate().get(
					"com.stock.dao.Dline", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Dline instance) {
		log.debug("finding Dline instance by example");
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
		log.debug("finding Dline instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Dline as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByStockCode(Object stockCode) {
		return findByProperty(STOCK_CODE, stockCode);
	}

	public List findByFinistNum(Object finistNum) {
		return findByProperty(FINIST_NUM, finistNum);
	}

	public List findByStartNum(Object startNum) {
		return findByProperty(START_NUM, startNum);
	}

	public List findByTopNum(Object topNum) {
		return findByProperty(TOP_NUM, topNum);
	}

	public List findByLastNum(Object lastNum) {
		return findByProperty(LAST_NUM, lastNum);
	}

	public List findByTurnover(Object turnover) {
		return findByProperty(TURNOVER, turnover);
	}

	public List findAll() {
		log.debug("finding all Dline instances");
		try {
			String queryString = "from Dline";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Dline merge(Dline detachedInstance) {
		log.debug("merging Dline instance");
		try {
			Dline result = (Dline) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Dline instance) {
		log.debug("attaching dirty Dline instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Dline instance) {
		log.debug("attaching clean Dline instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static DlineDAO getFromApplicationContext(ApplicationContext ctx) {
		return (DlineDAO) ctx.getBean("DlineDAO");
	}
}