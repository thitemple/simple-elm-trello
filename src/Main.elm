module Main exposing (..)

import Html exposing (Html)
import Navigation exposing (Location)
import Page.Errored as Errored exposing (PageLoadError)
import Page.Home as Home
import Page.NotFound as NotFound
import Route exposing (Route)
import Types exposing (Board)
import Views.Page as Page exposing (ActivePage)


-- MODEL --


type Page
    = Blank
    | NotFound
    | Home Home.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


type alias ElmInitFlagsFromJS =
    { boards : List Board }


type alias Model =
    { pageState : PageState
    , savedBoards : List Board
    }


init : ElmInitFlagsFromJS -> Location -> ( Model, Cmd Msg )
init { boards } location =
    setRoute (Route.fromLocation location)
        { pageState = Loaded initialPage
        , savedBoards = boards
        }


initialPage : Page
initialPage =
    Blank



-- VIEW --


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage False page

        TransitioningFrom page ->
            viewPage True page


viewPage : Bool -> Page -> Html Msg
viewPage isLoading page =
    let
        frame =
            Page.frame isLoading
    in
    case page of
        NotFound ->
            NotFound.view
                |> frame Page.Other

        Blank ->
            Html.text ""
                |> frame Page.Other

        Home subModel ->
            Home.view subModel
                |> frame Page.Home
                |> Html.map HomeMsg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
    | HomeLoaded (Result PageLoadError Home.Model)
    | HomeMsg Home.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            { model | pageState = Loaded NotFound } ! []

        Just Route.Home ->
            { model | pageState = Loaded (Home (Home.init model.savedBoards)) } ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage (getPage model.pageState) msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
            ( { model | pageState = Loaded (toModel newModel) }, Cmd.map toMsg newCmd )
    in
    case ( msg, page ) of
        ( SetRoute route, _ ) ->
            setRoute route model

        ( HomeLoaded (Ok subModel), _ ) ->
            { model | pageState = Loaded (Home subModel) } ! []

        ( HomeMsg subMsg, Home subModel ) ->
            toPage Home HomeMsg Home.update subMsg subModel

        ( _, NotFound ) ->
            -- Disregard incoming messages when we're on the
            -- NotFound page.
            model ! []

        ( _, _ ) ->
            -- Disregard incoming messages that arrived for the wrong page
            model ! []



-- MAIN


main : Program ElmInitFlagsFromJS Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
