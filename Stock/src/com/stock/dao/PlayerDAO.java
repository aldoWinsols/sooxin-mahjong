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
 * Player entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.stock.dao.Player
 * @author MyEclipse Persistence Tools
 */

public class PlayerDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(PlayerDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String PLAYER_PWD = "playerPwd";
	public static final String HAVE_MONEY = "haveMoney";
	public static final String CLOCK_MONEY = "clockMoney";
	public static final String SORT = "sort";

	protected void initDao() {
		// do nothing
	}

	public void save(Player transientInstance) {
		log.debug("saving Player instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Player persistentInstance) {
		log.debug("deleting Player instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Player findById(java.lang.Long id) {
		log.debug("getting Player instance with id: " + id);
		try {
			Player instance = (Player) getHibernateTemplate().get(
					"com.stock.dao.Player", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Player instance) {
		log.debug("finding Player instance by example");
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
		log.debug("finding Player instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Player as model where model."
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

	public List findByPlayerPwd(Object playerPwd) {
		return findByProperty(PLAYER_PWD, playerPwd);
	}

	public List findByHaveMoney(Object haveMoney) {
		return findByProperty(HAVE_MONEY, haveMoney);
	}

	public List findByClockMoney(Object clockMoney) {
		return findByProperty(CLOCK_MONEY, clockMoney);
	}

	public List findBySort(Object sort) {
		return findByProperty(SORT, sort);
	}

	public List findAll() {
		log.debug("finding all Player instances");
		try {
			String queryString = "from Player";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Player merge(Player detachedInstance) {
		log.debug("merging Player instance");
		try {
			Player result = (Player) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Player instance) {
		log.debug("attaching dirty Player instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Player instance) {
		log.debug("attaching clean Player instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PlayerDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PlayerDAO) ctx.getBean("PlayerDAO");
	}
}