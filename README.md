# E-Learning Platform

A comprehensive e-learning platform built with Flask that enables course management, student learning, forum discussions, and note-taking capabilities.

## Features

- User Authentication (Login/Register)
- Course Management
  - Create and manage courses
  - Add lessons to courses
  - Browse available courses
  - Track course progress
- Forum System
  - Create topics
  - Participate in discussions
  - Course-specific forums
- Notes System
  - Create and edit personal notes
  - Organize study materials
- Admin Dashboard
  - User management
  - Course oversight
  - System statistics

## Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- Git

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd e-learning
```

2. Create a virtual environment:
```bash
python -m venv venv
```

3. Activate the virtual environment:
- Windows:
```bash
venv\Scripts\activate
```
- Unix or MacOS:
```bash
source venv/bin/activate
```

4. Install required packages:
```bash
pip install -r requirements.txt
```

## Configuration

1. Create a `.env` file in the root directory with the following variables:
```env
SECRET_KEY=your-secret-key-here
DATABASE_URL=sqlite:///elearning.db
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-email-password
```

2. Create required directories:
```bash
mkdir -p static/uploads
```

## Database Setup

1. Initialize the database:
```bash
flask db upgrade
```

2. Create an admin user:
```bash
python create_admin.py
```

## Running the Application

1. Start the development server:
```bash
flask run
```

2. Access the application at `http://localhost:5000`

## Project Structure

```
e-learning/
├── app/
│   ├── admin/         # Admin panel functionality
│   ├── auth/          # Authentication system
│   ├── courses/       # Course management
│   ├── forum/         # Discussion forum
│   ├── notes/         # Note-taking system
│   ├── static/        # Static files (CSS, JS)
│   └── templates/     # HTML templates
├── migrations/        # Database migrations
├── config.py         # Application configuration
├── requirements.txt  # Python dependencies
└── wsgi.py          # WSGI entry point
```

## Features Usage

### For Students
- Register an account
- Browse available courses
- Enroll in courses
- Track progress
- Participate in forum discussions
- Create and manage personal notes

### For Instructors
- Create and manage courses
- Add lessons and course materials
- Monitor student progress
- Participate in course discussions

### For Administrators
- Manage users and permissions
- Overview of system statistics
- Monitor and moderate content
- Manage course catalog

## Support

For any issues or questions, please open an issue in the repository or contact the system administrator.
