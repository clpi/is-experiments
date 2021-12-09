# Testing nim Jester for micro webframeworks
import jester, json, os, strutils, asyncdispatch

router baseRouter:
  get "/":
    var htmlOut = """
      <h1>Welcome to %%title</h1>
    """
    resp htmlOut.replace "%%title", "is-api"

  get "/users/@name":
    cond @"name" != "daniel"
    resp "Thats not my naem"
  get "/auth":
    setCookie "is-auth", @"checked", daysForward 3

proc run*() =
  let sett = newSettings (int 3456).Port
  var jest = baseRouter.initJester sett
  jest.serve

when isMainModule: run()