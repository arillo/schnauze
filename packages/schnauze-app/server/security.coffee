# console.log Schnauze.Collections.AudioSnippets
# Security.permit(['insert','download']).collections([ Schnauze.Collections.AudioSnippets ]).apply()

Schnauze.Collections.AudioSnippets.deny
  insert: ->
    false
  update: ->
    false
  remove: ->
    false
  download: ->
    false
Schnauze.Collections.AudioSnippets.allow
  insert: ->
    true
  update: ->
    true
  remove: ->
    true
  download: ->
    true