module Update exposing (update)

import Model exposing (Model)
import Msgs exposing (Msg(..))
import Ports exposing (storeBoards)
import Types exposing (CreateBoardState(..), board)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        CreatingBoard ->
            { model | createBoard = Creating board } ! []

        CloseCreatingBoard ->
            { model | createBoard = Create } ! []

        InputNewBoardText newBoard ->
            { model | createBoard = Creating { name = newBoard } } ! []

        CreateBoard board ->
            let
                boards =
                    model.boards ++ [ board ]
            in
            { model | boards = boards, createBoard = Create } ! [ storeBoards boards ]
