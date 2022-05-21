package com.bezkoder.spring.jpa.postgresql.repository;

import com.bezkoder.spring.jpa.postgresql.model.Tutorial;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.math.BigInteger;
import java.util.List;
import java.util.stream.Collectors;

public class TutorialRepositoryCustomImpl implements TutorialRepositoryCustom {

	@PersistenceContext
	private EntityManager entityManager;

	@Override public List<Tutorial> findAllPublished() {
		return getTutorialsViaFunction("get_published_tutorials()");
	}

	@Override public List<Tutorial> findByTitleContaining(String title) {
		return getTutorialsViaFunction(String.format("get_tutorials_by_title('%s')", title));
	};

	private List<Tutorial> getTutorialsViaFunction(String function) {
		String queryString = "select * from " + function;
		Session session = this.entityManager.unwrap(Session.class);
		Query query = session.createNativeQuery(queryString);
		List<Object[]> results = query.getResultList();
		return results.stream().map(this::toTutorial).collect(Collectors.toList());
	}

	private Tutorial toTutorial(Object[] row) {
		Tutorial t = new Tutorial(((BigInteger) row[0]).longValue());
		t.setTitle((String) row[1]);
		t.setDescription((String) row[2]);
		t.setPublished((Boolean) row[3]);
		return t;
	}

}
