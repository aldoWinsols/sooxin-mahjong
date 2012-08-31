package com.stock.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Achievement entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.stock.dao.Achievement
 * @author MyEclipse Persistence Tools
 */

public class AchievementDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(AchievementDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String TITLE = "title";
	public static final String ONE_SHOUYI = "oneShouyi";
	public static final String ONE_ZHICHAN = "oneZhichan";
	public static final String SHOUYI_BI = "shouyiBi";
	public static final String ALL_GUBEN = "allGuben";
	public static final String LIUTONG_GU = "liutongGu";

	protected void initDao() {
		// do nothing
	}

	public void save(Achievement transientInstance) {
		log.debug("saving Achievement instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Achievement persistentInstance) {
		log.debug("deleting Achievement instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Achievement findById(java.lang.Long id) {
		log.debug("getting Achievement instance with id: " + id);
		try {
			Achievement instance = (Achievement) getHibernateTemplate().get(
					"com.stock.dao.Achievement", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Achievement instance) {
		log.debug("finding Achievement instance by example");
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
		log.debug("finding Achievement instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Achievement as model where model."
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

	public List findByTitle(Object title) {
		return findByProperty(TITLE, title);
	}

	public List findByOneShouyi(Object oneShouyi) {
		return findByProperty(ONE_SHOUYI, oneShouyi);
	}

	public List findByOneZhichan(Object oneZhichan) {
		return findByProperty(ONE_ZHICHAN, oneZhichan);
	}

	public List findByShouyiBi(Object shouyiBi) {
		return findByProperty(SHOUYI_BI, shouyiBi);
	}

	public List findByAllGuben(Object allGuben) {
		return findByProperty(ALL_GUBEN, allGuben);
	}

	public List findByLiutongGu(Object liutongGu) {
		return findByProperty(LIUTONG_GU, liutongGu);
	}

	public List findAll() {
		log.debug("finding all Achievement instances");
		try {
			String queryString = "from Achievement";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Achievement merge(Achievement detachedInstance) {
		log.debug("merging Achievement instance");
		try {
			Achievement result = (Achievement) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Achievement instance) {
		log.debug("attaching dirty Achievement instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Achievement instance) {
		log.debug("attaching clean Achievement instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static AchievementDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (AchievementDAO) ctx.getBean("AchievementDAO");
	}
}