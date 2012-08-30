package com.stock.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Tenplayer entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.stock.dao.Tenplayer
 * @author MyEclipse Persistence Tools
 */

public class TenplayerDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(TenplayerDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String PLAYER_NAME = "playerName";
	public static final String HAVE_NUM = "haveNum";
	public static final String ZHANBI = "zhanbi";
	public static final String REMARK = "remark";

	protected void initDao() {
		// do nothing
	}

	public void save(Tenplayer transientInstance) {
		log.debug("saving Tenplayer instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Tenplayer persistentInstance) {
		log.debug("deleting Tenplayer instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Tenplayer findById(java.lang.Long id) {
		log.debug("getting Tenplayer instance with id: " + id);
		try {
			Tenplayer instance = (Tenplayer) getHibernateTemplate().get(
					"com.stock.dao.Tenplayer", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Tenplayer instance) {
		log.debug("finding Tenplayer instance by example");
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
		log.debug("finding Tenplayer instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Tenplayer as model where model."
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

	public List findByPlayerName(Object playerName) {
		return findByProperty(PLAYER_NAME, playerName);
	}

	public List findByHaveNum(Object haveNum) {
		return findByProperty(HAVE_NUM, haveNum);
	}

	public List findByZhanbi(Object zhanbi) {
		return findByProperty(ZHANBI, zhanbi);
	}

	public List findByRemark(Object remark) {
		return findByProperty(REMARK, remark);
	}

	public List findAll() {
		log.debug("finding all Tenplayer instances");
		try {
			String queryString = "from Tenplayer";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Tenplayer merge(Tenplayer detachedInstance) {
		log.debug("merging Tenplayer instance");
		try {
			Tenplayer result = (Tenplayer) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Tenplayer instance) {
		log.debug("attaching dirty Tenplayer instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Tenplayer instance) {
		log.debug("attaching clean Tenplayer instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static TenplayerDAO getFromApplicationContext(ApplicationContext ctx) {
		return (TenplayerDAO) ctx.getBean("TenplayerDAO");
	}
}