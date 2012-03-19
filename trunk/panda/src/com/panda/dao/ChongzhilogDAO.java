package com.panda.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Chongzhilog entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.panda.dao.Chongzhilog
 * @author MyEclipse Persistence Tools
 */

public class ChongzhilogDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(ChongzhilogDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String CHONGZHI_MONEY = "chongzhiMoney";
	public static final String LAST_HAVE_MONEY = "lastHaveMoney";
	public static final String NOW_HAVE_MONEY = "nowHaveMoney";

	protected void initDao() {
		// do nothing
	}

	public void save(Chongzhilog transientInstance) {
		log.debug("saving Chongzhilog instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Chongzhilog persistentInstance) {
		log.debug("deleting Chongzhilog instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Chongzhilog findById(java.lang.Long id) {
		log.debug("getting Chongzhilog instance with id: " + id);
		try {
			Chongzhilog instance = (Chongzhilog) getHibernateTemplate().get(
					"com.panda.dao.Chongzhilog", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Chongzhilog instance) {
		log.debug("finding Chongzhilog instance by example");
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
		log.debug("finding Chongzhilog instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Chongzhilog as model where model."
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

	public List findByChongzhiMoney(Object chongzhiMoney) {
		return findByProperty(CHONGZHI_MONEY, chongzhiMoney);
	}

	public List findByLastHaveMoney(Object lastHaveMoney) {
		return findByProperty(LAST_HAVE_MONEY, lastHaveMoney);
	}

	public List findByNowHaveMoney(Object nowHaveMoney) {
		return findByProperty(NOW_HAVE_MONEY, nowHaveMoney);
	}

	public List findAll() {
		log.debug("finding all Chongzhilog instances");
		try {
			String queryString = "from Chongzhilog";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Chongzhilog merge(Chongzhilog detachedInstance) {
		log.debug("merging Chongzhilog instance");
		try {
			Chongzhilog result = (Chongzhilog) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Chongzhilog instance) {
		log.debug("attaching dirty Chongzhilog instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Chongzhilog instance) {
		log.debug("attaching clean Chongzhilog instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ChongzhilogDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (ChongzhilogDAO) ctx.getBean("ChongzhilogDAO");
	}
}