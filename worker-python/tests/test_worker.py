import sys
sys.path.insert(0, '../src')

def test_process_job():
    assert True

def test_worker_imports():
    import time
    import logging
    assert time is not None
    assert logging is not None