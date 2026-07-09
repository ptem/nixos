#!/bin/sh
# Inject app info into PipeWire/PulseAudio before launching mpv. Purely because I don't like seeing an mpv stream for feishin lmfao.
case "$*" in
    *--audio-device=help*|*--ao=help*|*--version*) exec mpv "$@" ;;
esac

export PIPEWIRE_PROPS='{ application.name = "Feishin", node.description = "Feishin", media.role = "music" }'
exec mpv "$@"
