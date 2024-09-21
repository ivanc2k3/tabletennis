CREATE TABLE IF NOT EXISTS public.outcome_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(40) NOT NULL DEFAULT 'no data',
    code VARCHAR(15) NOT NULL DEFAULT 1
)

CREATE TABLE IF NOT EXISTS public.action_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    technicalType VARCHAR(15) NOT NULL DEFAULT 'Zero',
    code VARCHAR(5) NOT NULL DEFAULT 1
)

CREATE TABLE IF NOT EXISTS public.point_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    code VARCHAR(10) NOT NULL, --rename
    nameEng VARCHAR(40) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.spin_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) DEFAULT 1
)

CREATE TABLE IF NOT EXISTS public.strength_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) NOT NULL DEFAULT 1
)

CREATE TABLE IF NOT EXISTS public.hand_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data',
    code VARCHAR(5) NOT NULL DEFAULT 1
)

CREATE TABLE IF NOT EXISTS public.strick_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.position_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(40) NOT NULL 
)

CREATE TABLE IF NOT EXISTS public.group_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL
)

CREATE TABLE IF NOT EXISTS public.serve_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(2) NOT NULL
)

CREATE TABLE IF NOT EXISTS public.game_level_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.game_category_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.game_format_type (
    id SERIAL PRIMARY KEY, -- auto_increment
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.technical_style_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.rubber_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.grip_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    nameEng VARCHAR(50) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.recket_hand_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(30) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.nationality_type (
    id SERIAL PRIMARY KEY,
    code VARCHAR(4) NOT NULL,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.sex_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    nameEng VARCHAR(20) NOT NULL DEFAULT 'no data'
)

CREATE TABLE IF NOT EXISTS public.user_registion (
    tel INT NOT NULL,
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    password VARCHAR NOT NULL,
    department VARCHAR(50),
    categoryId INT,
    mail VARCHAR(50) NOT NULL,
    nationalityId INT NOT NULL,
    masterId INT,
    userId INT,
    plan1 INT,
    plan2 INT,
    plan3 INT,
    plan4 INT,
    FOREIGN KEY (nationalityId)
        REFERENCES nationality_type(id)
)

CREATE TABLE IF NOT EXISTS public.player (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    sexId INT NOT NULL,
    birthday DATE,
    nationalityId INT NOT NULL,
    bestRecord INT NOT NULL,
    worldRanking INT NOT NULL,
    recketHandId INT NOT NULL,
    gripId INT NOT NULL,
    rubberId INT NOT NULL,
    technicalStyleId INT NOT NULL,
    builderId INT,
    userId INT,
    ballage INT,
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
)

CREATE TABLE IF NOT EXISTS public.game (
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    formatId INT NOT NULL,
    date DATE,
    serveId INT NOT NULL,
    categoryId INT NOT NULL,
    levelId INT NOT NULL,
    builderId1 INT,
    builderId2 INT,
    notes VARCHAR(4500),
    groupId INT NOT NULL DEFAULT 11,
    videoType VARCHAR(5) NOT NULL,
    videoUrl VARCHAR(100) NOT NULL,
    isDelete INT NOT NULL DEFAULT 0,
    FOREIGN KEY (formatId)
        REFERENCES game_format_type(id),
    FOREIGN KEY (serveId)
        REFERENCES serve_type(id),
    FOREIGN KEY (categoryId)
        REFERENCES game_category_type(id),
    FOREIGN KEY (levelId)
        REFERENCES game_level_type(id)
)

CREATE TABLE IF NOT EXISTS public.game_player (
    id SERIAL PRIMARY KEY,
    serveId INT NOT NULL,
    gameId INT NOT NULL,
    playerId INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    sexId INT NOT NULL,
    nationalityId INT NOT NULL,
    worldRanking INT NOT NULL,
    recketHandId INT NOT NULL,
    gripId INT NOT NULL,
    rubberId INT NOT NULL,
    technicalStyleId INT NOT NULL,
    isWin INT NOT NULL DEFAULT 0,
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
)

-- CREATE TABLE IF NOT EXISTS public.goodscore(
--     id INT(12) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
--     typeId INT NOT NULL DEFAULT 0,
--     gamePlayerItemStart BIGINT(25) UNSIGNED NOT NULL,
--     gameId INT NOT NULL,
--     numberGame TINYINT NOT NULL,
--     score VARCHAR(10) NOT NULL,
--     FOREIGN KEY (gamePlayerItemStart)
--         REFERENCES game_player(id),
--     FOREIGN KEY (gameId)
--         REFERENCES game(id)
--         ON DELETE CASCADE
-- )

CREATE TABLE IF NOT EXISTS public.game_player_item (
    id SERIAL PRIMARY KEY,
    numberGame INT NOT NULL,
    gamePlayerId INT NOT NULL,
    gamePlayerOtherId INT NOT NULL DEFAULT 0,
    serveId INT NOT NULL,
    servePoint INT NOT NULL,
    serveNumber INT NOT NULL DEFAULT 0,
    numberGameA INT NOT NULL DEFAULT 0,
    numberGameB INT NOT NULL DEFAULT 0,
    strickNumber INT NOT NULL,
    scoreSelf INT NOT NULL DEFAULT 0,
    scoreOther INT NOT NULL DEFAULT 0,
    strickId INT NOT NULL,
    handId INT NOT NULL,
    strengthId INT NOT NULL,
    spinId INT NOT NULL,
    pointId INT NOT NULL,
    actionId INT NOT NULL,
    outcomeId INT NOT NULL,
    let INT NOT NULL, -- origianl: stopGamePlayerId
    goodId INT NOT NULL DEFAULT 0,
    positionId INT NOT NULL DEFAULT 0,
    timer DECIMAL(26,20) NOT NULL DEFAULT 0.00000000000000000000,
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
    FOREIGN KEY (positionId)
        REFERENCES position_type(id)
)

CREATE TABLE IF NOT EXISTS public.game_player_double_item (
    id SERIAL PRIMARY KEY,
    numberGame INT NOT NULL,
    gamePlayerId INT NOT NULL,
    gamePlayerOtherId INT NOT NULL DEFAULT 0,
    serveId INT NOT NULL,
    servePoint INT NOT NULL,
    serveNumber INT NOT NULL DEFAULT 0,
    numberGameA INT NOT NULL DEFAULT 0,
    numberGameB INT NOT NULL DEFAULT 0,
    strickNumber INT NOT NULL,
    scoreSelf INT NOT NULL DEFAULT 0,
    scoreOther INT NOT NULL DEFAULT 0,
    strickId INT NOT NULL,
    handId INT NOT NULL,
    strengthId INT NOT NULL,
    spinId INT NOT NULL,
    pointId INT NOT NULL,
    actionId INT NOT NULL,
    outcomeId INT NOT NULL,
    let INT NOT NULL, -- origianl: stopGamePlayerId
    goodId INT NOT NULL DEFAULT 0,
    timer DECIMAL(26,20) NOT NULL DEFAULT 0.00000000000000000000,
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
)


CREATE TABLE IF NOT EXISTS public.goodscore(
    id SERIAL PRIMARY KEY,
    typeId INT NOT NULL DEFAULT 0,
    gamePlayerItemIdStart INT NOT NULL,
    startTimer DECIMAL(26,20) NOT NULL,
    endTimer DECIMAL(26,20) NOT NULL,
    gameId INT NOT NULL,
    numberGame INT NOT NULL,
    score VARCHAR(10) NOT NULL,
    FOREIGN KEY (gamePlayerItemIdStart)
        REFERENCES game_player_item(id)
        ON DELETE CASCADE,
    FOREIGN KEY (gameId)
        REFERENCES game(id)
        ON DELETE CASCADE
)

CREATE TABLE IF NOT EXISTS public.doublegoodscore (
    id SERIAL PRIMARY KEY,
    typeId INT NOT NULL DEFAULT 0,
    gamePlayerItemIdStart INT NOT NULL,
    startTimer DECIMAL(26,20) NOT NULL,
    endTimer DECIMAL(26,20) NOT NULL,
    gameId INT NOT NULL,
    numberGame INT NOT NULL,
    score VARCHAR(10) NOT NULL,
    FOREIGN KEY (gamePlayerItemIdStart)
        REFERENCES game_player_double_item(id)
        ON DELETE CASCADE,
    FOREIGN KEY (gameId)
        REFERENCES game(id)
        ON DELETE CASCADE
)


TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.game
    OWNER to wasn;