###
# Schnauze EventEmitter
#
# usage: 
#   
#   Schnauze.EventEmitter.on(eventName, listener)
#   Schnauze.EventEmitter.emit(eventName, payload)
#   Schnauze.EventEmitter.removeListener(eventName, listener)
#
# event nomenclature
#
#   Component:eventName - e.g.: Geolocation:locationChange
#
###

Schnauze.EventEmitter = new EventEmitter