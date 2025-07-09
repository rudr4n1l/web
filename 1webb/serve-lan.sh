#!/bin/bash

PORT=8080

# Try to get IP using `ip`, fallback to `ifconfig`, else empty
if command -v ip > /dev/null; then
    IP=$(ip route get 1.1.1.1 | awk '{print $7; exit}')
elif command -v ifconfig > /dev/null; then
    IP=$(ifconfig | grep 'inet ' | grep -v 127 | awk '{print $2}' | head -n 1)
else
    IP=""
fi

echo "Starting Python HTTP server..."
if [ -n "$IP" ]; then
    echo "Your site is now accessible on:"
    echo
    echo "  http://$IP:$PORT"
    echo
else
    echo "⚠️  Could not detect your local IP address."
    echo "🔗 Visit http://<your-local-ip>:$PORT from another device."
    echo
fi

echo "Press Ctrl+C to stop the server."

python3 -m http.server $PORT --bind 0.0.0.0
