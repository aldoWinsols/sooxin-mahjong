package com.panda.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Duihuanlog entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.panda.dao.Duihuanlog
 * @author MyEclipse Persistence Tools
 */

public class DuihuanlogDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(DuihuanlogDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String ITEM_NAME = "itemName";
	public static final String DUIHUAN_MONEY = "duihuanMoney";
	public static final String LAST_HAVE_MONEY = "lastHaveMoney";
	public static final String NOW_HAVE_MONEY = "nowHaveMoney";
	public static final String CONTACT_NAME = "contactName";
	public static final String CONTACT_TEL = "contactTel";
	public static final String CONTACT_ADDRESS = "contactAddress";

	protected void initDao() {
		// do nothing
	}

	public void save(Duihuanlog transientInstance) {
		log.debug("saving Duihuanlog instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Duihuanlog persistentInstance) {
		log.debug("deleting Duihuanlog instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Duihuanlog findById(java.lang.Long id) {
		log.debug("getting Duihuanlog instance with id: " + id);
		try {
			Duihuanlog instance = (Duihuanlog) getHibernateTemplate().get(
					"com.panda.dao.Duihuanlog", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Duihuanlog instance) {
		log.debug("finding Duihuanlog instance by example");
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
		log.debug("finding Duihuanlog instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Duihuanlog as model where model."
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

	public List findByItemName(Object itemName) {
		return findByProperty(ITEM_NAME, itemName);
	}

	public List findByDuihuanMoney(Object duihuanMoney) {
		return findByProperty(DUIHUAN_MONEY, duihuanMoney);
	}

	public List findByLastHaveMoney(Object lastHaveMoney) {
		return findByProperty(LAST_HAVE_MONEY, lastHaveMoney);
	}

	public List findByNowHaveMoney(Object nowHaveMoney) {
		return findByProperty(NOW_HAVE_MONEY, nowHaveMoney);
	}

	public List findByContactName(Object contactName) {
		return findByProperty(CONTACT_NAME, contactName);
	}

	public List findByContactTel(Object contactTel) {
		return findByProperty(CONTACT_TEL, contactTel);
	}

	public List findByContactAddress(Object contactAddress) {
		return findByProperty(CONTACT_ADDRESS, contactAddress);
	}

	public List findAll() {
		log.debug("finding all Duihuanlog instances");
		try {
			String queryString = "from Duihuanlog";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Duihuanlog merge(Duihuanlog detachedInstance) {
		log.debug("merging Duihuanlog instance");
		try {
			Duihuanlog result = (Duihuanlog) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Duihuanlog instance) {
		log.debug("attaching dirty Duihuanlog instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Duihuanlog instance) {
		log.debug("attaching clean Duihuanlog instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static DuihuanlogDAO getFromApplicationContext(ApplicationContext ctx) {
		return (DuihuanlogDAO) ctx.getBean("DuihuanlogDAO");
	}
}