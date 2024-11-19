# HBNB Project

## Structure of project
```
hbnb/
 |-app/
 | |-api/
 | | |-v1/
 | | | |-reviews.py
 | | | |-__init__.py
 | | | |-auth.py
 | | | |-amenities.py
 | | | |-admin.py
 | | | |-users.py
 | | | |-places.py
 | | |-__init__.py
 | |-models/
 | | |-place.py
 | | |-review.py
 | | |-base.py
 | | |-user.py
 | | |-amenity.py
 | | |-__init__.py
 | |-persistence
 | | |-places.py
 | | |-amenities.py
 | | |-user.py
 | | |-reviews.py
 | | |-repository.py
 | | |-__init__.py
 | |-services/
 | | |-__init__.py
 | | |-facade.py
 | |-__init__.py
 |-config.py
 |-README.md
 |-requirements.txt
 |-run.py
```

**Explanation:**
- The `app/` folder serves as the core of the application, housing its main components.
- Within `api/`, you’ll find the API routes categorized by version (`v1/`) for better organization.
- The `models/` directory defines the core business logic and entities like `user.py` and `place.py`.
- The `persistence/` folder currently implements in-memory storage, which will later transition to a database-backed system with - SQLAlchemy.
- The `services/` directory contains a Facade layer that orchestrates interactions between different components.
- The `config.py` file handles application settings and environment configurations.
- The `README.md` provides an overview of the project, offering context for developers.
- The `requirements.txt` lists all required Python packages for the project to function.
- The `run.py` script is the main entry point to start the Flask application.


### Command
```markdown
#Run server:
    python run.py

#Run api test (tests folder):
    pytest -s -v --disable-warnings

#Create database and test (tests folder):
    mysql -hlocalhost -u <user> -p <create_database.sql || test_database.sql>
```

### Diagrams
```mermaid
erDiagram
    USER {
        varchar(36) id PK
        varchar(255) first_name
        varchar(255) last_name
        varchar(255) email UK
        varchar(255) password
        boolean is_admin
        timestamp created_at
        timestamp updated_at
    }

    PLACE {
        varchar(36) id PK
        varchar(255) title
        text description
        decimal price
        float latitude
        float longitude
        varchar(36) owner_id FK
        timestamp created_at
        timestamp updated_at
    }

    REVIEW {
        varchar(36) id PK
        text text
        int rating
        varchar(36) user_id FK
        varchar(36) place_id FK
        timestamp created_at
        timestamp updated_at
    }

    AMENITY {
        varchar(36) id PK
        varchar(255) name UK
        timestamp created_at
        timestamp updated_at
    }

    PLACE_AMENITY {
        varchar(36) place_id PK,FK
        varchar(36) amenity_id PK,FK
        timestamp created_at
    }

    USER ||--o{ PLACE : owns
    USER ||--o{ REVIEW : writes
    PLACE ||--o{ REVIEW : receives
    PLACE }|--|{ AMENITY : has
    PLACE ||--|{ PLACE_AMENITY : contains
    AMENITY ||--|{ PLACE_AMENITY : included_in
```

```mermaid
erDiagram
    USER {
        char(36) id PK
        varchar(255) first_name
        varchar(255) last_name
        varchar(255) email UK
        varchar(255) password
        boolean is_admin
        timestamp created_at
        timestamp updated_at
    }

    PLACE {
        char(36) id PK
        varchar(255) title
        text description
        decimal price
        float latitude
        float longitude
        char(36) owner_id FK
        timestamp created_at
        timestamp updated_at
    }

    REVIEW {
        char(36) id PK
        text text
        int rating
        char(36) user_id FK
        char(36) place_id FK
        timestamp created_at
        timestamp updated_at
    }

    AMENITY {
        char(36) id PK
        varchar(255) name UK
        timestamp created_at
        timestamp updated_at
    }

    PLACE_AMENITY {
        char(36) place_id PK,FK
        char(36) amenity_id PK,FK
        timestamp created_at
    }

    RESERVATION {
        char(36) id PK
        datetime start_date
        datetime end_date
        char(36) user_id FK
        char(36) place_id FK
        timestamp created_at
        timestamp updated_at
    }

    USER ||--o{ PLACE : owns
    USER ||--o{ REVIEW : writes
    USER ||--o{ RESERVATION : makes
    PLACE ||--o{ REVIEW : receives
    PLACE ||--o{ RESERVATION : hosts
    PLACE }|--|{ AMENITY : has
    PLACE ||--|{ PLACE_AMENITY : contains
    AMENITY ||--|{ PLACE_AMENITY : included_in
```
