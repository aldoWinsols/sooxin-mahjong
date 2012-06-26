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
 * Player entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.panda.dao.Player
 * @author MyEclipse Persistence Tools
 */

public class PlayerDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(PlayerDAO.class);
	// property constants
	public static final String PLAYER_NAME = "playerName";
	public static final String PLAYER_PWD = "playerPwd";
	public static final String HAVE_MONEY = "haveMoney";
	public static final String BIRTHDAY = "birthday";
	public static final String BIRTH_MONTH = "birthMonth";
	public static final String BIRTH_YEAR = "birthYear";
	public static final String CITY_CODE = "cityCode";
	public static final String COUNTRY_CODE = "countryCode";
	public static final String EDU = "edu";
	public static final String EMAIL = "email";
	public static final String FANS_NUM = "fansNum";
	public static final String HEAD = "head";
	public static final String IDOL_NUM = "idolNum";
	public static final String INTRODUCTION = "introduction";
	public static final String ISENT = "isent";
	public static final String ISREAL_NAME = "isrealName";
	public static final String ISVIP = "isvip";
	public static final String LOCATION = "location";
	public static final String NICK = "nick";
	public static final String OPENID = "openid";
	public static final String PROVINCE_CODE = "provinceCode";
	public static final String SEX = "sex";
	public static final String TAG = "tag";
	public static final String TWEETNUM = "tweetnum";
	public static final String VERIFYINFO = "verifyinfo";
	public static final String OFFLINE_GAME_NO = "offlineGameNo";

	protected void initDao() {
		// do nothing
	}

	public void save(Player transientInstance) {
		log.debug("saving Player instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Player persistentInstance) {
		log.debug("deleting Player instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Player findById(java.lang.Long id) {
		log.debug("getting Player instance with id: " + id);
		try {
			Player instance = (Player) getHibernateTemplate().get(
					"com.panda.dao.Player", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Player instance) {
		log.debug("finding Player instance by example");
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
		log.debug("finding Player instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Player as model where model."
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

	public List findByPlayerPwd(Object playerPwd) {
		return findByProperty(PLAYER_PWD, playerPwd);
	}

	public List findByHaveMoney(Object haveMoney) {
		return findByProperty(HAVE_MONEY, haveMoney);
	}

	public List findByBirthday(Object birthday) {
		return findByProperty(BIRTHDAY, birthday);
	}

	public List findByBirthMonth(Object birthMonth) {
		return findByProperty(BIRTH_MONTH, birthMonth);
	}

	public List findByBirthYear(Object birthYear) {
		return findByProperty(BIRTH_YEAR, birthYear);
	}

	public List findByCityCode(Object cityCode) {
		return findByProperty(CITY_CODE, cityCode);
	}

	public List findByCountryCode(Object countryCode) {
		return findByProperty(COUNTRY_CODE, countryCode);
	}

	public List findByEdu(Object edu) {
		return findByProperty(EDU, edu);
	}

	public List findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}

	public List findByFansNum(Object fansNum) {
		return findByProperty(FANS_NUM, fansNum);
	}

	public List findByHead(Object head) {
		return findByProperty(HEAD, head);
	}

	public List findByIdolNum(Object idolNum) {
		return findByProperty(IDOL_NUM, idolNum);
	}

	public List findByIntroduction(Object introduction) {
		return findByProperty(INTRODUCTION, introduction);
	}

	public List findByIsent(Object isent) {
		return findByProperty(ISENT, isent);
	}

	public List findByIsrealName(Object isrealName) {
		return findByProperty(ISREAL_NAME, isrealName);
	}

	public List findByIsvip(Object isvip) {
		return findByProperty(ISVIP, isvip);
	}

	public List findByLocation(Object location) {
		return findByProperty(LOCATION, location);
	}

	public List findByNick(Object nick) {
		return findByProperty(NICK, nick);
	}

	public List findByOpenid(Object openid) {
		return findByProperty(OPENID, openid);
	}

	public List findByProvinceCode(Object provinceCode) {
		return findByProperty(PROVINCE_CODE, provinceCode);
	}

	public List findBySex(Object sex) {
		return findByProperty(SEX, sex);
	}

	public List findByTag(Object tag) {
		return findByProperty(TAG, tag);
	}

	public List findByTweetnum(Object tweetnum) {
		return findByProperty(TWEETNUM, tweetnum);
	}

	public List findByVerifyinfo(Object verifyinfo) {
		return findByProperty(VERIFYINFO, verifyinfo);
	}

	public List findByOfflineGameNo(Object offlineGameNo) {
		return findByProperty(OFFLINE_GAME_NO, offlineGameNo);
	}

	public List findAll() {
		log.debug("finding all Player instances");
		try {
			String queryString = "from Player";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Player merge(Player detachedInstance) {
		log.debug("merging Player instance");
		try {
			Player result = (Player) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Player instance) {
		log.debug("attaching dirty Player instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Player instance) {
		log.debug("attaching clean Player instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PlayerDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PlayerDAO) ctx.getBean("PlayerDAO");
	}
	
	public Player findByAcctNameUnique(String playerName){
		List<Player> players = findByPlayerName(playerName);
		return players.isEmpty() ? null : players.get(0);
	}
}