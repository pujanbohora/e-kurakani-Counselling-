import hashlib
import hmac
import base64
import time
import jwt
import requests
import json
# from time import time
from decouple import config


DEBUG = config('DEBUG', cast=bool)

# Enter your API key and your API secret
if DEBUG:
    # Personal Test account
    # API_KEY = 'TfdoTCUTZCyhvinxOyWYQ'
    # API_SEC = 'go1szidM5oFIM0r387fYzxT1l9OmXBhH'
    API_KEY = 'zG5szuqzSu69hczJTENcrg'
    API_SEC = 'qvOyswWN4UzghHAXjv4P8lFLAbR2AAPbAwRu'
else:
    pass

# create a function to generate a token
# using the pyjwt library


def generateToken():
    token = jwt.encode(

        # Create a payload of the token containing
        # API Key & expiration time
        {'iss': API_KEY, 'exp': time.time() + 5000},

        # Secret used to generate token signature
        API_SEC,

        # Specify the hashing alg
        algorithm='HS256'
    )
    return token


def generateSignature(data):
    ts = int(round(time.time() * 1000)) - 30000
    msg = data['apiKey'] + str(data['meetingNumber']) + \
        str(ts) + str(data['role'])
    message = base64.b64encode(bytes(msg, 'utf-8'))
    # message = message.decode("utf-8");
    secret = bytes(data['apiSecret'], 'utf-8')
    hash = hmac.new(secret, message, hashlib.sha256)
    hash = base64.b64encode(hash.digest())
    hash = hash.decode("utf-8")
    tmpString = "%s.%s.%s.%s.%s" % (data['apiKey'], str(
        data['meetingNumber']), str(ts), str(data['role']), hash)
    signature = base64.b64encode(bytes(tmpString, "utf-8"))
    signature = signature.decode("utf-8")
    return signature.rstrip("=")


def getSignatureCode(data):
    data['apiKey'] = API_KEY
    data['apiSecret'] = API_SEC
    return generateSignature(data)
