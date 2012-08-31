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
 * Companyinfo entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.stock.dao.Companyinfo
 * @author MyEclipse Persistence Tools
 */

public class CompanyinfoDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(CompanyinfoDAO.class);
	// property constants
	public static final String STOCK_CODE = "stockCode";
	public static final String COMPANY_NAME = "companyName";
	public static final String HANGYE_SORT = "hangyeSort";
	public static final String JY_CONTENT = "jyContent";
	public static final String MOST_JY = "mostJy";
	public static final String INTRODUNCE = "introdunce";

	protected void initDao() {
		// do nothing
	}

	public void save(Companyinfo transientInstance) {
		log.debug("saving Companyinfo instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Companyinfo persistentInstance) {
		log.debug("deleting Companyinfo instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Companyinfo findById(java.lang.Long id) {
		log.debug("getting Companyinfo instance with id: " + id);
		try {
			Companyinfo instance = (Companyinfo) getHibernateTemplate().get(
					"com.stock.dao.Companyinfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Companyinfo instance) {
		log.debug("finding Companyinfo instance by example");
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
		log.debug("finding Companyinfo instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Companyinfo as model where model."
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

	public List findByCompanyName(Object companyName) {
		return findByProperty(COMPANY_NAME, companyName);
	}

	public List findByHangyeSort(Object hangyeSort) {
		return findByProperty(HANGYE_SORT, hangyeSort);
	}

	public List findByJyContent(Object jyContent) {
		return findByProperty(JY_CONTENT, jyContent);
	}

	public List findByMostJy(Object mostJy) {
		return findByProperty(MOST_JY, mostJy);
	}

	public List findByIntrodunce(Object introdunce) {
		return findByProperty(INTRODUNCE, introdunce);
	}

	public List findAll() {
		log.debug("finding all Companyinfo instances");
		try {
			String queryString = "from Companyinfo";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Companyinfo merge(Companyinfo detachedInstance) {
		log.debug("merging Companyinfo instance");
		try {
			Companyinfo result = (Companyinfo) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Companyinfo instance) {
		log.debug("attaching dirty Companyinfo instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Companyinfo instance) {
		log.debug("attaching clean Companyinfo instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static CompanyinfoDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (CompanyinfoDAO) ctx.getBean("CompanyinfoDAO");
	}
}