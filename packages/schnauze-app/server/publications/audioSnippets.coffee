Meteor.publish "audioSnippets", () ->
    console.log 'schnauze:app'.yellow, '[publication] audioSnippets'.blue
    Schnauze.Collections.AudioSnippets.find({})