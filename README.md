# Angular / Spring Boot CRUD with Stored Procedures

Find the original README at the bottom of this document

## Installation

The setup consists of a frontend and a backend application.

### Frontend:

An Angular 13 application that can be used as is from https://github.com/bezkoder/angular-13-crud-example. After cloning the repo, run `npm install` to install, then `ng serve --port 8081` to run. The UI should be available under http://localhost:8081.

### Backend (this repo):

A Spring Boot application that was forked from https://github.com/bezkoder/spring-boot-jpa-postgresql with minor adjustments. You have to run `docker-compose up` in the root directory to initialize the PostgreSQL database we're using, then run the app itself from your IDE or via `mvn spring-boot:run`

If both processes are running, you should be seeing a few tutorial records in the UI.

## Documentation

Both frontend and backend are mostly unchanged from https://www.bezkoder.com/spring-boot-angular-13-crud/, so head over there for the bulk of the documentation. In addition to that I:

- added a `docker-compose.yml` that contains instructions to spin up a PostgreSQL database on the developer machine that is initialized via the `init.sql` script
- provided the `init.sql` script that sets up the table and the stored procedures we'll be using to simulate the business logic in the Oracle DB
- wrote a `TutorialRepositoryCustom` interface and `TutorialRepositoryCustomImpl` implementation that uses these stored procedures

### Persistence / ORM

You'll notice that the original version did not need any implementation in the repo, just the interface. This is because Spring Boot can infer the SQL query it needs to execute from the method name, i.e. `findByTitleContaininig` indicates that it has to construct a where clause using the `title` column and the `like` operator.

Obviously this only works for simple cases. For more complex ones custom queries are necessary. Usually for these you would use `JPQL`, which is an abstraction over SQL that, among other things, allows the ORM to happen automatically (i.e. you don't have to tell the application how to map result sets into `Tutorial` objects). However, since we're using stored functions here, these are native queries, meaning Spring Boot has no concept of the kind of data that is returned, so our implementation has to do it manually.

### Model

The backend model is the `Tutorial` class in the `com.bezkoder.spring.hpa.postgresql.model` package. It is also used as the data transfer object in the controller (which determines what gets sent back via a REST API call). In a real life application, there is often a separate DTO layer and a transformation between entity and DTO (and vice versa) happens.

In the frontend, there is a Typescript class for the Tutorial in `tutorial.model.ts` that mirrors the backend entity (or, more precisely, the DTO).

### REST API

The REST API is defined by the annotations (`@RequestMapping`, `@GetMapping` etc.) in the  `TutorialController`. The frontend is calling those REST endpoints through the `tutorial.service.ts`.

# Spring Boot JPA PostgreSQL example with Maven

For instruction, please visit:
> [Spring Boot PostgreSQL with Maven example using Spring Data JPA](https://bezkoder.com/spring-boot-postgresql-example/)

More practice:
> [Spring Boot Pagination & Filter example | Spring JPA, Pageable](https://bezkoder.com/spring-boot-pagination-filter-jpa-pageable/)

> [Spring Data JPA Sort/Order by multiple Columns | Spring Boot](https://bezkoder.com/spring-data-sort-multiple-columns/)

> [Spring Boot Repository Unit Test with @DataJpaTest](https://bezkoder.com/spring-boot-unit-test-jpa-repo-datajpatest/)

> [Deploy Spring Boot App on AWS – Elastic Beanstalk](https://bezkoder.com/deploy-spring-boot-aws-eb/)

Security:
> [Spring Boot, Spring Security, PostgreSQL: JWT Authentication & Authorization example](https://bezkoder.com/spring-boot-security-postgresql-jwt-authentication/)

Fullstack:
> [Vue.js + Spring Boot + MySQL/PostgreSQL example](https://bezkoder.com/spring-boot-vue-js-crud-example/)

> [Angular 10 + Spring Boot + PostgreSQL example](https://bezkoder.com/angular-10-spring-boot-postgresql/)

> [Angular 11 + Spring Boot + PostgreSQL example](https://bezkoder.com/angular-11-spring-boot-postgresql/)

> [React + Spring Boot + MySQL example](https://bezkoder.com/react-spring-boot-crud/)

> [React + Spring Boot + PostgreSQL example](https://bezkoder.com/spring-boot-react-postgresql/)

Run both Back-end & Front-end in one place:
> [Integrate Angular with Spring Boot Rest API](https://bezkoder.com/integrate-angular-spring-boot/)

> [Integrate React.js with Spring Boot Rest API](https://bezkoder.com/integrate-reactjs-spring-boot/)

> [Integrate Vue.js with Spring Boot Rest API](https://bezkoder.com/integrate-vue-spring-boot/)

## Run Spring Boot application
```
mvn spring-boot:run
```

