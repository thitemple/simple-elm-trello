module Model exposing (Model, initialModel)

import Types
    exposing
        ( Board
        , CreateBoardState(..)
        )


type alias Model =
    { boards : List Board
    , createBoard : CreateBoardState
    }


initialModel : List Board -> Model
initialModel boards =
    { boards = boards, createBoard = Create }
