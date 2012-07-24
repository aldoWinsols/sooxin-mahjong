package com.stock.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Bag
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Bag
 * @author MyEclipse Persistence Tools
 */

public class BagDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(BagDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String STOCK_NUM = "stockNum";
	public static final String HAVE_NUM = "haveNum";
	public static final String EVL_PRICE = "evlPrice";

	protected void initDao() {
		// do nothing
	}

	public void save(Bag transientInstance) {
		log.debug("saving Bag instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Bag persistentInstance) {
		log.debug("deleting Bag instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Bag findById(java.lang.Long id) {
		log.debug("getting Bag instance with id: " + id);
		try {
			Bag instance = (Bag) getHibernateTemplate().get(
					"com.stock.dao.Bag", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Bag instance) {
		log.debug("finding Bag instance by example");
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
		log.debug("finding Bag instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Bag as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByPlayerName(Object playerName) {
		return findByProperty(PLAYER_NAME, playerName);
	}

	public List findByStockNum(Object stockNum) {
		return findByProperty(STOCK_NUM, stockNum);
	}

	public List findByHaveNum(Object haveNum) {
		return findByProperty(HAVE_NUM, haveNum);
	}

	public List findByEvlPrice(Object evlPrice) {
		return findByProperty(EVL_PRICE, evlPrice);
	}

	public List findAll() {
		log.debug("finding all Bag instances");
		try {
			String queryString = "from Bag";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Bag merge(Bag detachedInstance) {
		log.debug("merging Bag instance");
		try {
			Bag result = (Bag) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Bag instance) {
		log.debug("attaching dirty Bag instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Bag instance) {
		log.debug("attaching clean Bag instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static BagDAO getFromApplicationContext(ApplicationContext ctx) {
		return (BagDAO) ctx.getBean("BagDAO");
	}
}