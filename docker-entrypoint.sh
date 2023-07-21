#!/usr/bin/env bash

if [ "$PORT" ]; then
    export MB_JETTY_PORT="$PORT"
fi

if [ "$DATABASE_URL" ]; then
    export MB_DB_CONNECTION_URI="$DATABASE_URL"
fi

# We need to override the $JAVA_OPTS and give it a slightly lower memory limit
# because Heroku tends to think we can use more memory than we actually can.
JAVA_OPTS="$JAVA_OPTS -XX:+UnlockExperimentalVMOptions"
JAVA_OPTS+=" -XX:+UseContainerSupport"         # Tell the JVM to use container info to set heap limit -- see https://devcenter.heroku.com/articles/java-memory-issues#configuring-java-to-run-in-a-container
JAVA_OPTS+=" -XX:-UseGCOverheadLimit"          # Disable limit to amount of time spent in GC. Better slow than not working at all
JAVA_OPTS+=" -XX:+UseCompressedOops"           # Use 32-bit pointers. Reduces memory usage
JAVA_OPTS+=" -XX:+UseCompressedClassPointers"  # Same as above. See also http://blog.leneghan.com/2012/03/reducing-java-memory-usage-and-garbage.html
JAVA_OPTS+=" -Xverify:none"                    # Skip bytecode verification, the Heroku buildpack comes from us so it's already verified. Speed up launch slightly
JAVA_OPTS+=" -XX:+UseG1GC"                     # G1GC seems to use slightly less memory in my testing...
JAVA_OPTS+=" -XX:+UseStringDeduplication"      # Especially when used in combination with string deduplication

# Other Java options
JAVA_OPTS+=" -server"                  # Run in server mode. This is the default for 64-bit JVM
JAVA_OPTS+=" -Djava.awt.headless=true" # don't try to start AWT. Not sure this does anything but better safe than wasting memory
JAVA_OPTS+=" -Dfile.encoding=UTF-8"    # Use UTF-8

# Set timezone using the JAVA_TIMEZONE variable if present
if [ "$JAVA_TIMEZONE"]; then
    echo "  -> Timezone setting detected: $JAVA_TIMEZONE"
    JAVA_OPTS+=" -Duser.timezone=$JAVA_TIMEZONE"
fi

echo "JAVA_OPTS: $JAVA_OPTS"
export JAVA_OPTS

/app/run_metabase.sh