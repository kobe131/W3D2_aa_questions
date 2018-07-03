DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  users_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,
  FOREIGN KEY (users_id) REFERENCES users(id), 
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  questions_id INTEGER NOT NULL,
  parents_reply_id INTEGER,
  users_id INTEGER NOT NULL,  
  FOREIGN KEY (parents_reply_id) REFERENCES replies(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id),
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  users_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,
  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id) 
);

INSERT INTO
users (fname, lname)
VALUES
('Kobe', 'Ko'), ('Nigel', 'Rodrigues'), ('App', 'Academy');

INSERT INTO
questions (title, body, author_id)
VALUES
('NigelQuestion', 'NigelBody', (SELECT id FROM users WHERE fname = 'Nigel')), 
('KobeQuestion', 'KobeBody', (SELECT id FROM users WHERE fname = 'Kobe')),
('AppQuestion', 'AppBody', (SELECT id FROM users WHERE fname = 'Nigel'));

INSERT INTO
question_follows (users_id, questions_id)
VALUES
((SELECT id FROM users WHERE fname = 'Nigel'), (SELECT id FROM questions WHERE title = 'NigelQuestion')), 
((SELECT id FROM users WHERE fname = 'Kobe'), (SELECT id FROM questions WHERE title = 'KobeQuestion')),
((SELECT id FROM users WHERE fname = 'Nigel'), (SELECT id FROM questions WHERE title = 'AppQuestion'));

INSERT INTO
replies (body, questions_id, parents_reply_id, users_id)
VALUES
('ReplyBody1', (SELECT id FROM questions WHERE title = 'NigelQuestion'), NULL, (SELECT id FROM users WHERE fname = 'Nigel')), 
('ReplyBody2', (SELECT id FROM questions WHERE title = 'NigelQuestion'), 1, (SELECT id FROM users WHERE fname = 'Kobe')),
('ReplyBody3', (SELECT id FROM questions WHERE title = 'KobeQuestion'), 1, (SELECT id FROM users WHERE fname = 'App'));

INSERT INTO
question_likes (users_id, questions_id)
VALUES
((SELECT id FROM users WHERE fname = 'Nigel'), (SELECT id FROM questions WHERE title = 'NigelQuestion')), 
((SELECT id FROM users WHERE fname = 'Kobe'), (SELECT id FROM questions WHERE title = 'NigelQuestion')),
((SELECT id FROM users WHERE fname = 'App'), (SELECT id FROM questions WHERE title = 'KobeQuestion'));

