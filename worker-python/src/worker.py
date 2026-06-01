import time
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def process_job(job_id):
    logger.info(f"Processing job {job_id}...")
    time.sleep(1)
    logger.info(f"Job {job_id} completed successfully.")

def main():
    logger.info("Python Worker started...")
    job_id = 1
    while True:
        process_job(job_id)
        job_id += 1
        time.sleep(5)

if __name__ == "__main__":
    main()