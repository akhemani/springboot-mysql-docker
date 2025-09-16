-- V1: Initial schema for Visit Tracker
-- Safe, additive create with explicit engine/charset/collation.

CREATE TABLE IF NOT EXISTS visit (
  id BIGINT NOT NULL AUTO_INCREMENT,
  message VARCHAR(255) NOT NULL,
  created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

  CONSTRAINT pk_visit PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;
