import prologue
import prologue/websocket

var 
  app = newApp
  base = newGroup app, "/", @[]
  auth = newGroup app, "/auth", @[]
  users = newGroup app, "/user", @[]

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"
proc bye*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

proc ws*(ctx: Context) {.async.} =
  var ws = await newWebSocket ctx
  await ws.send "Welcome to simple echo server"
  while ws.readyState == Open:
  let packet = await ws.receiveStrPacket
  await ws.send packet

template `GET`*(routeStr: string, route: Router) = 
  app.get routeStr, route

template `nests`*(routeStr: string)
  app.addGroup *routes

template `nested`*()

"/" nests [hello, bye]
"/auth" nest
"/" GET hello
addGroup app, auth, users
app.run
