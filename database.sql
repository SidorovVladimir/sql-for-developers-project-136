CREATE TABLE lessons (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) UNIQUE NOT NULL,
  content VARCHAR(255) UNIQUE NOT NULL,
  url_video VARCHAR(255) UNIQUE NOT NULL,
  pozition INT UNIQUE NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  url_course VARCHAR(255) NOT NULL,
  is_deleted TINYINT DEFAULT 0,
  course_id INT REFERENCES courses (id) UNIQUE NOT NULL
);

CREATE TABLE courses (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) UNIQUE NOT NULL,
  description VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
);

CREATE TABLE modules (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) UNIQUE NOT NULL,
  description VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
);

CREATE TABLE programs (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) UNIQUE NOT NULL,
  price NUMERIC,
  type VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE program_module (
    program_id INT NOT NULL,
    module_id INT NOT NULL,
    PRIMARY KEY (program_id, module_id),
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE course_module (
    course_id INT NOT NULL,
    module_id INT NOT NULL,
    PRIMARY KEY (course_id, module_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE users (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  url_group VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE teaching_groups (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  slug VARCHAR(255) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  user_id REFERENCES users(id) NOT NULL
);