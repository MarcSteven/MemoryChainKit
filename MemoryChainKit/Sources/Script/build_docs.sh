#!/bin/sh

#  build_docs.sh
#  MemoryChainKit
#
#  Created by Marc Steven on 2020/3/25.
#  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.

if ! which jazzy >/dev/null; then
  echo "Jazzy not detected: You can download it from https://github.com/realm/jazzy"
  exit
fi

jazzy \
  --clean \
  --author Marc Steven \
  --author_url https://marcsteven.top \
  --github_url https://github.com/MarcSteven/MemoryChainKit \
  --github-file-prefix https://github.com/MarcSteven/MemoryChainKit/tree/master \
  --module-version 0.1.2 \
  --xcodebuild-arguments -scheme, MemoryChainKit \
  --module MemoryChainKit \
  --root-url https://github.com/MarcSteven/MemoryChainKit\
  -x -workspace,MemoryChainKit.xcworkspace,-scheme,MemoryChainKit
