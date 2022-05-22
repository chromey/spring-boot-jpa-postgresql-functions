-- create the table itself, in case it hasn't automatically been created by Spring Boot yet
CREATE TABLE IF NOT EXISTS tutorials (
	id int8 NOT NULL,
	description varchar(255) NULL,
	published bool NULL,
	title varchar(255) NULL,
	CONSTRAINT tutorials_pkey PRIMARY KEY (id)
);

-- some sample data
INSERT INTO tutorials
(id, title, description, published)
VALUES (1, 'First tutorial', 'Description of first tutorial', false) ON CONFLICT DO NOTHING;

INSERT INTO tutorials
(id, title, description, published)
VALUES (2, 'Second tutorial', 'Description of second tutorial', true) ON CONFLICT DO NOTHING;

INSERT INTO tutorials
(id, title, description, published)
VALUES (3, 'Third tutorial', 'Description of third tutorial', true) ON CONFLICT DO NOTHING;


-- the stored procedures (functions) we'll be using. i am assuming here that this similar
-- to the kind of business logic stored in the Oracle DB (a lot simpler of course)
create or replace function get_published_tutorials() returns TABLE (id int8, title varchar, description varchar, published bool) as $$
#variable_conflict use_column
begin
	return query select id, title, description, published from tutorials where published = true;
end;$$ language plpgsql;

create or replace function get_tutorials_by_title(t varchar) returns TABLE (id int8, title varchar, description varchar, published bool) as $$
#variable_conflict use_column
begin
	return query select id, title, description, published from tutorials where lower(title) like lower('%' || t || '%');
end;$$ language plpgsql;



