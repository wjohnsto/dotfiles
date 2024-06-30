#!/bin/bash

. scripts/utils.sh
. scripts/deploy.sh
. scripts/init.sh
. scripts/reset.sh
. scripts/update.sh
. scripts/symlinks.sh

info "Dotfiles setup..."
log "What would you like to do?"
log "  [0] Initialize"
log "  [1] Deploy (default)"
log "  [2] Reset"
log "  [3] Update"
log "  [q] Quit/Cancel"
read -p "? " action

case "$action" in
   "0")
     log "Initializing"
     initialize
     deploy
   ;;
   "2")
     log "Reseting"
     reset
     deploy
   ;;
   "3")
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

