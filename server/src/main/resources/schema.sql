DROP TABLE IF EXISTS EWM_USER cascade;
DROP TABLE IF EXISTS CATEGORY cascade;
DROP TABLE IF EXISTS EVENT cascade;
DROP TABLE IF EXISTS LOCATION cascade;
DROP TABLE IF EXISTS REQUEST cascade;
DROP TABLE IF EXISTS COMPILATION;

CREATE TABLE IF NOT EXISTS EWM_USER
(
    user_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email   VARCHAR(50)  NOT NULL UNIQUE,
    name    VARCHAR(250) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CATEGORY
(
    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS COMPILATION
(
    compilation_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pinned         BOOLEAN,
    title          VARCHAR(120)
);

CREATE TABLE IF NOT EXISTS EVENT
(
    event_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    annotation         VARCHAR(2000)                         NOT NULL
        CONSTRAINT EVENT_ANNOT CHECK (length(annotation) >= 20),
    category_id        INT REFERENCES CATEGORY (category_id) NOT NULL,
    confirmed_requests INTEGER,
    creation_date      TIMESTAMP WITHOUT TIME ZONE,
    description        VARCHAR(7000)                         NOT NULL
        CONSTRAINT EVENT_DESCR CHECK (length(annotation) >= 20),
    event_date         TIMESTAMP WITHOUT TIME ZONE           NOT NULL,
    initiator_id       BIGINT REFERENCES EWM_USER (user_id)  NOT NULL,
    lat                FLOAT                                 NOT NULL,
    lon                FLOAT                                 NOT NULL,
    is_paid            BOOLEAN,
    participant_limit  INTEGER,
    publishing_date    TIMESTAMP WITHOUT TIME ZONE,
    request_moderation BOOLEAN,
    state              VARCHAR(50),
    title              VARCHAR(120)                          NOT NULL
        CONSTRAINT EVENT_TITLE CHECK (length(annotation) >= 3),
    views              BIGINT,
    compilation_id     INT REFERENCES COMPILATION (compilation_id)
);

CREATE TABLE IF NOT EXISTS REQUEST
(
    request_id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    creation_date TIMESTAMP WITHOUT TIME ZONE,
    event_id      BIGINT REFERENCES EVENT (event_id)   NOT NULL,
    requester_id  BIGINT REFERENCES EWM_USER (user_id) NOT NULL,
    status         VARCHAR(50)
);

