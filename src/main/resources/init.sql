CREATE TABLE IF NOT EXISTS tutorials (
	id int8 NOT NULL,
	description varchar(255) NULL,
	published bool NULL,
	title varchar(255) NULL,
	CONSTRAINT tutorials_pkey PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION get_tutorials() RETURNS RECORD as $$
DECLARE 
  ret RECORD;
begin
	select * from tutorials into ret;
return ret;
end;$$ language plpgsql;


