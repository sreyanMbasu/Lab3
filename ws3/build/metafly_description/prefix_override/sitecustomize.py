import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/min/a/basu38/ece569-fall2026/Lab3/ws3/install/metafly_description'
