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
    output = b'Hello my darling!'

    response_headers = [('Content-type', 'text/plain'),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    logger.info("Test Message")

    return [output]
