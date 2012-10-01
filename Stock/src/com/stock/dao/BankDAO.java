package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Bank
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Bank
 * @author MyEclipse Persistence Tools
 */

public class BankDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(BankDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String SORT = "sort";
	public static final String MONEY = "money";
	public static final String LV = "lv";
	public static final String DAYS = "days";
	public static final String RETURN_MONEY = "returnMoney";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(Bank transientInstance) {
		log.debug("saving Bank instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Bank persistentInstance) {
		log.debug("deleting Bank instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Bank findById(java.lang.Long id) {
		log.debug("getting Bank instance with id: " + id);
		try {
			Bank instance = (Bank) getHibernateTemplate().get(
					"com.stock.dao.Bank", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Bank instance) {
		log.debug("finding Bank instance by example");
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
		log.debug("finding Bank instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Bank as model where model."
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

	public List findBySort(Object sort) {
		return findByProperty(SORT, sort);
	}

	public List findByMoney(Object money) {
		return findByProperty(MONEY, money);
	}

	public List findByLv(Object lv) {
		return findByProperty(LV, lv);
	}

	public List findByDays(Object days) {
		return findByProperty(DAYS, days);
	}

	public List findByReturnMoney(Object returnMoney) {
		return findByProperty(RETURN_MONEY, returnMoney);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all Bank instances");
		try {
			String queryString = "from Bank";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Bank merge(Bank detachedInstance) {
		log.debug("merging Bank instance");
		try {
			Bank result = (Bank) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Bank instance) {
		log.debug("attaching dirty Bank instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Bank instance) {
		log.debug("attaching clean Bank instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static BankDAO getFromApplicationContext(ApplicationContext ctx) {
		return (BankDAO) ctx.getBean("BankDAO");
	}
}