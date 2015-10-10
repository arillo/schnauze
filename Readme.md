# Schnauze

Location based audio snippets


## Dev stuff

create geospatial index
    
    db.cfs.audioSnippets.filerecord.ensureIndex({'metadata.loc.coordinates':'2dsphere'})