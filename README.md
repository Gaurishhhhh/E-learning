# E-Learning Platform

A comprehensive e-learning platform built with Flask that enables course creation, student enrollment, and interactive learning experiences.

## Features

### User Roles
- **Admin**: Platform management and oversight
- **Instructor**: Course creation and management
- **Student**: Course enrollment and learning

### Course Management
- Create and edit courses
- Set course pricing (free or paid)
- Control course publication status
- View enrollment statistics

### User Features
- User authentication (login/register)
- Role-based access control
- Profile management
- Course enrollment

### Admin Features
- User management dashboard
- Course oversight
- Platform statistics
- System-wide settings

## Setup

1. Clone the repository:
```bash
git clone https://github.com/Gaurishhhhh/E-learning.git
cd E-learning
```

2. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set environment variables:
```bash
set FLASK_APP=wsgi.py
set FLASK_DEBUG=1  # For development
```

5. Initialize the database:
```bash
flask db upgrade
```

6. Create an admin user:
```bash
python create_admin.py
```

7. Run the application:
```bash
flask run
```

## Project Structure

```
e-learning/
├── app/
│   ├── __init__.py
│   ├── models.py
│   ├── auth/
│   │   ├── __init__.py
│   │   ├── routes.py
│   │   └── forms.py
│   ├── courses/
│   │   ├── __init__.py
│   │   ├── routes.py
│   │   └── forms.py
│   ├── admin/
│   │   ├── __init__.py
│   │   └── routes.py
│   ├── static/
│   │   ├── css/
│   │   │   └── style.css
│   │   └── js/
│   │       └── main.js
│   └── templates/
│       ├── base.html
│       ├── auth/
│       ├── courses/
│       └── admin/
├── config.py
├── requirements.txt
└── wsgi.py
```

## Usage

1. Admin Login:
   - Email: admin@example.com
   - Password: admin123

2. Creating a Course:
   - Login as admin/instructor
   - Click "My Courses"
   - Click "Create New Course"
   - Fill in course details
   - Click "Save Course"

3. Enrolling in a Course:
   - Browse available courses
   - Click on a course
   - Click "Enroll Now"

## Security Features

- User authentication with Flask-Login
- Password hashing
- CSRF protection
- Role-based access control
- Secure form handling

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
