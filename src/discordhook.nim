import httpclient
import jsony
import httpcore
import asyncdispatch

# sorry for snake_case, worried incase of json gettng fucked up, will test.
type

  Embed* = object
    ## Emebed object
    ## title of embed
    title*: string
    discription*: string
    url*: string
    ## ISO8601 timestamp
    timestamp*: string
    ## Color code
    color*: int

  Webhook* = object
    ## Discord webhook
    url*: string
    ## Content Of the webhook.
    content*: string
    ## Is this a text to speach message.
    tts*: bool
    embed*: array[9, Embed]



proc send*(hc: HttpClient or AsyncHttpClient, hook: Webhook): Future[string] {.multisync.} =
  ## make sure to set your http headers!
  result = await  (await hc.post(hook.url, body=hook.toJson)).body


proc send*(hook: Webhook): string =
  let hc = newHttpClient(headers=newHttpHeaders({ "Content-Type": "application/json" }))
  result = hc.post(hook.url, body=hook.toJson).body



