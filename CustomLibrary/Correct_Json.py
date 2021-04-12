import json
def Correct_Json(input):
    tmp=json.dumps(input)
    return tmp.replace("\'","\"")
