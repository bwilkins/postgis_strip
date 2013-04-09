#PostGIS Strip

This is a tool to strip legacy PostGIS data from a PostgreSQL database dump. The dump should be in the same form as expected for postgis_restore.pl.

### WARNING: Can be potentially destructive!
This script is very naïve, and will delete any and all functions, operators, aggregates etc in a database dump. For an idea of what would be removed, checkout the grep line.
