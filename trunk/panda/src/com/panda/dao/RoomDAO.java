package com.panda.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for Room
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.panda.dao.Room
 * @author MyEclipse Persistence Tools
 */

public class RoomDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(RoomDAO.class);
	// property constants
	public static final String ROOM_NAME = "roomName";
	public static final String FAN_NUM = "fanNum";
	public static final String MAX_FAN_NUM = "maxFanNum";
	public static final String JOIN_NUM = "joinNum";
	public static final String ONLINE_NUM = "onlineNum";
	public static final String CONN_URL = "connUrl";
	public static final String IS_VIEW = "isView";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(Room transientInstance) {
		log.debug("saving Room instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Room persistentInstance) {
		log.debug("deleting Room instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Room findById(java.lang.Long id) {
		log.debug("getting Room instance with id: " + id);
		try {
			Room instance = (Room) getHibernateTemplate().get(
					"com.panda.dao.Room", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Room instance) {
		log.debug("finding Room instance by example");
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
		log.debug("finding Room instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Room as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByRoomName(Object roomName) {
		return findByProperty(ROOM_NAME, roomName);
	}

	public List findByFanNum(Object fanNum) {
		return findByProperty(FAN_NUM, fanNum);
	}

	public List findByMaxFanNum(Object maxFanNum) {
		return findByProperty(MAX_FAN_NUM, maxFanNum);
	}

	public List findByJoinNum(Object joinNum) {
		return findByProperty(JOIN_NUM, joinNum);
	}

	public List findByOnlineNum(Object onlineNum) {
		return findByProperty(ONLINE_NUM, onlineNum);
	}

	public List findByConnUrl(Object connUrl) {
		return findByProperty(CONN_URL, connUrl);
	}

	public List findByIsView(Object isView) {
		return findByProperty(IS_VIEW, isView);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all Room instances");
		try {
			String queryString = "from Room";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Room merge(Room detachedInstance) {
		log.debug("merging Room instance");
		try {
			Room result = (Room) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Room instance) {
		log.debug("attaching dirty Room instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Room instance) {
		log.debug("attaching clean Room instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static RoomDAO getFromApplicationContext(ApplicationContext ctx) {
		return (RoomDAO) ctx.getBean("RoomDAO");
	}
}