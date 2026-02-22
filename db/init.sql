-- Create Players table
CREATE TABLE IF NOT EXISTS players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    bu VARCHAR(50) NOT NULL,
    password VARCHAR(255),
    role VARCHAR(20) DEFAULT 'player',
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

-- Create Matches table
CREATE TABLE IF NOT EXISTS matches (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER REFERENCES players(id),
    opponent_id INTEGER REFERENCES players(id),
    winner_id INTEGER REFERENCES players(id),
    creator_score INTEGER NOT NULL,
    opponent_score INTEGER NOT NULL,
    match_type VARCHAR(2) NOT NULL, -- '11' or '21'
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'verified', 'rejected'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verified_at TIMESTAMP
);

-- Seed Players
INSERT INTO players (name, bu, role, score_11, score_21, password) VALUES 
('Admin', 'Management', 'admin', 1000, 1000, 'adminpassword'),
('Marco S.', 'Eng', 'player', 1250, 1300, NULL),
('Luca R.', 'HR', 'player', 1100, 1050, NULL),
('Sara B.', 'Sales', 'player', 1150, 1200, NULL),
('Marta G.', 'Eng', 'player', 1050, 1100, NULL),
('Andrea V.', 'Marketing', 'player', 1000, 1000, NULL),
('Paolo F.', 'Sales', 'player', 1080, 1040, NULL)
ON CONFLICT (name) DO NOTHING;

-- Seed Teams (using subqueries to get IDs based on names for reliability)
INSERT INTO teams (player1_id, player2_id, score_21, team_name) VALUES 
((SELECT id FROM players WHERE name = 'Marco S.'), (SELECT id FROM players WHERE name = 'Luca R.'), 1200, 'The Smashers'),
((SELECT id FROM players WHERE name = 'Sara B.'), (SELECT id FROM players WHERE name = 'Marta G.'), 1150, 'Ping Kings');
