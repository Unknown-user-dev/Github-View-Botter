import asyncdispatch, httpclient, os, strutils

var url = ""
var requestCount = 0

proc getContent() {.async.} =
  let client = newAsyncHttpClient()
  while true:
    try:
      requestCount += 1
      echo "+ [", requestCount, "] View to: ", url
      let response = await client.get(url)
      let statusCode = parseInt(response.status.split(' ')[0])
      if statusCode == Http429.int:
        echo "Too many requests, waiting for 60 seconds before retrying..."
        await sleepAsync(60000)
    except HttpRequestError:
      echo "An error occurred while sending the request."

proc main() =
  while true:
    echo "1. Start botting ur view"
    echo "2. Exit"

    echo "\nChoose an options: "
    var choiceStr: string
    discard readLine(stdin, choiceStr)
    let choice = parseInt(choiceStr)

    case choice
    of 1:
      echo "Enter the url: "
      discard readLine(stdin, url)
      waitFor getContent()
    of 2:
      break
    else:
      echo "Bro ur weird, u have 1 and 2 JUST CHOOSE BRO"

main()