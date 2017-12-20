module Page.NotFound exposing (view)

import Html exposing (Html, div, text)


view : Html msg
view =
    div [] [ text "The page you are looking for could not be found" ]
