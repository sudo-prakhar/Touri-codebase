import os
import openai
import whisper
import pyaudio
import wave

# export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

print("Downloading model...")
model = whisper.load_model("small")

options = dict(language='en', best_of=1)
transcribe_options = dict(task="transcribe", **options)
translate_options = dict(task="translate", **options)

# TODO: Change these
openai.organization = "INSERT-ORGANIZATION-KEY"
openai.api_key = "INSERT-API-KEY"

def translateAndTranscribe():
    result = model.transcribe("recorded.wav", **translate_options, fp16=False)
    print("Command: ", result["text"])
    return result["text"]



def think(command, detectionList):
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=createPrompt(command, detectionList),
        max_tokens=3,
        temperature=0,
        best_of=3
        )

    return response['choices'][0]['text'].strip()



# ---------------------------------------------------------------------------- #

objectList = {
    0 : 'object_0 - white color bottle with a red cap with "CMU" labels\n',
    1 : 'object_1 - black tennis ball\n',
    4 : 'object_4 - green monkey stuffed toy keychain\n',
    6 : 'object_6 - black color dog belt\n',
    7 : 'object_7 - set of three white table tennis balls\n',
    8 : 'object_8 - white cow stuffed toy keychain\n',
    10 : 'object_10 - stuffed unicorn toy which is white in color\n',
    11 : 'object_11 - airpods case to keep airpods safe\n',
}

exampleList = {
    #BOTTLE
    0 : [
        'Command: Pick up that white bottle\nSelected object: object_0\n\n',
        'Command: Pick up the bottle\nSelected object: object_0\n\n',
    ],
    #TENNIS BALL
    1 : [
        'Command: Pick up the black ball\nSelected object: object_1\n\n',
        'Command: I want that tennis ball\nSelected object: object_1\n\n',
    ],
    #MONKEY KEYCHAIN
    4 : [
        'Command: Buy that monkey keychain\nSelected object: object_4\n\n',
        'Command: I want that monkey\nSelected object: object_4\n\n',
    ],
    #DOG BELT
    6 : [
        'Command: Pick up a gift for my dog\nSelected object: object_6\n\n',
        'Command: Buy the dog belt\nSelected object: object_6\n\n',
    ],
    #TABLE TENNIS BALLS
    7 : [
        'Command: Pick up those ping pong balls\nSelected object: object_7\n\n',
        'Command: Buy the table tennis balls\nSelected object: object_7\n\n',
    ],
    #COW_KEYCHAIN
    8 : [
        'Command: Buy the cow keychain\nSelected object: object_8\n\n',
        'Command: I want the that cow\nSelected object: object_8\n\n',
    ],
    #UNICORN
    10 : [
        'Command: Pick up the unicorn\nSelected object: object_10\n\n',
        'Command: I want to buy that unicorn keychain\nSelected object: object_10\n\n',
    ], 
    #AIRPODS CASE
    11 : [
        'Command: I want a new airpod case\nSelected object: object_11\n\n',
        'Command: Could you buy me that airpods case\nSelected object: object_11\n\n',
    ],
}


# ---------------------------------------------------------------------------- #

def createPrompt(command, detectionList):

    prompt = 'The following objects are available\n\n'

    for objNum in detectionList:
        prompt += objectList[objNum]

    prompt += '\n'

    for objNum in detectionList:
        for j in exampleList[objNum]:
            prompt += j



    prompt += 'Command: {}\nSelected object:'''.format(command)

    return prompt