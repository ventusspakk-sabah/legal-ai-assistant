-- PostgreSQL schema for Legal AI Assistant

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Projects table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Files table
CREATE TABLE files (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Analysis results table
CREATE TABLE analysis_results (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    result JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Generated documents table
CREATE TABLE generated_documents (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    document_path VARCHAR(255) NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Email logs table
CREATE TABLE email_logs (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    email_address VARCHAR(255) NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50)
);

-- Subscription plans table
CREATE TABLE subscription_plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    features JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO subscription_plans (name, price, features) VALUES
('Free Plan', 0.00, 'Basic features'),
('Pro Plan', 29.99, 'Advanced features'),
('Enterprise Plan', 99.99, 'All features');

-- Activity logs table
CREATE TABLE activity_logs (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    action VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_files_project_id ON files(project_id);
CREATE INDEX idx_analysis_results_project_id ON analysis_results(project_id);
CREATE INDEX idx_generated_documents_project_id ON generated_documents(project_id);
CREATE INDEX idx_email_logs_user_id ON email_logs(user_id);
CREATE INDEX idx_activity_logs_user_id ON activity_logs(user_id);
