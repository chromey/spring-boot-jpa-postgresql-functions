package com.bezkoder.spring.jpa.postgresql.repository;

import com.bezkoder.spring.jpa.postgresql.model.Tutorial;

import java.util.List;

public interface TutorialRepositoryCustom {
	List<Tutorial> findAllPublished();

	List<Tutorial> findByTitleContaining(String title);
}
