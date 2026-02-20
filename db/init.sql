-- Create Players table
CREATE TABLE IF NOT EXISTS players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bu VARCHAR(50) NOT NULL,
    score_11 INTEGER DEFAULT 1000,
    score_21 INTEGER DEFAULT 1000
);

-- Create Teams table
CREATE TABLE IF NOT EXISTS teams (
    id SERIAL PRIMARY KEY,
    player1_id INTEGER REFERENCES players(id),
    player2_id INTEGER REFERENCES players(id),
    score_21 INTEGER DEFAULT 1000,
    team_name VARCHAR(100)
);

-- Seed Players
INSERT INTO players (name, bu, score_11, score_21) VALUES 
('Marco S.', 'Eng', 1250, 1300),
('Luca R.', 'HR', 1100, 1050),
('Sara B.', 'Sales', 1150, 1200),
('Marta G.', 'Eng', 1050, 1100),
('Andrea V.', 'Marketing', 950, 980),
('Paolo F.', 'Sales', 1080, 1040);

-- Seed Teams (using subqueries to get IDs based on names for reliability)
INSERT INTO teams (player1_id, player2_id, score_21, team_name) VALUES 
((SELECT id FROM players WHERE name = 'Marco S.'), (SELECT id FROM players WHERE name = 'Luca R.'), 1200, 'The Smashers'),
((SELECT id FROM players WHERE name = 'Sara B.'), (SELECT id FROM players WHERE name = 'Marta G.'), 1150, 'Ping Kings');
