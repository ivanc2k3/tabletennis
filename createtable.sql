CREATE TABLE IF NOT EXISTS outcome_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(40) NOT NULL DEFAULT 'no data',
    code VARCHAR(15) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS action_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    technicalType VARCHAR(15) NOT NULL DEFAULT 'Zero',
    code VARCHAR(5) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS point_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    code VARCHAR(10) NOT NULL, --rename
    nameEng VARCHAR(40) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS spin_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) DEFAULT 1
);

CREATE TABLE IF NOT EXISTS strength_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS hand_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS strick_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS position_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(40) NOT NULL 
);

CREATE TABLE IF NOT EXISTS group_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS serve_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS game_level_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS game_category_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS game_format_type (
    id SERIAL PRIMARY KEY, -- auto_increment
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS technical_style_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS rubber_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS grip_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS recket_hand_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(30) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS nationality_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS sex_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
);

CREATE TABLE IF NOT EXISTS user_registion (
    tel INT(20) UNSIGNED NOT NULL,
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    password VARCHAR NOT NULL,
    department VARCHAR(50),
    categoryId INT(2),
    mail VARCHAR(50) NOT NULL,
    nationalityId INT(4) UNSIGNED NOT NULL,
    masterId INT(10) UNSIGNED,
    userId INT(10) UNSIGNED,
    plan1 INT(1) UNSIGNED,
    plan2 INT(1) UNSIGNED,
    plan3 INT(1) UNSIGNED,
    plan4 INT(1) UNSIGNED,
    FOREIGN KEY (nationalityId)
        REFERENCES nationality_type(id)
);

CREATE TABLE IF NOT EXISTS player (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    sexId INT(2) UNSIGNED NOT NULL,
    birthday DATE,
    nationalityId INT(4) UNSIGNED NOT NULL,
    bestRecord INT(6) UNSIGNED NOT NULL,
    worldRanking INT(6) UNSIGNED NOT NULL,
    recketHandId INT(2) UNSIGNED NOT NULL,
    gripId INT(2) UNSIGNED NOT NULL,
    rubberId INT(10) UNSIGNED NOT NULL,
    technicalStyleId INT(2) UNSIGNED NOT NULL,
    builderId INT(11),
    userId INT(10) UNSIGNED,
    ballage INT(2) UNSIGNED,
    FOREIGN KEY (sexId)
        REFERENCES sex_type(id),
    FOREIGN KEY (nationalityId)
        REFERENCES nationality_type(id),
    FOREIGN KEY (recketHandId)
        REFERENCES recket_hand_type(id),
    FOREIGN KEY (gripId)
        REFERENCES grip_type(id),
    FOREIGN KEY (rubberId)
        REFERENCES rubber_type(id),
    FOREIGN KEY (technicalStyleId)
        REFERENCES technical_style_type(id)
);

CREATE TABLE IF NOT EXISTS game (
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    formatId INT(2) UNSIGNED NOT NULL,
    date DATE,
    serveId INT(2) UNSIGNED NOT NULL,
    categoryId INT(2) UNSIGNED NOT NULL,
    levelId INT(3) UNSIGNED NOT NULL,
    builderId1 INT(11),
    builderId2 INT(11),
    notes VARCHAR(4000),
    groupId INT(2) UNSIGNED NOT NULL DEFAULT 11,
    isAnalyzed BOOLEAN DEFAULT 0, --  new
    FOREIGN KEY (formatId)
        REFERENCES game_format_type(id),
    FOREIGN KEY (serveId)
        REFERENCES serve_type(id),
    FOREIGN KEY (categoryId)
        REFERENCES game_category_type(id),
    FOREIGN KEY (levelId)
        REFERENCES game_level_type(id)
);

CREATE TABLE IF NOT EXISTS game_player (
    id SERIAL PRIMARY KEY,
    serveId INT(2) UNSIGNED NOT NULL,
    gameId INT(11) UNSIGNED NOT NULL,
    playerId INT(10) UNSIGNED NOT NULL,
    name VARCHAR(30) NOT NULL,
    sexId INT(2) UNSIGNED NOT NULL,
    nationalityId INT(4) UNSIGNED NOT NULL,
    worldRanking INT(6) UNSIGNED NOT NULL,
    recketHandId INT(2) UNSIGNED NOT NULL,
    gripId INT(2) UNSIGNED NOT NULL,
    rubberId INT(10) UNSIGNED NOT NULL,
    technicalStyleId INT(2) UNSIGNED NOT NULL,
    isWin INT(2) UNSIGNED NOT NULL DEFAULT 0,
    FOREIGN KEY (serveId)
        REFERENCES serve_type(id),
    FOREIGN KEY (gameId)
        REFERENCES game(id)
        ON DELETE CASCADE,
    FOREIGN KEY (playerId)
        REFERENCES player(id)
        ON DELETE CASCADE,
    FOREIGN KEY (sexId)
        REFERENCES sex_type(id),
    FOREIGN KEY (nationalityId)
        REFERENCES nationality_type(id),
    FOREIGN KEY (recketHandId)
        REFERENCES recket_hand_type(id),
    FOREIGN KEY (gripId)
        REFERENCES grip_type(id),
    FOREIGN KEY (rubberId)
        REFERENCES rubber_type(id),
    FOREIGN KEY (technicalStyleId)
        REFERENCES technical_style_type(id)
);

