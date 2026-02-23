-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create Players table
CREATE TABLE IF NOT EXISTS players (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    bu VARCHAR(50) NOT NULL,
    password VARCHAR(255),
    role VARCHAR(20) DEFAULT 'player',
    score_21 INTEGER DEFAULT 1000
);

-- Create Teams table (auto-created when first doubles match is played)
CREATE TABLE IF NOT EXISTS teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player1_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    player2_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    score_21 INTEGER DEFAULT 1000,
    UNIQUE(player1_id, player2_id)
);

-- Create Matches table (singles only)
CREATE TABLE IF NOT EXISTS matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    creator_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    opponent_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    winner_id UUID REFERENCES players(id) ON DELETE SET NULL,
    creator_score INTEGER NOT NULL,
    opponent_score INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'verified',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verified_at TIMESTAMP
);

-- Create Team Matches table (doubles)
CREATE TABLE IF NOT EXISTS team_matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    opponent_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    team_score INTEGER NOT NULL,
    opponent_score INTEGER NOT NULL,
    winner_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast team lookups
CREATE INDEX IF NOT EXISTS idx_teams_players ON teams(player1_id, player2_id);

-- Seed Admin only
INSERT INTO players (name, bu, role, score_21, password) VALUES 
('Admin', 'Management', 'admin', 1000, 'adminpassword')
ON CONFLICT (name) DO NOTHING;
