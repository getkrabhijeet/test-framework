import base64

def base64_encode(input):
    return str(base64.b64encode(input),"utf-8")