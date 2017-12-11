module Msgs exposing (..)

import Types exposing (Board)


type Msg
    = NoOp
    | CreatingBoard
    | CloseCreatingBoard
    | CreateBoard Board
    | InputNewBoardText String
