#!/bin/bash

. scripts/utils.sh
. scripts/deploy.sh
. scripts/reset.sh
. scripts/update.sh

info "Dotfiles setup..."
log "What would you like to do?"
log "  [0] Deploy (default)"
log "  [1] Reset"
log "  [2] Update"
log "  [q] Quit/Cancel"
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
  "q") ;;
   *)
      log "Deploying"
      deploy
   ;;
esac