-- CREATE TABLE IF NOT EXISTS goodscore(
--     id INT(12) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
--     typeId INT(1) UNSIGNED NOT NULL DEFAULT 0,
--     gamePlayerItemStart BIGINT(25) UNSIGNED NOT NULL,
--     gameId INT(11) UNSIGNED NOT NULL,
--     numberGame TINYINT(3) UNSIGNED NOT NULL,
--     score VARCHAR(10) NOT NULL,
--     FOREIGN KEY (gamePlayerItemStart)
--         REFERENCES game_player(id),
--     FOREIGN KEY (gameId)
--         REFERENCES game(id)
--         ON DELETE CASCADE
-- )

CREATE TABLE IF NOT EXISTS game_player_item (
    id SERIAL PRIMARY KEY,
    numberGame TINYINT(3) UNSIGNED NOT NULL,
    gamePlayerId INT(11) UNSIGNED NOT NULL,
    gamePlayerOtherId INT(11) UNSIGNED NOT NULL DEFAULT 0,
    serveId INT(2) UNSIGNED NOT NULL,
    servePoint INT(2) UNSIGNED NOT NULL,
    serveNumber INT(2) UNSIGNED NOT NULL DEFAULT 0,
    numberGameA INT(2) UNSIGNED NOT NULL DEFAULT 0,
    numberGameB INT(2) UNSIGNED NOT NULL DEFAULT 0,
    strickNumber INT(4) UNSIGNED NOT NULL,
    scoreSelf INT(3) UNSIGNED NOT NULL DEFAULT 0,
    scoreOther INT(3) UNSIGNED NOT NULL DEFAULT 0,
    strickId INT(2) UNSIGNED NOT NULL,
    handId INT(4) UNSIGNED NOT NULL,
    strengthId INT(4) UNSIGNED NOT NULL,
    spinId INT(4) UNSIGNED NOT NULL,
    pointId INT(4) UNSIGNED NOT NULL,
    actionId INT(4) UNSIGNED NOT NULL,
    outcomeId INT(4) UNSIGNED NOT NULL,
    let INT(11) UNSIGNED NOT NULL, -- origianl: stopGamePlayerId
    goodId INT(2) UNSIGNED NOT NULL DEFAULT 0,
    positionId INT(2) UNSIGNED NOT NULL DEFAULT 0,
    FOREIGN KEY (gamePlayerId)
        REFERENCES game_player(id)
        ON DELETE CASCADE,
    FOREIGN KEY (serveId)
        REFERENCES serve_type(id),
    FOREIGN KEY (strickId)
        REFERENCES strick_type(id),
    FOREIGN KEY (handId)
        REFERENCES hand_type(id),
    FOREIGN KEY (strengthId)
        REFERENCES strength_type(id),
    FOREIGN KEY (spinId)
        REFERENCES spin_type(id),
    FOREIGN KEY (pointId)
        REFERENCES point_type(id),
    FOREIGN KEY (actionId)
        REFERENCES action_type(id),
    FOREIGN KEY (outcomeId)
        REFERENCES outcome_type(id),
    -- FOREIGN KEY (goodId)
    --     REFERENCES goodscore(id)
    FOREIGN KEY (positionId)
        REFERENCES position_type(id)
);

CREATE TABLE IF NOT EXISTS game_player_double_item (
    id SERIAL PRIMARY KEY,
    numberGame TINYINT(3) UNSIGNED NOT NULL,
    gamePlayerId INT(11) UNSIGNED NOT NULL,
    gamePlayerOtherId INT(11) UNSIGNED NOT NULL DEFAULT 0,
    serveId INT(2) UNSIGNED NOT NULL,
    servePoint INT(2) UNSIGNED NOT NULL,
    serveNumber INT(2) UNSIGNED NOT NULL DEFAULT 0,
    numberGameA INT(2) UNSIGNED NOT NULL DEFAULT 0,
    numberGameB INT(2) UNSIGNED NOT NULL DEFAULT 0,
    strickNumber INT(4) UNSIGNED NOT NULL,
    scoreSelf INT(3) UNSIGNED NOT NULL DEFAULT 0,
    scoreOther INT(3) UNSIGNED NOT NULL DEFAULT 0,
    strickId INT(2) UNSIGNED NOT NULL,
    handId INT(4) UNSIGNED NOT NULL,
    strengthId INT(4) UNSIGNED NOT NULL,
    spinId INT(4) UNSIGNED NOT NULL,
    pointId INT(4) UNSIGNED NOT NULL,
    actionId INT(4) UNSIGNED NOT NULL,
    outcomeId INT(4) UNSIGNED NOT NULL,
    let INT(11) UNSIGNED NOT NULL, -- origianl: stopGamePlayerId
    goodId INT(2) UNSIGNED NOT NULL DEFAULT 0,
    FOREIGN KEY (gamePlayerId)
        REFERENCES game_player(id)
        ON DELETE CASCADE,
    FOREIGN KEY (serveId)
        REFERENCES serve_type(id),
    FOREIGN KEY (strickId)
        REFERENCES strick_type(id),
    FOREIGN KEY (handId)
        REFERENCES hand_type(id),
    FOREIGN KEY (strengthId)
        REFERENCES strength_type(id),
    FOREIGN KEY (spinId)
        REFERENCES spin_type(id),
    FOREIGN KEY (pointId)
        REFERENCES point_type(id),
    FOREIGN KEY (actionId)
        REFERENCES action_type(id),
    FOREIGN KEY (outcomeId)
        REFERENCES outcome_type(id)
);