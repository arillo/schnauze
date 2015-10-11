# console.log Schnauze.Collections.AudioSnippets
# Security.permit(['insert','download']).collections([ Schnauze.Collections.AudioSnippets ]).apply()
# Schnauze.Collections.AudioSnippets._ensureIndex({'metadata.loc.coordinates':'2dsphere'})
Schnauze.Collections.AudioSnippets.deny
  insert: ->
    false
  update: ->
    false
  remove: ->
    true
  download: ->
    false
Schnauze.Collections.AudioSnippets.allow
  insert: ->
    true
  update: ->
    true
  remove: ->
    false
  download: ->
    true