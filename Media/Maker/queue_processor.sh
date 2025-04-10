#!/bin/bash

QUEUE_FILE="command_queue.txt"
LOCK_FILE="command_queue.lock"

process_queue() {
  while true; do
    if [ -s "$QUEUE_FILE" ]; then
      # Acquire a lock
      exec 200>"$LOCK_FILE"
      flock -n 200 || exit 1

      command=$(head -n 1 "$QUEUE_FILE")
      sed -i '1d' "$QUEUE_FILE"

      # Release the lock
      flock -u 200

      echo "Running: $command"
      eval "$command"
    else
      sleep 1
    fi
  done
}

process_queue
