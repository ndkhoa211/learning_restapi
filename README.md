# Learning REST API with Flask

![Python](https://img.shields.io/badge/python-v3.8+-blue.svg)
![Flask](https://img.shields.io/badge/Flask-2.0+-green.svg)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-ORM-orange.svg)
![JWT](https://img.shields.io/badge/JWT-Authentication-red.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

This repository documents my journey learning how to build REST APIs using Flask and related technologies.

## What I Learned

### 1. Flask Application Structure
- **App Factory Pattern**: Created a modular Flask app using `create_app()` function in `app.py:17`
- **Blueprint Organization**: Separated concerns using Flask-Smorest blueprints for different resources
- **Configuration Management**: Set up proper configuration for development with SQLite database

### 2. Database Design & SQLAlchemy
- **One-to-Many Relationships**: Implemented stores-to-items relationship in `models/store.py:9`
- **Many-to-Many Relationships**: Created items-tags relationship using association table `models/item_tags.py`
- **Database Models**: Built proper SQLAlchemy models for Store, Item, Tag, and User entities
- **Foreign Keys & Cascading**: Used proper cascade deletion and foreign key constraints

### 3. REST API Design
- **Resource-Based URLs**: Organized endpoints around resources (stores, items, tags, users)
- **HTTP Methods**: Implemented GET, POST, PUT, DELETE operations for CRUD functionality
- **Status Codes**: Used appropriate HTTP status codes (200, 201, 404, 409, 401, etc.)
- **API Documentation**: Auto-generated Swagger UI documentation at `/swagger-ui`

### 4. User Authentication & Security
- **Password Hashing**: Used `passlib` with `pbkdf2_sha256` for secure password storage in `resources/user.py:36`
- **JWT Authentication**: Implemented JSON Web Tokens using Flask-JWT-Extended
- **Protected Endpoints**: Added `@jwt_required()` decorator to secure API endpoints
- **Token Management**:
  - Login endpoint generates access tokens at `resources/user.py:53`
  - Logout endpoint adds tokens to blocklist for revocation at `resources/user.py:23`
  - Token expiration and validation handlers in `app.py:61-87`

### 5. Advanced JWT Features
- **Custom Claims**: Added admin privileges based on user ID in `app.py:55`
- **Token Blocklist**: Implemented token revocation system using in-memory blocklist
- **Comprehensive Error Handling**: Created handlers for expired, invalid, and missing tokens

### 6. API Validation & Serialization
- **Marshmallow Schemas**: Used schemas for request/response validation and serialization
- **Input Validation**: Validated incoming data structure and types
- **Response Formatting**: Consistent JSON response formatting

### 7. Development Tools & Best Practices
- **Flask-Smorest**: Used for automatic API documentation and validation
- **Method View Classes**: Organized endpoints using `MethodView` for cleaner code structure
- **Error Handling**: Implemented proper error responses with meaningful messages
- **Database Migration**: Set up automatic table creation with `db.create_all()`

## Key Technologies Used
- **Flask**: Web framework
- **Flask-SQLAlchemy**: ORM for database operations
- **Flask-Smorest**: API documentation and validation
- **Flask-JWT-Extended**: JWT authentication
- **Passlib**: Password hashing
- **SQLite**: Development database

## Learning Progression
1. Basic Flask app setup and routing
2. Database modeling with SQLAlchemy relationships
3. REST API endpoints with proper HTTP methods
4. User registration and authentication
5. JWT token-based security
6. Protected endpoints and authorization
7. Token management (logout/revocation)

This project provided hands-on experience with modern web API development patterns and security practices.

## 🚀 Installation & Setup

### Prerequisites
- Python 3.8 or higher
- pip (Python package manager)

### Quick Start
```bash
# Clone the repository
git clone <your-repo-url>
cd learning_restapi

# Install dependencies
pip install flask flask-smorest flask-sqlalchemy flask-jwt-extended passlib

# Set environment variables (optional)
export FLASK_APP=app
export FLASK_ENV=development

# Run the application
flask run
```

The API will be available at `http://localhost:5000` and Swagger documentation at `http://localhost:5000/swagger-ui`.

## 📁 Project Structure
```
learning_restapi/
├── app.py                 # Main application factory
├── db.py                  # Database initialization
├── blocklist.py          # JWT token blocklist
├── schemas.py            # Marshmallow schemas
├── models/               # SQLAlchemy models
│   ├── __init__.py
│   ├── user.py          # User model
│   ├── store.py         # Store model
│   ├── item.py          # Item model
│   ├── tag.py           # Tag model
│   └── item_tags.py     # Many-to-many association table
└── resources/           # API endpoints
    ├── user.py          # User authentication endpoints
    ├── store.py         # Store CRUD endpoints
    ├── item.py          # Item CRUD endpoints
    └── tag.py           # Tag CRUD endpoints
```

## 🔌 API Endpoints

### Authentication Endpoints
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/register` | Register a new user | ❌ |
| POST | `/login` | Login and get access token | ❌ |
| POST | `/logout` | Logout and revoke token | ✅ |

### User Management (Development Only)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/user/<int:user_id>` | Get user by ID | ❌ |
| DELETE | `/user/<int:user_id>` | Delete user by ID | ❌ |

### Store Management
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/store` | Get all stores | ❌ |
| POST | `/store` | Create a new store | ❌ |
| GET | `/store/<int:store_id>` | Get store by ID | ❌ |
| DELETE | `/store/<int:store_id>` | Delete store | ❌ |

### Item Management
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/item` | Get all items | ✅ |
| POST | `/item` | Create a new item | ✅ |
| GET | `/item/<int:item_id>` | Get item by ID | ✅ |
| PUT | `/item/<int:item_id>` | Update item | ❌ |
| DELETE | `/item/<int:item_id>` | Delete item | ✅ (Admin only) |

### Tag Management
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/store/<int:store_id>/tag` | Get all tags for a store | ❌ |
| POST | `/store/<int:store_id>/tag` | Create a new tag | ❌ |
| POST | `/item/<int:item_id>/tag/<int:tag_id>` | Link item to tag | ❌ |
| DELETE | `/item/<int:item_id>/tag/<int:tag_id>` | Unlink item from tag | ❌ |
| GET | `/tag/<int:tag_id>` | Get tag by ID | ❌ |
| DELETE | `/tag/<int:tag_id>` | Delete tag | ❌ |