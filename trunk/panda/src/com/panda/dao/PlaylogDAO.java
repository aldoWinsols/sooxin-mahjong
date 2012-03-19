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
 * Playlog entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.panda.dao.Playlog
 * @author MyEclipse Persistence Tools
 */

public class PlaylogDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(PlaylogDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String GAME_CLASS = "gameClass";
	public static final String GAME_SUB_CLASS = "gameSubClass";
	public static final String GAME_NAME = "gameName";
	public static final String GAME_NO = "gameNo";
	public static final String GAME_CONTENT = "gameContent";
	public static final String ALL_TOU_ZHU_MONEY = "allTouZhuMoney";
	public static final String PRE_MONEY = "preMoney";
	public static final String WIN_LOSS_MONEY_BEFORE_TAX = "winLossMoneyBeforeTax";
	public static final String GAME_TAXACTION = "gameTaxaction";
	public static final String WIN_LOSS_MONEY_AFTER_TAX = "winLossMoneyAfterTax";
	public static final String AFTER_MONEY = "afterMoney";
	public static final String GAME_IP = "gameIp";
	public static final String REMARKS = "remarks";

	protected void initDao() {
		// do nothing
	}

	public void save(Playlog transientInstance) {
		log.debug("saving Playlog instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Playlog persistentInstance) {
		log.debug("deleting Playlog instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Playlog findById(java.lang.Long id) {
		log.debug("getting Playlog instance with id: " + id);
		try {
			Playlog instance = (Playlog) getHibernateTemplate().get(
					"com.panda.dao.Playlog", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Playlog instance) {
		log.debug("finding Playlog instance by example");
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
		log.debug("finding Playlog instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Playlog as model where model."
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

	public List findByGameClass(Object gameClass) {
		return findByProperty(GAME_CLASS, gameClass);
	}

	public List findByGameSubClass(Object gameSubClass) {
		return findByProperty(GAME_SUB_CLASS, gameSubClass);
	}

	public List findByGameName(Object gameName) {
		return findByProperty(GAME_NAME, gameName);
	}

	public List findByGameNo(Object gameNo) {
		return findByProperty(GAME_NO, gameNo);
	}

	public List findByGameContent(Object gameContent) {
		return findByProperty(GAME_CONTENT, gameContent);
	}

	public List findByAllTouZhuMoney(Object allTouZhuMoney) {
		return findByProperty(ALL_TOU_ZHU_MONEY, allTouZhuMoney);
	}

	public List findByPreMoney(Object preMoney) {
		return findByProperty(PRE_MONEY, preMoney);
	}

	public List findByWinLossMoneyBeforeTax(Object winLossMoneyBeforeTax) {
		return findByProperty(WIN_LOSS_MONEY_BEFORE_TAX, winLossMoneyBeforeTax);
	}

	public List findByGameTaxaction(Object gameTaxaction) {
		return findByProperty(GAME_TAXACTION, gameTaxaction);
	}

	public List findByWinLossMoneyAfterTax(Object winLossMoneyAfterTax) {
		return findByProperty(WIN_LOSS_MONEY_AFTER_TAX, winLossMoneyAfterTax);
	}

	public List findByAfterMoney(Object afterMoney) {
		return findByProperty(AFTER_MONEY, afterMoney);
	}

	public List findByGameIp(Object gameIp) {
		return findByProperty(GAME_IP, gameIp);
	}

	public List findByRemarks(Object remarks) {
		return findByProperty(REMARKS, remarks);
	}

	public List findAll() {
		log.debug("finding all Playlog instances");
		try {
			String queryString = "from Playlog";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Playlog merge(Playlog detachedInstance) {
		log.debug("merging Playlog instance");
		try {
			Playlog result = (Playlog) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Playlog instance) {
		log.debug("attaching dirty Playlog instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Playlog instance) {
		log.debug("attaching clean Playlog instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PlaylogDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PlaylogDAO) ctx.getBean("PlaylogDAO");
	}
}