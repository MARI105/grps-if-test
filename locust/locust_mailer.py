#!/usr/bin/env python

import os
import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

SMTP_HOST = "localhost"
SMTP_PORT = "2525"

LOCUST_LOGS_PATH = "locust/logs"


# Gets input parameters from environment variables set by caller
def get_parameters():
    test_run = os.environ.get("LOCUST_TEST_CASE_LOG")
    if test_run is None:
        print("LOCUST_TEST_CASE_LOG environment variable is missing for locust_mailer")
        sys.exit(11)

    test_status = os.environ.get("LOCUST_TEST_STATUS")
    if test_status is None:
        print("LOCUST_TEST_STATUS environment variable is missing for locust_mailer")
        sys.exit(12)

    mail_from = os.environ.get("LOCUST_MAIL_FROM")
    if mail_from is None:
        print("LOCUST_MAIL_FROM environment variable is missing for locust_mailer")
        sys.exit(13)

    mail_to = os.environ.get("LOCUST_MAIL_TO")
    if mail_to is None:
        print("LOCUST_MAIL_TO environment variable is missing for locust_mailer")
        sys.exit(14)

    mail_subject = os.environ.get("LOCUST_MAIL_SUBJECT")
    if mail_subject is None:
        print("LOCUST_MAIL_SUBJECT environment variable is missing for locust_mailer")
        sys.exit(15)

    return (test_run, test_status, mail_from, mail_to, mail_subject)


# Gets the text result of a test run
def get_test_run_text(test_run):
    with open(LOCUST_LOGS_PATH + "/" + test_run + ".out") as f:
        test_run_lines = f.readlines()

    test_run_text="".join(test_run_lines)

    return test_run_text


# Gets the HTML formatted text of a test run
def generate_test_run_html(test_run, test_run_text, test_status):
    html_test = "<h3>" + test_run + "</h3>"

    html_status = "<h3 style='color: green'>PASSED</h3>" if not bool(int(test_status)) else "<h3 style='color: red'>FAILED</h3>"

    html_report = "<pre>" + test_run_text + "</pre>"

    return html_test + html_status + html_report


if __name__ == '__main__':

    # Get input parameters
    (test_run, test_status, mail_from, mail_to, mail_subject) = get_parameters()

    # Send HTML email
    msg = MIMEMultipart("alternative")
    msg["From"] = mail_from
    msg["To"] = mail_to
    msg["Subject"] = mail_subject + " - " + test_run + " - " + ("PASSED" if not bool(int(test_status)) else "FAILED")

    part = MIMEText(generate_test_run_html(test_run, get_test_run_text(test_run), test_status), "html")
    msg.attach(part)

    s = smtplib.SMTP(SMTP_HOST, SMTP_PORT)
    s.send_message(msg)
    s.quit()

