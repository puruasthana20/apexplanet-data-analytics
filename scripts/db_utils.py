import sqlite3

DB_PATH = "../data/customer_churn.db"

def get_connection():
    """
    Returns a connection to the SQLite database.
    """
    return sqlite3.connect(DB_PATH)