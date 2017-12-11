module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model)
import Msgs exposing (Msg(..))
import Types exposing (Board, CreateBoardState(..), board)


view : Model -> Html Msg
view model =
    div [ class "columns is-multiline is-mobile" ]
        ([ createBoardBox model.createBoard
         ]
            ++ List.map showBoard model.boards
        )


showBoard : Board -> Html Msg
showBoard board =
    div [ class "column is-one-quarter" ]
        [ text board.name ]


createBoardBox : CreateBoardState -> Html Msg
createBoardBox createBoardState =
    case createBoardState of
        Create ->
            div [ class "column is-one-quarter" ]
                [ button [ class "button is-primary", onClick Msgs.CreatingBoard ]
                    [ text "Create new board..." ]
                ]

        Creating newBoard ->
            div [ class "column is-one-quarter box" ]
                [ div [ class "columns" ]
                    [ span [ class "column is-four-fiths" ] [ text "Creating a board" ]
                    , a [ class "button", onClick Msgs.CloseCreatingBoard ]
                        [ span [ class "icon" ]
                            [ i [ class "fa fa-close" ] [] ]
                        ]
                    ]
                , div []
                    [ input [ class "input", onInput Msgs.InputNewBoardText, placeholder "What shall we call the board?" ] [] ]
                , div [ class "columns" ]
                    [ button [ class "column button", onClick Msgs.CloseCreatingBoard ] [ text "Cancel" ]
                    , button [ class "column button is-primary", onClick (Msgs.CreateBoard newBoard) ] [ text "Create" ]
                    ]
                ]
