port module Ports exposing (storeBoards)

import Types exposing (Board)


port storeBoards : List Board -> Cmd msg
