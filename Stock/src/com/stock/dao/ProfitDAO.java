package com.stock.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Profit entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.stock.dao.Profit
 * @author MyEclipse Persistence Tools
 */

public class ProfitDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(ProfitDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String TITLE = "title";
	public static final String JIN_LIRUN = "jinLirun";
	public static final String JIN_LIRUN_INCREASE_LV = "jinLirunIncreaseLv";
	public static final String JIN_ZHICHAN_SHOYI_LV = "jinZhichanShoyiLv";
	public static final String ZHICHAN_FUZAI_LV = "zhichanFuzaiLv";
	public static final String CACH_LV = "cachLv";

	protected void initDao() {
		// do nothing
	}

	public void save(Profit transientInstance) {
		log.debug("saving Profit instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Profit persistentInstance) {
		log.debug("deleting Profit instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Profit findById(java.lang.Long id) {
		log.debug("getting Profit instance with id: " + id);
		try {
			Profit instance = (Profit) getHibernateTemplate().get(
					"com.stock.dao.Profit", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Profit instance) {
		log.debug("finding Profit instance by example");
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
		log.debug("finding Profit instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Profit as model where model."
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

	public List findByJinLirun(Object jinLirun) {
		return findByProperty(JIN_LIRUN, jinLirun);
	}

	public List findByJinLirunIncreaseLv(Object jinLirunIncreaseLv) {
		return findByProperty(JIN_LIRUN_INCREASE_LV, jinLirunIncreaseLv);
	}

	public List findByJinZhichanShoyiLv(Object jinZhichanShoyiLv) {
		return findByProperty(JIN_ZHICHAN_SHOYI_LV, jinZhichanShoyiLv);
	}

	public List findByZhichanFuzaiLv(Object zhichanFuzaiLv) {
		return findByProperty(ZHICHAN_FUZAI_LV, zhichanFuzaiLv);
	}

	public List findByCachLv(Object cachLv) {
		return findByProperty(CACH_LV, cachLv);
	}

	public List findAll() {
		log.debug("finding all Profit instances");
		try {
			String queryString = "from Profit";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Profit merge(Profit detachedInstance) {
		log.debug("merging Profit instance");
		try {
			Profit result = (Profit) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Profit instance) {
		log.debug("attaching dirty Profit instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Profit instance) {
		log.debug("attaching clean Profit instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ProfitDAO getFromApplicationContext(ApplicationContext ctx) {
		return (ProfitDAO) ctx.getBean("ProfitDAO");
	}
}