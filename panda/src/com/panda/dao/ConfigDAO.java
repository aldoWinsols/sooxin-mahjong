package com.panda.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Config entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.panda.dao.Config
 * @author MyEclipse Persistence Tools
 */

public class ConfigDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(ConfigDAO.class);
	// property constants
	public static final String MAIN_CONN_URL = "mainConnUrl";
	public static final String HIDE_JIANGPIN = "hideJiangpin";

	protected void initDao() {
		// do nothing
	}

	public void save(Config transientInstance) {
		log.debug("saving Config instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Config persistentInstance) {
		log.debug("deleting Config instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Config findById(java.lang.Integer id) {
		log.debug("getting Config instance with id: " + id);
		try {
			Config instance = (Config) getHibernateTemplate().get(
					"com.panda.dao.Config", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Config instance) {
		log.debug("finding Config instance by example");
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
		log.debug("finding Config instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Config as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByMainConnUrl(Object mainConnUrl) {
		return findByProperty(MAIN_CONN_URL, mainConnUrl);
	}

	public List findByHideJiangpin(Object hideJiangpin) {
		return findByProperty(HIDE_JIANGPIN, hideJiangpin);
	}

	public List findAll() {
		log.debug("finding all Config instances");
		try {
			String queryString = "from Config";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Config merge(Config detachedInstance) {
		log.debug("merging Config instance");
		try {
			Config result = (Config) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Config instance) {
		log.debug("attaching dirty Config instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Config instance) {
		log.debug("attaching clean Config instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ConfigDAO getFromApplicationContext(ApplicationContext ctx) {
		return (ConfigDAO) ctx.getBean("ConfigDAO");
	}
}