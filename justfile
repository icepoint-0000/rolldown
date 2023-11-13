set shell := ["bash", "-cu"]

_default:
    just --list -u

init:
    cargo binstall rusty-hook taplo-cli cargo-insta cargo-nextest -y
    yarn install
    git submodule update

test:
    cargo nextest run --no-fail-fast

lint:
    cargo clippy --all -- --deny warnings

# Update our local branch with the remote branch (this is for you to sync the submodules)
update:
    git pull
    git submodule update --init

fmt:
    cargo fmt
    taplo format
    npm run prettier

bench-prepare:
    git clone https://github.com/mrdoob/three.js.git --depth 1 ./temp/three.js  
    for i in {1..10}; do cp -r ./temp/three.js/src ./temp/three.js/copy$i/; done

# build node binding
build-binding mode="debug":
    yarn workspace @rolldown/node-binding run {{ if mode == "release" { "build:release" } else { "build" } }} 

bench:
    cargo bench -p bench

# build wasm of rolldown and move the output `pkg/` under `web` directory

# Use `just wasm-build release` for better performance but also it will cost more time.
wasm-build mode="dev":
    cd crates/rolldown_wasm && wasm-pack build --{{ mode }} --target web
    -rm -r ./web/wasm
    mv crates/rolldown_wasm/pkg ./web/wasm
