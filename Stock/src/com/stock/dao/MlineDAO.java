package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Mline
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Mline
 * @author MyEclipse Persistence Tools
 */

public class MlineDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(MlineDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String PRICE = "price";
	public static final String TURNOVER = "turnover";

	protected void initDao() {
		// do nothing
	}

	public void save(Mline transientInstance) {
		log.debug("saving Mline instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Mline persistentInstance) {
		log.debug("deleting Mline instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Mline findById(java.lang.Long id) {
		log.debug("getting Mline instance with id: " + id);
		try {
			Mline instance = (Mline) getHibernateTemplate().get(
					"com.stock.dao.Mline", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Mline instance) {
		log.debug("finding Mline instance by example");
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
		log.debug("finding Mline instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Mline as model where model."
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

	public List findByPrice(Object price) {
		return findByProperty(PRICE, price);
	}

	public List findByTurnover(Object turnover) {
		return findByProperty(TURNOVER, turnover);
	}

	public List findAll() {
		log.debug("finding all Mline instances");
		try {
			String queryString = "from Mline";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Mline merge(Mline detachedInstance) {
		log.debug("merging Mline instance");
		try {
			Mline result = (Mline) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Mline instance) {
		log.debug("attaching dirty Mline instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Mline instance) {
		log.debug("attaching clean Mline instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static MlineDAO getFromApplicationContext(ApplicationContext ctx) {
		return (MlineDAO) ctx.getBean("MlineDAO");
	}
}