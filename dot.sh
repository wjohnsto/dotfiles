#!/bin/bash

. scripts/utils.sh
. scripts/deploy.sh
. scripts/reset.sh
. scripts/update.sh

info "Dotfiles intallation initialized..."
log "What would you like to do?"
log "  [0] Deploy (default)"
log "  [1] Reset"
log "  [2] Update" action
read -p "? " action

case "$action" in
   "1")
     log "Reseting"
     reset
     deploy
   ;;
   "2")
     log "Updating"
     reset
     deploy
   ;;
   *)
      log "Deploying"
      deploy
   ;;
esac

