# AquaHub - Laravel Backend API

AquaHub is a specialized community platform for aquarium enthusiasts. This backend API handles user authentication, post creation, media storage, categorical topic filtering, comments, bookmarks, user follow relationships, top contributor metrics, and community pulse analytics.

- **Frontend Repository:** [AquaHub Frontend](https://github.com/yairhtet1000/Aqua-Hub-Frontend.git)

---

## Prerequisites & Requirements

- **PHP:** `^8.1` or `^8.2` (Ensure PHP CLI matches your web server version)
- **Composer:** `^2.x`
- **Database:** MySQL / MariaDB (e.g., via Laragon or XAMPP)
- **Node.js & NPM:** (Optional, for running frontend asset builds if applicable)

---

## Common Setup Issues & Solutions

### 1. PHP Version Mismatch

If you encounter errors like `composer install requires php ^8.x but your system version is 8.y`:

- Verify your CLI PHP version using `php -v`.
- If using Laragon or XAMPP, ensure your system `PATH` points to the correct PHP version directory.
- Alternatively, bypass strict platform checks during installation:
    ```bash
    composer install --ignore-platform-req=php
    ```

````

### 2. Composer Dependency & Ext-ZIP / Ext-PDO Errors
If `composer install` fails due to missing PHP extensions or package conflicts:

Enable required extensions in your `php.ini` file:

```ini
extension=pdo_mysql
extension=zip
extension=fileinfo
extension=mbstring
extension=gd
````

Clear Composer cache and run a platform-agnostic update:

```bash
composer clear-cache
composer update --ignore-platform-reqs
```

---

## Installation & Setup Instructions

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yairhtet1000/Aqua-Hub-Backend.git
    cd Aqua-Hub-Backend
    ```

2. **Install PHP dependencies:**

    ```bash
    composer install --ignore-platform-reqs
    ```

3. **Configure Environment File:**
    - Copy `.env.example` to `.env`:
        ```bash
        cp .env.example .env
        ```
    - Open `.env` and set your local MySQL database credentials:

        ```env
        DB_CONNECTION=mysql
        DB_HOST=127.0.0.1
        DB_PORT=3306
        DB_DATABASE=aqua_hub
        DB_USERNAME=root
        DB_PASSWORD=

        APP_URL=http://127.0.0.1:8000
        FRONTEND_URL=http://localhost:5173
        ```

4. **Generate Application Key:**

    ```bash
    php artisan key:generate
    ```

5. **Database Import / Migration:**

    **Option A (Import database dump):**
    - Create a MySQL database named `aqua_hub` and import `database.sql`:
        ```bash
        mysql -u root -p aqua_hub < database.sql
        ```

    **Option B (Run fresh migrations & seeders):**

    ```bash
    php artisan migrate:fresh --seed
    ```

6. **Create Storage Symlink (Crucial for Avatars & Post Images):**

    ```bash
    php artisan storage:link
    ```

7. **Run the Backend Server:**
    ```bash
    php artisan serve
    ```

The API server will run at `http://127.0.0.1:8000`.

---

## Database Setup

1. Create a MySQL database named `aqua_hub` (or update `.env` with your database credentials).
2. Import the database dump:
    ```bash
    mysql -u root -p aqua_hub < database.sql
    ```
3. Alternatively, run migrations and seeders:
    ```bash
    php artisan migrate --seed
    ```
