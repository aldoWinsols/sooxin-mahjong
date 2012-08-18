package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Wline
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Wline
 * @author MyEclipse Persistence Tools
 */

public class WlineDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(WlineDAO.class);
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

	public void save(Wline transientInstance) {
		log.debug("saving Wline instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Wline persistentInstance) {
		log.debug("deleting Wline instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Wline findById(java.lang.Long id) {
		log.debug("getting Wline instance with id: " + id);
		try {
			Wline instance = (Wline) getHibernateTemplate().get(
					"com.stock.dao.Wline", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Wline instance) {
		log.debug("finding Wline instance by example");
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
		log.debug("finding Wline instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Wline as model where model."
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
		log.debug("finding all Wline instances");
		try {
			String queryString = "from Wline";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Wline merge(Wline detachedInstance) {
		log.debug("merging Wline instance");
		try {
			Wline result = (Wline) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Wline instance) {
		log.debug("attaching dirty Wline instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Wline instance) {
		log.debug("attaching clean Wline instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static WlineDAO getFromApplicationContext(ApplicationContext ctx) {
		return (WlineDAO) ctx.getBean("WlineDAO");
	}
}