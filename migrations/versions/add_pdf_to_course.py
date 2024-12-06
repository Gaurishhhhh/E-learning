"""Add pdf_file to Course model

Revision ID: add_pdf_to_course
Revises: 657296af1d46
Create Date: 2024-12-05 23:03:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision = 'add_pdf_to_course'
down_revision = '657296af1d46'
branch_labels = None
depends_on = None

def upgrade():
    op.add_column('course', sa.Column('pdf_file', sa.String(length=255), nullable=True))

def downgrade():
    op.drop_column('course', 'pdf_file')
