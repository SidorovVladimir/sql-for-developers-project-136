CREATE TABLE courses (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) UNIQUE NOT NULL,
  description VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
);
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
CREATE TABLE course_modules (
    course_id INT NOT NULL,
    module_id INT NOT NULL,
    PRIMARY KEY (course_id, module_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE program_modules (
    program_id INT NOT NULL,
    module_id INT NOT NULL,
    PRIMARY KEY (program_id, module_id),
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);
CREATE TABLE teaching_groups (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  slug VARCHAR(255) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  user_id INT REFERENCES users(id) NOT NULL
);

CREATE TYPE user_role AS ENUM ('Студент', 'Учитель', 'Админ');
CREATE TABLE users (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  url_group VARCHAR(255) NOT NULL,
  role user_role,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


CREATE TYPE status AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id INT REFERENCES users(id) NOT NULL,
  program_id INT REFERENCES programs(id) NOT NULL,
  status status,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TYPE status_payments AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  enrollment_id INT REFERENCES enrollments(id) NOT NULL,
  amount NUMERIC NOT NULL,
  status status_payments,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE program_completions (
   id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
   user_id INT REFERENCES users(id) NOT NULL,
   program_id INT REFERENCES programs(id) NOT NULL,
   status status,
   begin TIMESTAMP,
   end TIMESTAMP,
   created_at TIMESTAMP,
   updated_at TIMESTAMP
);

CREATE TABLE sertificates (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id INT REFERENCES users(id) NOT NULL,
  program_id INT REFERENCES programs(id) NOT NULL,
  url VARCHAR(255) NOT NULL,
  relese TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE quizzes (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id INT REFERENCES lessons(id) NOT NULL,
  title VARCHAR(255) UNIQUE NOT NULL,
  content JSONB,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE exercises (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id INT REFERENCES lessons(id) NOT NULL,
  title VARCHAR(255) UNIQUE NOT NULL,
  url VARCHAR(255) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE discussions (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id INT REFERENCES lessons(id) NOT NULL,
  user_id INT REFERENCES users(id) NOT NULL,
  text JSONB,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE TYPE status_blog AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blogs (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id INT REFERENCES users(id) NOT NULL,
  title VARCHAR(255) NOT NULL,
  text text NOT NULL,
  status status_blog,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
