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
 * Gamehistory entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.panda.dao.Gamehistory
 * @author MyEclipse Persistence Tools
 */

public class GamehistoryDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(GamehistoryDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String LAST_MONEY = "lastMoney";
	public static final String NOW_MONEY = "nowMoney";
	public static final String GAME_CONTENT = "gameContent";

	protected void initDao() {
		// do nothing
	}

	public void save(Gamehistory transientInstance) {
		log.debug("saving Gamehistory instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Gamehistory persistentInstance) {
		log.debug("deleting Gamehistory instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Gamehistory findById(java.lang.Long id) {
		log.debug("getting Gamehistory instance with id: " + id);
		try {
			Gamehistory instance = (Gamehistory) getHibernateTemplate().get(
					"com.panda.dao.Gamehistory", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Gamehistory instance) {
		log.debug("finding Gamehistory instance by example");
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
		log.debug("finding Gamehistory instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Gamehistory as model where model."
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

	public List findByLastMoney(Object lastMoney) {
		return findByProperty(LAST_MONEY, lastMoney);
	}

	public List findByNowMoney(Object nowMoney) {
		return findByProperty(NOW_MONEY, nowMoney);
	}

	public List findByGameContent(Object gameContent) {
		return findByProperty(GAME_CONTENT, gameContent);
	}

	public List findAll() {
		log.debug("finding all Gamehistory instances");
		try {
			String queryString = "from Gamehistory";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Gamehistory merge(Gamehistory detachedInstance) {
		log.debug("merging Gamehistory instance");
		try {
			Gamehistory result = (Gamehistory) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Gamehistory instance) {
		log.debug("attaching dirty Gamehistory instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Gamehistory instance) {
		log.debug("attaching clean Gamehistory instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GamehistoryDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (GamehistoryDAO) ctx.getBean("GamehistoryDAO");
	}
}