import firebase_admin
from firebase_admin import credentials, db, storage

import pvporcupine
from pvrecorder import PvRecorder

import pyaudio
import wave
import asr
import nlu


def sendCommandToRobot(objectId):
    try : 
        cred = credentials.Certificate("keys/touri-65f07-firebase-adminsdk-wuv71-b245c875f8.json")
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://touri-65f07-default-rtdb.firebaseio.com/',
            'storageBucket' : 'touri-65f07.appspot.com' 
        })
    except:
        pass  
    
    db.reference("autoSkills/nlp").update({
        "objectId" : objectId
    })


def getDetectionList():
    try : 
        cred = credentials.Certificate("keys/touri-65f07-firebase-adminsdk-wuv71-b245c875f8.json")
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://touri-65f07-default-rtdb.firebaseio.com/',
            'storageBucket' : 'touri-65f07.appspot.com' 
        })
    except:
        pass  
    
    detectionList =  db.reference("autoSkills/nlp/detections").get()
    return detectionList


# ---------------------------------------------------------------------------- #

def run():
    asr.recordAudio()
    command = nlu.translateAndTranscribe()
    sendCommandToRobot(command)
    # detectionList = getDetectionList()
    # response = nlu.think(command, detectionList)
    # print("###########################################")
    # if response in objectIdDict:
    #     print('Picking up ', objectIdDict[response])
    #     sendCommandToRobot(response)
    # else:
    #     print('No such object in the database. ', response)
    # print("###########################################")


objectIdDict = {
    'object_0' : 'cmu_tartan_bottle',
    'object_1' : 'tennis_ball_toy',
    'object_4' : 'monkey_keychain',
    'object_6' : 'all_star_dog_belt',
    'object_7' : 'table_tennis_balls',
    'object_8' : 'cow_keychain',
    'object_10' : 'unicorn',
    'object_11' : 'airpods_case',
}