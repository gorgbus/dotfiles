#!/usr/bin/env bash

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach || tmux
fi
