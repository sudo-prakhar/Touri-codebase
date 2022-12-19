# TOURI CODEBASE

This repository is for the Touri codebase - related to interfaces, NLP, and core system.

NOTE: The current API keys are expired in most of the codebase. You will need your own API keys. 


## Bot Tablet frontend  
A flutter project for the tablet attached to the robot. It is only used for audio-video interface. This does not control the tablet movement - that code is in botside core. 

THIRD PARTY SERVICES: Agora, Firebase

## Botside core
A python codebase to listen to database events and call callback functions - trigger ROS services, call python scripts etc

THIRD PARTY SERVICES: Firebase


## User frontend
A flutter projcet for the user side mobile application. Currently firebase is only initialised for iOS apps so the code is iOS only.

THIRD PARTY SERVICES: Agora, Firebase

## Touri NLP
A pyhton project for natural language understanding and cognition. 

THIRD PARTY SERVICES: OpenAI GPT3, Porcupine wakeword, Firebase