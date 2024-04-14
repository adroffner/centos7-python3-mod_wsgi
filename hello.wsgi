#! /usr/bin/env python
from datetime import datetime
import logging
import logging.handlers

logger = logging.getLogger('hello_wsgi_logger')
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
formatter = logging.Formatter("""
{
    "loggerName": "%(name)s",
    "asciTime": "%(asctime)s",
    "pathName": "%(pathname)s",
    "logRecordCreationTime": "%(created)f",
    "functionName": "%(funcName)s",
    "levelNo": "%(levelno)s",
    "lineNo": "%(lineno)d",
    "time": "%(msecs)d",
    "levelName": "%(levelname)s",
    "message":"%(message)s"
}
""")

handler.formatter = formatter
logger.addHandler(handler)


def application(environ, start_response):
    status = '200 OK'
    output = [b'Hello Dockerized World!', b'\n' * 2]
    output.extend([b'Time: ' + bytes(str(datetime.now()), 'ascii')])
    request_params = [
        '{}: {}'.format(key, value).encode('ascii')
        for key, value in sorted(environ.items())
        if key.startswith('wsgi.')
    ]
    output.extend(request_params)
    output = b'\n'.join(output)

    response_headers = [('Content-type', 'text/plain'),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    logger.info("Test Message")

    return [output]
