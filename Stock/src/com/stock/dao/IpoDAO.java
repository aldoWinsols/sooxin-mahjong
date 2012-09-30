package com.stock.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Ipo
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.stock.dao.Ipo
 * @author MyEclipse Persistence Tools
 */

public class IpoDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(IpoDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String STOCK_NAME = "stockName";
	public static final String ALL_NUM = "allNum";
	public static final String BUS_NUM = "busNum";
	public static final String HAVE_BUY_NUM = "haveBuyNum";
	public static final String JINZHI = "jinzhi";
	public static final String SHOUYI = "shouyi";
	public static final String START_BUY = "startBuy";
	public static final String START_SALE = "startSale";
	public static final String INTRODUNCE = "introdunce";
	public static final String PRICE = "price";

	protected void initDao() {
		// do nothing
	}

	public void save(Ipo transientInstance) {
		log.debug("saving Ipo instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Ipo persistentInstance) {
		log.debug("deleting Ipo instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Ipo findById(java.lang.Long id) {
		log.debug("getting Ipo instance with id: " + id);
		try {
			Ipo instance = (Ipo) getHibernateTemplate().get(
					"com.stock.dao.Ipo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Ipo instance) {
		log.debug("finding Ipo instance by example");
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
		log.debug("finding Ipo instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Ipo as model where model."
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

	public List findByHaveBuyNum(Object haveBuyNum) {
		return findByProperty(HAVE_BUY_NUM, haveBuyNum);
	}

	public List findByJinzhi(Object jinzhi) {
		return findByProperty(JINZHI, jinzhi);
	}

	public List findByShouyi(Object shouyi) {
		return findByProperty(SHOUYI, shouyi);
	}

	public List findByStartBuy(Object startBuy) {
		return findByProperty(START_BUY, startBuy);
	}

	public List findByStartSale(Object startSale) {
		return findByProperty(START_SALE, startSale);
	}

	public List findByIntrodunce(Object introdunce) {
		return findByProperty(INTRODUNCE, introdunce);
	}

	public List findByPrice(Object price) {
		return findByProperty(PRICE, price);
	}

	public List findAll() {
		log.debug("finding all Ipo instances");
		try {
			String queryString = "from Ipo";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Ipo merge(Ipo detachedInstance) {
		log.debug("merging Ipo instance");
		try {
			Ipo result = (Ipo) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Ipo instance) {
		log.debug("attaching dirty Ipo instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Ipo instance) {
		log.debug("attaching clean Ipo instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static IpoDAO getFromApplicationContext(ApplicationContext ctx) {
		return (IpoDAO) ctx.getBean("IpoDAO");
	}
}