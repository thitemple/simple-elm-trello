module Page.Home exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Ports exposing (storeBoards)
import Types exposing (Board, board)


-- MODEL --


type alias Model =
    { boards : List Board
    , createBoard : CreateBoardState
    }


init : List Board -> Model
init boards =
    { boards = boards, createBoard = Create }



-- TYPES --


type CreateBoardState
    = Create
    | Creating Board



-- UPDATE --


type Msg
    = CreatingBoard
    | CloseCreatingBoard
    | CreateBoard Board
    | InputNewBoardText String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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



-- VIEWS --


view : Model -> Html Msg
view model =
    div [ class "columns is-multiline is-mobile" ]
        ([ createBoardBox model.createBoard
         ]
            ++ List.map showBoard model.boards
        )


showBoard : Board -> Html Msg
showBoard board =
    div [ class "column is-one-quarter box set-board-box" ]
        [ text board.name ]


createBoardBox : CreateBoardState -> Html Msg
createBoardBox createBoardState =
    case createBoardState of
        Create ->
            div [ class "column is-one-quarter box set-board-create" ]
                [ button [ class "button is-primary", onClick CreatingBoard ]
                    [ text "Create new board..." ]
                ]

        Creating newBoard ->
            div [ class "column is-one-quarter box set-board-create" ]
                [ div [ class "columns" ]
                    [ span [ class "column is-four-fiths" ] [ text "Creating a board" ]
                    , a [ class "button", onClick CloseCreatingBoard ]
                        [ span [ class "icon" ]
                            [ i [ class "fa fa-close" ] [] ]
                        ]
                    ]
                , div [ class "columns" ]
                    [ div [ class "column" ]
                        [ input
                            [ class "input"
                            , onInput InputNewBoardText
                            , placeholder "What shall we call the board?"
                            ]
                            []
                        ]
                    ]
                , div [ class "columns" ]
                    [ div [ class "column" ]
                        [ button
                            [ class "button"
                            , onClick CloseCreatingBoard
                            ]
                            [ text "Cancel" ]
                        ]
                    , div [ class "column" ]
                        [ button
                            [ class "button is-primary"
                            , onClick (CreateBoard newBoard)
                            ]
                            [ text "Create" ]
                        ]
                    ]
                ]
