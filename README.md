remoteredux-standalone
================

A standalone monitor, debugging redux even without internet. Based on [`remotedev`](https://github.com/zalmoxisus/remotedev).

### Installation

```
$ npm install -g remoteredux-standalone
```

##### for macOS
```
$ npm install -g remoteredux-standalone --unsafe-perm=true --allow-root
```

### Usage

##### Now run remoteredux from the terminal to launch the standalone DevTools app:

```
$ remoteredux
```

### Connection settings

Set `hostname` and `port` to the values you want. `hostname` by default is `localhost` and `port` is `8000`.

To use WSS, set `protocol` argument to `https` and provide `key`, `cert` and `passphrase` arguments.
```
$ remoteredux --hostname=localhost --port=8000
```
Right now `localhost:8000` is default setting
### License 

MIT
