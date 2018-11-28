DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT,
  danger_level VARCHAR(255),
  last_location VARCHAR,
  homeworld VARCHAR(255),
  weapon VARCHAR(255),
  captured BOOLEAN,
  collected_by VARCHAR(255)
);
