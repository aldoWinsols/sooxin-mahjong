package com.stock.dao;

import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Stock
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Stock
 * @author MyEclipse Persistence Tools
 */

public class StockDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(StockDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String STOCK_NAME = "stockName";
	public static final String ALL_NUM = "allNum";
	public static final String BUS_NUM = "busNum";
	public static final String JINZHI = "jinzhi";
	public static final String SHOUYI = "shouyi";
	public static final String PE = "pe";
	public static final String LAST_DAY_END_PRICE = "lastDayEndPrice";
	public static final String LAST_DAY_CJSHOU = "lastDayCjshou";
	public static final String XINXIN_LV = "xinxinLv";

	protected void initDao() {
		// do nothing
	}

	public void save(Stock transientInstance) {
		log.debug("saving Stock instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Stock persistentInstance) {
		log.debug("deleting Stock instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Stock findById(java.lang.Long id) {
		log.debug("getting Stock instance with id: " + id);
		try {
			Stock instance = (Stock) getHibernateTemplate().get(
					"com.stock.dao.Stock", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Stock instance) {
		log.debug("finding Stock instance by example");
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
		log.debug("finding Stock instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Stock as model where model."
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

	public List findByStockName(Object stockName) {
		return findByProperty(STOCK_NAME, stockName);
	}

	public List findByAllNum(Object allNum) {
		return findByProperty(ALL_NUM, allNum);
	}

	public List findByBusNum(Object busNum) {
		return findByProperty(BUS_NUM, busNum);
	}

	public List findByJinzhi(Object jinzhi) {
		return findByProperty(JINZHI, jinzhi);
	}

	public List findByShouyi(Object shouyi) {
		return findByProperty(SHOUYI, shouyi);
	}

	public List findByPe(Object pe) {
		return findByProperty(PE, pe);
	}

	public List findByLastDayEndPrice(Object lastDayEndPrice) {
		return findByProperty(LAST_DAY_END_PRICE, lastDayEndPrice);
	}

	public List findByLastDayCjshou(Object lastDayCjshou) {
		return findByProperty(LAST_DAY_CJSHOU, lastDayCjshou);
	}

	public List findByXinxinLv(Object xinxinLv) {
		return findByProperty(XINXIN_LV, xinxinLv);
	}

	public List findAll() {
		log.debug("finding all Stock instances");
		try {
			String queryString = "from Stock";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Stock merge(Stock detachedInstance) {
		log.debug("merging Stock instance");
		try {
			Stock result = (Stock) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Stock instance) {
		log.debug("attaching dirty Stock instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Stock instance) {
		log.debug("attaching clean Stock instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static StockDAO getFromApplicationContext(ApplicationContext ctx) {
		return (StockDAO) ctx.getBean("StockDAO");
	}
}